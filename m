Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34674 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbeKFCRg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Nov 2018 21:17:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1-v6so4497586pgq.1
        for <linux-wpan@vger.kernel.org>; Mon, 05 Nov 2018 08:57:01 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V2 0/7] net: lorawan: Add LoRaWAN soft MAC module
Date: Tue,  6 Nov 2018 00:55:38 +0800
Message-Id: <20181105165544.5215-1-starnight@g.ncu.edu.tw>
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, "David S . Miller" <davem@davemloft.net>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>, Jian-Hong Pan <starnight@g.ncu.edu.tw>

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

Jian-Hong Pan (7):
  net: lorawan: Add macro and definition for LoRaWAN
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 137 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/core/dev.c                      |   4 +-
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 681 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 209 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 522 +++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 199 ++++++++
 net/maclorawan/main.c               | 600 ++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 20 files changed, 2473 insertions(+), 5 deletions(-)
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
2.19.1
