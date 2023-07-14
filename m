Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCFCEB64DA
	for <linux-wpan@archiver.kernel.org>; Fri, 14 Jul 2023 04:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjGNEvg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 14 Jul 2023 00:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGNEvf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 14 Jul 2023 00:51:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2C2D5F;
        Thu, 13 Jul 2023 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qD1DXByFaVGbY/ACa45ihUzn0y1l3V5o3cGLVTAVR2A=; b=PWbv+b9d71LvMImhJaPVoUOsyn
        EESuz1kQB92oVOXS/r3VcuSkBWvwM7d5Aa9b4RGvdMeSEujCheplsMm1FP0oZA6DWB6NobAtH5wCZ
        bFMApdt2/hZKLk1wh6HiB20d03hrtxdhb01KASGTl5rn/wM4XWjMQ8M4DSv4hm6ov4jdX77t7I3ul
        C+hNt2ncmv1naNPv4BWunZI0rBJ3eRjnU4QaLbNkT8C9e3mkFwV4xU2YPKFNe50U0+pc9xtVXWJhw
        8qTJ2/QDc515CVUDx7AKzVcFqPSnfaPsiIWmz3bRJgVn+ATUqCwsSeSVmrfL/3uK+mYY+LzlMVGhC
        l6olE4pw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKAm9-0050ZV-2n;
        Fri, 14 Jul 2023 04:51:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     netdev@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-wpan@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2 net 2/9] net: cfg802154: fix kernel-doc notation warnings
Date:   Thu, 13 Jul 2023 21:51:20 -0700
Message-ID: <20230714045127.18752-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714045127.18752-1-rdunlap@infradead.org>
References: <20230714045127.18752-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Add an enum heading to the kernel-doc comments to prevent
kernel-doc warnings.

cfg802154.h:174: warning: Cannot understand  * @WPAN_PHY_FLAG_TRANSMIT_POWER: Indicates that transceiver will support
 on line 174 - I thought it was a doc line

cfg802154.h:192: warning: Enum value 'WPAN_PHY_FLAG_TXPOWER' not described in enum 'wpan_phy_flags'
cfg802154.h:192: warning: Excess enum value 'WPAN_PHY_FLAG_TRANSMIT_POWER' description in 'wpan_phy_flags'

Fixes: edea8f7c75ec ("cfg802154: introduce wpan phy flags")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
v2: add Ack by Miquel;

 include/net/cfg802154.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/include/net/cfg802154.h b/include/net/cfg802154.h
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -170,7 +170,8 @@ wpan_phy_cca_cmp(const struct wpan_phy_c
 }
 
 /**
- * @WPAN_PHY_FLAG_TRANSMIT_POWER: Indicates that transceiver will support
+ * enum wpan_phy_flags - WPAN PHY state flags
+ * @WPAN_PHY_FLAG_TXPOWER: Indicates that transceiver will support
  *	transmit power setting.
  * @WPAN_PHY_FLAG_CCA_ED_LEVEL: Indicates that transceiver will support cca ed
  *	level setting.
