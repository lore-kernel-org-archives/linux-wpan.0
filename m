Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:46879 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbbFPQ47 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 12:56:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 3/3] at86rf230: cleanup start and stop callbacks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434445664-438-3-git-send-email-alex.aring@gmail.com>
Date: Tue, 16 Jun 2015 18:56:56 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <56F911A4-BFD9-40EF-9D42-8CABD71F9D1D@holtmann.org>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com> <1434445664-438-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This code cleanups the start and stop callbacks by removing hw->priv and
> using the already dereferenced variable lp which is the same.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

