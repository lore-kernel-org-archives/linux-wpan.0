Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72D193418;
	Thu, 19 Sep 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730857; cv=none; b=YXQRSCRZcxKUOEY/okTTzijZGtriuM4rv43+S5dfOhVKDTOE3oz0ZVC6IhnT0U+AOoVnGJYj4w9R6tHWgAqqSBbwSDnSxn9Jfca7xHxiuReIjIEhSl2Qau5bFAkz5XrIHCuVTmnLHc7jA4kRg6H0gXOV9yYsU5tL+6Jlla5ECHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730857; c=relaxed/simple;
	bh=GVjuTIwkdsz4YHVBTRhSWjHQ/dDR05dJ+3peEJosjgg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=I4hoOjAsFaRR0vFfaKMTvz0OcQgF0CWm5RgKXyzsPLyl5K63qGIe6jFu+WLRlR6VGDCHCu7Q3dnQ8I20t72NErsq3S/Ep9vU4Hzehw59qjuC6iBKO31pj8y7/lmbEoq3ypoCQUZrggPitswV9B7inuupeZ9yfDTROxaLq6ycfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vuPv0Wcw; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vuPv0Wcw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726730543;
	bh=WVNu8AiV9G8393mFYa1TtjTVMD7rCrQTbszT2HczlEQ=;
	h=From:To:Cc:Subject:Date;
	b=vuPv0Wcwdoicp14iTbyOB1Yeubc/2Qizga93E+w3BphIoIpvQORRDeKc5AkGXnqtT
	 Vymia5XPMcCbqebGTO/y/iQ7GFx9iJsWPnAMhxpSiCDND/zrEUY/v/R8m1U7LvH1C+
	 KqiU9Bh9QksY5Ze4dQQMWz96rbRlyPOgVrQXoVMQ=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 4093144F; Thu, 19 Sep 2024 15:16:09 +0800
X-QQ-mid: xmsmtpt1726730169t92x1i33o
Message-ID: <tencent_24586A9E52F56C5C12E9535AD3F243C98B06@qq.com>
X-QQ-XMAILINFO: M4wVjRC01ue09gv8wxMJnKV3gXmV+vNnebMTHEZ2/+ALg1OBD+uHWsDyqihdMH
	 T25+DQJk2dnTCYuw37iaRXzDqvx36WUNqqJQG1YWiCU++8nALikm3nBq+cBwTSmxFCcXS+EkMZ+v
	 w+7lnJhhvMoANmSL+QvJ2cGB7BYVWe8l/vlDElE3k2en0M+CfqmWT+qax3H3yJY/4zwNrqw6MmYb
	 Ns3O01phe7+GRzX++6Sis71rnusRDjcbGaOHhiwqNsMxUpcvO2SzPeJl/wb1kATvDxVMo9uqfxum
	 baNubbIz74GA4CVi6OK2UsQEKRPvKabjr/JJaPvmMBF78rf/iQvRdsMv6N1ei91U9RW57e7wsATc
	 RkbURfVSpA+ce7VsJmd/k3LItbgagmL5qa+gMxCWFokVhtDThPzjc4SlDJAJHtSzMniEaAquTHnX
	 IFXop4/TIpAM0L1w+Ll9FDR0zUWYCx0ieYvAtlzZR69xg2vNnAwt3rGPLH/GGsbNsNVxbWh6hRGZ
	 FqjXFvlquUBBsR/uyXosWOdXUjmu8bN07xJ3gXb2xICdlrqZAGLvmIdSdNh5+88XO/1G1M/tygvg
	 eT7Ca8ymoz5+s5tl7stk+U8H5TVZZNSejHCHqVmbyVLw9duhxtii1W6QOv8OspVK9RIjqndd6M1W
	 E/gyx69dJD1aFxa2XbK1pwb4qDbbvhQkAboJUl0VoowyAyxWpYsNJk5OED0Mg/Eh/aLe3wAN9ilx
	 k+g5LMZU1SstF5Gu1yfmnfvKrIEM/qJELJaSZco6TViv94ZLooqiv67G0cZTNEmxJib3JigUdFJP
	 4dfHXmiHQFhFIaG849E5QWceZL7r47/KUoPKjfTue+DzqAyJsCpzYFoLkhaYwJfBtzKcYo/TPySu
	 F3N1UBruL8lBcf555z0Wk1LoT0qHOji3PQFR/VOpb57XpXZQlcQWT3glvxCmiAzrutygymxCzZRs
	 77ZwUM90LL7iltzaKdvHsCfsen/DWNXTKGUl4+HA0AtvVFA7/d6eAGRVCpwjxHTb54wIp+iVsvbL
	 viXSbbSjUMNEZzQWsYuuCf3YIRtLBZkZXZBNgakn5rkm8hQjK1KdE1awlxIr8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	david.girault@qorvo.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Thu, 19 Sep 2024 07:16:09 +0000
X-OQ-MSGID: <20240919071609.985069-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `mac802154_scan_worker` function, the `scan_req->type` field was
accessed after the RCU read-side critical section was unlocked. According
to RCU usage rules, this is illegal and can lead to unpredictable
behavior, such as accessing memory that has been updated or causing
use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the `scan_req->type` value is now stored in a local
variable `scan_req_type` while still within the RCU read-side critical
section. The `scan_req_type` is then used after the RCU lock is released,
ensuring that the type value is safely accessed without violating RCU
rules.

Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 net/mac802154/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 1c0eeaa76560..29cd84c9f69c 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -180,6 +180,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
 	u8 scan_req_duration;
+	enum nl802154_scan_types scan_req_type;
 	u8 page, channel;
 	int ret;
 
@@ -210,6 +211,7 @@ void mac802154_scan_worker(struct work_struct *work)
 
 	wpan_phy = scan_req->wpan_phy;
 	scan_req_duration = scan_req->duration;
+	scan_req_type = scan_req->type;
 
 	/* Look for the next valid chan */
 	page = local->scan_page;
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,
-- 
2.34.1

