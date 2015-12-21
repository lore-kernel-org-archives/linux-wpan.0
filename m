Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33236 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbLUBPw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Dec 2015 20:15:52 -0500
Received: by mail-io0-f196.google.com with SMTP id f127so9244293ioa.0
        for <linux-wpan@vger.kernel.org>; Sun, 20 Dec 2015 17:15:51 -0800 (PST)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCH 0/1] ieee802154-cc2520: Check CRC
Date: Sun, 20 Dec 2015 20:15:32 -0500
Message-Id: <1450660533-38184-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: Brad Campbell <bradjc5@gmail.com>

After collecting 802.15.4 packets from about 30 devices with the CC2520
driver, I noticed that I was getting a bunch of packets from devices I
didn't recognize. Digging a little deeper, it seems the CC2520 driver
doesn't check that the CRC for incoming packets is correct. Since the
CC2520 does the heavy lifting, adding this is a small change.

I originally thought adding this to the `cc2520_rx()` function made the
most sense, but I couldn't find a clean way to access the last byte of
the skb buffer. However, since the `cc2520_rx()` function already has an
error check when calling `cc2520_read_rxfifo()`, and I'm assuming that
someday `cc2520_read_rxfifo()` will actually calculate the LQI (which
will require reading the last byte of the packet as well), I added
the CRC check to `cc2520_read_rxfifo()`. I can move the check if there
is a better place for it.

I tested this with my 30 node packet receiving application and am no longer
seeing the spurious TX ids or corrupted packets.

Brad Campbell (1):
  ieee802154-cc2520: Check CRC

 drivers/net/ieee802154/cc2520.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.6.3

