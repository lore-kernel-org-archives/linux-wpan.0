Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:45566 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbdHTSwY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Aug 2017 14:52:24 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ieee802154: ca8210: Fix a potential NULL pointer
 dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170820162502.4342-1-christophe.jaillet@wanadoo.fr>
Date: Sun, 20 Aug 2017 20:52:21 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <ECF0BF4F-CBFA-42B2-9976-C268ADF1EA10@holtmann.org>
References: <20170820162502.4342-1-christophe.jaillet@wanadoo.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Netdev list <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Hi Christophe,

> 'spi' is known to be NULL, so we dereference a NULL pointer here.
> Use 'pr_crit()' instead of 'dev_crit()' to report the message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> drivers/net/ieee802154/ca8210.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

