Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38869 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbbI3LZg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:36 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: 6lowpan: don't skip first dsn while fragmentation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443601211-27790-2-git-send-email-alex.aring@gmail.com>
Date: Wed, 30 Sep 2015 13:25:14 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <E65C55BE-3CB9-42E1-849D-0ADF337908F6@holtmann.org>
References: <1443601211-27790-1-git-send-email-alex.aring@gmail.com> <1443601211-27790-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch fixes the data frame sequence numer (dsn) while 6lowpan
> fragmentation for frag1. Currently we create one 802.15.4 header at
> first, then check if it's match into one frame and at the end construct
> many fragments and calling wpan_dev_hard_header for each of them,
> inclusive for the first fragment. This will make the first generated
> header to garbage, instead we copying this header for frag1 instead of
> generate a new one which skips one dsn.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/tx.c | 27 +++++++++++++++++----------
> 1 file changed, 17 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

