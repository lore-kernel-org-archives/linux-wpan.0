Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:58713 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934421AbcDMImz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Apr 2016 04:42:55 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 00/11] 6lowpan: prepare for 6lowpan ndisc implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Date: Wed, 13 Apr 2016 09:42:49 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <44A490CC-DB65-4CC8-AE6D-31DB54CAC982@holtmann.org>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hi Alex,

> this patch series are taken from the pending RFCv2 about
> "6lowpan: l2 neighbour data and short address" which are 802.15.4/6lowpan
> subsystem related.
> 
> If these patches are fine and are mainline on bluetooth-next, I will try to
> bring the rest of patches mainline.
> 
> - Alex
> 
> Alexander Aring (11):
>  ieee802154: cleanups for ieee802154.h
>  ieee802154: add short address helpers
>  nl802154: avoid address change while running lowpan
>  ieee802154: 6lowpan: fix short addr hash
>  6lowpan: change naming for lowpan private data
>  6lowpan: move lowpan_802154_dev to 6lowpan
>  6lowpan: iphc: rename add lowpan prefix
>  6lowpan: iphc: remove unnecessary zero data
>  6lowpan: move eui64 uncompress function
>  6lowpan: add lowpan_is_ll function
>  6lowpan: move mac802154 header
> 
> include/linux/ieee802154.h         |  35 +++++++++++-
> include/net/6lowpan.h              |  37 ++++++++++++-
> include/net/mac802154.h            |  10 ++++
> net/6lowpan/6lowpan_i.h            |   9 +++
> net/6lowpan/core.c                 |   8 +--
> net/6lowpan/debugfs.c              |  22 ++++----
> net/6lowpan/iphc.c                 | 111 ++++++++++++++++---------------------
> net/6lowpan/nhc_udp.c              |   2 +-
> net/bluetooth/6lowpan.c            |  82 ++++++++++++++-------------
> net/ieee802154/6lowpan/6lowpan_i.h |  14 +----
> net/ieee802154/6lowpan/core.c      |   6 +-
> net/ieee802154/6lowpan/tx.c        |  14 ++---
> net/ieee802154/nl802154.c          |  10 ++++
> 13 files changed, 214 insertions(+), 146 deletions(-)

all 11 patches have been applied to bluetooth-next tree.

Regards

Marcel

