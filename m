Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:32823 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754086AbcGHLYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Jul 2016 07:24:35 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHv4 bluetooth-next 0/8] ieee802154: pending/new fixes and cleanup/features
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160706213231.23058-1-aar@pengutronix.de>
Date: Fri, 8 Jul 2016 13:24:32 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <E5BF7CD1-19AE-4D4D-A785-C919290411DD@holtmann.org>
References: <20160706213231.23058-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> I currently work on running the RIOT-OS stack in userspace stuff. At first
> for a testing use-case. While working on that I detected the intra-pan
> addressing behaviour and non-monitors on fakelb.
> 
> I recently posted the first 4 patches and the atusb one. I simple put
> them now into one patch-series and added Stefan's suggestion, but still
> not use if these pointer helpers on mac headers are okay for lowlevel
> functionality.
> 
> - Alex
> 
> changes since v4:
> - nothing, it's just a resend
> 
> changes since v3:
> - fix intra-pan behaviour in ieee802154_skb_src_pan. If intra-pan is set and
>   source address mode is different than NONE the destination pan id will
>   always used. If not intra-pan is set, then the destination address mode will
>   be evaluated to jump over it.
> 
> changes since v2:
> - Add new patch [5/8] 6lowpan: ndisc: set invalid unicast short addr to unspec
> - Add new patch [8/8] fakelb: allow to run as monitor.
> - split WARN_ON cleanup from "ieee802154: fix skb get fc on big endian" into
>   new separate [7/8] ieee802154: cleanup WARN_ON for fc fetch.
> - add missing pan_id check in case of non intra-pan and dadder available for
>   ieee802154_skb_src_pan function.
> - add fix for atusb csma setting which isn't mainline yet.
> 
> Alexander Aring (8):
>  ieee802154: add ieee802154_skb_dst_pan helper
>  ieee802154: add ieee802154_skb_src_pan helper
>  ieee802154: 6lowpan: fix intra pan id check
>  ieee802154: fix skb get fc on big endian
>  6lowpan: ndisc: set invalid unicast short addr to unspec
>  atusb: don't change csma settings while set channel
>  ieee802154: cleanup WARN_ON for fc fetch
>  fakelb: allow to run as monitor
> 
> drivers/net/ieee802154/atusb.c  |   6 +--
> drivers/net/ieee802154/fakelb.c |   8 +++
> include/linux/ieee802154.h      |  29 ++++++++++
> include/net/mac802154.h         | 117 ++++++++++++++++++++++++++++++++++++++--
> net/6lowpan/ndisc.c             |   7 ++-
> net/ieee802154/6lowpan/rx.c     |   2 +-
> 6 files changed, 157 insertions(+), 12 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

