Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from demetra.cnit.it ([217.9.64.12]:34324 "EHLO mail.cnit.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbdG0MrU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 27 Jul 2017 08:47:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.cnit.it (Postfix) with ESMTP id D04F153E04
        for <linux-wpan@vger.kernel.org>; Thu, 27 Jul 2017 14:39:25 +0200 (CEST)
Received: from mail.cnit.it ([127.0.0.1])
        by localhost (demetra.cnit.it [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WiaiSlZOQ0F2 for <linux-wpan@vger.kernel.org>;
        Thu, 27 Jul 2017 14:39:25 +0200 (CEST)
Received: from giove (giove.cnit.it [217.9.64.16])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.cnit.it (Postfix) with ESMTPSA id 6C89153D20
        for <linux-wpan@vger.kernel.org>; Thu, 27 Jul 2017 14:39:25 +0200 (CEST)
Date: Thu, 27 Jul 2017 12:39:25 +0000
Message-ID: <20170727123925.Horde.wOM_gZTTS3ppRvU-NkGUfQ1@webmail.cnit.it>
From: Luca Di Mauro <ldimauro@cnit.it>
Subject: IEEE80154 sockets problem with kernel 4.1.15
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org



Dear all,
I am working with transceiver AT86RF233 on a board with Variscite i.MX 6 SOM.
I'm using IEEE802154 sockets in the following test code:

#include<errno.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <string.h>
#include <net/if.h>



int main () {
	int socketfd = 0;
	struct ifreq ifr;
	static const char *wpandevs[] = {"wpan0"};
	int ret;

	socketfd = socket(PF_IEEE802154, SOCK_RAW, 0);

	strncpy(ifr.ifr_name, wpandevs[0], IF_NAMESIZE);
printf("d0\n");
	ret = ioctl(socketfd, SIOCGIFADDR, &ifr);
printf("d1\n");

	if (ret < 0) {
		fprintf(stderr,"ioctl: SIOCGIFADDR error\n");
		return;
	}
printf("d2\n");

	return 0;
}

But when I execute this code, kernel says to me following error messages:
RTNL: assertion failed at net/mac802154/iface.c (65)
CPU: 1 PID: 2023 Comm: main Not tainted 4.1.15-224528-gc28c3ac-dirty #3
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<8001691c>] (unwind_backtrace) from [<80012748>] (show_stack+0x10/0x14)
[<80012748>] (show_stack) from [<807577a8>] (dump_stack+0x84/0xc4)
[<807577a8>] (dump_stack) from [<8074e41c>] (mac802154_wpan_ioctl+0xf0/0x154)
[<8074e41c>] (mac802154_wpan_ioctl) from [<7f039744>]  
(ieee802154_sock_ioctl+0x184/0x1f0 [ieee802154_socket])
[<7f039744>] (ieee802154_sock_ioctl [ieee802154_socket]) from  
[<805fcbf4>] (sock_ioctl+0x1c0/0x294)
[<805fcbf4>] (sock_ioctl) from [<800f9dd0>] (do_vfs_ioctl+0x40c/0x5fc)
[<800f9dd0>] (do_vfs_ioctl) from [<800f9ff4>] (SyS_ioctl+0x34/0x5c)
[<800f9ff4>] (SyS_ioctl) from [<8000f480>] (ret_fast_syscall+0x0/0x3c)

Do you have some tips to solve the problem?

I'm using Debian Jessie (downloaded here  
http://www.variwiki.com/index.php?title=VAR-SOM-MX6_Debian_R2) with  
kernel 4.1.15-224528-gc28c3ac-dirty.

Best,
Luca Di Mauro

