Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34029 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759034AbeD0VWE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Apr 2018 17:22:04 -0400
Received: by mail-it0-f68.google.com with SMTP id c5-v6so3564415itj.1
        for <linux-wpan@vger.kernel.org>; Fri, 27 Apr 2018 14:22:04 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [RFC PATCH wpan-next 0/2] ieee802154: hwsim: add hwsim driver
Date: Fri, 27 Apr 2018 17:21:52 -0400
Message-Id: <20180427212154.29582-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

Hi,

This patch series introduce a new virtual ieee802154 driver mac802154_hwsim.
The mac802154_hwsim driver offers more flexibility to change topology so
we can use it to test 6LoWPAN routing protocols e.g. RPL.

This driver cleaned up and prepared for mainline now. I showed basic mechanism
in my netdev 2.1 talk [0].

- Alex

[0] https://www.youtube.com/watch?v=iMYCaqHVmS0

Alexander Aring (2):
  ieee802154: hwsim: add replacement for fakelb
  ieee802154: fakelb: add deprecated msg while probe

 drivers/net/ieee802154/Kconfig           |  11 +
 drivers/net/ieee802154/Makefile          |   1 +
 drivers/net/ieee802154/fakelb.c          |   3 +
 drivers/net/ieee802154/mac802154_hwsim.c | 925 +++++++++++++++++++++++++++++++
 drivers/net/ieee802154/mac802154_hwsim.h |  73 +++
 5 files changed, 1013 insertions(+)
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.c
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.h

-- 
2.11.0

