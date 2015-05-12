Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33648 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbbELI2X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 04:28:23 -0400
Received: by wgin8 with SMTP id n8so156928699wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 01:28:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55517906.2060204@gmail.com>
References: <19096.1431373298@sandelman.ca>
	<55517906.2060204@gmail.com>
Date: Tue, 12 May 2015 10:28:21 +0200
Message-ID: <CAG9Fz+uwxkkAGtM=8asYNQh5PO9o9uJiSSaep_y4UmZnZk=Ohw@mail.gmail.com>
Subject: Re: testing and building for RPI
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Michael Richardson <mcr@sandelman.ca>, linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>

2015-05-12 5:52 GMT+02:00 Varka Bhadram <varkabhadram@gmail.com>:
> On 05/12/2015 01:11 AM, Michael Richardson wrote:
>
>> I ordered the 802.15.4 module for PI's GPIO pins from:
>>   http://openlabs.co/OSHW/Raspberry-Pi-802.15.4-radio
>>
>> I haven't yet gotten to caring if I got the right dtbs file,
>> as discussed here:
>>    http://forum.openlabs.co/general-oshw-discussion/6lowpan-kernel-on-rpi/

hmm, old post I should probably answer it with my final solution which
is "just do a clean build and it works as intended".

>> Will I have to do some dtbs hacking?

At [1] I have the device tree patch I apply for RPi model B (i.e. not
B+). So if you have B+ just copy the information there to the correct
dts file.

>>
> You can directly use linux-wpan-next tree directly, which has the basic
> support for RPI. No need to rebase it on rpi kernel.

I use the bluetooth-next tree and more specifically a 4.1.0-rc1 commit
from late april on my two RPi model B. I haven't made any "release" of
my scripts [2] but they should all work at the moment from master
branch. If you are running Ubuntu 14.04 and have RPi model B just
follow the README and you should get a working kernel image and dtb
file built.

[1] https://github.com/christofferholmstedt/linux-wpan-dev/blob/master/scripts/linux_kernel_patches/0001-arm-dts-Update-RPi-B-dts-for-Openlabs-802.15.4-trans.patch
[2] https://github.com/christofferholmstedt/linux-wpan-dev

Don't hesitate to send me an email if the scripts don't work.
-- 
Christoffer Holmstedt
