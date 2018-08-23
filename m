Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf1-f173.google.com ([209.85.210.173]:47095 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeHWUt0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 16:49:26 -0400
Received: by mail-pf1-f173.google.com with SMTP id u24-v6so3094820pfn.13
        for <linux-wpan@vger.kernel.org>; Thu, 23 Aug 2018 10:18:44 -0700 (PDT)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 0/3 net] lorawan: Add LoRaWAN soft MAC module
Date: Fri, 24 Aug 2018 01:15:40 +0800
Message-Id: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

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

Besides, I upload these patches and open discussion.  For example, the
more common/flexible interface for compatible LoRa device drivers and
protocols implementation, etc.

Another idea mentioned by Andreas: Make PF_LORA and PF_LORAWAN like
PF_INET and PF_INET6 exist at the same time.  That is also interesting.

Jian-Hong Pan (3):
  lorawan: Add LoRaWAN class module
  lorawan: Add macro and definition for LoRaWAN class modlue
  lorawan: List LORAWAN in menuconfig

 include/linux/maclorawan/lora.h     | 239 ++++++++++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   1 +
 net/Makefile                        |   1 +
 net/core/dev.c                      |   4 +-
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/lorawan.h            | 219 +++++++++
 net/maclorawan/lrwsec.c             | 237 ++++++++++
 net/maclorawan/lrwsec.h             |  57 +++
 net/maclorawan/mac.c                | 552 ++++++++++++++++++++++
 net/maclorawan/main.c               | 665 ++++++++++++++++++++++++++
 net/maclorawan/socket.c             | 700 ++++++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 17 files changed, 2701 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/maclorawan/lora.h
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/lorawan.h
 create mode 100644 net/maclorawan/lrwsec.c
 create mode 100644 net/maclorawan/lrwsec.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/main.c
 create mode 100644 net/maclorawan/socket.c

-- 
2.18.0
