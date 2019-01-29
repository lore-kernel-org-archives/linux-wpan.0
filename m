Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfA2FBo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 29 Jan 2019 00:01:44 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 0/4] net: EnOcean prototype driver
Date: Tue, 29 Jan 2019 06:01:26 +0100
Message-Id: <20190129050130.10932-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, support@enocean.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Hello,

This series implements a serdev driver for the EnOcean Serial Protocol (ESP).

It follows previous weekend's Z-Wave serdev driver [1], exploring various
wireless technologies surrounding LoRa/FSK/OOK in quest of a solid PHY layer.

The EnOcean Radio Protocol 1 (ERP1) is based on ASK; ERP2 on FSK for sub-GHz
and on IEEE 802.15.4 for 2.4 GHz. The company EnOcean also manufactures some
BLE based devices unrelated to ERP or this patchset.

ESP3 has been tested with basic host -> module -> host communication and
radio transmission via PF_PACKET datagram sockets.
ESP2 has only been tested for telegram checksums and served for abstraction.
Both handle the same radio telegrams, with transparent translation for ESP2.

Note how much further this implementation got on one weekend plus an evening
in comparison with [1], thanks to solid, open protocol documentation.

Unlike Z-Wave's Command Classes, EnOcean relies on a Learn-in process to
interpret incoming telegram data from a certain device ID correctly, i.e.,
the receiver needs to maintain a mapping from device ID to Equipment Profile.

By exposing the radio (sub)telegrams on a socket, userspace still gets to
handle all the gory Equipment Profile dependent data, while abstracting the
ESP-specific frames and checksumming algorithms. So far no netlink layer was
required; BaseID and receiver sensitivity would in theory be ESP2 options,
and ESP3 offers several more. The selection of ESP2 vs. ESP3 is done via DT.

Again, these have been tested as external modules and lack Kbuild/Makefile
integration with the net subsystem for now. A test program is at [2].

The receive path could not yet be tested for lack of devices and is left out.

Have a lot of fun!

Cheers,
Andreas

[1] https://patchwork.ozlabs.org/patch/1028209/
[2] https://github.com/afaerber/lora-modules/blob/master/txenocean.c

P.S. My conclusion here is that PF_PACKET is a viable alternative to my
current PF_LORA, if we extend my recent cfglora patches with more commands:
https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000154.html
Only downside was that for lack of an include/uapi/linux/enocean.h header
file I had to resort to a patch not included here to define ETH_P_ERP2 etc.
for lack of obvious ways to prepend my own if_{ether,arp}.h files.

Andreas Färber (4):
  net: Reserve protocol identifiers for EnOcean
  net: Prepare EnOcean device drivers
  net: enocean: Add ESP3 driver
  net: enocean: Prepare ESP2 support

 drivers/net/enocean/Makefile       |   7 +
 drivers/net/enocean/enocean.c      | 124 +++++++++++++
 drivers/net/enocean/enocean_esp.c  | 287 ++++++++++++++++++++++++++++
 drivers/net/enocean/enocean_esp.h  |  46 +++++
 drivers/net/enocean/enocean_esp2.c | 276 +++++++++++++++++++++++++++
 drivers/net/enocean/enocean_esp3.c | 372 +++++++++++++++++++++++++++++++++++++
 include/linux/enocean/dev.h        |  23 +++
 include/uapi/linux/if_arp.h        |   1 +
 include/uapi/linux/if_ether.h      |   2 +
 9 files changed, 1138 insertions(+)
 create mode 100644 drivers/net/enocean/Makefile
 create mode 100644 drivers/net/enocean/enocean.c
 create mode 100644 drivers/net/enocean/enocean_esp.c
 create mode 100644 drivers/net/enocean/enocean_esp.h
 create mode 100644 drivers/net/enocean/enocean_esp2.c
 create mode 100644 drivers/net/enocean/enocean_esp3.c
 create mode 100644 include/linux/enocean/dev.h

-- 
2.16.4
