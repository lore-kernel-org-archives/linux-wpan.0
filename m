Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35147 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbFDHNd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:13:33 -0400
Received: by padjw17 with SMTP id jw17so23736901pad.2
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:13:32 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCHv2 wpan-tools] interface: fix interface type info
Date: Thu,  4 Jun 2015 12:43:00 +0530
Message-Id: <1433401980-4704-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 src/interface.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/interface.c b/src/interface.c
index e501763..647247b 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -16,7 +16,7 @@
 
 SECTION(interface);
 
-static char modebuf[100];
+static char iftypebuf[100];
 
 const char *iftype_name(enum nl802154_iftype iftype)
 {
@@ -28,8 +28,8 @@ const char *iftype_name(enum nl802154_iftype iftype)
 	case NL802154_IFTYPE_COORD:
 		return "coordinator";
 	default:
-		sprintf(modebuf, "Unknown mode (%d)", iftype);
-		return modebuf;
+		sprintf(iftypebuf, "Invalid iftype (%d)", iftype);
+		return iftypebuf;
 	}
 }
 
-- 
1.7.9.5

