Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45785 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbbFSJXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2015 05:23:15 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: fix llsec authentication without encryption BUG 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
Date: Fri, 19 Jun 2015 11:23:09 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <19DC550A-2A75-4A00-A571-2EFF4F605830@holtmann.org>
References: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, phoebe.buckheister@itwm.fraunhofer.de

Hi Simon,

> 802.15.4 security levels 1,2,3 provide data authenticity but
> no encryption. Currently the llsec implementation hits a BUG() if these modes
> are used. This is due to the scatterlist length being set to 0 when
> encryption is not used. This patch fixes this issue.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> net/mac802154/llsec.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

