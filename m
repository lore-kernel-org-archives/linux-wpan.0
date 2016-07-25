Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:51443 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752488AbcGYRYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Jul 2016 13:24:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/2] mac802154: don't warn on unsupported frames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1469461601-656-1-git-send-email-arozansk@redhat.com>
Date: Mon, 25 Jul 2016 19:24:12 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <167C7568-9A15-4CC5-B39A-3F1370E3278A@holtmann.org>
References: <1469461601-656-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi Aristeu,

> Just because we don't support certain types of frames yet doesn't mean
> we have to flood the message log with warnings about "invalid" frames.
> 
> v2: get rid of stats update, some of them were wrong, others might change in
>    the future
> 
> Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
> ---
> net/mac802154/rx.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

