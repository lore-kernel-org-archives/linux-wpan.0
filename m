Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:57703 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751655AbcF0GEW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Jun 2016 02:04:22 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 2/2] 6lowpan: ndisc: add missing 802.15.4 only check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160621082719.9903-2-aar@pengutronix.de>
Date: Mon, 27 Jun 2016 08:04:19 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <16269ED3-7E95-40DE-A570-0682EA062A57@holtmann.org>
References: <20160621082719.9903-1-aar@pengutronix.de> <20160621082719.9903-2-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, dan.carpenter@oracle.com

Hi Alex,

> This patch adds a missing check to handle short address parsing for
> 802.15.4 6LoWPAN only.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/ndisc.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

