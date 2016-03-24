Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33118 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcCXIEo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Mar 2016 04:04:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so263304057wml.0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Mar 2016 01:04:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F25FF6.4040500@osg.samsung.com>
References: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
	<56F25FF6.4040500@osg.samsung.com>
Date: Thu, 24 Mar 2016 09:04:43 +0100
Message-ID: <CAPpUg6MyVaH4rVH4GJv8LKiyH0CM9UpKYCMkhPAzxX3EEWKzJg@mail.gmail.com>
Subject: Re: at86rf212B 868Mhz
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Thanks Stefan, Ok so my tests show that it doesn't work for the
moment. I may go on Kernel 4.3 if you made any changes on this.


2016-03-23 10:20 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> On 22/03/16 19:48, Baptiste Clenet wrote:
>>
>> Hi,
>>
>> I've got two devices with a at86rf212B onboard: device A (ohter OS
>> with at86rf212b driver) sending frame to device B  (running on Kernel
>> 4.1 with the at86rf230 driver)
>> Both has got a 868MHz antenna.
>> Case 1: I set channel to 5 and page to 0 (914MHz according to
>> datasheet) to both of them, it works fine, I can receive and send
>> frames.
>> Case 2: I set channel to 0 and page to 0 (868MHz according to
>> dataheet) and I can't receive or send any frames.
>>
>> Alexander, have you already tried to run on 868MHz?
>>
>
> I'm not Alex but I can tell you that neither he or myself have 868 MHz
> capable hardware so we never have been able to test that on our side.
>
> There could still be a bug in the driver or the iwpan page/channel setting
> somewhere. Printing out the values you get in the kernel (first the ones you
> get over netlink from iwpan and second the ones being set into the register)
> might give you a first clue if they actually compare to what the chip
> expects.
>
> regards
> Stefan Schmidt



-- 
Baptiste
