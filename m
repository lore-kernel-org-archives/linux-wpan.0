Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38487 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbbI3LZW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:22 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: 6lowpan: add tx/rx stats
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443601211-27790-3-git-send-email-alex.aring@gmail.com>
Date: Wed, 30 Sep 2015 13:25:08 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <41D783A5-AE73-464A-8157-18DB588F229C@holtmann.org>
References: <1443601211-27790-1-git-send-email-alex.aring@gmail.com> <1443601211-27790-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds support for increment transmit and receive stats. The
> meaning of these stats are IPv6 based, which shows the stats after
> running the 6lowpan adaptation layer (uncompression/compression,
> fragmentation handling) on receive and before the adaptation layer
> when transmit.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/rx.c | 2 ++
> net/ieee802154/6lowpan/tx.c | 4 ++++
> 2 files changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

