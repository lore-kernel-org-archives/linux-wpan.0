Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38782 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbEZVqU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 17:46:20 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] nl802154: fix cca mode wpan phy flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432674691-2008-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 26 May 2015 23:46:06 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <DD1E845A-0D9D-4DBB-8C51-9AD84E9B442D@holtmann.org>
References: <1432674691-2008-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch fix the handling to call cca mode setting. If the phy isn't
> flag then the driver doesn't support this setting.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Varka Bhadram <varkabhadram@gmail.com>
> ---
> net/ieee802154/nl802154.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

