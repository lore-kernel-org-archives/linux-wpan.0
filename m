Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50611 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbEST4h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:37 -0400
Date: Tue, 19 May 2015 22:49:53 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 0/8] ieee802154: Assorted fixes and cleanups.
Message-ID: <20150519194953.GL11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Lennert Buytenhek (8):
  ieee802154 socket: Return EMSGSIZE from raw_sendmsg() if packet too
    big.
  Documentation/networking/ieee802154.txt: fix various inaccuracies.
  ieee802154: Remove ieee802154_reduced_mlme_ops references.
  ieee802154: Remove 802.15.4/6LoWPAN checks for interface MTU.
  ieee802154 6lowpan: Don't implement ieee802154_mlme_ops.
  ieee802154 socket: No need to check for ARPHRD_IEEE802154 in
    raw_bind().
  mac802154: mac802154_header_create() optimisation.
  mac802154: mac802154_mlme_start_req() optimisation.

 Documentation/networking/ieee802154.txt | 25 ++++++++++++-------------
 include/net/ieee802154_netdev.h         |  6 ------
 net/ieee802154/6lowpan/core.c           | 28 ----------------------------
 net/ieee802154/6lowpan/tx.c             |  7 ++++---
 net/ieee802154/nl-mac.c                 | 17 +++--------------
 net/ieee802154/socket.c                 |  8 +-------
 net/mac802154/iface.c                   |  2 +-
 net/mac802154/mac_cmd.c                 | 29 +++++++++++------------------
 8 files changed, 32 insertions(+), 90 deletions(-)

-- 
2.1.0

