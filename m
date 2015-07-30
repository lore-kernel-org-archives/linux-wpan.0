Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:35638 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbG3MDA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 08:03:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next] at86rf230: remove hrtimer on 1 usec delay
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438251209-13292-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 30 Jul 2015 14:02:57 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <0D3A5736-B359-49E1-A2CA-4E1830977D2D@holtmann.org>
References: <1438251209-13292-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> According Documentation/timers/timers-howto.txt the usually case for
> setting up a hrtimer takes > ~10us. So we should use udelay in this
> case so we are sure that the state change was done, before doing the
> state change assert.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

