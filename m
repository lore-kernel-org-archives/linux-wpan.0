Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:41363 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdGGKSb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 7 Jul 2017 06:18:31 -0400
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 3x3rD550NFzyVS
        for <linux-wpan@vger.kernel.org>; Fri,  7 Jul 2017 12:18:29 +0200 (CEST)
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id OJvt33YRSqzq for <linux-wpan@vger.kernel.org>;
        Fri,  7 Jul 2017 12:18:29 +0200 (CEST)
Received: from [IPv6:2001:a61:2155:5c01:c83b:a7ff:d357:a611] (unknown [IPv6:2001:a61:2155:5c01:c83b:a7ff:d357:a611])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by postout1.mail.lrz.de (Postfix) with ESMTPSA id 3x3rD51Zh7zyVP
        for <linux-wpan@vger.kernel.org>; Fri,  7 Jul 2017 12:18:29 +0200 (CEST)
From: Balz <s.balz@hm.edu>
Subject: Resend : Reading corrupt IEEE 802.15.4 packages with the AT-REB233
 and the BeagleBone Black with IWPAN
Message-ID: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
Date: Fri, 7 Jul 2017 12:18:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear IWPAN Team,

I’m not sure if you received my last mail because it get's declared as 
spam because of using HTML.
Maybe there is a Problem with the Attachment (I’ve upload it to Dropbox).

Original Mail:
We (university of applied since Munich) are developing a multi-sensor 
Sniffer for IEEE 802.15.4 Networks, basted on your Linux-WPAN and the 
AT86RF233 Chip (with the REB233-XPRO).
We connect the REB233-XPRO with a BeagleBone Black and implement the 
AT-REB233 chip as Network interface (via iwpan).
The Beaglebone (BBB) is with at AT-REB233 via a 1Mhz SPI connected.

The AT-REB is so configured, that after a frame has received it send a 
interrupt to the BBB with can then read out the Frame Buffer.
The connection with the BeagleBone Works fine, but sometimes the network 
interface reads corrupted date.  That package starts normal but after 
+/- 6 Byte the frame gets (at most) periodical byte sequence like (0xff 
0 x30 0xf0 0x00 | 0xff 0 x30 0xf0 0x00 | ….).

We could evaluate, that the packages get corrupt after following situation:
- AT-REB233 sends a first interrupt
- The BBB ask what kind of interrupt it is and starts reading the 
Framebuffer
- The AT-REB sends a second interrupt after about the sixed Byte of the 
Framebuffer. Since this second interrupt the content of the Frame Buffer 
is corrupt (detectable by the byte sequence).
After the BBB has read the (corrupt) framebuffer it starts a new read 
(because of the second interrupt signalized that there are new data 
available), usually this is a ACK.
Might it be possible that the AT-REB233 received a new Data-Frame and 
overwrite the current Framebuffer after receiving the new (ACK)Package ?
The AT86RF233 does have a Framebuffer Protection (Section 9.3 in the 
Datasheet of the AT86RF233) (Dynamic Frame Buffer Reg 0x0C bit: 7 
section 11.8 in the Datasheet) ore by setting PLL_ON in the TRX_STATE 
Register (Reg: 0x02 9.3.1)
But I do not see such a configuration. May I have overseen it?

I have a PCAP package and a Logic dump attached. The logic dump could be 
analysed with the SALEAE Logic Tool(https://www.saleae.com/downloads )
This errors could be seen e.g. at and sec. :
- 10.099
- 11.428
- 11.433
- 28.218
I would be very grateful if you can help us with this problem.

Attachment’s : 
https://www.dropbox.com/sh/3mj7o7vo8hsjp0j/AADHI__q4fqZ51S1Ib_yyrNja?dl=0
Best Regards
Sebastian Balz

