Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34803 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGIS1h (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Jul 2017 14:27:37 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so110496086wrb.1
        for <linux-wpan@vger.kernel.org>; Sun, 09 Jul 2017 11:27:36 -0700 (PDT)
Date: Sun, 9 Jul 2017 20:27:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170709182728.kam75j2kpt36ulju@omega>
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
 <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega>
 <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Sun, Jul 09, 2017 at 06:22:29PM +0200, Balz wrote:
> Hi,
> I do not use the SPIDEV fragment, so I've deleted it out of the Overlay.
> The data sheet of the ATREB233 says that the SPI cut get up to 7.5 MHZ but
> decreasing it does have no positive effects.
> My SPI Configuration is specified for the BBB.
> 

mh, ok. 7Mhz could be too high, I expierenced bad behaviours on RPI with
openlabs board which has no jumpwire etc. setup.

> I do think that released the RX_Save_MODE means, that the frame buffer is
> not any more protected, so that the hardware can override the FrameBuffer.
> I've checked the value of register 0x0c periodically but it does not change
> its value while operating.  But i have no idea how to make the regmap
> volatile.
>

You need to have it volatile otherwise the read will not trigger a register
read on the bus. Maybe there exists a runtime solution to add it via debugfs
to volatile registers. I know this way only, you can run the cat on
registers afterwards and it should trigger a register read. Acutally you
could check it on you logic analyzer (but there should be a lot of
register read, search for 0x0c).

Here is the diff, very easy (recompile kernel and boot it, sure... or
just at86rf230.ko replacement):

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 548d9d026a85..858b07a4febc 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -311,6 +311,7 @@ at86rf230_reg_volatile(struct device *dev, unsigned int reg)
        case RG_VREG_CTRL:
        case RG_PLL_CF:
        case RG_PLL_DCU:
+       case RG_TRX_CTRL_2:
                return true;
        default:
                return false;

----------

I reread the datasheet and I think this will not happen, that we lost
RX_SAFE_MODE... because the datasheet [0] shows how to setup enable
"receive mode" inclusive address filtering etc. there is the
RX_SAFE_MODE setting mentioned. That says to me: we need it for hardware
init once OR when going into some RX state of at86rf233... but what an
ugly behaviour that it will drop RX_SAFE_MODE when changing state -
another question: would we always set the address filtering again then?
I don't know...

I maybe can ask "again" Atmel support for help me, but this support
interface of them are very ugly and I only got reponse the last time,
because somebody on the list had some support contract with them (I
think).

Also [0] for running in promiscuous mode (page 59) doesn't mention
anything about RX_SAFE_MODE! So question would be if RX_SAFE_MODE
working in promiscuous mode? Or does the hardware doesn't support it...
in this configuration.

The datasheet doesn't contain the information which I need to know... I
need the firmware of this chip >:-(

- Alex

[0] http://www.atmel.com/images/Atmel-8351-MCU_Wireless-AT86RF233_Datasheet.pdf (PDF PAGE 56)
