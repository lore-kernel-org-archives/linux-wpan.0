Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33916 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbbFCFwT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 01:52:19 -0400
Received: by pdbki1 with SMTP id ki1so149258495pdb.1
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 22:52:18 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-tools] interface: fix interface type info
Date: Wed,  3 Jun 2015 11:21:38 +0530
Message-Id: <1433310698-14691-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 src/interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/interface.c b/src/interface.c
index e501763..1c59876 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -28,7 +28,7 @@ const char *iftype_name(enum nl802154_iftype iftype)
 	case NL802154_IFTYPE_COORD:
 		return "coordinator";
 	default:
-		sprintf(modebuf, "Unknown mode (%d)", iftype);
+		sprintf(modebuf, "Invalid iftype (%d)", iftype);
 		return modebuf;
 	}
 }
-- 
1.7.9.5

