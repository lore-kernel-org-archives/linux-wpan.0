Return-Path: <SRS0=RTCd=ZN=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCBC432C0
	for <linux-wpan@archiver.kernel.org>; Thu, 21 Nov 2019 19:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641A206D7
	for <linux-wpan@archiver.kernel.org>; Thu, 21 Nov 2019 19:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUTyY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:54:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKUTyY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 21 Nov 2019 14:54:24 -0500
Received: from localhost (unknown [IPv6:2001:558:600a:cc:f9f3:9371:b0b8:cb13])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37D6215044652;
        Thu, 21 Nov 2019 11:54:23 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:54:22 -0800 (PST)
Message-Id: <20191121.115422.718114631247576545.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, pantelis.antoniou@gmail.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        kvalo@codeaurora.org, pontus.fuchs@gmail.com,
        ath9k-devel@qca.qualcomm.com, sgruszka@redhat.com,
        helmut.schaa@googlemail.com, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-wpan@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] drivers: net: Fix Kconfig indentation, continued
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191121132828.28828-1-krzk@kernel.org>
References: <20191121132828.28828-1-krzk@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Nov 2019 11:54:23 -0800 (PST)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 21 Nov 2019 21:28:28 +0800

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style.  This fixes various indentation mixups (seven spaces,
> tab+one space, etc).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to net-next.
