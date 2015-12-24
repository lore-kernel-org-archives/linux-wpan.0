Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33177 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbLXCTz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Dec 2015 21:19:55 -0500
Received: by mail-ig0-f181.google.com with SMTP id mv3so76447896igc.0
        for <linux-wpan@vger.kernel.org>; Wed, 23 Dec 2015 18:19:54 -0800 (PST)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCH v3 0/1] ieee802154: cc2520: Check CRC & add promiscuous
Date: Wed, 23 Dec 2015 21:19:40 -0500
Message-Id: <1450923581-967-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: Brad Campbell <bradjc5@gmail.com>

Update the patch to disable AUTOCRC and manually set CRC on TX when in
promiscuous mode rather than recreating the CRC upon receive.

I've tested that in monitor mode all packets are received with the CRC, and
in node mode packets are being filtered as expected.

Changes since v2:
- Disable AUTOCRC when in promiscuous mode rather than manually
calculating CRC
- Add CRC manually for TX when in promiscuous mode
- Remove initializing FRMCTRL0 as it is set when promiscuous mode
is configured.

Changes since v1:
- Add support for promiscuous mode in cc2520
- Make frame filtering default
- Append CRC to incoming packets for monitors
- Actually calculate LQI

Brad Campbell (1):
  ieee802154: cc2520: Check CRC & add promiscuous

 drivers/net/ieee802154/cc2520.c | 145 +++++++++++++++++++++++++++++++++-------
 1 file changed, 122 insertions(+), 23 deletions(-)

--
2.6.3

