Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:35137 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbCIM4V (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 08:56:21 -0400
Received: by wesw55 with SMTP id w55so11151749wes.2
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 05:56:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] at86rf230: state delay over hrtimer and calibration
Date: Mon,  9 Mar 2015 13:56:09 +0100
Message-Id: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains for doing the state delay via hrtimer and introduce
the transceiver calibration by doing a TRX_OFF -> TX_ON state before transmit
and transceiver leaves 5 minutes in PLL state.

- Alex

Alexander Aring (3):
  at86rf230: replace state change sleeps with hrtimer
  at86rf230: add support for calibration timeout
  at86rf230: fix volatile regmap registers

 drivers/net/ieee802154/at86rf230.c | 113 +++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 24 deletions(-)

-- 
2.3.0

