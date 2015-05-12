Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34723 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbELHuX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 03:50:23 -0400
Received: by wicmc15 with SMTP id mc15so46802583wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 00:50:22 -0700 (PDT)
Date: Tue, 12 May 2015 09:50:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/3] mac802154: remove mib lock
Message-ID: <20150512075018.GB733@omega>
References: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
 <1431290456-25524-4-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1431290456-25524-4-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi,

On Sun, May 10, 2015 at 10:40:56PM +0200, Alexander Aring wrote:
>  	hdr.fc.type = cb->type;
>  	hdr.fc.security_enabled = cb->secen;
>  	hdr.fc.ack_request = cb->ackreq;
> -	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
> +	/* TODO: use atomic_t as dsn, dsn need to be locked when AF_IEEE802154
> +	 * and IEEE802154 6LoWPAN call this at the same time.
> +	 */
> +	hdr.seq = dev->ieee802154_ptr->dsn++;

I am thinking that a good solution would be:

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index c6aa1d2..91550c4 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -177,9 +177,9 @@ struct wpan_dev {
        __le64 extended_addr;
 
        /* MAC BSN field */
-       u8 bsn;
+       u8 __percpu *bsn;
        /* MAC DSN field */
-       u8 dsn;
+       u8 __percpu *dsn;
 
        u8 min_be;
        u8 max_be;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 866d27f..343ef29 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -365,10 +365,7 @@ static int mac802154_header_create(struct sk_buff *skb,
        hdr.fc.type = cb->type;
        hdr.fc.security_enabled = cb->secen;
        hdr.fc.ack_request = cb->ackreq;
-       /* TODO: use atomic_t as dsn, dsn need to be locked when AF_IEEE802154
-        * and IEEE802154 6LoWPAN call this at the same time.
-        */
-       hdr.seq = dev->ieee802154_ptr->dsn++;
+       hdr.seq = this_cpu_inc_return(*wpan_dev->dsn);
 
        if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
                return -EINVAL;
@@ -442,6 +439,8 @@ static void mac802154_wpan_free(struct net_device *dev)
 {
        struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
+       free_percpu(sdata->wpan_dev.dsn);
+       free_percpu(sdata->wpan_dev.bsn);
        mac802154_llsec_destroy(&sdata->sec);
 
        free_netdev(dev);
@@ -464,13 +463,25 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
                       enum nl802154_iftype type)
 {
        struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+       u8 tmp;
 
        /* set some type-dependent values */
        sdata->vif.type = type;
        sdata->wpan_dev.iftype = type;
 
-       get_random_bytes(&wpan_dev->bsn, 1);
-       get_random_bytes(&wpan_dev->dsn, 1);
+       wpan_dev->bsn = alloc_percpu(u8);
+       if (!wpan_dev->bsn)
+               return -ENOMEM;
+
+       get_random_bytes(&tmp, 1);
+       this_cpu_write(*wpan_dev->bsn, tmp);
+
+       wpan_dev->dsn = alloc_percpu(u8);
+       if (!wpan_dev->dsn)
+               return -ENOMEM;
+
+       get_random_bytes(&tmp, 1);
+       this_cpu_write(*wpan_dev->dsn, tmp);
 
        /* defaults per 802.15.4-2011 */
        wpan_dev->min_be = 3;


Introduce a percpu counter for the sequence numbers, incrementation of
this counter is an atomic operation then and we are sure that we don't
sending the same sequence number when calling this function at the  same
time.

- Alex
