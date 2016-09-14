Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:58361 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754527AbcINMNV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Sep 2016 08:13:21 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/2] info: remove confusing supported commands printout
Date: Wed, 14 Sep 2016 14:03:52 +0200
Message-Id: <1473854633-4391-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1473854633-4391-1-git-send-email-stefan@osg.samsung.com>
References: <1473854633-4391-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This is confusing for the user as it used the raw netlink names and might not
match the help output we print. If we want to query the kernel for available
commands to display them we need to spent more energy to print it out
understandable.

Fixes #8

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/info.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/info.c b/src/info.c
index 69f37f9..b06093b 100644
--- a/src/info.c
+++ b/src/info.c
@@ -472,16 +472,6 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			}
 		}
 	}
-
-	if (tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS]) {
-		struct nlattr *nl_cmd;
-		int rem_cmd;
-
-		printf("Supported commands:\n");
-		nla_for_each_nested(nl_cmd, tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS], rem_cmd)
-			printf("\t* %s\n", command_name(nla_get_u32(nl_cmd)));
-	}
-
 	return 0;
 }
 
-- 
2.5.5

