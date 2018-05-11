Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:44068 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEKPj7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 11 May 2018 11:39:59 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Date: Fri, 11 May 2018 17:39:57 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jian-Hong,

> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
> telecommunication wide area network designed to allow long range
> communications at a low bit rate among things (connected objects), such
> as sensors operated on a battery.  It can be used widely in IoT area.
> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
> access control (MAC) layer protocol for managing communication between
> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
> LoRaWAN™ Specification could be downloaded at:
> https://lora-alliance.org/lorawan-for-developers
> 
> However, LoRaWAN is not implemented in Linux kernel right now, so I am
> trying to develop it.  Here is my repository:
> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
> 
> Because it is a kind of network, the ideal usage in an user space
> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
> PF_LORAWAN ..., must be listed in the header files of glibc.
> For the driver in kernel space, the definitions also must be listed in
> the corresponding Linux socket header files.
> Especially, both are for the testing programs.
> 
> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
> Could or should we add the definitions into corresponding kernel header
> files now, if LoRaWAN will be accepted as a subsystem in Linux?

when you submit your LoRaWAN subsystem to netdev for review, include a patch that adds these new address family definitions. Just pick the next one available. There will be no pre-allocation of numbers until your work has been accepted upstream. Meaning, that the number might change if other address families get merged before yours. So you have to keep updating. glibc will eventually follow the number assigned by the kernel.

Regards

Marcel

