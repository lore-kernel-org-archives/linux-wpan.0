Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36717 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbbGXNBq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 09:01:46 -0400
Received: by wicgb10 with SMTP id gb10so27924743wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 06:01:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] ieee802154: multiple lowpan interface support and fix mac setting
Date: Fri, 24 Jul 2015 15:01:43 +0200
Message-Id: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

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

Alexander Aring (2):
  ieee802154: 6lowpan: remove multiple lowpan support
  mac802154: fix wpan mac setting while lowpan

 include/net/cfg802154.h            |  3 ++
 net/ieee802154/6lowpan/6lowpan_i.h |  6 ----
 net/ieee802154/6lowpan/core.c      | 67 +++++++++++---------------------------
 net/ieee802154/6lowpan/rx.c        | 38 +++++----------------
 net/mac802154/iface.c              | 14 ++++++++
 5 files changed, 44 insertions(+), 84 deletions(-)

-- 
2.4.6

