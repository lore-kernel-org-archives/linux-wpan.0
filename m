Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:45767 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdC2Sy5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Mar 2017 14:54:57 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH][bluetooth-next][V2] ieee802154: ca8210: Add checks for
 kmalloc allocation failures
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170329170540.21011-1-colin.king@canonical.com>
Date: Wed, 29 Mar 2017 20:54:53 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <80D11AF4-0CD7-4FEE-AF17-AD79FBFBD294@holtmann.org>
References: <20170329170540.21011-1-colin.king@canonical.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Colin,

> Ensure we don't end up with a null pointer dereferences by checking
> for for allocation failures.  Allocate by sizeof(*ptr) rather than
> the type to fix checkpack warnings.  Also merge multiple lines into
> one line for the kmalloc call.
> 
> Detected by CoverityScan, CID#1422435 ("Dereference null return value")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/net/ieee802154/ca8210.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

