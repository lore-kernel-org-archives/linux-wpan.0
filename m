Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:34409 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbICOHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Sep 2015 10:07:51 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: use correct ESC value for dispatch
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441284859-22191-1-git-send-email-stefan@osg.samsung.com>
Date: Thu, 3 Sep 2015 07:07:43 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <9D2F82DC-7399-4816-BFB5-D0FFF046C345@holtmann.org>
References: <1441284859-22191-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> The ESC dispatch value has some history and it originally was 0x7f in rfc4944
> (see section-5.1). With the release of rfc6282 this value got part of the
> LOWPAN_IPHC range and was no longer available for ESC. Instead 0x40 was used
> as replacement (see section-2 in rfc6282).
> 
> We have been checking the dispatch byte in an order where IPHC would always be
> evaluated before ESC and thus we would never reach the ESC check as the IPHC
> range already covers this value.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> net/ieee802154/6lowpan/rx.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

