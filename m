Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECBC63793
	for <linux-wpan@archiver.kernel.org>; Thu, 22 Jul 2021 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B896128C
	for <linux-wpan@archiver.kernel.org>; Thu, 22 Jul 2021 14:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhGVNks (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:40:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51664 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhGVNjN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jul 2021 09:39:13 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id D3988CECE1;
        Thu, 22 Jul 2021 16:19:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] 6lowpan: iphc: Fix an off-by-one check of array index
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210712121440.17860-1-colin.king@canonical.com>
Date:   Thu, 22 Jul 2021 16:19:46 +0200
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6995CA71-5AE5-4E4D-8F3A-81A25324AE22@holtmann.org>
References: <20210712121440.17860-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Colin,

> The bounds check of id is off-by-one and the comparison should
> be >= rather >. Currently the WARN_ON_ONCE check does not stop
> the out of range indexing of &ldev->ctx.table[id] so also add
> a return path if the bounds are out of range.
> 
> Addresses-Coverity: ("Illegal address computation").
> Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> net/6lowpan/debugfs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

