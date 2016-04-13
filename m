Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:58730 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934094AbcDMIoR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 13 Apr 2016 04:44:17 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 3/3] mrf24j40: apply the security-enabled bit on secured outbound frames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460479982-4955-3-git-send-email-web+oss@zopieux.com>
Date: Wed, 13 Apr 2016 09:44:07 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <A501F341-AA72-4CAF-87CB-285422FD1F48@holtmann.org>
References: <1457988374-31220-1-git-send-email-web+oss@zopieux.com> <1460479982-4955-1-git-send-email-web+oss@zopieux.com> <1460479982-4955-3-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Alexandre,

> We set the TXNSECEN bit of register TXNCON to on when transmitting a
> security-enabled frame, as described in section 3.12.2 of the MRF
> datasheet.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Acked-by: Alan Ott <alan@signal11.us>
> ---
> drivers/net/ieee802154/mrf24j40.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

