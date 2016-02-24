Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38167 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752792AbcBXKkq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 24 Feb 2016 05:40:46 -0500
Subject: Re: [PATCH] 6lowpan: fix error checking code
References: <1456302733-7053-1-git-send-email-a.hajda@samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56CD88A6.5020904@pengutronix.de>
Date: Wed, 24 Feb 2016 11:40:38 +0100
MIME-Version: 1.0
In-Reply-To: <1456302733-7053-1-git-send-email-a.hajda@samsung.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org

Hi,

Am 02/24/2016 um 09:32 AM schrieb Andrzej Hajda:
> Bool variable 'fail' is always non-negative, it indicates an error if it
> is true.
>
> The problem has been detected using coccinelle script
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Acked-by: Alexander Aring <aar@pengutronix.de>

Marcel, can you please apply this patch on bluetooth-next?
Thanks.

- Alex
