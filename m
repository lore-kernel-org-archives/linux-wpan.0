Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:52298
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965430AbdIZKQr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2017 06:16:47 -0400
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw>
 <fda61128-d27a-8b08-5a31-97e8a57677fe@osg.samsung.com>
 <CAC=mGzja5h1xq66au-CX92oARptFaFGjZcOH5KU0oujBfH4vvw@mail.gmail.com>
 <d463f3a2-e12b-a708-1ade-e9309fa068fa@osg.samsung.com>
 <CAC=mGzi+wD-Fob6NMviZyZHGpekhAGvuXjB45P71zL6cc2+88g@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <bb72c12e-1072-9bfd-f76b-0b454bdf6da4@osg.samsung.com>
Date: Tue, 26 Sep 2017 12:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAC=mGzi+wD-Fob6NMviZyZHGpekhAGvuXjB45P71zL6cc2+88g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: StarNight <starnight@g.ncu.edu.tw>
Cc: Alexander Aring <alex.aring@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Xue Liu <liuxuenetmail@gmail.com>

Hello.

[I dropped the device tree list as this is really unrelated to them now]

On 09/24/2017 04:53 PM, StarNight wrote:
> Hi,
> 
> I have written a note which is reordered and extracted from LoRaWAN 1.0.2.
> https://hackmd.io/s/S1kg6Ymo-#
> Hope this wiil be easier for readers.
> 
> LoRaWAN defiened by LoRa Alliance is the MAC layer over LoRa PHY.
> (The relation between LoRaWAN and LoRa PHY)

Thanks a lot for putting thee notes together.

Reading the MAC frame format I see not much in common with IEEE 802.15.4.
Maybe they really refer to the link layer security parts only.

Given that your driver operates in LoRa and thus will not work with any
other 802.15.4 device I would not apply it to the ieee802154 subsystem.

The driver is a good start for real LoRa support in the Linux kernel thought.
I would very much welcome such support and would also be happy to help.
(Not before November though as my next weeks will be to busy)

Xue (in CC now) also has an interest in LoRa support in the Linux Kernel and
already started some work if I remember correctly. If you both are interested
to actively contribute to such a subsystem I would be happy to help getting
it into the mainline kernel.

Please let me both know what you think. I can ask for a linux-lora
(or linux-lpwan?) list on vger to get the ball rolling for initial discussions.

regards
Stefan Schmidt
