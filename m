Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40400 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864AbbIBSTu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 14:19:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix drop return value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441217142-21315-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 2 Sep 2015 11:19:43 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <6275DCF4-01B7-4DB4-BB96-5E3D55996922@holtmann.org>
References: <1441217142-21315-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch changes the return value of lowpan packet receive handler to
> the correct NET_RX_DROP instead RX_DROP.
> 
> This issue was detected by sparse and reported from Marcel:
> net/ieee802154/6lowpan/rx.c:329:32:    expected int
> net/ieee802154/6lowpan/rx.c:329:32:    got restricted lowpan_rx_result ...
> 
> Reported-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/rx.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

