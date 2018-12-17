Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34052 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeLQOKJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Dec 2018 09:10:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so12442553wrw.1
        for <linux-wpan@vger.kernel.org>; Mon, 17 Dec 2018 06:10:08 -0800 (PST)
Date: Mon, 17 Dec 2018 15:02:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Message-ID: <20181217140233.GG2096@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216101858.9585-6-starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org

Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
>LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
>
>This patch implements part of Class A end-devices SoftMAC defined in
>LoRaWAN(TM) Specification Ver. 1.0.2:
>1. End-device receive slot timing
>2. Only single channel and single data rate for now
>3. Unconfirmed data up/down message types
>
>On the other side, it defines the basic interface and operation
>functions for compatible LoRa device drivers.
>
>Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>---
>V2:
>- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>  LoRaWAN Soft MAC modules
>- Modify for Big/Little-Endian
>- Use SPDX license identifiers
>
>V3:
>- Remove the decoration word - inline of the functions
>- Order local variables from longest to shortest line in the functions
>- Change the calling mac_cb function to lrw_get_mac_cb macro
>
>V4:
>- Fix the delay period between RX window#1 and window#2
>- Fix by coding style report from scripts/checkpatch.pl
>
>V5:
>- Initial rx_skb_list when it is allocated with LoRa hardware
>- Check the sk_buff's data length before access it
>- Deal FPort field and decrypt payload in lrw_parse_frame function
>- Drop the recieved frame if parse failed
>- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
>
> net/maclorawan/Kconfig  |  14 +
> net/maclorawan/Makefile |   2 +
> net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 1177 insertions(+)
> create mode 100644 net/maclorawan/Kconfig
> create mode 100644 net/maclorawan/Makefile
> create mode 100644 net/maclorawan/mac.c
> create mode 100644 net/maclorawan/main.c


I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
you add headers for "API" and here you implement functions. That is just
weird. Does it mean you can have other implementations?


Also, you don't really have any user of this API in the set. Please
introduce at least 1 driver, preferably more (I see that Andreas has
multiple ones in his patchset). You cannot push kernel infrastructure
without kernel user.
