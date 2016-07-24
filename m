Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:44018 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751928AbcGXQmi (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 24 Jul 2016 12:42:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: set phy net namespace for new ifaces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160724141225.17591-1-aar@pengutronix.de>
Date: Sun, 24 Jul 2016 18:42:35 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <8B7819D2-CF97-4596-984E-4E33793E2ACB@holtmann.org>
References: <20160724141225.17591-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

Hi Alex,

> This patch sets the net namespace when creating SoftMAC interfaces. This
> is important if the namespace at phy layer was switched before.
> Currently we losing interfaces in some namespace and it's not possible
> to recover that.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/mac802154/iface.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

