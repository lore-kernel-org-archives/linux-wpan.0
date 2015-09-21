Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53976 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbIUSnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 14:43:53 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 0/5] ieee802154: llsec fix and get AF_PACKET working
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 21 Sep 2015 20:43:45 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <9B51BB80-CA65-4EF3-8405-41A04B41FF41@holtmann.org>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch series contains at first a little fix for llsec which I currently
> working on (nl802154 support). The second patch fixes push header if we don't
> set the fc address modes.
> 
> Patch 3 and 4 contains fixes to get AF_PACKET for wpan intefaces working and
> cleanup the headroom/tailroom hard_header_len fields. This was broken "somehow"
> before, don't know if I can crash the kernel with that. I tried to figure out
> what we need to have some AF_PACKET use-case.
> 
> AF_PACKET:
> 
> AF_PACKET is very generic socket interface and provided RAW and DGRAM sockets.
> 
> For RAW sockets:
> You need at least 3 bytes frame and it's also possible to send frames above
> 125, which we usually doesn't support. It will be dropped now at xmit callback.
> To fix it right we need special handling in AF_PACKET and right FCS extra_len
> arguments. This will be a new TODO.
> 
> For DGRAM sockets:
> 
> The semantic scheme for AF_PACKET DGRAM is set some maximum 8 byte destination
> address and send out the frame. Currently it's broken because we always assume
> "struct ieee802154_addr" there which is also above 8 bytes. The new "create"
> callback which is used by AF_PACKET DGRAM sockets assumes now always an
> extended_addr and doing intra_pan dataframe afterwards, fc fields like ackreq,
> security is set with fallback defaults.
> 
> For what's it's good for?
> 
> I think the RAW socket is useful to have and we should replace it with AF802154
> RAW sockets. The AF_PACKET mode is usually known and AF802154 RAW sockets should
> to the same like AF_PACKET RAW sockets. (And I know AF802154 RAW sockets are somehow
> broken currently.)
> 
> The DGRAM sockets has a small use-case if somebody wants to send "somehow" a frame,
> if you need another destination address or short address then you need AF802154 (or
> the successor of this socket family). Nevertheless I implement now the create/parse
> address for extended address only to have something there which works. Not sure if
> we should really support DGRAM sockets for AF_PACKET because the UAPI has limitations
> which doesn't fit to 802.15.4 address space.
> 
> 
> In general a nice to have is now to create "AF_PACKET RAW sockets" and generate some
> 6LoWPAN frames in userspace in combination with the fakelb driver. I think we can do
> a nice testing framework with that. Also in Python, I tested to send out AF_PACKET raw
> over python. (DGRAM sockets are not supported by python, don't know why).
> 
> 
> The tailroom, headroom, hard_header_len values has a new semantic what we mean with that
> and I hope the core network stack means the same then.
> 
> - needed_headroom:
>  The needed_headroom means we need for callbacks like dev_hard_header at minimum a
>  before allocated headroom which is this size. This is usually the WORST-CASE scenario
>  by calling skb_push, which moves headroom into dataspace (start of buffer).
>  This room is also available inside the xmit callback.
> 
> - needed_tailroom:
>  Same like headroom but for the tail where the FCS is placed.
> 
> - hard_header_len:
>  skb->len, where skb_mac_header is placed should be more than hard_header_len. I saw
>  this for AF_PACKET RAW sockets and this is the minimum lengths which need to be there
>  before calling xmit callback. At our case this is 3 bytes, which is an ACK frame and
>  contains fc fields, already there are also drivers which checks on fc field in driver
>  layer. For lowpan interface we need at least ipv6hdr to uncompress it.
> 
> What this patch series does now is to move hard_header_len length (which is maximum size
> of mac header) to needed_headroom. The hard_header_len is now the minimum size for
> a mac header. I lookup 802.15.4 upper-layer protocols and changed at points like lowpan
> hard_header_len to needed_headroom. At AF802154 they use LL_RESERVED_SPACE which does
> some "needed_headroom + hard_header_len" calculation, so it should be fine.
> 
> - Alex
> 
> Alexander Aring (5):
>  mac802154: llsec: fix device deletion from list
>  ieee802154: header_ops: fix frame control setting
>  ieee802154: introduce wpan_dev_header_ops
>  ieee802154: change needed headroom/tailroom
>  mac802154: tx: add warning if MTU exceeds
> 
> include/linux/ieee802154.h      |  11 ++++
> include/net/6lowpan.h           |   8 +++
> include/net/cfg802154.h         |  33 ++++++++++++
> include/net/ieee802154_netdev.h |  11 +---
> include/net/mac802154.h         |   8 ---
> net/6lowpan/nhc.h               |   2 -
> net/ieee802154/6lowpan/core.c   |  14 ++++--
> net/ieee802154/6lowpan/tx.c     |  20 +++++---
> net/ieee802154/header_ops.c     |  20 ++++----
> net/ieee802154/socket.c         |   4 +-
> net/mac802154/iface.c           | 108 ++++++++++++++++++++++++++++++++++------
> net/mac802154/llsec.c           |   1 +
> net/mac802154/tx.c              |  14 ++++--
> 13 files changed, 195 insertions(+), 59 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

