Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:50041 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbbFIMGU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 08:06:20 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next] ieee802154: cc2520: check for return values in cc2520_filter()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433843367-1976-1-git-send-email-stefan@osg.samsung.com>
Date: Tue, 9 Jun 2015 14:06:18 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F90D9657-F6AD-4A37-8474-87553A971D87@holtmann.org>
References: <1433843367-1976-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>

Hi Stefan,

> neither ram nor register write return values have been checked here.
> Checking both now. Assign ret with 0 as all other assignments are inside
> if blocks and might not happen before we return ret.
> 
> CID: 1230469
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> drivers/net/ieee802154/cc2520.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

