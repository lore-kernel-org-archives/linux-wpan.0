Return-Path: <SRS0=QQ6u=YR=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63235CA9EAF
	for <linux-wpan@archiver.kernel.org>; Thu, 24 Oct 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E16820663
	for <linux-wpan@archiver.kernel.org>; Thu, 24 Oct 2019 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfJXWTy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:19:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfJXWTx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Oct 2019 18:19:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 28FCA14B79EBE;
        Thu, 24 Oct 2019 15:19:53 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:19:52 -0700 (PDT)
Message-Id: <20191024.151952.183800816459145037.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     varkabhadram@gmail.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: remove set but not used variable
 'status'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191023070618.30044-1-yuehaibing@huawei.com>
References: <20191023070618.30044-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Oct 2019 15:19:53 -0700 (PDT)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Oct 2019 15:06:18 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ieee802154/cc2520.c:221:5: warning:
>  variable status set but not used [-Wunused-but-set-variable]
> 
> It is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I am assuming the WPAN folks will pick this up, thanks.
