Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52603 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbbEYMiY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:38:24 -0400
Date: Mon, 25 May 2015 15:38:19 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCHv2 bluetooth-next 0/6] ieee802154: Assorted fixes and cleanups.
Message-ID: <20150525123819.GI11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Changes from v1:

- rebased onto bt-next

- dropped patches "ieee802154 6lowpan: Don't implement
  ieee802154_mlme_ops" and "mac802154: mac802154_header_create()
  optimisation" as they have been obsoleted by some of Alexander's
  patches that have been applied to bt-next in the meantime

- added various maintainer ACKs

I was seeing deadlocks after rebasing onto bt-next, but the cause of
those is another patch that went into bt-next (see my other email),
and with a workaround for that issue applied this patchset seems to
be working OK.


Lennert Buytenhek (6):
  ieee802154 socket: Return EMSGSIZE from raw_sendmsg() if packet too
    big.
  Documentation/networking/ieee802154.txt: fix various inaccuracies.
  ieee802154: Remove ieee802154_reduced_mlme_ops references.
  ieee802154: Remove 802.15.4/6LoWPAN checks for interface MTU.
  ieee802154 socket: No need to check for ARPHRD_IEEE802154 in
    raw_bind().
  mac802154: mac802154_mlme_start_req() optimisation.

 Documentation/networking/ieee802154.txt | 32 +++++++++++---------------------
 include/net/ieee802154_netdev.h         |  6 ------
 net/ieee802154/nl-mac.c                 | 17 +++--------------
 net/ieee802154/socket.c                 |  8 +-------
 net/mac802154/mac_cmd.c                 | 29 +++++++++++------------------
 5 files changed, 26 insertions(+), 66 deletions(-)

-- 
2.1.0

