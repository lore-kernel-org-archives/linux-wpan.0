Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52576 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463AbcBOWTV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 15 Feb 2016 17:19:21 -0500
Subject: Re: [PATCHv2 bluetooth-next] mac802154: Fixes kernel oops when
 unloading a radio driver
References: <1455101378-2225-1-git-send-email-koen@bergzand.net>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56C24EE7.6090805@pengutronix.de>
Date: Mon, 15 Feb 2016 23:19:19 +0100
MIME-Version: 1.0
In-Reply-To: <1455101378-2225-1-git-send-email-koen@bergzand.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen Zandberg <koen@bergzand.net>
Cc: linux-wpan@vger.kernel.org

Hi Koen,

Am 02/10/2016 um 11:49 AM schrieb Koen Zandberg:
> Destroying the workqueue before unregistering the net device caused a
> kernel oops
>
> Signed-off-by: Koen Zandberg <koen@bergzand.net>

Acked-by: Alexander Aring <aar@pengutronix.de>
