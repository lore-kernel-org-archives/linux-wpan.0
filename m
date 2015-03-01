Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:45828 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbCAUzy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:55:54 -0500
Received: by wgha1 with SMTP id a1so29836693wgh.12
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:52 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/6] at86rf230: improvements and cleanups
Date: Sun,  1 Mar 2015 21:55:27 +0100
Message-Id: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this series contains some improvements in transmit handling which insert
a retry mode for going into STATE_TX_ON instead of turning into this state
with forcing after the first try. This series contains also some improvements
/cleanups which squash some multiple dereferencing and don't overwrite a
memory space always with the same number.

- Alex

Alexander Aring (6):
  at86rf230: add transmit retry support
  at86rf230: cleanup and squash stack variable
  at86rf230: refactor receive handling
  at86rf230: remove multiple dereferencing for irq
  at86rf230: remove multiple dereferencing for ctx
  at86rf230: restore trx len when needed

 drivers/net/ieee802154/at86rf230.c | 117 +++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 50 deletions(-)

-- 
2.3.0

