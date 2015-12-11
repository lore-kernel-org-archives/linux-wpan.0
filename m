Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:38012 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750826AbbLKAMh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 10 Dec 2015 19:12:37 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] ieee802154-atusb: Delete an unnecessary check before the function call "kfree_skb"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449787474-24238-1-git-send-email-stefan@osg.samsung.com>
Date: Thu, 10 Dec 2015 14:12:30 -1000
Content-Transfer-Encoding: 7bit
Message-Id: <D8731145-E152-428F-8FFF-C38A970C15F5@holtmann.org>
References: <1449787474-24238-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>

Hi Stefan,

> The kfree_skb() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> 
> Resending after the initial one got lost and the resend had problems with
> applying. This one applies, compiles and works fine for me. Added my ACK
> directly.
> 
>  drivers/net/ieee802154/atusb.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

