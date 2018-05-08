Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:37392 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754307AbeEHPdD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 8 May 2018 11:33:03 -0400
Received: by mail-ot0-f169.google.com with SMTP id 77-v6so36549638otd.4
        for <linux-wpan@vger.kernel.org>; Tue, 08 May 2018 08:33:03 -0700 (PDT)
MIME-Version: 1.0
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 8 May 2018 23:33:01 +0800
Message-ID: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Subject: [RFC] net: Add new LoRaWAN subsystem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

A Low-Power Wide-Area Network (LPWAN) is a type of wireless
telecommunication wide area network designed to allow long range
communications at a low bit rate among things (connected objects), such
as sensors operated on a battery.  It can be used widely in IoT area.
LoRaWAN, which is one kind of implementation of LPWAN, is a medium
access control (MAC) layer protocol for managing communication between
LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
LoRaWAN=E2=84=A2 Specification could be downloaded at:
https://lora-alliance.org/lorawan-for-developers

However, LoRaWAN is not implemented in Linux kernel right now, so I am
trying to develop it.  Here is my repository:
https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN

Because it is a kind of network, the ideal usage in an user space
program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
other socket APIs.  Therefore, the definitions like AF_LORAWAN,
PF_LORAWAN ..., must be listed in the header files of glibc.
For the driver in kernel space, the definitions also must be listed in
the corresponding Linux socket header files.
Especially, both are for the testing programs.

Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
Could or should we add the definitions into corresponding kernel header
files now, if LoRaWAN will be accepted as a subsystem in Linux?

Thanks,
Jian-Hong Pan
