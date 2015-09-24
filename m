Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52429 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbbIXSoT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 14:44:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 2/2] mac802154: iface: assume big endian for af_packet
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443080231-6416-2-git-send-email-alex.aring@gmail.com>
Date: Thu, 24 Sep 2015 20:44:15 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <DB352301-EDC8-4EA1-9A50-C5ADE955F122@holtmann.org>
References: <1443080231-6416-1-git-send-email-alex.aring@gmail.com> <1443080231-6416-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> The callback "create" and "parse" from header_ops are called from
> netdev core upper-layer functionality, like af_packet. These callbacks
> assumes big endian for addresses and we should not introduce a special
> byteordering handling for ieee802154 over af_packet in userspace.
> 
> We have an identical issue with setting the mac address which also
> assumes big endian byteordering.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

