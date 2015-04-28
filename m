Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32991 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbbD1Iab (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Apr 2015 04:30:31 -0400
Received: by pacwv17 with SMTP id wv17so135539945pac.0
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2015 01:30:30 -0700 (PDT)
Message-ID: <553F4511.2060007@gmail.com>
Date: Tue, 28 Apr 2015 14:00:09 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] cfg802154: pass name_assign_type to rdev_add_virtual_intf()
References: <1429691836-29316-1-git-send-email-varkab@cdac.in> <20150428073702.GA700@omega> <553F42A2.2060908@gmail.com> <20150428082922.GB700@omega>
In-Reply-To: <20150428082922.GB700@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On 04/28/2015 01:59 PM, Alexander Aring wrote:
> On Tue, Apr 28, 2015 at 01:49:46PM +0530, Varka Bhadram wrote:
>> What about the following change..?
>>
>> diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
>> index ac3462a..248490c 100644
>> --- a/net/ieee802154/nl-phy.c
>> +++ b/net/ieee802154/nl-phy.c
>> @@ -175,6 +175,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>>         int rc = -ENOBUFS;
>>         struct net_device *dev;
>>         int type = __IEEE802154_DEV_INVALID;
>> +       unsigned char name_assign_type;
>>
>>         pr_debug("%s\n", __func__);
>>
>> @@ -190,8 +191,10 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>>                 if (devname[nla_len(info->attrs[IEEE802154_ATTR_DEV_NAME]) - 1]
>>                                 != '\0')
>>                         return -EINVAL; /* phy name should be null-terminated */
>> +               name_assign_type = NET_NAME_USER;
>>         } else  {
>>                 devname = "wpan%d";
>> +               name_assign_type = NET_NAME_ENUM;
>>         }
>>
>>         if (strlen(devname) >= IFNAMSIZ)
>> @@ -221,7 +224,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>>         }
>>
>>         dev = rdev_add_virtual_intf_deprecated(wpan_phy_to_rdev(phy), devname,
>> -                                              NET_NAME_ENUM,
>> +                                              name_assign_type,
>>                                                type);
>>         if (IS_ERR(dev)) {
>>                 rc = PTR_ERR(dev);
> yes that is what I meant.
>
> - Alex

Thanks.. I will send the updated patch.

-- 
Varka Bhadram

