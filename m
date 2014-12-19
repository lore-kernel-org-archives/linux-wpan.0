Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57279 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaLSW2u (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:28:50 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so2493667wgh.15
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 14:28:49 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] mac802154: iface: better concurrent iface handling
Date: Fri, 19 Dec 2014 23:28:41 +0100
Message-Id: <1419028123-21367-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains changes for a better multiple iface handling.
We have only one phy with several mac parameters like csma, aret, etc.
Currently it could be that one interface can overwrite these parameters
while ifup when another interface is currently running. To avoid that
we compare each parameter and check if differs, if not we allow to ifup
the interface.

Alexander Aring (2):
  mac802154: iface: check concurrent ifaces
  ieee802154: iface: move multiple node type check

 net/mac802154/iface.c | 101 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 14 deletions(-)

-- 
2.2.0

