Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50468 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGIjp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:45 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7049776wiv.5
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/9] at86rf230: various fixes and cleanups
Date: Tue,  7 Oct 2014 10:38:24 +0200
Message-Id: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this series fix a race condition when switching to RX_AACK_ON and irq is
enabled. Also contains correct handling of enable_irq if the irq was disabled
before. Additional we fix the handling of lifs/sifs timing in ARET mode.

- Alex

Alexander Aring (9):
  at86rf230: fix errno on tx timeout handling
  at86rf230: add missing error handling
  at86rf230: correct aret lifs and sifs handling
  at86rf230: correct at86rf2xx lifs timings
  at86rf230: squash unnecessary dereferencing
  at86rf230: add missing enable_irq
  at86rf230: fix race condition
  at86rf230: fix enable_irq handling on async spi
  at86rf230: remove unnecessary print of async error

 drivers/net/ieee802154/at86rf230.c | 180 +++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 88 deletions(-)

-- 
2.1.2

