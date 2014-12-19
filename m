Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:64645 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaLSWqG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:46:06 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so2488050wgg.11
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 14:46:04 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/2] mac802154: iface: better concurrent iface handling
Date: Fri, 19 Dec 2014 23:45:57 +0100
Message-Id: <1419029159-21554-1-git-send-email-alex.aring@gmail.com>
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

changes since v2:
 - fix mixed comments and variable declaration.

Alexander Aring (2):
  mac802154: iface: check concurrent ifaces
  ieee802154: iface: move multiple node type check

 net/mac802154/iface.c | 100 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 14 deletions(-)

-- 
2.2.0

