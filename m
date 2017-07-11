Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:42715 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdGKGsg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Jul 2017 02:48:36 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] mrf24j40: Fix en error handling path in
 'mrf24j40_probe()'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170708084013.18620-1-christophe.jaillet@wanadoo.fr>
Date: Tue, 11 Jul 2017 08:48:33 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <7CBE2DA8-9296-42F8-ACC4-9472C178753E@holtmann.org>
References: <20170708084013.18620-1-christophe.jaillet@wanadoo.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alan Ott <alan@signal11.us>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Christophe,

> If this check fails, we must release some resources as done everywhere
> else in this function before returning an error code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: initialization of ret in this erro path ws missing. Stupid me!
> ---
> drivers/net/ieee802154/mrf24j40.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

