Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:39700 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUxX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 19 Apr 2018 16:53:23 -0400
Received: by mail-io0-f195.google.com with SMTP id v13-v6so8190713iob.6
        for <linux-wpan@vger.kernel.org>; Thu, 19 Apr 2018 13:53:22 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan] net: cfg802154: mark ieee802154_addr as packed
Date: Thu, 19 Apr 2018 16:53:03 -0400
Message-Id: <20180419205303.30035-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, eric.dumazet@gmail.com, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch marks ieee802154_addr as packed as it used by memcmp to
compare this struct for rhashtable in fragmentation api.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 include/net/cfg802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 795ca4008f72..fc5dab9c798e 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -242,7 +242,7 @@ struct ieee802154_addr {
 		__le16 short_addr;
 		__le64 extended_addr;
 	};
-};
+} __packed;
 
 struct ieee802154_llsec_key_id {
 	u8 mode;
-- 
2.11.0

