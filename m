Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36084 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbEHSYm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:24:42 -0400
Received: by wizk4 with SMTP id k4so39429761wiz.1
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:24:40 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 00/17] ieee802154: add support for phy capabilities
Date: Fri,  8 May 2015 20:24:11 +0200
Message-Id: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains support for phy capabilities. The phy capabilities
can be used to check the setting parameters in nl802154 before we calling the
according rdev-ops to send them into SoftMAC/Driver(HardMAC) layer. This avoids
that we know before sending them to these layers that we know a "-EINVAL" before,
this can be used to check all setting parameters in one setting commands like [0].
Additional we can now dump the capabilities into userspace so users know what the
phy is supported.

The initial values for phy capabilities is that if the driver supports the according
handling then the full range of 802.15.4 is supported like csma parameters or
max frame retries. If the driver doesn't support the setting of these we assume the
802.15.4 standard values which cannot be changed. (If the phy supports that in any
way then the driver is broken and need to support that, we assume that the phy
doing 802.15.4 defaults). This case is for mac parameters. In case of that the driver
supports the according settings like CSMA/frame retries _but_ not the full range of
the 802.15.4 then the driver can overwrite this behaviour by changing the capabilities.

For phy parameters, if the driver doesn't set anything, then there is also no
possibility to change these values from userspace, this is also a lack of support
inside the driver then.

At least this patch series also includes a rework of setting/reporting
tx_powers/cca_ed_levels values.

- Alex

changes since v2:
 - fix nl802154_capability_attr to nl802154_wpan_phy_capability_attr
 - change dbm handling to mbm handling
 - reorder patches "mac802154: check for really change" and
   "mac802154: remove check if operation is supported" because inconsitent
   when it's applied before "ieee802154: add several phy supported handling"

changes since v3:
 - rebase with cleanups on bluetooth-next.
 - remove the listet iteration of transmit powers and cca energy detection
   levels.
 - introduce wpan phy flags for checking in nl802154 for L1 supports. The
   hw flags are related to L2 settings which the phy supports. Was needed
   to access txpower/cca energy detection array without checking on null
   in nl802154 layer.
 - add cca_ed_levels reset values for at86rf230.

Alexander Aring (17):
  nl802154: cleanup invalid argument handling
  ieee802154: move validation check out of softmac
  ieee802154: change transmit power to s32
  ieee802154: change transmit power to mbm
  ieee802154: change cca ed level to mbm
  ieee802154: introduce wpan_phy_supported
  ieee802154: add several phy supported handling
  mac802154: check for really changes
  mac802154: remove check if operation is supported
  cfg802154: introduce wpan phy flags
  ieee802154: add iftypes capability
  at86rf230: set cca_modes supported flags
  at86rf230: rework tx power support
  at86rf230: rework tx cca energy detection level
  at86rf230: add cca ed level reset value
  at86rf230: add reset states of tx power level
  nl802154: add support for dump phy capabilities

 drivers/net/ieee802154/at86rf230.c | 187 +++++++++++++++++++++++++--------
 drivers/net/ieee802154/cc2520.c    |   2 +-
 drivers/net/ieee802154/fakelb.c    |  30 +++---
 drivers/net/ieee802154/mrf24j40.c  |   2 +-
 include/net/cfg802154.h            |  62 ++++++++++-
 include/net/mac802154.h            |  38 ++-----
 include/net/nl802154.h             |  79 ++++++++++++++
 net/ieee802154/nl-mac.c            |   8 +-
 net/ieee802154/nl-phy.c            |   4 +-
 net/ieee802154/nl802154.c          | 209 ++++++++++++++++++++++++++++++++-----
 net/mac802154/cfg.c                |  63 ++++-------
 net/mac802154/driver-ops.h         |   8 +-
 net/mac802154/mac_cmd.c            |   6 +-
 net/mac802154/main.c               |  32 ++++++
 14 files changed, 557 insertions(+), 173 deletions(-)

-- 
2.3.7

