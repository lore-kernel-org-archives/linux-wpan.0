Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48051 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbBKNjb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 08:39:31 -0500
Received: by mail-wi0-f169.google.com with SMTP id em10so382370wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 05:39:30 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/3] ieee802154: small cleanups
Date: Wed, 11 Feb 2015 14:39:14 +0100
Message-Id: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
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

changes since v2:

- use __put_unaligned_memmove64 for handle unaligned pointer access
  in Patch 2/3 and 3/3.

Alexander Aring (3):
  ieee802154: correct ieee802154_is_valid_psdu_len
  ieee802154: cleanup ieee802154_be64_to_le64
  ieee802154: cleanup ieee802154_le64_to_be64

 include/linux/ieee802154.h | 12 ++++++++++--
 include/net/mac802154.h    |  9 +++------
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.3.0

