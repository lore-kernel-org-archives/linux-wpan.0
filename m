Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbeLPKTR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Dec 2018 05:19:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so4733104pgs.2
        for <linux-wpan@vger.kernel.org>; Sun, 16 Dec 2018 02:19:16 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 0/6] net: lorawan: Add LoRaWAN soft MAC module
Date: Sun, 16 Dec 2018 18:18:53 +0800
Message-Id: <20181216101858.9585-1-starnight@g.ncu.edu.tw>
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>

LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.

LoRaWAN networks typically are laid out in a star-of-stars topology in
which gateways relay messages between end-devices and a central network
server at the backend.  Gateways are connected to the network server via
standard IP connections while end-devices use single hop LoRa(TM) or FSK
communication to one or many gateways.

A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
optional features (Class B, Class C ...):
* Bi-directional end-devices (Class A)
* Bi-directional end-devices with scheduled receive slots (Class B)
* Bi-directional end-devices with maximal receive slots (Class C)

This patch set add LoRaWAN class module implementing the stack,
especially the soft MAC, between socket APIs and LoRa device drivers.

socket APIs:
send and receive the data
------------------------------------------------------------------------
LoRaWAN class module implements soft MAC:
append the header/footer, encryption/decryption, timing slot and MAC
commands
------------------------------------------------------------------------
LoRa device drivers:
send and receive the messages for MAC layer
------------------------------------------------------------------------
LoRa devices

This module starts from simple and implements partial Class A
end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
More features and complexity, for example regional parameters, confirmed
data messages, join request/accept messages for Over-The-Air Activation,
MAC commands ... will be added in the future.

Jian-Hong Pan (6):
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 131 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 686 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 212 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 555 ++++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 202 ++++++++
 net/maclorawan/main.c               | 606 ++++++++++++++++++++++++
 14 files changed, 2503 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h
 create mode 100644 include/linux/lora/lorawan_netdev.h
 create mode 100644 net/lorawan/Kconfig
 create mode 100644 net/lorawan/Makefile
 create mode 100644 net/lorawan/socket.c
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/maclorawan.h
 create mode 100644 net/maclorawan/main.c

-- 
2.20.0
