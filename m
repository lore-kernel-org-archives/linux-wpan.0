Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40819 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbbJHM07 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Oct 2015 08:26:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: move shared settings to lowpan_netdev_setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443810484-10528-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 8 Oct 2015 14:26:49 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <6E9785D1-DB85-40F9-A661-132348F1160A@holtmann.org>
References: <1443810484-10528-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi Alex,

> This patch moves values for all lowpan interface to the shared
> implementation of 6lowpan. This patch also quietly fixes the forgotten
> IFF_NO_QUEUE flag for the bluetooth 6LoWPAN interface. An identically
> commit is 4afbc0d ("net: 6lowpan: convert to using IFF_NO_QUEUE") which
> wasn't changed for bluetooth 6lowpan.
> 
> All 6lowpan interfaces should be virtual with IFF_NO_QUEUE, using EUI64
> address length, the mtu size is 1280 (IPV6_MIN_MTU) and the netdev type
> is ARPHRD_6LOWPAN.
> 
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/net/6lowpan.h         | 2 ++
> net/6lowpan/core.c            | 5 +++++
> net/bluetooth/6lowpan.c       | 6 ------
> net/ieee802154/6lowpan/core.c | 4 ----
> 4 files changed, 7 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

