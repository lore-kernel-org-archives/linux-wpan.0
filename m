Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:34590 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbbIBRtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 13:49:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 00/16] ieee802154: 6lowpan: cleanup and rework dispatch evaluation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 2 Sep 2015 10:49:06 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <2B3E8E1C-DDBA-40C6-A803-9398FC29E2FC@holtmann.org>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi Alex,

> this patch series contains a rework of 802.15.4 6LoWPAN receive handling.
> We need to check on some things before which never checked before, like
> is 802.15.4 dataframe, if we can access skb->data[0] (could be that skb->len
> is 0 then), etc.
> 
> Also various bug fixes like the masking for fragmentation dispatch value which
> is currently wrong. Also we should again check the dispatch value after successful
> reassembly a fragment, we currently assume always a iphc header there. This is wrong
> it could also be a non-compressed header. This can occur if the compressed header is
> larger than lower interface MTU size, we doesn't react on this while transmit which
> is another issue. Nevertheless we also don't reach this case at worst-case compression
> currently.
> 
> I introduced a complete new handling for the dispatch values based on mac80211
> receive handling mechanism.
> 
> - Alex
> 
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> 
> changes since PATCH:
> - rebase to current bluetooth-next/master
> - remove unnecessary else branch in fragmentation handling
> - add more detailed "why" in the commit message of "ieee802154: 6lowpan:
>   register packet layer while open"
> - replace magic numbers for getting dgram size high bytes by some defines.
> - Add the "Updated Last" date at iana code commentary for dispatch values. 
> - Add Jukka into Cc: because we touch the 6LoWPAN generic branch. (Should only
>   802.15.4 related changes there, see "ieee820154: 6lowpan: dispatch
>   evaluation rework"
> - Add several "Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>", thanks
>   for giving some feedback. 
> 
> changes since v2:
> - I know there is some patch on net-next which occurs in merge conflicts, I
>   will wait until this patch is in bluetooth-next before sending as PATCH.
> - fix the "ieee820154: 6lowpan: dispatch evaluation rework" by also doing
>   dispatch evaluation on FRAG1. Also we do now FRAG1 uncompression (if iphc)
>   on-the-fly. This is currently solved by doing special lltype handling
>   in generic 6LoWPAN. Maybe we can introduce some "payload_len" parameter
>   to the uncompression functions, to avoid the use of skb->cb.
>   The complete patch looks different now, I fixup also some other patches into
>   this patch.
>   Also add skb_unshare on dispatches where we manipulate the skb data.
>   Change address handling for fragmentation for parse again skb_mac_header instead
>   using skb->cb which was filled from lower layer.
> - replace the removal of wdev running patch "ieee802154: 6lowpan: change if
>   lowpan dev is running".
> - add lowpan_dff dispatch.
> - change reserved dispatch values to use ranges.
> - add "ieee802154: 6lowpan: register packet layer while open".
> - add "ieee802154: 6lowpan: remove check on null".
> - change order at "ieee802154: 6lowpan: trivial checks at" to check on
>   "wdev->type != ARPHRD_IEEE802154" at first.
> - change "ieee802154: 6lowpan: check on valid 802.15.4 frame", we don't need
>   to check on addr none. Dataframes which belongs to a "node" type should always
>   have source and destination addresses. This need to be handled in the lower layers.
> - add "ieee802154: 6lowpan: remove tx full-size" which removes a ugly workaround
>   to calculate the full size of iphc packet. We don't need it since we use FRAG1
>   uncompression on the fly. Also change this behaviour for transmit and remove
>   the ugly workaround functions.
> 
> Alexander Aring (16):
>  ieee802154: 6lowpan: change dev vars to wdev and ldev
>  ieee802154: 6lowpan: register packet layer while open
>  ieee802154: 6lowpan: remove check on null
>  ieee802154: 6lowpan: remove set to zero
>  ieee802154: 6lowpan: remove EXPORT_SYMBOL
>  ieee802154: 6lowpan: change if lowpan dev is running
>  ieee802154: 6lowpan: cleanup pull of iphc bytes
>  ieee802154: 6lowpan: trivial checks at first
>  ieee802154: 6lowpan: earlier skb->dev switch
>  ieee820154: 6lowpan: dispatch evaluation rework
>  ieee802154: 6lowpan: add generic lowpan header check
>  ieee802154: 6lowpan: add handler for all dispatch values
>  ieee802154: 6lowpan: add check for reserved dispatch
>  ieee802154: 6lowpan: check on valid 802.15.4 frame
>  ieee802154: 6lowpan: remove packet type to host
>  ieee802154: 6lowpan: remove tx full-size calc workaround
> 
> include/linux/ieee802154.h          |  25 +++
> include/net/6lowpan.h               | 144 +++------------
> include/net/mac802154.h             |  15 ++
> net/6lowpan/iphc.c                  |  13 +-
> net/6lowpan/nhc_udp.c               |  13 +-
> net/ieee802154/6lowpan/6lowpan_i.h  |  14 +-
> net/ieee802154/6lowpan/core.c       | 116 ++++++------
> net/ieee802154/6lowpan/reassembly.c | 157 +++++++++++-----
> net/ieee802154/6lowpan/rx.c         | 352 ++++++++++++++++++++++++++++--------
> net/ieee802154/6lowpan/tx.c         |  51 +++---
> 10 files changed, 572 insertions(+), 328 deletions(-)

all 16 patches have been applied to bluetooth-next tree.

Regards

Marcel

