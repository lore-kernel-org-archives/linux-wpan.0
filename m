Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34637 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbGaLL3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 31 Jul 2015 07:11:29 -0400
Received: by wibud3 with SMTP id ud3so54017689wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 31 Jul 2015 04:11:28 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/2] ieee802154: multiple lowpan interface support and fix mac setting
Date: Fri, 31 Jul 2015 13:11:40 +0200
Message-Id: <1438341102-15878-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains two patches. At first we remove the multiple
lowpan interface support. I don't see any use case for that, if somebody
has an use case for it. Please report your use case.

Currently it's broken to update the wpan mac address while having a lowpan
interface on the top. The first patch will introduce some easy mechanism
to access the lowpan interface inside the lower mac802154 layer. When the
mac802154 changes the mac address then it will updated also on the lowpan
interface, if the wpan interface belongs to a lowpan interface.

Another idea would be maybe to react on the lowpan_device_event, when a
wpan interface updates his address, but this doesn't work because the
lowpan interface need to be down to update the mac setting, otherwise the
SLAAC address will not be updated.

- Alex

changes since v2:
 - fix handling in patch 2/2 that we will check at first that the lowpan
   interface is down. Otherwise we had return -EBUSY and wpan interface
   address was updated and not the lowpan interface address.
 - change subject at patch 2/2 from "fix wpan mac setting while lowpan" to
   "fix wpan mac setting while lowpan is there". I don't use "up", because
   it was broken before, doesn't matter if the interface was up or down.
 - add several tested-by and reviewed-by tags

Alexander Aring (2):
  ieee802154: 6lowpan: remove multiple lowpan support
  mac802154: fix wpan mac setting while lowpan is there

 include/net/cfg802154.h            |  3 ++
 net/ieee802154/6lowpan/6lowpan_i.h |  6 ----
 net/ieee802154/6lowpan/core.c      | 67 +++++++++++---------------------------
 net/ieee802154/6lowpan/rx.c        | 38 +++++----------------
 net/mac802154/iface.c              | 15 +++++++++
 5 files changed, 45 insertions(+), 84 deletions(-)

-- 
2.5.0

