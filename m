Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38500 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbaLOJ0Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:26:24 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so13893659wgh.6
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 01:26:20 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/5] at86rf230: cleanups
Date: Mon, 15 Dec 2014 10:25:52 +0100
Message-Id: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains various cleanups for the at86rf230.
Except patch 3/5 which contains a fix for a rarely error handling.
Because this error handling is very rarely and should only happens
if something is wrong with the spi controller, it's okay to fix it
in next.

- Alex

changes since v2:
 - make patch 1/5 "at86rf230: remove if branch" more human readable.

Alexander Aring (5):
  at86rf230: remove if branch
  at86rf230: make at86rf230_async_error inline
  at86rf230: fix context pointer handling
  at86rf230: cleanup check on trac status
  at86rf230: remove unnecessary assign

 drivers/net/ieee802154/at86rf230.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

-- 
2.1.3

