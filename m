Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:56616 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbaLWO26 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:28:58 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so9225081wgg.0
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:28:57 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/7] 6lowpan: allow pull only at lowpan_fetch_skb
Date: Tue, 23 Dec 2014 15:28:23 +0100
Message-Id: <1419344909-16007-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

This patch adds a check on data pointer. If this pointer is NULL we
don't copy data from skb into data. This is useful if we only check if
we can run skb_pull and doing it afterwards.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index dc03d77..c64d274 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -246,7 +246,9 @@ static inline bool lowpan_fetch_skb(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, len)))
 		return true;
 
-	skb_copy_from_linear_data(skb, data, len);
+	if (likely(data))
+		skb_copy_from_linear_data(skb, data, len);
+
 	skb_pull(skb, len);
 
 	return false;
-- 
2.2.0

