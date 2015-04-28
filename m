Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36409 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965207AbbD1I31 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Apr 2015 04:29:27 -0400
Received: by wizk4 with SMTP id k4so130365877wiz.1
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2015 01:29:26 -0700 (PDT)
Date: Tue, 28 Apr 2015 10:29:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] cfg802154: pass name_assign_type to
 rdev_add_virtual_intf()
Message-ID: <20150428082922.GB700@omega>
References: <1429691836-29316-1-git-send-email-varkab@cdac.in>
 <20150428073702.GA700@omega>
 <553F42A2.2060908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <553F42A2.2060908@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Tue, Apr 28, 2015 at 01:49:46PM +0530, Varka Bhadram wrote:
> What about the following change..?
> 
> diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
> index ac3462a..248490c 100644
> --- a/net/ieee802154/nl-phy.c
> +++ b/net/ieee802154/nl-phy.c
> @@ -175,6 +175,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>         int rc = -ENOBUFS;
>         struct net_device *dev;
>         int type = __IEEE802154_DEV_INVALID;
> +       unsigned char name_assign_type;
> 
>         pr_debug("%s\n", __func__);
> 
> @@ -190,8 +191,10 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>                 if (devname[nla_len(info->attrs[IEEE802154_ATTR_DEV_NAME]) - 1]
>                                 != '\0')
>                         return -EINVAL; /* phy name should be null-terminated */
> +               name_assign_type = NET_NAME_USER;
>         } else  {
>                 devname = "wpan%d";
> +               name_assign_type = NET_NAME_ENUM;
>         }
> 
>         if (strlen(devname) >= IFNAMSIZ)
> @@ -221,7 +224,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>         }
> 
>         dev = rdev_add_virtual_intf_deprecated(wpan_phy_to_rdev(phy), devname,
> -                                              NET_NAME_ENUM,
> +                                              name_assign_type,
>                                                type);
>         if (IS_ERR(dev)) {
>                 rc = PTR_ERR(dev);

yes that is what I meant.

- Alex
