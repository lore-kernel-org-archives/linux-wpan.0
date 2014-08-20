Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:41759 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbaHTXSY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:24 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so8389977wes.8
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 4/8] iwpan: fix coding style issue
Date: Thu, 21 Aug 2014 01:17:53 +0200
Message-Id: <1408576677-28149-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/iwpan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/iwpan.c b/src/iwpan.c
index 73d5ba3..1e0b162 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -118,8 +118,9 @@ static void __usage_cmd(const struct cmd *cmd, char *indent, bool full)
 			printf("%.*s\n", (int)(lend - start), start);
 			start = lend + 1;
 		} while (end != lend);
-	} else
+	} else {
 		printf("\n");
+	}
 
 	if (!full || !cmd->help)
 		return;
-- 
2.0.4

