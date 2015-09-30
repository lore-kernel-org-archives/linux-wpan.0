Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:39109 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbbI3LZo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:44 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] mac802154: check on len instead mac_len
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443463188-6881-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 30 Sep 2015 13:25:17 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F9E914EB-5FF5-430D-81C0-67D6216D15FE@holtmann.org>
References: <1443463188-6881-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch change the length check to len instead of mac_len for
> checking if the frame control field is available to dereference.
> We need to change it because I saw issues with af_packet raw sockets
> and the mrf24j40 which calls this functionality. The raw socket
> functionality doesn't set the mac_len but resets the skb_mac_header to
> skb->data which is still correct. The issue occur at mrf24j40 only,
> because the driver need to evaluate the fc fields.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/net/mac802154.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

