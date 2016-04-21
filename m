Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34289 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbcDUSuE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 21 Apr 2016 14:50:04 -0400
Subject: Re: [PATCH bluetooth-next 1/4] ieee802154: atusb: implement
 .set_csma_params ops callback
References: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
 <b02d54d3-7f09-e946-6dbd-316f697fc422@pengutronix.de>
 <5718A4DB.3010300@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <571920D7.6000502@osg.samsung.com>
Date: Thu, 21 Apr 2016 20:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <5718A4DB.3010300@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org

Hello.

On 21/04/16 12:00, Stefan Schmidt wrote:
> Hello.
>
> On 20/04/16 20:55, Alexander Aring wrote:
>> Hi,
>>
>> On 04/19/2016 04:28 PM, Stefan Schmidt wrote:
>>> Catching up with the stack here and implement CSMA parameter setting.
>>>
>>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> all patches are fine. I want to remember this settings have no effects
>> until atusb has TX_ARET support and drops basic operation mode.
>>
>> But I am sure you already known that and this will part of next firmware
>> version.
>
> Yes, thats what I'm working on right now.
>
>> Also please care of ed-levels if they are the same on at86rf230, don't
>> known yet. There is some calculation with rssi_base_val parameter which
>> is on 2.4 Ghz always -91.
>
> I will have a look at the 230 ed level table and see if anything 
> special is needed for it when running atusb with the rzusb dongle.

I looked it up in the datasheets (231 on page 91ff and for 230 page 50ff).

Both have 85 ED levels in 1dB steps and the range is 0 - 84 on both as well.

Nothing I can see where 230 and 231 have any difference how we would 
need to handle them.

regards
Stefan Schmidt
