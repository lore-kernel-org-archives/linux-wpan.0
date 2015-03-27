Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56671 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbbC0SWc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Mar 2015 14:22:32 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 1/3] mac802154: cleanup concurrent check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 27 Mar 2015 11:22:26 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <C7BB5225-D2E2-4E73-9E1E-989B4DE01655@holtmann.org>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

> This patch cleanups the checking of different mac phy depended values by
> handling depended mac settings per hw support flag in one condition.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 20 ++++++--------------
> 1 file changed, 6 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

