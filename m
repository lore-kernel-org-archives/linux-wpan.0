Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36407 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeJPX3b (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Oct 2018 19:29:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so26211249qth.3
        for <linux-wpan@vger.kernel.org>; Tue, 16 Oct 2018 08:38:30 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan-tools] wpan-hwsim: fix long option argument option for dot
Date: Tue, 16 Oct 2018 11:38:21 -0400
Message-Id: <20181016153821.10331-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aring@mojatatu.com>

This patch fixes the long option argument option to no argument. The dot
argument doesn't require any postponed argument.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 wpan-hwsim/wpan-hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
index dcddb09..3e54348 100644
--- a/wpan-hwsim/wpan-hwsim.c
+++ b/wpan-hwsim/wpan-hwsim.c
@@ -393,7 +393,7 @@ int main(int argc, const char *argv[])
 		static struct option long_options[] = {
 			{"help",	no_argument,		0,	'h' },
 			{"version",	no_argument,		0,	'v' },
-			{"dot",		required_argument,	0,	'd' },
+			{"dot",		no_argument,		0,	'd' },
 			{"ignore",	required_argument,	0,	'i' },
 			{0,				0,	0,	0 }
 		};
-- 
2.11.0
