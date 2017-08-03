Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:49231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdHCUvg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 3 Aug 2017 16:51:36 -0400
Received: from hella-laptop.localnet ([88.117.90.138]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MDhba-1dtMSn1ICM-00HA7J for <linux-wpan@vger.kernel.org>; Thu, 03 Aug 2017
 22:51:35 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Thu, 03 Aug 2017 22:51:34 +0200
Message-ID: <3182719.nDP85ksrvE@hella-laptop>
In-Reply-To: <71bd7b82-4e76-b129-c459-7bed5cba8fb0@osg.samsung.com>
References: <5179358.aL3rf9WXy9@hella-laptop> <71bd7b82-4e76-b129-c459-7bed5cba8fb0@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

> If you look at the tiny mac part of the firmware you will see that we
> adjust teh state handling based on the transceiver. I haven't checked
> but I think at least that parts needs to be adapted as the 212 and 230
> will be different for for the state handling (also see Alex's reply on this)
> 
> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atus
> b/fw/mac.c

Thanks, i will check that out tomorrow.

> Is there any source where I still would be able to buy/get one of these
> devices from? The main link indicates they are no longer available. I
> would love to add one to my collection. At the minimum to make sure I do
> not break it when I do a new firmware or driver updates.

The company i work for still has quite a few of those sticks. I can send you 
one. You just have to tell me where i should send it to :)

> Good to know. Interesting that you prefer to use a usb dongle on the pi
> instead of a transceiver hooked up over SPI.

We are currently using this stick running contiki and its 6LoWPAN stack. The 
next iteration of our hardware will be using the transceiver directly via SPI. 
But we need backwards compatability with this stick - and ideally a unified 
interface to send and receive data via SPI and with the stick. By using the 
linux-wpan stack we are really close to achieve this in a proper way :) 

-- 
Josef Filzmaier
