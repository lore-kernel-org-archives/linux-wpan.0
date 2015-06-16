Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:46819 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbbFPQ46 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 12:56:58 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 2/3] at86rf230: add recommended csma backoffs settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434445664-438-2-git-send-email-alex.aring@gmail.com>
Date: Tue, 16 Jun 2015 18:56:52 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <CBB8F668-D95E-4657-A30F-1BEA86967D92@holtmann.org>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com> <1434445664-438-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds support for a new random csma backoffs settings when
> going into sleep state. This is recommended according at86rf2xx
> datasheets.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

