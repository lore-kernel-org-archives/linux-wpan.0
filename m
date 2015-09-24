Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54541 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbbIXSlG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 14:41:06 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] mrf24j40: remove trailing semicolon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443116433-27396-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 24 Sep 2015 20:40:54 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <E0E1DAB9-6A36-463B-BB4A-100829992171@holtmann.org>
References: <1443116433-27396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch removes a trailing semicolon which was introduced by commit
> d3f1bc3 ("mrf24j40: add cca mode support") and reported by kbuild test
> robot.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/mrf24j40.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

