Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34143 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbE0LmS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 07:42:18 -0400
Received: by wicmc15 with SMTP id mc15so90957713wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 04:42:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] ieee802154: add support for current cca ed level
Date: Wed, 27 May 2015 13:42:08 +0200
Message-Id: <1432726930-20126-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series based on ("ieee802154: add set transmit power support")
and support handling for setting current phy cca ed level. This value should
only be necessary if cca_mode is something with an energy detection level
threshold and max frame retries is 0 or above, which do the CSMA-CA handling.
Currently this value is printed always out, doesn't depend if it's really
used or not. It's just represent the current register setting when phy
supports this handling.

- Alex

Alexander Aring (2):
  nl802154: add support for cca ed level info
  nl802154: add support to set cca ed level

 include/net/cfg802154.h   |  1 +
 net/ieee802154/nl802154.c | 37 +++++++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h | 11 +++++++++++
 net/ieee802154/trace.h    | 15 +++++++++++++++
 net/mac802154/cfg.c       | 19 +++++++++++++++++++
 5 files changed, 83 insertions(+)

-- 
2.4.1

