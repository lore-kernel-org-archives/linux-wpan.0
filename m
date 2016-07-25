Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59262 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266AbcGYQTS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 12:19:18 -0400
Subject: Re: [PATCH v2 1/2] mac802154: don't warn on unsupported frames
References: <1469461601-656-1-git-send-email-arozansk@redhat.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <30d70958-90e6-8033-2f27-d667de61fb56@pengutronix.de>
Date: Mon, 25 Jul 2016 18:19:13 +0200
MIME-Version: 1.0
In-Reply-To: <1469461601-656-1-git-send-email-arozansk@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi,

On 07/25/2016 05:46 PM, Aristeu Rozanski wrote:
> Just because we don't support certain types of frames yet doesn't mean
> we have to flood the message log with warnings about "invalid" frames.
> 
> v2: get rid of stats update, some of them were wrong, others might change in
>     the future
> 
> Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

Acked-by: Alexander Aring <aar@pengutronix.de>
