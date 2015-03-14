Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60151 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbCNQNf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 12:13:35 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next] at86rf230: init xtal_trim with zero
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425762427-8081-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 14 Mar 2015 09:13:31 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <A45F30E7-6AFD-4BEC-81B6-0DEA162BEFB1@holtmann.org>
References: <1425762427-8081-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch initialize xtal_trim value to zero. The xtal_trim property is
> an optional device tree value. Currently if no xtal_trim property is
> given the xtal_trim value can be contain random data, because it's a
> stack variable. This patch init the xtal_trim value to zero which is
> also the default value after reset for at86rf230 transceivers.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

