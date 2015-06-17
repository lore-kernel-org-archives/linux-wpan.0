Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:35959 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999AbbFQOCH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Jun 2015 10:02:07 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 2/2] mac802154: iface: cleanup stack variable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434548118-25656-2-git-send-email-alex.aring@gmail.com>
Date: Wed, 17 Jun 2015 16:02:05 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <4739486D-2A3C-40BA-B229-CE4009289371@holtmann.org>
References: <1434548118-25656-1-git-send-email-alex.aring@gmail.com> <1434548118-25656-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> There is no need to init res with zero, res can be unused but then we
> returning zero and not res.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

