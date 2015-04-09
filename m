Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33399 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbDIGgX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 02:36:23 -0400
Received: by pdbnk13 with SMTP id nk13so142481833pdb.0
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 23:36:22 -0700 (PDT)
From: varkabhadram@gmail.com
Subject: [PATCH bluetooth-next] mac802154: fix typo for device
Date: Thu,  9 Apr 2015 12:05:43 +0530
Message-Id: <1428561343-32752-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

From: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/mac802154.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index d6a809e..56ef97a 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -247,7 +247,7 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
 	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
 }
 
-/* Basic interface to register ieee802154 hwice */
+/* Basic interface to register ieee802154 device */
 struct ieee802154_hw *
 ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
 void ieee802154_free_hw(struct ieee802154_hw *hw);
-- 
1.7.9.5

