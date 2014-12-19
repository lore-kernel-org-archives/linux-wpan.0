Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59127 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaLSK51 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 05:57:27 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next RESEND] at86rf230: cleanup check on trac status
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418981810-17663-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 19 Dec 2014 11:57:24 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <6AC2F7D7-DA76-4D7C-B49C-485E3F25414F@holtmann.org>
References: <1418981810-17663-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

I would however prefer that even these small patches get a commit message explaining why that is correct and now was wrong before. Does not have to be anything big, but at least some sort of commit message body clearly explaining it would be helpful.

Regards

Marcel

