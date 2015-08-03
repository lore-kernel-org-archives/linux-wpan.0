Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35557 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbHCGXk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:40 -0400
Received: by wibxm9 with SMTP id xm9so106058930wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 00/16] ieee802154: 6lowpan: cleanup and rework dispatch evaluation
Date: Mon,  3 Aug 2015 08:23:39 +0200
Message-Id: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains a rework of 802.15.4 6LoWPAN receive handling.
We need to check on some things before which never checked before, like
is 802.15.4 dataframe, if we can access skb->data[0] (could be that skb->len
is 0 then), etc.

Also various bug fixes like the masking for fragmentation dispatch value which
is currently wrong. Also we should again check the dispatch value after successful
reassembly a fragment, we currently assume always a iphc header there. This is wrong
it could also be a non-compressed header. This can occur if the compressed header is
larger than lower interface MTU size, we doesn't react on this while transmit which
is another issue. Nevertheless we also don't reach this case at worst-case compression
currently.

I introduced a complete new handling for the dispatch values based on mac80211
datatype receive handling mechanism.

This patch series based on bluetooth-next with various pending patches, I uploaded
the branch at:

https://github.com/linux-wpan/linux-wpan-next/commits/802154_6lowpan_cleanup2

so everybody can test it.

- Alex

Alexander Aring (16):
  ieee802154: 6lowpan: change dev vars to wdev and ldev
  ieee802154: 6lowpan: remove set to zero
  ieee802154: 6lowpan: remove EXPORT_SYMBOL
  ieee802154: 6lowpan: remove check on wdev is running
  ieee802154: 6lowpan: cleanup pull of iphc bytes
  ieee802154: 6lowpan: trivial checks at first
  ieee802154: 6lowpan: change skb->dev earlier
  ieee802154: 6lowpan: change frag return value handling
  ieee820154: 6lowpan: dispatch evaluation rework
  ieee802154: 6lowpan: add dispatch evalualtion helpers
  ieee802154: 6lowpan: fix fragmentation dispatch mask
  ieee802154: 6lowpan: add generic lowpan header check
  ieee802154: 6lowpan: add handler for all dispatch values
  ieee802154: 6lowpan: add check for reserved dispatch
  ieee802154: 6lowpan: check on valid 802.15.4 frame
  ieee802154: 6lowpan: remove packet type to host

 include/linux/ieee802154.h          |  48 +++++-
 include/net/6lowpan.h               |  18 ++-
 net/ieee802154/6lowpan/6lowpan_i.h  |   5 +-
 net/ieee802154/6lowpan/core.c       |  83 +++++-----
 net/ieee802154/6lowpan/reassembly.c |  15 +-
 net/ieee802154/6lowpan/rx.c         | 312 +++++++++++++++++++++++++++---------
 net/ieee802154/6lowpan/tx.c         |  39 +++--
 7 files changed, 369 insertions(+), 151 deletions(-)

-- 
2.5.0

