Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33436 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbdC2QVz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Mar 2017 12:21:55 -0400
Message-ID: <1490804511.24891.37.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [PATCH] Add checks for kmalloc allocation failures
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 29 Mar 2017 09:21:51 -0700
In-Reply-To: <20170329155447.17991-1-colin.king@canonical.com>
References: <20170329155447.17991-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-03-29 at 16:54 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Ensure we don't end up with a null pointer dereferences by checking
> for for allocation failures.  Allocate by sizeof(*ptr) rather than
> the type to fix checkpack warnings.  Also merge multiple lines into
> one line for the kmalloc call.
> 
> Detected by CoverityScan, CID#1422435 ("Dereference null return value")

OK, but could you change patch title to be less generic ?

Also, what tree is this patch targeting ?

# ls -l drivers/net/ieee802154/ca8210.c 
ls: cannot access drivers/net/ieee802154/ca8210.c: No such file or
directory

Thanks.


