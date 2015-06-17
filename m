Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:34994 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbFQOBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Jun 2015 10:01:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: iface: fix order while interface up
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434548118-25656-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 17 Jun 2015 16:01:46 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <35450551-CBF3-4F42-96D1-62E351F8C289@holtmann.org>
References: <1434548118-25656-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch moves the hardware setting before calling the driver start
> callback which activates the receive handling. The hardware setup
> contains settings like address filtering which should be setup before
> activate the receive handling on the transceiver. These setting are
> protected by ieee802154_check_concurrent_iface check. This means we
> need to set these registers once before calling drv_start and can't
> be overwritten by other interfaces.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 103 +++++++++++++++++++++++++++-----------------------
> 1 file changed, 55 insertions(+), 48 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

