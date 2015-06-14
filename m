Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40438 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbFNXZX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 19:25:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] fakelb: add xmit_async after stop testcase
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434293324-26049-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 15 Jun 2015 01:25:21 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <9D05BCD9-38A5-4FC5-8ABD-C716B70B7857@holtmann.org>
References: <1434293324-26049-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds a suspended testcase into the xmit_async functionality.
> In the hope that we can found race conditions when xmit_async is called
> after an ieee802154_ops stop. This should never happen.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/fakelb.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

