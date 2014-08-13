Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:58269 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaHMPHS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 11:07:18 -0400
Received: by mail-la0-f52.google.com with SMTP id b17so8112773lan.39
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 08:07:17 -0700 (PDT)
Received: from omega (p20030064A92B8D85E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a92b:8d85:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id j2sm1353061laf.15.2014.08.13.08.07.16
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 08:07:16 -0700 (PDT)
Date: Wed, 13 Aug 2014 17:07:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140813150712.GB19527@omega>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
 <1407937595-16415-10-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407937595-16415-10-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 09/12] mac802154: remove useless -EBUSY if
 sdata running
To: linux-wpan@vger.kernel.org

Hi,

On Wed, Aug 13, 2014 at 03:46:32PM +0200, Alexander Aring wrote:
> The slave_open function is only called by ndo_open callback. This
> callback is already protected to do a ip link set wpan0 up twice.
> This patch removing also a unnecessary for each loop to find the right
> entry which is already known.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/mac802154/iface.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index ae774d3..ab23246 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -35,24 +35,11 @@
>  static int mac802154_slave_open(struct net_device *dev)
>  {
>  	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
> -	struct ieee802154_sub_if_data *subif;
>  	struct ieee802154_local *local = sdata->local;
>  	int res = 0;
>  
>  	ASSERT_RTNL();
>  
> -	if (sdata->type == NL802154_IFTYPE_NODE) {
> -		mutex_lock(&sdata->local->iflist_mtx);
> -		list_for_each_entry(subif, &sdata->local->interfaces, list) {
> -			if (subif != sdata && subif->type == sdata->type &&

I will keep this patch, I thought this is subif == sdata... then it
would not make sense. But this make sense now. It checks that we don't
have an another running interface for a phy.

Sorry.

- Alex
