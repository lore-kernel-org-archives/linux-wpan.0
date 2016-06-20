Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44397 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbcFTHCE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 20 Jun 2016 03:02:04 -0400
Message-ID: <1466405926.31678.115.camel@linux.intel.com>
Subject: Re: linux-wpan radvd upstream
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 20 Jun 2016 09:58:46 +0300
In-Reply-To: <22574127-79b0-9877-769d-1489eb3162e5@pengutronix.de>
References: <22574127-79b0-9877-769d-1489eb3162e5@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, reubenhwk@gmail.com

Hi Alex,

On Sat, 2016-06-18 at 11:23 +0200, Alexander Aring wrote:
> Hi wpan and bluetooth people,
> 
> Please review dev branch [0]. The important commit is the rework of
> the 6CO
> support which is used by Bluetooth and 802.15.4 6LoWPAN.
> 
> Jukka, tell me if support for a common userspace application to
> sending
> RA frames is okay for you.

Yes, I am ok with that. It would be really great to have 6co support in
radvd.

> 
> I like to send a push request the next days to radvd repository.
> 
> btw:
> 
> We have now the layer for ndisc stuff and could think about to handle
> 6CO in userspace.
> 
> NOT the sending transmit of RA + 6CO, this isn't kernel job, but
> processing
> RA frames with 6CO could be moved to kernel. The kernel take care for
> context table only (overwrites by administration should always
> possible).
> 
> Anyway, I think we can still change it later if we want to move the
> handling into kernelspace.
> 
> - Alex
> 
> [0] https://github.com/linux-wpan/radvd/commits/6lowpan


Cheers,
Jukka

