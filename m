Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D8AC678D5
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Mar 2023 07:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCGHmN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 7 Mar 2023 02:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCGHmN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Mar 2023 02:42:13 -0500
X-Greylist: delayed 617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 23:42:11 PST
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF22E837;
        Mon,  6 Mar 2023 23:42:10 -0800 (PST)
Received: from pride-PowerEdge-R740.. ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3277U5pJ009289-3277U5pM009289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Mar 2023 15:30:10 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        syzbot+bd85b31816913a32e473@syzkaller.appspotmail.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ieee802154: fix a null pointer in nl802154_trigger_scan
Date:   Tue,  7 Mar 2023 15:30:03 +0800
Message-Id: <20230307073004.74224-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

There is a null pointer dereference if NL802154_ATTR_SCAN_TYPE is
not set by the user.

Fix this by adding a null pointer check.

Reported-and-tested-by: syzbot+bd85b31816913a32e473@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 net/ieee802154/nl802154.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 2215f576ee37..1cf00cffd63f 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1412,7 +1412,8 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
-	if (!nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE])) {
+	if (!info->attrs[NL802154_ATTR_SCAN_TYPE] ||
+	    !nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE])) {
 		NL_SET_ERR_MSG(info->extack, "Malformed request, missing scan type");
 		return -EINVAL;
 	}
-- 
2.34.1

