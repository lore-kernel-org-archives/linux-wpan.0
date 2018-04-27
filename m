Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:44483 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757815AbeD0VYm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Apr 2018 17:24:42 -0400
Received: by mail-io0-f193.google.com with SMTP id d11-v6so4012750iof.11
        for <linux-wpan@vger.kernel.org>; Fri, 27 Apr 2018 14:24:42 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [RFC PATCH wpan-tools 0/2] wpan-hwsim: introduce new user space tool
Date: Fri, 27 Apr 2018 17:24:16 -0400
Message-Id: <20180427212418.29729-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

Hi,

small fix and new user space tool to work with the new driver!
In my netdev 2.1 video I had a ugly debugfs API.

- Alex

Alexander Aring (2):
  wpan-ping: fix ifname setting
  wpan-hwsim: initial commit

 Makefile.am                  |   1 +
 configure.ac                 |   1 +
 wpan-hwsim/Makefile.am       |   8 +
 wpan-hwsim/mac802154_hwsim.h |  73 +++++++
 wpan-hwsim/wpan-hwsim.c      | 509 +++++++++++++++++++++++++++++++++++++++++++
 wpan-ping/wpan-ping.c        |   2 +-
 6 files changed, 593 insertions(+), 1 deletion(-)
 create mode 100644 wpan-hwsim/Makefile.am
 create mode 100644 wpan-hwsim/mac802154_hwsim.h
 create mode 100644 wpan-hwsim/wpan-hwsim.c

-- 
2.11.0

