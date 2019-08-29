Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34997 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfH2V6F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Aug 2019 17:58:05 -0400
MIME-Version: 1.0
From: Alexander Aring <alex.aring@gmail.com>
Date: Thu, 29 Aug 2019 17:57:52 -0400
Message-ID: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
Subject: ANNOUNCE: rpld an another RPL implementation for Linux
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Cc: Michael Richardson <mcr@sandelman.ca>, Jamal Hadi Salim <jhs@mojatatu.com>, Robert Kaiser <robert.kaiser@hs-rm.de>, Martin Gergeleit <martin.gergeleit@hs-rm.de>, Kai Beckmann <kai.beckmann@hs-rm.de>, koen@bergzand.net, linux-wpan - ML <linux-wpan@vger.kernel.org>, reubenhwk@gmail.com, BlueZ development <linux-bluetooth@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, sebastian.meiling@haw-hamburg.de, Marcel Holtmann <marcel@holtmann.org>, Werner Almesberger <werner@almesberger.net>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi,

I had some free time, I wanted to know how RPL [0] works so I did a
implementation. It's _very_ basic as it only gives you a "routable"
(is that a word?) thing afterwards in a very constrained setup of RPL
messages.

Took ~1 month to implement it and I reused some great code from radvd
[1]. I released it under the same license (BSD?). Anyway, I know there
exists a lot of memory leaks and the parameters are just crazy as not
practical in a real environment BUT it works.

I changed a little bit the dependencies from radvd (because fancy new things):

- lua for config handling
- libev for event loop handling
- libmnl for netlink handling

The code is available at:

https://github.com/linux-wpan/rpld

With a recent kernel (I think 4.19 and above) and necessary user space
dependencies, just build it and run the start script. It will create
some virtual IEEE 802.15.4 6LoWPAN interfaces and you can run
traceroute from namespace ns0 (which is the RPL DODAG root) to any
other node e.g. namespace ns5. With more knowledge of the scripts you
can change the underlying topology, everybody is welcome to improve
them.

I will work more on it when I have time... to have at least something
running means the real fun can begin (but it was already fun before).

The big thing what everybody wants is source routing, which requires
some control plane for RPL into the kernel to say how and when to put
source routing headers in IPv6. I think somehow I know what's
necessary now... but I didn't implemented it, this simple
implementation just filling up routing tables as RPL supports storing
(routing table) or non-storing (source routing) modes. People tells me
to lookup frrouting to look how they do source routing, I will if I
get the chance.

It doesn't run on Bluetooth yet, I know there exists a lack of UAPI to
figure out the linklayer which is used by 6LoWPAN. I need somehow a
SLAVE_INFO attribute in netlink to figure this out and tell me some
6LoWPAN specific attributes. I am sorry Bluetooth people, but I think
you are also more interested in source routing because I heard
somebody saying it's the more common approach outside (but I never saw
any other RPL implementation than unstrung running).

Also I did something in my masters thesis to make a better parent
selection, if this implementation becomes stable I can look to get
this migrated.

Please, radvd maintainer let me know if everything is okay from your
side. As I said I reused some code from radvd. I also operate on
ICMPv6 sockets. The same to Michael Richardson unstrung [2]. If there
is anything to talk or you have complains, I can change it.

Thanks, I really only wanted to get more knowledge about routing
protocols and how to implement such. Besides all known issues, I still
think it's a good starting point.

- Alex

[0] https://tools.ietf.org/html/rfc6550
[1] https://github.com/reubenhwk/radvd
[2] https://github.com/AnimaGUS-minerva/unstrung
