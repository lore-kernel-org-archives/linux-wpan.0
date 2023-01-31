Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E8DC38142
	for <linux-wpan@archiver.kernel.org>; Tue, 31 Jan 2023 10:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjAaK6M (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjAaK6J (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 31 Jan 2023 05:58:09 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E8910A9A;
        Tue, 31 Jan 2023 02:58:08 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6DE99C0011;
        Tue, 31 Jan 2023 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675162687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9u/VCCc7TCKF6KtcIYr7+wk3tce3PphKkpSeQWVdUsQ=;
        b=AcvMl/pG9P7uXR9H/da3nUR+QKAsyRD4KgWQkai+8/kfxPhX4zNMKMcxVvLrzHUK5Fz7jS
        kYSs8zPFghDkud89Zhzclq5XY537AwhM5B3RxiE6bfAfr/kudcXCsnkt1ihyBzgtf6nsvA
        /h7boL6KgfYeGzByYsKYxs23UR4C54XZyDQKhpQb3VFm+L1BjcOWzNL9PXvMccsVsVuZGO
        h/UFCR/ZKby/7N70MmGw4xO6gtcAj9TJSTTPyphHZzNRpyKGWdVyJEyp8W8pzsYQLo38qA
        Cia+DrK+Pol/lzH1VC4DQ4Rk4CX1qyQsSm5choB38ykpzsDfIEtlrTKDgl6Eew==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [wpan-next 1/4] ieee802154: Add support for user active scan requests
Date:   Tue, 31 Jan 2023 11:57:54 +0100
Message-Id: <20230131105757.163034-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131105757.163034-1-miquel.raynal@bootlin.com>
References: <20230131105757.163034-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

In case a passive scan could not discover any PAN, a device may decide
to perform an active scan to force coordinators to send a BEACON
"immediately". Allow users to request to perform an active scan.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/nl802154.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 0d9becd678e3..c48b937936aa 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1414,6 +1414,7 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	type = nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE]);
 	switch (type) {
+	case NL802154_SCAN_ACTIVE:
 	case NL802154_SCAN_PASSIVE:
 		request->type = type;
 		break;
-- 
2.34.1

