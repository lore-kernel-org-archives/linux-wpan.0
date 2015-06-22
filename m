Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:41386 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbbFVKY1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Jun 2015 06:24:27 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: add request for ipv6 module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434899479-22310-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 22 Jun 2015 12:24:24 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F69F1152-4ECB-426D-AD28-E05E1BB28BB2@holtmann.org>
References: <1434899479-22310-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hi Alex,

> The iphc module depends on CONFIG_IPV6, because it's not very useful to
> build the module without IPv6 support. Recently an user reported about
> issues for setting an IPv6 address to a 6LoWPAN interface. The issues
> was solved by modprobe the ipv6 module before. To avoid such user issues
> we try to request the ipv6 module when the 6LoWPAN module is loaded.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/6lowpan/iphc.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
