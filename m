Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:49418 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbdIAX2c (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 1 Sep 2017 19:28:32 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: [PATCH bluetooth-next 0/2] *** Firmware patch to support HULUSB ***
Date: Sat,  2 Sep 2017 01:28:20 +0200
Message-Id: <20170901232822.31901-1-j.filzmaier@gmx.at>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Josef Filzmaier <j.filzmaier@gmx.at>

This patch (in combination with the linux kernel patch)
introduces support for the Busware HUL stick. There are two 
commits, one that enables UART debugging (for convenience purposes)
and another that modularizes the firmware to better support
multiple hardware targets. As the Busware HUL stick uses the
at86rf212 transceiver there have been a few modifications to
support this transceiver. Otherwise this board is very similar to the
already existing atusb and rzusb boards, meaning most of the code
can be shared. (e.g. it also uses the at90usb1287 microcontroller).

Josef Filzmaier (2):
  atusb/fw: Introduce DEBUG flag
  atusb/fw: Introduction of a new board named HULUSB

 atusb/fw/Makefile              |  16 +++-
 atusb/fw/atusb.c               |  11 +++
 atusb/fw/board.c               |  68 ++++++++++------
 atusb/fw/board.h               |   9 +++
 atusb/fw/board_atusb.c         |  40 +++++++++
 atusb/fw/board_hulusb.c        | 179 +++++++++++++++++++++++++++++++++++++++++
 atusb/fw/board_hulusb.h        |  66 +++++++++++++++
 atusb/fw/board_rzusb.c         |  40 +++++++++
 atusb/fw/ep0.c                 |  15 +++-
 atusb/fw/include/atusb/atusb.h |   8 ++
 atusb/fw/include/atusb/ep0.h   |   5 --
 atusb/fw/mac.c                 |  32 --------
 atusb/fw/uart.c                |  64 +++++++++++++++
 atusb/fw/uart.h                |  25 ++++++
 14 files changed, 513 insertions(+), 65 deletions(-)
 create mode 100644 atusb/fw/board_hulusb.c
 create mode 100644 atusb/fw/board_hulusb.h
 create mode 100644 atusb/fw/uart.c
 create mode 100644 atusb/fw/uart.h

-- 
2.14.1

