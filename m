Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:36486 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbEIOl2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sat, 9 May 2015 10:41:28 -0400
Received: from [5.170.86.146] (account m.petracca@sssup.it HELO [192.168.0.101])
  by sssup.it (CommuniGate Pro SMTP 5.3.15)
  with ESMTPSA id 101612939 for linux-wpan@vger.kernel.org; Sat, 09 May 2015 16:41:26 +0200
Message-ID: <554E1C92.7040306@sssup.it>
Date: Sat, 09 May 2015 16:41:22 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Ieee802154 socket problem with SIOCGIFADDR
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear all,
I am working on a BeagleboneBlack with transceiver at86rf233.

When using ieee802154 sockets in my code I have:

ret = ioctl(socketfd, SIOCGIFADDR, &ifr);

and everything works fine with kernel 3.8.13.

In kernel 4.0.1 the request fails with the following kernel messages:

[  846.038365] RTNL: assertion failed at net/mac802154/iface.c (65)
[  846.044629] CPU: 0 PID: 2350 Comm: test Not tainted 4.0.1-bone1 #1
[  846.044653] Hardware name: Generic AM33XX (Flattened Device Tree)
[  846.044747] [<c0011f35>] (unwind_backtrace) from [<c00101b5>] 
(show_stack+0x11/0x14)
[  846.044876] [<c00101b5>] (show_stack) from [<bf8502f3>] 
(mac802154_wpan_ioctl+0xb6/0x100 [mac802154])
[  846.044972] [<bf8502f3>] (mac802154_wpan_ioctl [mac802154]) from 
[<bf8b738f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
[  846.045044] [<bf8b738f>] (ieee802154_sock_ioctl [ieee802154_socket]) 
from [<c05195fb>] (sock_ioctl+0xd3/0x1bc)
[  846.045094] [<c05195fb>] (sock_ioctl) from [<c00fca4d>] 
(do_vfs_ioctl+0x2cd/0x400)
[  846.045133] [<c00fca4d>] (do_vfs_ioctl) from [<c00fcbcd>] 
(SyS_ioctl+0x4d/0x58)
[  846.045172] [<c00fcbcd>] (SyS_ioctl) from [<c000d641>] 
(ret_fast_syscall+0x1/0x44)

Do you have any idea how to solve the problem?

Best,
Matteo

