Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:45247 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751523AbcADTlQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 4 Jan 2016 14:41:16 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] mac802154: constify ieee802154_llsec_ops structure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1450906592-9203-1-git-send-email-Julia.Lawall@lip6.fr>
Date: Mon, 4 Jan 2016 11:41:10 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <7E0080F5-62E2-475F-A861-7B58DC87131E@holtmann.org>
References: <1450906592-9203-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Alexander Aring <alex.aring@gmail.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hi Julia,

> The ieee802154_llsec_ops structure is never modified, so declare it as
> const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> include/net/ieee802154_netdev.h |    2 +-
> net/mac802154/mac_cmd.c         |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

