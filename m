Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38206 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870AbcGXKDN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sun, 24 Jul 2016 06:03:13 -0400
Subject: Re: Packets not reaching lowpan interface
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
 <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <1a77b106-bc45-e5da-e122-d4e0713539d8@pengutronix.de>
Date: Sun, 24 Jul 2016 12:03:06 +0200
MIME-Version: 1.0
In-Reply-To: <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aaron Sowry <aeneby@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 07/24/2016 10:49 AM, Aaron Sowry wrote:
> Hi,
> 
> Not sure if this is the right place to ask since I'm not sure exactly
> where the problem lies, but hopefully someone here can point me in the
> right direction.
> 
> I have a functioning RIOT node (openmote-cc2538) and an RPi 3 with an
> OpenLabs at86rf233 radio installed. Briefly, here's what I've done on
> the RPi:
> 
> 1) Built and installed a more recent kernel (4.7.0-rc7-v7+) to better
> support the radio, following roughly the instructions here [1], and
> enabled the relevant overlay. At this point I have a working wpan0
> interface which I can happily create a monitor interface on and sniff
> packets with.
> 
> 2) Created a lowpan interface:
> 
> # ip link set wpan0 down
> # iwpan phy phy0 set channel 0 26
> # iwpan dev wpan0 set pan_id 0x0023
> # ip link set wpan0 up
> # ip link set lowpan0 up
> 
> # ifconfig lowpan0
> lowpan0   Link encap:UNSPEC  HWaddr
> 4E-F9-73-3C-83-EA-79-6A-00-00-00-00-00-00-00-00
>           inet6 addr: fe80::4cf9:733c:83ea:796a/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:41 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1
>           RX bytes:0 (0.0 B)  TX bytes:7790 (7.6 KiB)
> 
> So in theory, I should be able to ping this link-local IP from the
> RIOT node (same channel and PAN) and expect a response, but I never
> get one. Sniffing packets OTA shows that the ping is being sent
> correctly.
> 
> The weird part is that running 'tcpdump -i wpan0' on the RPi during
> the ping shows that the pings are being received at link layer,
> however running 'tcpdump -i lowpan0' produces nothing. So it's like
> the packets are not traversing the whole stack for some reason.
> 
> If I ping the RIOT node from the RPi, my packet sniffer (running on a
> different RPi) shows both the query and the response being sent, but
> of course since the packet never makes it all the way up the stack,
> the ping6 application reports 100% packet loss.
> 
> Is there something I'm overlooking?
> 

there is currently a bug in 6LoWPAN because RIOT-OS do a stupid
handling. This stupid behaviour is that it doesn't set the intra pan id
but doing intra pan communication src_pan == dst_pan, this will fill the
payload with two bytes more than necessary.

I detected this issue some days ago by running current git RIOT-OS
version. At first I fixed it on the linux side that we can deal with
such frames [0]. On the RIOT-Summit I saw other board communication
which does set this bit again.

I don't know which version on RIOT does this behaviour, we should open
an issue at github RIOT-OS project if this issue still exists. Please
check if you seeing on wireshark that it is intra pan communication but
the intra pan id bit isn't set.

Another chance to fix this issue is to backport [0] and some other
patches to get it working.

We should really open a issue on that, that this is broken @RIOT-OS git
version. Maybe somebody can bisect it? To get the broken commit id.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg03977.html
