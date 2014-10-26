Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59869 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaJZSUk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 14:20:40 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next] mac802154: tx: make worker information static
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414343734-7367-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 26 Oct 2014 11:20:32 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <27CB7F94-4C58-4F86-9427-3CE68AADB965@holtmann.org>
References: <1414343734-7367-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch moves the worker information struct out of skb control block.
> Instead control block we declare it static inside of tx.c file. We can do
> that, because the worker can't be used twice at the same time. It's
> protected by stop and wake netdev queue.
> 
> This patch fix an issue that the "struct ieee802154_xmit_cb" doesn't fit
> into the skb control block on some kernel configuartion reported by
> kbuild test robot.
> 
> It was introduced by commit fe24371d6645b766c59ec664c59d0a9c310ad455
> ("mac802154: tx: remove kmalloc in xmit hotpath").
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/tx.c | 17 +++++------------
> 1 file changed, 5 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

