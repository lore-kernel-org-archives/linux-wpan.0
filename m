Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37951 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaLRXVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Dec 2014 18:21:09 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/6] Various coding style cleanups and typo fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Date: Fri, 19 Dec 2014 00:21:06 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <28EE2AA3-C53B-4BC7-A2B6-8BBEADBBE51F@holtmann.org>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> Just some smaller cleanups while going through the codebase. I'm aware that the
> 3.19 merge window is already open. If you feel these are .20 material feel free to
> stick them in a branch or let me know when you want me to re-submit them.
> 
> regards
> Stefan Schmidt
> 
> Stefan Schmidt (6):
>  ieee802154/at86rf230: Remove unneeded blank lines
>  ieee802154/at86rf230: Align to opening parenthesis
>  ieee802154/at86rf230: Fix typo unkown -> unknown
>  ieee802154/cc2520: Remove extra blank lines
>  ieee802154/mrf24j40: Fix typo begining -> beginning
>  ieee802154/mrf24j40: Fix alignment of parenthesis
> 
> drivers/net/ieee802154/at86rf230.c | 12 +++++-------
> drivers/net/ieee802154/cc2520.c    |  2 --
> drivers/net/ieee802154/mrf24j40.c  |  6 +++---
> 3 files changed, 8 insertions(+), 12 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

