Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:59379 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751116AbcBUAWK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sat, 20 Feb 2016 19:22:10 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCHv2 bluetooth-next] mac802154: Fixes kernel oops when unloading a radio driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1455101378-2225-1-git-send-email-koen@bergzand.net>
Date: Sat, 20 Feb 2016 16:22:04 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <573D0BD2-7216-4F6A-8FAE-EA4540E892B5@holtmann.org>
References: <1455101378-2225-1-git-send-email-koen@bergzand.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen Zandberg <koen@bergzand.net>
Cc: linux-wpan@vger.kernel.org

Hi Koen,

> Destroying the workqueue before unregistering the net device caused a
> kernel oops
> 
> Signed-off-by: Koen Zandberg <koen@bergzand.net>
> ---
> net/mac802154/main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

