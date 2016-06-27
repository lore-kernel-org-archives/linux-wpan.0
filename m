Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:57766 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751809AbcF0GKd (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Jun 2016 02:10:33 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RESEND bluetooth-next 1/3] nl802154: move PAD to right position
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160618084535.4699-1-aar@pengutronix.de>
Date: Mon, 27 Jun 2016 08:10:30 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <E21DE2FA-AAC0-4374-A211-169F51260750@holtmann.org>
References: <20160618084535.4699-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hi Alex,

> The PAD define should be above the experimental support. We don't care
> about if we break userspace in experimental stuff but PAD is part of the
> existing UAPI.
> 
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> include/net/nl802154.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

