Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04EEB64D9
	for <linux-wpan@archiver.kernel.org>; Mon, 10 Jul 2023 23:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGJXDX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 10 Jul 2023 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjGJXDV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Jul 2023 19:03:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF11E46;
        Mon, 10 Jul 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=129Ywr62GUsnB8fd4+dQPU9Qo62f2KA3pJRQUQ+UrIA=; b=furZUQOYyinrwWKEPxe+fq/sll
        NyISzldSKhJcVhzfPIf5zPZJZhhh1Q8sTWzgnZg+QpvMNteYMEWmG1qW7P5ksEt9fFv9zyopPCLe4
        WFEDJI5b0DTesdRF809fODhcM3MnVXTqKAmN1Sv0M6yyYaYkaJ57naiW/cghV17geEh58FJ0BN3k4
        UfegI5VCBXIpAPcIEpofclEyOqB+uohf+VRvvt5fFyKuoTBsRgSKQKL5HJtlR6vvk61QLfB+5kB5S
        ePIZYb1TmouazCdq4Cr17qKM+SGb6qEtjpW0975ts5cjJfeR3k7wXyrx56Z7/Nw/KOd0zWvLWZypj
        kSwd3KNQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzuV-00CuO1-22;
        Mon, 10 Jul 2023 23:03:15 +0000
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
Subject: [PATCH net 03/12] net: cfg802154: fix kernel-doc notation warnings
Date:   Mon, 10 Jul 2023 16:03:03 -0700
Message-ID: <20230710230312.31197-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
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
---
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
