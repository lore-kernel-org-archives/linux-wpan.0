Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59716
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751754AbdHCVJi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Aug 2017 17:09:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id C351DA0D4F
        for <linux-wpan@vger.kernel.org>; Thu,  3 Aug 2017 21:10:06 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aEm-e8pZkYLO for <linux-wpan@vger.kernel.org>;
        Thu,  3 Aug 2017 21:10:04 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79E7F.dip0.t-ipconnect.de [217.247.158.127])
        by osg.samsung.com (Postfix) with ESMTPSA id 235A4A0C9D
        for <linux-wpan@vger.kernel.org>; Thu,  3 Aug 2017 21:10:03 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
 <71bd7b82-4e76-b129-c459-7bed5cba8fb0@osg.samsung.com>
 <3182719.nDP85ksrvE@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com>
Date: Thu, 3 Aug 2017 23:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <3182719.nDP85ksrvE@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/03/2017 10:51 PM, Josef Filzmaier wrote:
>> If you look at the tiny mac part of the firmware you will see that we
>> adjust teh state handling based on the transceiver. I haven't checked
>> but I think at least that parts needs to be adapted as the 212 and 230
>> will be different for for the state handling (also see Alex's reply on this)
>>
>> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atus
>> b/fw/mac.c
> 
> Thanks, i will check that out tomorrow.

Let me know how it goes.

>> Is there any source where I still would be able to buy/get one of these
>> devices from? The main link indicates they are no longer available. I
>> would love to add one to my collection. At the minimum to make sure I do
>> not break it when I do a new firmware or driver updates.
> 
> The company i work for still has quite a few of those sticks. I can send you
> one. You just have to tell me where i should send it to :)

That would be great. I will send you my address directly.

If your company would be interested to produce some more and sell them I 
would expect there would be folks willing to get some. As a data point I 
can tell you that Sysmocom sold over 100 of the newly produced ATUSB so 
far and they are still going. With the initial sold 120 this shows there 
is a target market for such devices. Maybe not big enough for your 
company though. Just something to think about. :)

> 
>> Good to know. Interesting that you prefer to use a usb dongle on the pi
>> instead of a transceiver hooked up over SPI.
> 
> We are currently using this stick running contiki and its 6LoWPAN stack. The
> next iteration of our hardware will be using the transceiver directly via SPI.
> But we need backwards compatability with this stick - and ideally a unified
> interface to send and receive data via SPI and with the stick. By using the
> linux-wpan stack we are really close to achieve this in a proper way :)

I love to hear that. :)

regards
Stefan Schmidt
