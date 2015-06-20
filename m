Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35760 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbFTILb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Jun 2015 04:11:31 -0400
Received: by wgbhy7 with SMTP id hy7so105204480wgb.2
        for <linux-wpan@vger.kernel.org>; Sat, 20 Jun 2015 01:11:29 -0700 (PDT)
Date: Sat, 20 Jun 2015 10:11:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: At86rf233 RSSI
Message-ID: <20150620081116.GA730@omega>
References: <55844786.5080102@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55844786.5080102@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jun 19, 2015 at 06:47:02PM +0200, Matteo Petracca wrote:
> Hi,
> is there any way to get RSSI form the transceiver?
> 

not directly. I think it depends on your use case.

First make you clear what receceiving indicator which you want, there
exists more than RSSI in 802.15.4.

1. LQI (some indicator, standard doesn't say much about this value and
        how it's caluclated, in case of at86rf233 it's just "connection
	nearly to death (<0xFF) or some "good" connection indicated by
	0xFF. -> means packet quality.

2. RSSI

3. ED (energy detection, normally use to check if the channel is clear,
       there exists CCA modes with thresholds to specify the
       threshold).

Refer to atmels FAQ [0].



It depends on your use case what you want. Normally you want some
mapping from "latest frame from node xxx" and the measured LQI, RSSI, ED
values when the frame was received. And this is what we plan to do. Nodes
are indicated by the used address then.

We don't have such feature now, but what you could do is to readout the
register value over regmap.



RSSI (in case of RPI, spi name differs maybe):

echo $(( 0x`cat /sys/kernel/debug/regmap/spi32766.0/registers | sed -ne "s/06: \(.*\)/\1/p"` & 0x1f ))

This will readout the RSSI value register. But this doesn't working
well. Because the datasheet said:

"It is not recommended reading the RSSI value when using the Extended Operating
Modes or Smart Receiving, see Section 11.10.2.2. Instead, the automatically generated
ED value should be used, see Section 8.5."

I suppose this is because the "Smart Receiving" why I read only 0 or 1
out. You need to hack the driver and turn it off, it's default enabled.
I didn't test it.



ED (in case of RPI, spi name differs maybe):

cat /sys/kernel/debug/regmap/spi32766.0/registers  | sed -ne "s/07: \(.*\)/\1/p"

The above RSSI value said it's recommended using the ED value which
automatically updated (when exactly, depends on many things).


This is not a quite solution and we should provide this information in
some mapping for dumping it in userspace/"kernelspace" and updated the
values on each received frame from $NEIGHBOR_NODE.

- Alex

[0] http://atmel.force.com/support/articles/en_US/FAQ/Understanding-RSSI-ED-and-LQI-in-IEEE802-15-4-transceivers-and-SoCs
--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
