Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37295 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbACAws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Jan 2015 19:52:48 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next] mac802154: fix kbuild test robot warning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420210181-9228-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 2 Jan 2015 16:52:40 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <76E7E761-CCED-4A29-8B38-0B4146C206BA@holtmann.org>
References: <1420210181-9228-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch fixs the following kbuild test robot warning:
> 
> coccinelle warnings: (new ones prefixed by >>)
> 
>>> net/mac802154/cfg.c:53:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> To return net_device here is for supporting still the deprecated functionality.
> When we remove the old netlink interface we will change the return type to int.
> 
> net/mac802154/cfg.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

