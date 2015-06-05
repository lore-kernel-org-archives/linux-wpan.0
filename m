Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54285 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbbFENc1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 09:32:27 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/3] wpan-ping: Add .gitignore to ignore generated files
Date: Fri,  5 Jun 2015 15:32:12 +0200
Message-Id: <1433511132-15818-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 wpan-ping/.gitignore

diff --git a/wpan-ping/.gitignore b/wpan-ping/.gitignore
new file mode 100644
index 0000000..0e2e07a
--- /dev/null
+++ b/wpan-ping/.gitignore
@@ -0,0 +1,2 @@
+.deps/
+wpan-ping
-- 
2.1.0

