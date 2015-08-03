Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2153 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbbHCIWB (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 3 Aug 2015 04:22:01 -0400
Message-ID: <1438590118.2896.224.camel@linux.intel.com>
Subject: Re: [RFCv2 bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan
 private data
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 03 Aug 2015 11:21:58 +0300
In-Reply-To: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

Hi Alex,

On pe, 2015-07-31 at 14:38 +0200, Alexander Aring wrote:
> Hi,
> 
> I already thought many times to introduce something like that. Here is a draft
> for introducing the generic 6lowpan private data into each lowpan interface.
> For the beginning I introduced the enum "ll_type" which contains the LL type of
> a lowpan interface.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


BTW, did you document the description below somewhere, it looks very
useful.


> Use cases for such feature (LL types):
> 
>  - If we do in upper layers (6LoWPAN/IPv6) a evaluation of dev->type then
>    the value is on all lowpan interfaces "APRHRD_6LOWPAN". If we checked on
>    "dev->type" and it's ARPHRD_6LOWPAN we can safe use lowpan_priv to get
>    6LoWPAN generic private data. With this data we can check the LL type which
>    can be currently BTLE or IEEE802154. This could be useful to make different
>    handling in iphc compress/decompress and evaluating LL private data of skb
>    control block "skb->cb".
> 
>    Example (802.15.4 has different address handling functionality):
> 
>    switch (lowpan_priv(dev)->ll_type) {
>    case LOWPAN_LL_TYPE_BTLE:
>         /* do EUI64 btle handling */
>         break;
>    case LOWPAN_LL_TYPE_IEEE802154:
>         /* do complicated short/extended address handling */
>         /* we can surely call skb->cb to some other private data from LL
>            which was set before iphc compress/decompress function call */
>         break;
>    }
> 
>    The handling is currently for 802.15.4 is in generic 6lowpan code currently
>    not quite. This should be handled by private data. At the moment btle use
>    the same handling like for 802.15.4 extended address. Nevertheless is we can
>    cleanup some handling then in generic iphc functionality.
> 
>    This also possible in layers like IPv6, just doing a check on APRHRD_6LOWPAN
>    before calling lowpan_priv(dev)->ll_type, then we are sure that the private
>    data of the interface is a 6LoWPAN interface and we can cast it to lowpan_priv.
>    Then we can do 6LoWPAN generic stuff OR 6lowpan specific LL stuff.
> 
>  - In Lukasz Duda RFC for introducing stateful address compression, I saw
>    some behaviour which such functionality is also useful. Currently we don't
>    have a allocated space for a 6LoWPAN generic space which is assigned to a
>    lowpan interface. When LL layers (BTLE, IEEE802154) calls iphc
>    compress/decompress Lukasz had no change to access some room which is needed
>    for storing the context information into a table. The workaround for this
>    feature was to add allocate a static data room for the table and doing a
>    lookup/match of netdev name. Which a generic 6lowpan private data room per each
>    lowpan interface we can put this table according to the netdev private room,
>    which means in short: no lookup is needed anymore, just dereferencing lowpan_priv.
> 
>    In upper layer like IPv6 Lukasz could use that to get the stateful context
>    table information as an example for doing 6LoWPAN generic stuff in upper
>    layers.
> 
> 
> Note about the implementation for LL 6LoWPAN private pointer:
> 
> I stole some mechanism from wireless for that. See [0], the vif struct is part
> of sdata which is also part of private data of a wireless interface (mac80211).
> I hope I can just adapt this behaviour.
> 
> - Alex
> 
> [0] http://lxr.free-electrons.com/source/include/net/mac80211.h#L1366
> 
> changes since v2:
>  - rename L2/l2 to LL/ll. I think the usually word in ietf for L2 is
>    LL which means "link layer". Also ipv6 stack use ll for variables like
>    lladdr -> link layer address.
>  - rebase to current bluetooth-next/master
>  - remove some brackets in function lowpan_priv.
> 
> Alexander Aring (2):
>   bluetooth: 6lowpan: change netdev_priv to lowpan_dev
>   6lowpan: add generic 6lowpan netdev private data
> 
>  include/net/6lowpan.h              | 18 ++++++++++++++++++
>  net/bluetooth/6lowpan.c            |  9 ++++++---
>  net/ieee802154/6lowpan/6lowpan_i.h |  3 ++-
>  net/ieee802154/6lowpan/core.c      |  5 ++++-
>  4 files changed, 30 insertions(+), 5 deletions(-)
> 


Cheers,
Jukka




