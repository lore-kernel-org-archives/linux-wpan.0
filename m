Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53426 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLFU0V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Dec 2018 15:26:21 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/2] iwpan: fix clang compiler warning on absolute-value
Date: Thu,  6 Dec 2018 21:26:01 +0100
Message-Id: <20181206202602.22176-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com, Stefan Schmidt <stefan@datenfreihafen.org>

Our CI found this when building with clang (seems to have
the option on by deafult)

iwpan.c:469:13: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
        cmd_size = abs((long)&__section_set - (long)&__section_get);
                   ^
iwpan.c:469:13: note: use function 'labs' instead
        cmd_size = abs((long)&__section_set - (long)&__section_get);
                   ^~~
                   labs

This also follows a change in iw, where we derived from.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 src/iwpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwpan.c b/src/iwpan.c
index e7781fd..fb7bef1 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -466,7 +466,7 @@ int main(int argc, char **argv)
 	int err;
 
 	/* calculate command size including padding */
-	cmd_size = abs((long)&__section_set - (long)&__section_get);
+	cmd_size = labs((long)&__section_set - (long)&__section_get);
 	/* strip off self */
 	argc--;
 	argv0 = *argv++;
-- 
2.17.2
