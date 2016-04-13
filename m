Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:58720 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934097AbcDMIoI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 13 Apr 2016 04:44:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/3] ieee802154: add security bit check function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460479982-4955-1-git-send-email-web+oss@zopieux.com>
Date: Wed, 13 Apr 2016 09:44:04 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <733E2D9A-A8C9-4567-B0BE-8440C518293B@holtmann.org>
References: <1457988374-31220-1-git-send-email-web+oss@zopieux.com> <1460479982-4955-1-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Alexandre,

> ieee802154_is_secen checks if the 802.15.4 security bit is set in the
> frame control field.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Acked-by: Alan Ott <alan@signal11.us>
> ---
> include/linux/ieee802154.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

