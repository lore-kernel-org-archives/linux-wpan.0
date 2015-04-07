Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36069 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbDGM3c (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 08:29:32 -0400
Received: by pdea3 with SMTP id a3so77561223pde.3
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 05:29:31 -0700 (PDT)
Message-ID: <5523CD93.6090102@gmail.com>
Date: Tue, 07 Apr 2015 17:59:07 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bluetooth-next 2/4] nl802154: add set interface cmd
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com> <1428407393-16005-3-git-send-email-alex.aring@gmail.com> <20150407135902.2b885270@zoidberg> <20150407122149.GA16415@omega>
In-Reply-To: <20150407122149.GA16415@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

On 04/07/2015 05:51 PM, Alexander Aring wrote:
> Hi Phoebe,
>
> On Tue, Apr 07, 2015 at 01:59:02PM +0200, Phoebe Buckheister wrote:
>> On Tue,  7 Apr 2015 13:49:51 +0200
>> Alexander Aring <alex.aring@gmail.com> wrote:
>>
>>> This patch introduce the NL802154_CMD_SET_INTERFACE command which
>>> handles setting of all wpan interface mac attributes. his will
>>> introduce an easilier wpan mac settings handling in userspace
>>> application with nl802154.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>  net/ieee802154/nl802154.c | 110
>>> ++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 110
>>> insertions(+)
>>>
>>> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
>>> index c12c07f..e2f50ba 100644
>>> --- a/net/ieee802154/nl802154.c
>>> +++ b/net/ieee802154/nl802154.c
>>> @@ -603,6 +603,108 @@ static int nl802154_get_interface(struct
>>> sk_buff *skb, struct genl_info *info) return genlmsg_reply(msg, info);
>>>  }
>>>  
>>> +static int nl802154_set_interface(struct sk_buff *skb, struct
>>> genl_info *info) +{
>>> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
>>> +	struct net_device *dev = info->user_ptr[1];
>>> +	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
>>> +	int ret;
>>> +
>>> +	if (info->attrs[NL802154_ATTR_PAN_ID]) {
>>> +		__le16 pan_id;
>>> +
>>> +		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
>>> +			return -EINVAL;
>>> +
>>> +		if (netif_running(dev))
>>> +			return -EBUSY;
>>> +
>>> +		pan_id =
>>> nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
>>> +		ret = rdev_set_pan_id(rdev, wpan_dev, pan_id);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (info->attrs[NL802154_ATTR_SHORT_ADDR]) {
>>> +		__le16 short_addr;
>>> +
>>> +		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
>>> +			return -EINVAL;
>> This is not good. You may have partially applied the requested settings
>> when you return with an error, leaving the device in some intermediate
>> state that is most likely not useful. It'd be better to first check
>> whether all settings can be applied, and then apply them all at once.
>> But even then we have a problem with rolling back some changes if a
>> command fails :/
>>
> Yes, we need kind of rollback here if the command failed. I also stumble
> over this issue. [0] Mhh, we don't have it when I do each command in their
> own CMD SET call. So then I will leave the current behaviour as it is.
>
> Some idea:
>
> Solution would be on MAC settings that we really check if everything is
> valid. Then we can set everything in the pib values, after an interface
> up this values will be "really" set, like address filter settings in phy
> registers.
>
> This works for interface settings (MAC PIB values). But for phy values
> this is more difficult, because it's directly driver-layer calls. So we
> can't predigt if an driver layer return some error then.
>
>
> If nobody complaint then I will send a v4 and remove the nl802154
> settings, or maybe somebody has a better idea.
>
> - Alex
>
> [0] http://www.spinics.net/lists/linux-wpan/msg01568.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Instead of this its better to leave the current behavior as it is.

Why do we need to complicate the process...?

-- 
Varka Bhadram

