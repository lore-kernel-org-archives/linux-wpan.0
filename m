Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32817 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbFJEyX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 00:54:23 -0400
Received: by pdjn11 with SMTP id n11so29256468pdj.0
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 21:54:23 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [RFC bluetooth-next 0/2] mac802154: power management support
Date: Wed, 10 Jun 2015 10:23:46 +0530
Message-Id: <1433912028-17267-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This series implements the power management support in mac802154.
This series needs carefull review full fledged testing from Alex
and also from community.

It adds Runtime PM (System Sleep model) feature to mac802154,
So it will bringdown wpan interfaces while suspend and bring
them back on resume.

Alex, i need your help to improve the code in pm.c.

Thanks.

Varka Bhadram (2):
  cfg802154: add PM hooks
  mac802154: add suspend and resume callbacks

 include/net/cfg802154.h      |    2 ++
 include/net/mac802154.h      |    2 ++
 net/ieee802154/rdev-ops.h    |   20 +++++++++++++
 net/ieee802154/sysfs.c       |   38 ++++++++++++++++++++++++
 net/ieee802154/trace.h       |   22 ++++++++++++++
 net/mac802154/Makefile       |    2 ++
 net/mac802154/cfg.c          |   17 +++++++++++
 net/mac802154/driver-ops.h   |   39 ++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h |    4 +++
 net/mac802154/pm.c           |   67 ++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/trace.h        |   10 +++++++
 11 files changed, 223 insertions(+)
 create mode 100644 net/mac802154/pm.c

-- 
1.7.9.5

