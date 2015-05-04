Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34464 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbEDM4B (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 08:56:01 -0400
Received: by wgso17 with SMTP id o17so149252304wgs.1
        for <linux-wpan@vger.kernel.org>; Mon, 04 May 2015 05:55:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG9Fz+vc9C_gnL-FR+7D72bxGg_jNpRkc8z_5mgiBwBZoPmuug@mail.gmail.com>
References: <CAG9Fz+sU3k2U03szspUF3oKnZOSrJrs=aG1Tgs=dnxxJ74=-3Q@mail.gmail.com>
	<20150504084432.GA2385@omega.Speedport_W_921V_1_37_000>
	<CAG9Fz+vc9C_gnL-FR+7D72bxGg_jNpRkc8z_5mgiBwBZoPmuug@mail.gmail.com>
Date: Mon, 4 May 2015 14:55:59 +0200
Message-ID: <CAG9Fz+tkmWqzMObvFDiRY9S4oJ8infbsW1txh117QJZ5SBzY-Q@mail.gmail.com>
Subject: Re: Open task "missing enums", latest standard and where to put enums?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-05-04 11:23 GMT+02:00 Christoffer Holmstedt
<christoffer.holmstedt@gmail.com>:
> 2015-05-04 10:44 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> Hi,
>>
>> On Mon, May 04, 2015 at 08:08:38AM +0200, Christoffer Holmstedt wrote:
>>> Hi
>>> I'm looking in to the first open task about missing enums.
>>>
>>> ### Is the latest standard from 2011?
>>> Is the IEEE Std 802.15.4-2011 [1] the latest one to use?
>>>
>>
>> yes.
>>
>>> How much attention should I pay to the more specific ones such as
>>> 802.15.4(g) for smart metering utility networks or (p) for Rail
>>> communication and control? (I assume these are more about "policy" and
>>> perhaps not so much about the "mechanism" to be implemented in the
>>> linux kernel but I could be wrong here).
>>>
>>
>> I would say "yes" here too, but I asked this myself some time ago. maybe
>> some other people can answer your question here.
>>
>> What I know is in case of at86rf2xx transceivers:
>>
>> at86rf230 is -2003
>> at86rf231 is -2006
>> at86rf233 is -2011
>>
>> but you should follow the actual standard 2011, they have also some
>> notes like:
>>
>> 5.2.1.1.7 Frame Version field
>>
>> "This field shall be set to 0x00 to indicate a frame compatible with
>>  802.15.4-2003".
>>
>> Which we should lookup then in 2003 what's the different handling of this.
>>
>>
>> For all others transceivers in the datasheet stands 2003, 2006 or 2011
>> standard. I never saw a transceiver which have some additional character
>> which follows a 802.15.4(g) standard, but maybe they don't exists yet.
>> ;-) And also we don't handle the 2003 standard right at the moment, e.g.
>> check/create on frame version field. We also don't support the at86rf230
>> at the moment and this is maybe one reason, all others transceivers are
>> hopefully -2006 or -2011.
>>
>> I also never tried to speak to a -2003 transceiver and I am not sure if
>> this works correctly.

I just noticed a discussion on the IETF 6tisch mailing list about
versioning/referencing IEEE standards from 4 days ago. One post put
some clarity for me on the world of 802.15.4 standards.

Here it is: https://www.ietf.org/mail-archive/web/6tisch/current/msg03329.html

Regards
-- 
Christoffer Holmstedt
