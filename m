Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33399 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031630AbbD2JTB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 05:19:01 -0400
Received: by wief7 with SMTP id f7so35483032wie.0
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 02:19:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 wpan-next 0/6] at86rf230: cleanups and transmit improvements
Date: Wed, 29 Apr 2015 11:18:40 +0200
Message-Id: <1430299126-14855-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains a cleanup patch which removes tabs after define.
Also this patch adds improvements to the calibration timeout handling.
At least we adding support for the easiest use case of slp_tr pin, which
indicate the TX_START command instead doing a state change over spi.

- Alex

changes since v3:
 - fix typo in commit msg of ("at86rf230: remove unnecessary tx state change")
   s/patach/patch.

changes since v2:
 - Instead of declaring two variable in a single line, declare in two
   separate lines.
 - fix commit message in ("at86rf230: remove unnecessary tx state change"),
   we doing a state change from ARET_ON into AACK_ON not ARET_ON.

Alexander Aring (6):
  at86rf230: remove tabs after define
  at86rf230: move cal_timeout to state change
  at86rf230: add TX_ARET_ON for calibration timeout
  at86rf230: remove unnecessary tx state change
  at86rf230: change state change if from trx_off
  at86rf230: add slp_tr support to start tx

 drivers/net/ieee802154/at86rf230.c | 384 +++++++++++++++++++------------------
 1 file changed, 202 insertions(+), 182 deletions(-)

-- 
2.3.6

