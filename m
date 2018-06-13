Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:34979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeFMWhX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 13 Jun 2018 18:37:23 -0400
Received: from saab-desktop.localnet ([178.191.41.231]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MdWO8-1fsZJO1VzY-00PLYO for <linux-wpan@vger.kernel.org>; Thu, 14 Jun 2018
 00:37:22 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Problem using AF_PACKET with SOCK_RAW on ieee802514 devices
Date: Thu, 14 Jun 2018 00:35:40 +0200
Message-ID: <2998722.BvyPDujJB3@saab-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello everyone (again)!

I am using the linux-wpan stack with the atusb and at86rf230 drivers (rf212).
Moreover i am using raw sockets to test some userspace implemenation of a 
custom protocol. In userspace i am using (attention, golang ahead)

> protocol = htons(syscall.ETH_P_IEEE802154)
> syscall.Socket(syscall.AF_PACKET, syscall.SOCK_RAW, int(protocol))

to create a raw socket. This has been working as desired up until commit 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
id=b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba

After this commit the kernel mistakenly attaches two uninitialized bytes at 
the end of my raw data. I am currently using a patched kernel which uses the 
following code in af_packet.c (Modified the else if over Willem de Brujin's 
patch)

> } else if (sock->type != SOCK_RAW && reserve {
> 	skb_push(skb, reserve);
> }

Making this modification i can use my raw sockets with the correct length 
again. I wanted to ask if my solution is sensible here. I'm not 100% sure on 
why the patch was introduced, and my solution might not be sufficient for all 
use cases.

Another solution i thought of was to change the dev->hard_header_len but i'm 
unsure about changing these constants.

Is anyone else having this problem here, or can anyone else reproduce?
Any comments on whether my solution (or a modified one) could be upstreamed?

Thanks

-- 
Filzmaier Josef


