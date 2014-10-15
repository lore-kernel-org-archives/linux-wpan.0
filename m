Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54726 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaJONi2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Oct 2014 09:38:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 1/2] ieee802154: 6lowpan: improve packet registration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413189187-27123-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 15 Oct 2014 15:38:24 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <06BCBF12-A7CD-4DDC-B31C-3C71C4964C3A@holtmann.org>
References: <1413189187-27123-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch improves the packet registration handling. Instead of
> registration with module init we have a open count variable and
> registration the lowpan packet handler when it's needed.
> 
> The open count variable should be protected by RTNL.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan_rtnl.c | 30 ++++++++++++++++++------------
> 1 file changed, 18 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

