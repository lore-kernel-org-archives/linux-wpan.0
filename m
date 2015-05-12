Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:43881 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbbELLGT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 07:06:19 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t4CB6Gi2005893
	for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 13:06:17 +0200
Date: Tue, 12 May 2015 13:06:15 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [PATCH bluetooth-next 3/3] mac802154: remove mib lock
Message-ID: <20150512130615.3f8409f6@zoidberg>
In-Reply-To: <20150512075018.GB733@omega>
References: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
	<1431290456-25524-4-git-send-email-alex.aring@gmail.com>
	<20150512075018.GB733@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, 12 May 2015 09:50:19 +0200
Alexander Aring <alex.aring@gmail.com> wrote:

> Hi,
> 
> On Sun, May 10, 2015 at 10:40:56PM +0200, Alexander Aring wrote:
> >  	hdr.fc.type = cb->type;
> >  	hdr.fc.security_enabled = cb->secen;
> >  	hdr.fc.ack_request = cb->ackreq;
> > -	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
> > +	/* TODO: use atomic_t as dsn, dsn need to be locked when
> > AF_IEEE802154
> > +	 * and IEEE802154 6LoWPAN call this at the same time.
> > +	 */
> > +	hdr.seq = dev->ieee802154_ptr->dsn++;
> 
> I am thinking that a good solution would be:
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index c6aa1d2..91550c4 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -177,9 +177,9 @@ struct wpan_dev {
>         __le64 extended_addr;
>  
>         /* MAC BSN field */
> -       u8 bsn;
> +       u8 __percpu *bsn;
>         /* MAC DSN field */
> -       u8 dsn;
> +       u8 __percpu *dsn;
>  
>         u8 min_be;
>         u8 max_be;
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 866d27f..343ef29 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -365,10 +365,7 @@ static int mac802154_header_create(struct
> sk_buff *skb, hdr.fc.type = cb->type;
>         hdr.fc.security_enabled = cb->secen;
>         hdr.fc.ack_request = cb->ackreq;
> -       /* TODO: use atomic_t as dsn, dsn need to be locked when
> AF_IEEE802154
> -        * and IEEE802154 6LoWPAN call this at the same time.
> -        */
> -       hdr.seq = dev->ieee802154_ptr->dsn++;
> +       hdr.seq = this_cpu_inc_return(*wpan_dev->dsn);
>  
>         if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
>                 return -EINVAL;
> @@ -442,6 +439,8 @@ static void mac802154_wpan_free(struct net_device
> *dev) {
>         struct ieee802154_sub_if_data *sdata =
> IEEE802154_DEV_TO_SUB_IF(dev); 
> +       free_percpu(sdata->wpan_dev.dsn);
> +       free_percpu(sdata->wpan_dev.bsn);
>         mac802154_llsec_destroy(&sdata->sec);
>  
>         free_netdev(dev);
> @@ -464,13 +463,25 @@ ieee802154_setup_sdata(struct
> ieee802154_sub_if_data *sdata, enum nl802154_iftype type)
>  {
>         struct wpan_dev *wpan_dev = &sdata->wpan_dev;
> +       u8 tmp;
>  
>         /* set some type-dependent values */
>         sdata->vif.type = type;
>         sdata->wpan_dev.iftype = type;
>  
> -       get_random_bytes(&wpan_dev->bsn, 1);
> -       get_random_bytes(&wpan_dev->dsn, 1);
> +       wpan_dev->bsn = alloc_percpu(u8);
> +       if (!wpan_dev->bsn)
> +               return -ENOMEM;
> +
> +       get_random_bytes(&tmp, 1);
> +       this_cpu_write(*wpan_dev->bsn, tmp);
> +
> +       wpan_dev->dsn = alloc_percpu(u8);
> +       if (!wpan_dev->dsn)
> +               return -ENOMEM;
> +
> +       get_random_bytes(&tmp, 1);
> +       this_cpu_write(*wpan_dev->dsn, tmp);
>  
>         /* defaults per 802.15.4-2011 */
>         wpan_dev->min_be = 3;
> 
> 
> Introduce a percpu counter for the sequence numbers, incrementation of
> this counter is an atomic operation then and we are sure that we don't
> sending the same sequence number when calling this function at the
> same time.

With this, two threads running on the same interface can send different
packets with the same sequence number back to back. Maybe better make
it atomic instead of percpu instead to avoid that?

> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

