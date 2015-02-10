Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32795 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbBJWOy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Feb 2015 17:14:54 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm9so647980wib.5
        for <linux-wpan@vger.kernel.org>; Tue, 10 Feb 2015 14:14:53 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: small cleanups
Date: Tue, 10 Feb 2015 23:14:18 +0100
Message-Id: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains some small cleanups. THe first patch do a more
correct checking on valid psdu len, this is necessary e.g. in at86rf230
promiscous mode frame length checking to avoid an access out of mpdu buffer.
The last two patches simple remove some unnecessary temporary variable.

- Alex

Alexander Aring (3):
  ieee802154: correct ieee802154_is_valid_psdu_len
  ieee802154: cleanup ieee802154_be64_to_le64
  ieee802154: cleanup ieee802154_le64_to_be64

 include/linux/ieee802154.h | 12 ++++++++++--
 include/net/mac802154.h    |  8 ++------
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.2.2

