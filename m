Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37101 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbbDGLuF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 07:50:05 -0400
Received: by wiaa2 with SMTP id a2so15274767wia.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 04:50:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 0/4] ieee802154: nl802154 SET commands and pib defaults
Date: Tue,  7 Apr 2015 13:49:49 +0200
Message-Id: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch-series implement the already existed SET commands of an interface
and a wpan-phy. Currently we have one CMD for each setting which was a mistake
by me to implement it in this way. So we aren't currently a "real" UAPI header
for nl802154 and it's still under development. I decide now to change to
implement these setting in this way now. Currently I let these commands in
coexists with the old commands but _NOTE_ I will remove the other commands
from the nl802154 later.

So please use the new commands. When these patches are mainline I also want to
release a new wpan-tools release which use this new interface. Then everybody
has some time to change to the new wpan-tools release. After this "time" I will
remove the obsolete nl802154 commands from the header. This means older
wpan-tools releases doesn't work any more with new kernels. Also this means
newer wpan-tools releases doesn't work with older kernels. That will end in
some kind of chaos and I will note this on the website.

This behaviour to do it in only one command is much easier to handle in
userspace, like clicking an "apply button".


Also this patch series contains two patches for move the MAC PIB defaults
setting out of SoftMAC layer. Additional we set the max frame retries
parameter to 3 which is a real 802.15.4 default. Some transceivers doesn't
support ARET settings. If these transceivers doesn't support it, we assume
the 802.15.4 default.

- Alex

changes since v2:
 - remove ".done = nl802154_dump_wpan_phy_done" of patch 1/2.
 - add other movements for mac pib defaults which is needed for cfg802154
   crypto layer.

changes since v3:
 - some cleanups in the patch commit msgs, mostly I want to resend this series
   only.

Alexander Aring (4):
  nl802154: add set wpan phy cmd
  nl802154: add set interface cmd
  ieee802154: move mac pib defaults
  ieee802154: set aret handling according to 802.15.4

 net/ieee802154/core.c     |  29 +++++++++
 net/ieee802154/nl802154.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/iface.c     |  15 -----
 3 files changed, 190 insertions(+), 15 deletions(-)

-- 
2.3.5

