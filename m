Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34333 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbDHLS5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 07:18:57 -0400
Received: by wgbdm7 with SMTP id dm7so84658637wgb.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 04:18:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/4] ieee802154: add support for phy capabilities
Date: Wed,  8 Apr 2015 13:18:28 +0200
Message-Id: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, Varka Bhadram <varkabhadram@gmail.com>

Hi,

this patches introduce a mechanism to get phy capabilities. We simple add
some additional pib values like "channels_supported" information. These
information also includes mib values which are phy dependent like frame_retries
or csma_backoffs, this is necessary because the phy doing a little bit mac
stuff. We simple extend the pib according these phy dependent mac values.

These capabilities are by default full 802.15.4 complaint, if some transceiver
supports less functionality only then these values need to be overwritten inside
the driver-layer.

Fruthermore we also add functionality to dump these values via
NL802154_CMD_GET_WPAN_PHY.

- Alex

Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: Varka Bhadram <varkabhadram@gmail.com>

Alexander Aring (4):
  ieee802154: introduce wpan_phy_supported struct
  ieee802154: move channels supported out of softmac
  ieee802154: add several phy supported handling
  at86rf230: set cca_modes supported flags

 drivers/net/ieee802154/at86rf230.c | 14 ++++++++++----
 drivers/net/ieee802154/cc2520.c    |  2 +-
 drivers/net/ieee802154/fakelb.c    | 30 +++++++++++++++---------------
 drivers/net/ieee802154/mrf24j40.c  |  2 +-
 include/net/cfg802154.h            | 11 ++++++++++-
 net/ieee802154/nl-phy.c            |  4 ++--
 net/ieee802154/nl802154.c          | 29 ++++++++++++++++++++++-------
 net/mac802154/cfg.c                |  4 ----
 net/mac802154/main.c               | 10 ++++++++++
 9 files changed, 71 insertions(+), 35 deletions(-)

-- 
2.3.5

