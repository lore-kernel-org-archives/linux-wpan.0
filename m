Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52364 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaLNXUp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Dec 2014 18:20:45 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so7251676wiw.7
        for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2014 15:20:44 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/5] at86rf230: cleanups
Date: Mon, 15 Dec 2014 00:20:27 +0100
Message-Id: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
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

