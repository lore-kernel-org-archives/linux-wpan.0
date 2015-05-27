Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54429 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972AbbE0Lta (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 07:49:30 -0400
Message-ID: <5565AF46.8040606@osg.samsung.com>
Date: Wed, 27 May 2015 13:49:26 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] atusb: add support for at86rf230
References: <1432471383-5029-1-git-send-email-alex.aring@gmail.com> <5565838F.60107@osg.samsung.com> <20150527114635.GD712@omega>
In-Reply-To: <20150527114635.GD712@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 27/05/15 13:46, Alexander Aring wrote:
> Hi Stefan,
>
> On Wed, May 27, 2015 at 10:42:55AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 24/05/15 14:43, Alexander Aring wrote:
>>> This patch adds support for the at86rf230 version check which is used
>>> by the rzusb stick.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> Cc: Stefan Schmidt <stefan@osg.samsung.com>
>>> ---
>>>   drivers/net/ieee802154/atusb.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
>>> index 1e18774..5b6bb9a 100644
>>> --- a/drivers/net/ieee802154/atusb.c
>>> +++ b/drivers/net/ieee802154/atusb.c
>>> @@ -515,7 +515,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
>>>   			man_id_1, man_id_0);
>>>   		goto fail;
>>>   	}
>>> -	if (part_num != 3) {
>>> +	if (part_num != 3 && part_num != 2) {
>>>   		dev_err(&usb_dev->dev,
>>>   			"unexpected transceiver, part 0x%02x version 0x%02x\n",
>>>   			part_num, version_num);
>> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
>>
> is this patch okay, even when it's the same product id? Possible
> "stronger" test would be to check if atusb then part_num != 3, if rzusb
> then != 2. Or can we add support for this later?
Yes, we can get this in like it is right now. That enables you and maybe 
others to work with it.

Once we have a separate product id for rzusb we can adjust the checking 
here and also print out on what hardware (atusb or rzusb) we are running 
on. But that can wait until we have the firmware things sorted out for it.

regards
Stefan Schmidt

> - Alex

