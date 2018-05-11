Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33248 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeEKIQq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 11 May 2018 04:16:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id x12-v6so1928664wmc.0
        for <linux-wpan@vger.kernel.org>; Fri, 11 May 2018 01:16:45 -0700 (PDT)
Date: Fri, 11 May 2018 10:16:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
Message-ID: <20180511081643.GA1869@nanopsycho>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Tue, May 08, 2018 at 05:33:01PM CEST, starnight@g.ncu.edu.tw wrote:
>A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>telecommunication wide area network designed to allow long range
>communications at a low bit rate among things (connected objects), such
>as sensors operated on a battery.  It can be used widely in IoT area.
>LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>access control (MAC) layer protocol for managing communication between
>LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>LoRaWAN™ Specification could be downloaded at:
>https://lora-alliance.org/lorawan-for-developers
>
>However, LoRaWAN is not implemented in Linux kernel right now, so I am
>trying to develop it.  Here is my repository:
>https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN

Link to some out-of-tree module is not enough.
If you want anyone to look at this and comment, you need to base your
work on top of kernel git (net-next for example) and send a patch/patchset.


>
>Because it is a kind of network, the ideal usage in an user space
>program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>PF_LORAWAN ..., must be listed in the header files of glibc.
>For the driver in kernel space, the definitions also must be listed in
>the corresponding Linux socket header files.
>Especially, both are for the testing programs.
>
>Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
>Could or should we add the definitions into corresponding kernel header
>files now, if LoRaWAN will be accepted as a subsystem in Linux?
>
>Thanks,
>Jian-Hong Pan
