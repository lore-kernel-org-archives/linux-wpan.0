Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:58720 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755790AbcBXPQy (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 24 Feb 2016 10:16:54 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] 6lowpan: fix error checking code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1456302733-7053-1-git-send-email-a.hajda@samsung.com>
Date: Wed, 24 Feb 2016 07:16:48 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <DED11411-B9A6-49B8-9C5D-E4483A9B77AF@holtmann.org>
References: <1456302733-7053-1-git-send-email-a.hajda@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Alexander Aring <aar@pengutronix.de>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alex,

> Bool variable 'fail' is always non-negative, it indicates an error if it
> is true.
> 
> The problem has been detected using coccinelle script
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> net/6lowpan/iphc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

