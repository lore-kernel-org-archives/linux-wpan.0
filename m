Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59078 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbETJwY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 05:52:24 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] at86rf230: add missing cca ed level values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432106823-1778-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 20 May 2015 11:52:27 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <768472E0-9894-4875-8828-5861343F3AD4@holtmann.org>
References: <1432106823-1778-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch add missing values for at86rf212 ed level values. Currently
> there are 15 values and the register setting supports 16 different ed
> level values.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Craig Younkins <craig@freshtemp.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

