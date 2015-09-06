Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:55462 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbIFDrI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 5 Sep 2015 23:47:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] atusb: add handling for different chipnames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441448879-16511-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 5 Sep 2015 20:47:01 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <E754CFA9-548B-4554-886F-E90F3136E3DF@holtmann.org>
References: <1441448879-16511-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Stefan Schmidt <stefan@osg.samsung.com>

Hi Alex,

> This patch supports handling for printout different chipnames between
> atusb and rzusb. The rzusb contains an at86rf230 and atusb an at86rf231
> transceiver.
> 
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/atusb.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

