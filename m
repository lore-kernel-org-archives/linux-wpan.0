Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38646 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbbI3LZ2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 1/3] ieee802154: 6lowpan: change datagram var types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 30 Sep 2015 13:25:11 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <1BB429CD-965B-4DF3-BE1C-6A6DB23CE19B@holtmann.org>
References: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch changes datagram size variable from u16 type to unsigned int.
> The reason is that an IPv6 header has an MAX_UIN16 payload length, but
> the datagram size is payload + IPv6 header length. This avoids overflows
> at some places.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/6lowpan_i.h  | 4 ++--
> net/ieee802154/6lowpan/reassembly.c | 2 +-
> net/ieee802154/6lowpan/tx.c         | 8 ++++----
> 3 files changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

