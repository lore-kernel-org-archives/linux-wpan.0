Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:46007 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbHOV37 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 17:29:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 0/2] ieee802154: 6lowpan: fixes for multiple interfaces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 15 Aug 2015 14:29:55 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <F9971C92-460B-4D87-B6DC-A6F66F669848@holtmann.org>
References: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> while working on "ieee802154: 6lowpan: cleanup and rework dispatch evaluation",
> I detected issues which was introduced by removal the multiple interfaces
> feature _per_ wpan interface. These are:
> 
> - multiple registration for the packet handler -> fixed by open_count
> - check on if the wpan interface has a lowpan interface.
> 
> I also detect the missing dev_put while lowpan netdev_registation and
> take some patches like moving the ARPHRD check earlier, we need to
> check on this before evaluating the ieee802154_ptr.
> 
> - Alex
> 
> Alexander Aring (2):
>  ieee802154: 6lowpan: fix packet layer registration
>  ieee802154: 6lowpan: fix non-lowpan wpan interfaces
> 
> net/ieee802154/6lowpan/core.c | 22 +++++++++++++++++-----
> net/ieee802154/6lowpan/rx.c   |  7 ++++---
> 2 files changed, 21 insertions(+), 8 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

