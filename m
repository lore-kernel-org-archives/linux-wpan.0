Return-Path: <SRS0=DF8r=4Q=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C6CC3F2D2
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Feb 2020 14:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0398B246A0
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Feb 2020 14:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sxaH/oyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB1OVF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:21:05 -0500
Received: from gateway34.websitewelcome.com ([192.185.150.107]:49561 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgB1OVF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 28 Feb 2020 09:21:05 -0500
X-Greylist: delayed 1437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 09:21:04 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 26C31127D8DF
        for <linux-wpan@vger.kernel.org>; Fri, 28 Feb 2020 07:57:07 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7g8ZjJefbvBMd7g8ZjF4r1; Fri, 28 Feb 2020 07:57:07 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pJ55MoBgiHzpl8kAnbu/YiwbH1syaoq6Pgucy8z9yhQ=; b=sxaH/oyQ6D3/Y76B6w4QjSjS3i
        oagEf+gooAwg7En6IhyrywYfqPaabNp6rnN2rj0vmobFvKcPxNZ0uLdxeDt+5sqOZdb71TEJTbGNH
        BnJD6POBt560LnLA483c8JsJGM+g7Uknv209Y9sLz/vlyVSobSY2D5E2orhip4k3nCDu1vql4HksH
        LO6+kxvRCaOB9SF/AShWe8uQsuefMvMe9IQd+jaU9UdHwWt22Pg7PbYD5cofLsVtT9P9q7wcMZ2Nd
        KhnmaJNKalTcn5qzenynTqbWn5JD4HPMJHhcgPlhrbbvv+1Rx6X9CePcZbUTbqIiRPLlW9DRYBm56
        4N2u8I+w==;
Received: from [201.162.240.44] (port=3402 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7g8X-001adL-6K; Fri, 28 Feb 2020 07:57:05 -0600
Date:   Fri, 28 Feb 2020 07:59:59 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] cfg802154: Replace zero-length array with
 flexible-array member
Message-ID: <20200228135959.GA30464@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.44
X-Source-L: No
X-Exim-ID: 1j7g8X-001adL-6K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.44]:3402
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 70
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/net/cfg802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6f86073a5d7d..6ed07844eb24 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -214,7 +214,7 @@ struct wpan_phy {
 	/* the network namespace this phy lives in currently */
 	possible_net_t _net;
 
-	char priv[0] __aligned(NETDEV_ALIGN);
+	char priv[] __aligned(NETDEV_ALIGN);
 };
 
 static inline struct net *wpan_phy_net(struct wpan_phy *wpan_phy)
-- 
2.25.0

