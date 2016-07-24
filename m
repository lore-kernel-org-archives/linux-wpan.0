Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35921 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcGXItv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Jul 2016 04:49:51 -0400
Received: by mail-wm0-f49.google.com with SMTP id q128so101561403wma.1
        for <linux-wpan@vger.kernel.org>; Sun, 24 Jul 2016 01:49:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
From: Aaron Sowry <aeneby@gmail.com>
Date: Sun, 24 Jul 2016 20:49:47 +1200
Message-ID: <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
Subject: Re: Packets not reaching lowpan interface
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

Not sure if this is the right place to ask since I'm not sure exactly
where the problem lies, but hopefully someone here can point me in the
right direction.

I have a functioning RIOT node (openmote-cc2538) and an RPi 3 with an
OpenLabs at86rf233 radio installed. Briefly, here's what I've done on
the RPi:

1) Built and installed a more recent kernel (4.7.0-rc7-v7+) to better
support the radio, following roughly the instructions here [1], and
enabled the relevant overlay. At this point I have a working wpan0
interface which I can happily create a monitor interface on and sniff
packets with.

2) Created a lowpan interface:

# ip link set wpan0 down
# iwpan phy phy0 set channel 0 26
# iwpan dev wpan0 set pan_id 0x0023
# ip link set wpan0 up
# ip link set lowpan0 up

# ifconfig lowpan0
lowpan0   Link encap:UNSPEC  HWaddr
4E-F9-73-3C-83-EA-79-6A-00-00-00-00-00-00-00-00
          inet6 addr: fe80::4cf9:733c:83ea:796a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:41 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1
          RX bytes:0 (0.0 B)  TX bytes:7790 (7.6 KiB)

So in theory, I should be able to ping this link-local IP from the
RIOT node (same channel and PAN) and expect a response, but I never
get one. Sniffing packets OTA shows that the ping is being sent
correctly.

The weird part is that running 'tcpdump -i wpan0' on the RPi during
the ping shows that the pings are being received at link layer,
however running 'tcpdump -i lowpan0' produces nothing. So it's like
the packets are not traversing the whole stack for some reason.

If I ping the RIOT node from the RPi, my packet sniffer (running on a
different RPi) shows both the query and the response being sent, but
of course since the packet never makes it all the way up the stack,
the ping6 application reports 100% packet loss.

Is there something I'm overlooking?

[1] https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbian-image-with-6LoWPAN-support#4-new-linux-kernels-for-the-pi

/Aaron
