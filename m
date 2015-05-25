Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52495 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbEYGRI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 02:17:08 -0400
Date: Mon, 25 May 2015 09:17:03 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 5/8] ieee802154 6lowpan: Don't implement
 ieee802154_mlme_ops.
Message-ID: <20150525061703.GF11340@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195011.GQ11014@wantstofly.org>
 <20150520104146.GG3978@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150520104146.GG3978@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, May 20, 2015 at 12:41:50PM +0200, Alexander Aring wrote:

> > ieee802154_mlme_ops are implemented only by ARPHRD_IEEE802154
> > devices.
> 
> Yes, this patch is correct. I did that also for the removal the mib lock
> which makes the callbacks for getting some mib values unnecessary. It
> depends on context if we need to hold a lock or not (depends on if
> wpan interface is up). See patch [0].

Ah, OK, I hadn't noticed that patch, sorry!  I rebased against bt-next
and this patch of mine is indeed obsolete now, so I've dropped it from
the series.
