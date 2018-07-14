Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36996 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQwu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Jul 2018 12:52:50 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so33930777ioh.4
        for <linux-wpan@vger.kernel.org>; Sat, 14 Jul 2018 09:33:14 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCHv2 wpan-next 0/2] ieee802154: hwsim: add hwsim driver
Date: Sat, 14 Jul 2018 12:33:04 -0400
Message-Id: <20180714163306.5629-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aring@mojatatu.com>

Hi,

This patch series introduce a new virtual ieee802154 driver mac802154_hwsim.
The mac802154_hwsim driver offers more flexibility to change topology so
we can use it to test 6LoWPAN routing protocols e.g. RPL.

This driver cleaned up and prepared for mainline now. I showed basic mechanism
in my netdev 2.1 talk [0].

- Alex

[0] https://www.youtube.com/watch?v=iMYCaqHVmS0

since v2:
 - don't remember anymore exactly...
   - move some prototyes at beginning of the file
   - tried to change to GPLv2 only but it's not possible, reverted it
   - add newline
   - remove module parameter and add a hardcoded 2 instead

Currently sitting at the IETF hackathon to work on it, they have a lot of
coke here and the food smells good as well. Not sure if they will throw me
out - I am not registered.

Alexander Aring (2):
  ieee802154: hwsim: add replacement for fakelb
  ieee802154: fakelb: add deprecated msg while probe

 drivers/net/ieee802154/Kconfig           |  11 +
 drivers/net/ieee802154/Makefile          |   1 +
 drivers/net/ieee802154/fakelb.c          |   3 +
 drivers/net/ieee802154/mac802154_hwsim.c | 919 +++++++++++++++++++++++++++++++
 drivers/net/ieee802154/mac802154_hwsim.h |  73 +++
 5 files changed, 1007 insertions(+)
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.c
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.h

-- 
2.11.0

