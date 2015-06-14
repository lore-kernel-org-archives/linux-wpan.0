Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37660 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbFNXYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 19:24:16 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 4/4] at86rf230: add support for sleep state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434226554-1450-4-git-send-email-alex.aring@gmail.com>
Date: Mon, 15 Jun 2015 01:24:14 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <B78F5661-8F73-45CB-B14B-4C7D6B27716A@holtmann.org>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com> <1434226554-1450-4-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds support for sleep state when between stop and start
> period. In this period the transceiver isn't used by the subsystem, in
> this time we disable the irq and going into the sleep state.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

