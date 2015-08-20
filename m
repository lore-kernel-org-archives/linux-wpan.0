Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36465 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbHTQvY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:24 -0400
Received: by wicja10 with SMTP id ja10so150524630wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 00/16] ieee802154: 6lowpan: cleanup and rework dispatch evaluation
Date: Thu, 20 Aug 2015 18:47:29 +0200
Message-Id: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
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
receive handling mechanism.

- Alex

changes since v2:
 - I know there is some patch on net-next which occurs in merge conflicts, I
   will wait until this patch is in bluetooth-next before sending as PATCH.
 - fix the "ieee820154: 6lowpan: dispatch evaluation rework" by also doing
   dispatch evaluation on FRAG1. Also we do now FRAG1 uncompression (if iphc)
   on-the-fly. This is currently solved by doing special lltype handling
   in generic 6LoWPAN. Maybe we can introduce some "payload_len" parameter
   to the uncompression functions, to avoid the use of skb->cb.
   The complete patch looks different now, I fixup also some other patches into
   this patch.
   Also add skb_unshare on dispatches where we manipulate the skb data.
   Change address handling for fragmentation for parse again skb_mac_header instead
   using skb->cb which was filled from lower layer.
 - replace the removal of wdev running patch "ieee802154: 6lowpan: change if
   lowpan dev is running".
 - add lowpan_dff dispatch.
 - change reserved dispatch values to use ranges.
 - add "ieee802154: 6lowpan: register packet layer while open".
 - add "ieee802154: 6lowpan: remove check on null".
 - change order at "ieee802154: 6lowpan: trivial checks at" to check on
   "wdev->type != ARPHRD_IEEE802154" at first.
 - change "ieee802154: 6lowpan: check on valid 802.15.4 frame", we don't need
   to check on addr none. Dataframes which belongs to a "node" type should always
   have source and destination addresses. This need to be handled in the lower layers.
 - add "ieee802154: 6lowpan: remove tx full-size" which removes a ugly workaround
   to calculate the full size of iphc packet. We don't need it since we use FRAG1
   uncompression on the fly. Also change this behaviour for transmit and remove
   the ugly workaround functions.

Alexander Aring (16):
  ieee802154: 6lowpan: change dev vars to wdev and ldev
  ieee802154: 6lowpan: register packet layer while open
  ieee802154: 6lowpan: remove check on null
  ieee802154: 6lowpan: remove set to zero
  ieee802154: 6lowpan: remove EXPORT_SYMBOL
  ieee802154: 6lowpan: change if lowpan dev is running
  ieee802154: 6lowpan: cleanup pull of iphc bytes
  ieee802154: 6lowpan: trivial checks at first
  ieee802154: 6lowpan: earlier skb->dev switch
  ieee820154: 6lowpan: dispatch evaluation rework
  ieee802154: 6lowpan: add generic lowpan header check
  ieee802154: 6lowpan: add handler for all dispatch values
  ieee802154: 6lowpan: add check for reserved dispatch
  ieee802154: 6lowpan: check on valid 802.15.4 frame
  ieee802154: 6lowpan: remove packet type to host
  ieee802154: 6lowpan: remove tx full-size calc workaround

 include/linux/ieee802154.h          |  25 +++
 include/net/6lowpan.h               | 144 +++------------
 include/net/mac802154.h             |  15 ++
 net/6lowpan/iphc.c                  |  13 +-
 net/6lowpan/nhc_udp.c               |  13 +-
 net/ieee802154/6lowpan/6lowpan_i.h  |  14 +-
 net/ieee802154/6lowpan/core.c       | 115 ++++++------
 net/ieee802154/6lowpan/reassembly.c | 141 ++++++++++-----
 net/ieee802154/6lowpan/rx.c         | 350 ++++++++++++++++++++++++++++--------
 net/ieee802154/6lowpan/tx.c         |  51 +++---
 10 files changed, 559 insertions(+), 322 deletions(-)

-- 
2.5.0

