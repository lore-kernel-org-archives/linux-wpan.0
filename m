Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50354 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaI3PmN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 11:42:13 -0400
Message-ID: <542ACF52.3030807@xsilon.com>
Date: Tue, 30 Sep 2014 16:42:10 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Problems with fakeserial
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I'm trying to use the virtual-ieee802154-serial code but when I use izattach I get the following error msg:

root@10:/etc/init.d# izattach /dev/fakeserial0
ioctl: TIOCSETD: Invalid argument

I've tried ensuring the baud rates match and still get the same error.

I'm using the following git repos for the userspace tools, is this still correct?
git://git.code.sf.net/p/linux-zigbee/linux-zigbee

- Martin.

