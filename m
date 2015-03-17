Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:33061 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbCQU0P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 16:26:15 -0400
Received: by weop45 with SMTP id p45so16581030weo.0
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 13:26:14 -0700 (PDT)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCHv3 bluetooth-next 0/2] Add CC2591 Support
Date: Tue, 17 Mar 2015 16:25:44 -0400
Message-Id: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Brad Campbell <bradjc5@gmail.com>

Hi,

I fixed the two issues that Alex pointed out and updated the
commit message.

Brad

Brad Campbell (2):
  cc2520: Do not store platform_data in spi_device
  cc2520: Add support for CC2591 amplifier.

 .../devicetree/bindings/net/ieee802154/cc2520.txt  |   4 +
 drivers/net/ieee802154/cc2520.c                    | 150 +++++++++++++--------
 include/linux/spi/cc2520.h                         |   1 +
 3 files changed, 98 insertions(+), 57 deletions(-)

-- 
2.3.2

