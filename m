Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35716 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbG2MYm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Jul 2015 08:24:42 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan private data
Date: Wed, 29 Jul 2015 14:24:32 +0200
Message-Id: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, Alexander Aring <alex.aring@gmail.com>

Hi,

I already thought many times to introduce something like that. Here is a draft
for introducing the generic 6lowpan private data into each lowpan interface.
For the beginning I introduced the enum "l2_type" which contains the L2 type of
a lowpan interface.

Use cases for such feature (L2 types):

 - If we do in upper layers (6LoWPAN/IPv6) a evaluation of dev->type then
   the value is on all lowpan interfaces "APRHRD_6LOWPAN". If we checked on
   "dev->type" and it's ARPHRD_6LOWPAN we can safe use lowpan_priv to get
   6LoWPAN generic private data. With this data we can check the L2 type which
   can be currently BTLE or IEEE802154. This could be useful to make different
   handling in iphc compress/decompress and evaluating L2 private data of skb
   control block "skb->cb".

   Example (802.15.4 has different address handling functionality):

   switch (lowpan_priv(dev)->l2_type) {
   case LOWPAN_L2_TYPE_BTLE:
        /* do EUI64 btle handling */
        break;
   case LOWPAN_L2_TYPE_IEEE802154:
        /* do complicated short/extended address handling */
	/* we can surely call skb->cb to some other private data from L2
           which was set before iphc compress/decompress function call */
	break;
   }

   The handling is currently for 802.15.4 is in generic 6lowpan code currently
   not quite. This should be handled by private data. At the moment btle use
   the same handling like for 802.15.4 extended address. Nevertheless is we can
   cleanup some handling then in generic iphc functionality.

   This also possible in layers like IPv6, just doing a check on APRHRD_6LOWPAN
   before calling lowpan_priv(dev)->l2_type, then we are sure that the private
   data of the interface is a 6LoWPAN interface and we can cast it to lowpan_priv.
   Then we can do 6LoWPAN generic stuff OR 6lowpan specific L2 stuff.

 - In Lukasz Duda RFC for introducing stateful address compression, I saw
   some behaviour which such functionality is also useful. Currently we don't
   have a allocated space for a 6LoWPAN generic space which is assigned to a
   lowpan interface. When L2 layers (BTLE, IEEE802154) calls iphc
   compress/decompress Lukasz had no change to access some room which is needed
   for storing the context information into a table. The workaround for this
   feature was to add allocate a static data room for the table and doing a
   lookup/match of netdev name. Which a generic 6lowpan private data room per each
   lowpan interface we can put this table according to the netdev private room,
   which means in short: no lookup is needed anymore, just dereferencing lowpan_priv.

   In upper layer like IPv6 Lukasz could use that to get the stateful context
   table information as an example for doing 6LoWPAN generic stuff in upper
   layers.


Note about the implementation for L2 6LoWPAN private pointer:

I stole some mechanism from wireless for that. See [0], the vif struct is part
of sdata which is also part of private data of a wireless interface (mac80211).
I hope I can just adapt this behaviour.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/mac80211.h#L1366

Alexander Aring (2):
  bluetooth: 6lowpan: change netdev_priv to lowpan_dev
  6lowpan: add generic 6lowpan netdev private data

 include/net/6lowpan.h              | 18 ++++++++++++++++++
 net/bluetooth/6lowpan.c            |  9 ++++++---
 net/ieee802154/6lowpan/6lowpan_i.h |  3 ++-
 net/ieee802154/6lowpan/core.c      |  5 ++++-
 4 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.5.0

