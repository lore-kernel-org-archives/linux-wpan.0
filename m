Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:58724 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934421AbcDMIoP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 13 Apr 2016 04:44:15 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 2/3] mrf24j40: fix security-enabled processing on inbound frames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460479982-4955-2-git-send-email-web+oss@zopieux.com>
Date: Wed, 13 Apr 2016 09:44:06 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <76BE7A9B-0C8F-406C-9846-6A584DD2304B@holtmann.org>
References: <1457988374-31220-1-git-send-email-web+oss@zopieux.com> <1460479982-4955-1-git-send-email-web+oss@zopieux.com> <1460479982-4955-2-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Alexandre,

> When receiving a security-enabled IEEE 802.15.4 frame, the MRF24J40
> triggers a SECIF interrupt that needs to be handled for RX processing
> to keep functioning properly.
> 
> This patch enables the SECIF interrupt and makes the MRF ignores all
> hardware processing of security-enabled frames, that is handled by the
> ieee802154 stack instead.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Acked-by: Alan Ott <alan@signal11.us>
> ---
> drivers/net/ieee802154/mrf24j40.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

