Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51717 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbFBPKk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 11:10:40 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: set ackreq when needed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433253317-30920-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 2 Jun 2015 17:10:38 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <D7FF336A-3078-4CDB-A383-BF027E13D9CD@holtmann.org>
References: <1433253317-30920-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch sets the acknowledge request bit inside the 802.15.4 mac
> header when frame retries is 0 or above. The other frame retries value
> which is -1 indicates that the transmitter doesn't care about an
> acknowledge frame which will be ignored after transmitting if the node
> sends anyway an ack frame after receiving. This is currently unnecessary
> traffic if the max frame retries parameter is -1.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/tx.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

