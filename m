Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34653 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRPeQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Dec 2018 10:34:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so16085311otk.1
        for <linux-wpan@vger.kernel.org>; Tue, 18 Dec 2018 07:34:15 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw> <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com> <20181218142756.GA2031@nanopsycho>
In-Reply-To: <20181218142756.GA2031@nanopsycho>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 18 Dec 2018 23:34:19 +0800
Message-ID: <CAC=mGzifRScmq6VOtWE1QSJUUrOEG81gF2C8eiYYRnmBRUbWCw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

> Tue, Dec 18, 2018 at 03:27:09PM CET, starnight@g.ncu.edu.tw wrote:
> >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >> >
> >> >This patch implements part of Class A end-devices SoftMAC defined in
> >> >LoRaWAN(TM) Specification Ver. 1.0.2:
> >> >1. End-device receive slot timing
> >> >2. Only single channel and single data rate for now
> >> >3. Unconfirmed data up/down message types
> >> >
> >> >On the other side, it defines the basic interface and operation
> >> >functions for compatible LoRa device drivers.
> >> >
> >> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >> >---
> >> >V2:
> >> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
> >> >  LoRaWAN Soft MAC modules
> >> >- Modify for Big/Little-Endian
> >> >- Use SPDX license identifiers
> >> >
> >> >V3:
> >> >- Remove the decoration word - inline of the functions
> >> >- Order local variables from longest to shortest line in the functions
> >> >- Change the calling mac_cb function to lrw_get_mac_cb macro
> >> >
> >> >V4:
> >> >- Fix the delay period between RX window#1 and window#2
> >> >- Fix by coding style report from scripts/checkpatch.pl
> >> >
> >> >V5:
> >> >- Initial rx_skb_list when it is allocated with LoRa hardware
> >> >- Check the sk_buff's data length before access it
> >> >- Deal FPort field and decrypt payload in lrw_parse_frame function
> >> >- Drop the recieved frame if parse failed
> >> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
> >> >
> >> > net/maclorawan/Kconfig  |  14 +
> >> > net/maclorawan/Makefile |   2 +
> >> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> >> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> >> > 4 files changed, 1177 insertions(+)
> >> > create mode 100644 net/maclorawan/Kconfig
> >> > create mode 100644 net/maclorawan/Makefile
> >> > create mode 100644 net/maclorawan/mac.c
> >> > create mode 100644 net/maclorawan/main.c
> >>
> >>
> >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> >> you add headers for "API" and here you implement functions. That is just
> >> weird. Does it mean you can have other implementations?
> >
> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> >This part is soft-MAC as Andreas mentioned
> >http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html
>
> Okay, that does not answer my concern about header file in one patch and
> the actual implementation of functions in another one.

Just for clarification:
- Patch "net: lorawan: Add LoRaWAN socket module" is for lorawan module
- Patch "net: lorawan: Add LoRaWAN API declaration for LoRa devices"
containes the header file "include/linux/lora/lorawan.h" which will be
included by LoRa device drivers or other kernel modules.
- Patches "net: maclorawan: Add maclorawan module declaration", "net:
maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" are for maclorawan
module.

Question 1:
Should I marge "net: maclorawan: Add maclorawan module declaration",
"net: maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" into a single patch
named "net: maclorawan: Add maclorawan as the soft-MAC module"?

Then:
For example, after a LoRa device driver includes the header
"linux/lora/lorawan.h", the device driver will call "lrw_alloc_hw()"
and pass with a "struct lrw_operations" type of variable's pointer.
It gets a type of "struct lrw_hw *" pointer.  Then, it will call
"lrw_register_hw()" to register the device.  The device driver
implements the callback functions for the "struct lrw_operations" type
of variable by it self before calls "lrw_alloc_hw()".

Question 2:
Should the patch "net: lorawan: Add LoRaWAN API declaration for LoRa
devices" also be merged into "net: maclorawan: Add maclorawan as the
soft-MAC module" or "net: maclorawan: Implement maclorawan class
module"?  Or, just leave it as a single patch?
