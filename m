Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56665 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbHMJGz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 05:06:55 -0400
From: Stefan Schmidt <stefan@sostec.de>
Subject: ADF7242 driver ready for mainline inclusion?
Message-ID: <55CC5CF3.5030701@sostec.de>
Date: Thu, 13 Aug 2015 11:01:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

We have found the ADF7242 driver which lists you as author. :)

Alexander and myself are working on the linux-wpan subsystem which
handles IEEE 802.15.4. It seems the driver was submitted to the old
linux-zigbee project (ancestor of linux-wpan, renamed due to not being a
zigbee stack) but sadly never made it mainline when other parts have
been merged.

Are you still actively working on this driver? Is there an interest from
your side to get it into mainline? We would be happy to help you with
reviewing it.

So far I have only found these. Are they up to date?
http://wiki.analog.com/resources/tools-software/linux-drivers/networking-mac802154/adf7242
https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/net/ieee802154/adf7242.c

regards
Stefan Schmidt
