Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44409 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3HFA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 30 Nov 2018 02:05:00 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH wpan-tools] hwsim: make sure lqi is always initialized
Date: Thu, 29 Nov 2018 20:58:00 +0100
Message-Id: <20181129195800.28483-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com, Stefan Schmidt <stefan@datenfreihafen.org>

The lqi variable was not initialized in all code paths.

CID: 185497

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 wpan-hwsim/wpan-hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
index 3e54348..0a7c492 100644
--- a/wpan-hwsim/wpan-hwsim.c
+++ b/wpan-hwsim/wpan-hwsim.c
@@ -382,7 +382,7 @@ static void print_version(void)
 
 int main(int argc, const char *argv[])
 {
-	unsigned long int idx, idx2, lqi, ignore_idx = ULONG_MAX;
+	unsigned long int idx, idx2, lqi = 0, ignore_idx = ULONG_MAX;
 	bool dot = false;
 	int cmd;
 	int rc;
-- 
2.17.2
