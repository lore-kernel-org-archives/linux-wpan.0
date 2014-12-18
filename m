Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37815 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaLRXVF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Dec 2014 18:21:05 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] at86rf230: fix register read for part version
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418850882-4234-1-git-send-email-andrey@snupi.com>
Date: Fri, 19 Dec 2014 00:20:58 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <7DEA67B6-BA23-4B9D-B93E-E741D730288B@holtmann.org>
References: <1418850882-4234-1-git-send-email-andrey@snupi.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Yurovsky <andrey@snupi.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Andrey,

> The driver was reading the PART_NUM register for both the part number
> (type of device) and the part version, the version is actually in
> register 0x1D, VERSION_NUM.  I believe that this was a copy-paste error.
> 
> Tested on AT86RF212B where the part is detected to be the expected part
> number (0x07) and version (0x03 on mine).
> 
> Signed-off-by: Andrey Yurovsky <andrey@snupi.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 18 +++++++-----------
> 1 file changed, 7 insertions(+), 11 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

