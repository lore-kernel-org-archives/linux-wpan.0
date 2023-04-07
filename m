Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76AAC76196
	for <linux-wpan@archiver.kernel.org>; Fri,  7 Apr 2023 01:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbjDGB1l (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 6 Apr 2023 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbjDGB1j (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Apr 2023 21:27:39 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 660AA93EA;
        Thu,  6 Apr 2023 18:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5AhNg
        aaGO9qearGRujtpX7xQL4VfZn3Iowog8982fMM=; b=bCS34wZIBAD8MAjFqN7DX
        EL7vvjz6coEZXQPwg7r+urbC/k71DQN0UbR86fxbKcfRkSQ8aZPGSgXpIvomtiWn
        MjZ1rqZtetkfxjt1Zc08I4OAi4tA4Mw+ZkLKJOSliq4C6BKe/iwZora24+1hG4oD
        KpgcNOOcgeh7Ou3sme2kdA=
Received: from localhost.localdomain (unknown [119.3.119.19])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wC31LFQcS9klZYEAw--.46479S2;
        Fri, 07 Apr 2023 09:26:41 +0800 (CST)
From:   Chen Aotian <chenaotian2@163.com>
To:     alex.aring@gmail.com
Cc:     stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Aotian <chenaotian2@163.com>
Subject: [PATCH] ieee802154: hwsim: Fix possible memory leaks
Date:   Fri,  7 Apr 2023 09:26:26 +0800
Message-Id: <20230407012626.45500-1-chenaotian2@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC31LFQcS9klZYEAw--.46479S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUCFWDGF48ur1rXw1xuFg_yoW8JFy8pF
        Wjv3sxtF48tr18W3yDGw4kAa4SyayrWry8ur1fKa93ZF1IqrW09rnrGF1ayr4YyrWDC3Wf
        AF4qqr1avrn8CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joKZJUUUUU=
X-Originating-IP: [119.3.119.19]
X-CM-SenderInfo: xfkh0tprwlt0qs6rljoofrz/1tbiRRRKwGDuzUsVOAAAs+
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

After replacing e->info, it is necessary to free the old einfo.

Signed-off-by: Chen Aotian <chenaotian2@163.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 8445c2189..6e7e10b17 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -685,7 +685,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -723,8 +723,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
+			einfo_old = rcu_dereference(e->info);
 			rcu_assign_pointer(e->info, einfo);
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
-- 
2.25.1

