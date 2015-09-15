Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33617 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbIOIPF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Sep 2015 04:15:05 -0400
Date: Tue, 15 Sep 2015 13:44:57 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] at86rf230: fix build warning
Message-ID: <20150915081457.GH9305@sudip-pc>
References: <1441964764-15611-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441964764-15611-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Sep 11, 2015 at 03:16:04PM +0530, Sudip Mukherjee wrote:
> e616a00ce786 ("drivers/net/ieee802154/at86rf230.c: seq_printf() now returns NULL")
> has removed the usage of the integer "ret" but missed removing the
> variable. And we were getting a build warning about "unused variable".
> 
> Fixes: e616a00ce786 ("drivers/net/ieee802154/at86rf230.c: seq_printf() now returns NULL")
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
Please drop this patch. This was against a temporary fix by Stephen on
linux-next. The commit is not availble now.

regards
sudip
