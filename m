Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48747 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbaHXG7i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Aug 2014 02:59:38 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so1231859wib.11
        for <linux-wpan@vger.kernel.org>; Sat, 23 Aug 2014 23:59:36 -0700 (PDT)
Received: from omega (p20030064A967E944E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a967:e944:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id eb4sm17365313wic.16.2014.08.23.23.59.35
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Aug 2014 23:59:36 -0700 (PDT)
Date: Sun, 24 Aug 2014 08:59:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next 09/12] mac802154: remove useless -EBUSY if
 sdata running
Message-ID: <20140824065922.GA17798@omega>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
 <1407937595-16415-10-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407937595-16415-10-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
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
> -			    subif->running) {
> -				mutex_unlock(&sdata->local->iflist_mtx);
> -				return -EBUSY;
> -			}
> -		}
> -		mutex_unlock(&sdata->local->iflist_mtx);
> -	}

I finally found where it was copy&pasted from wireless code and
obfuscated afterwards. [0]

It's like a good puzzle. :-)

I adapt the current 80211 behaviour.


I will write a status update about the rework process today.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac80211/iface.c?v=3.16#L257
