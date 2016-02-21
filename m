Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r-36.net ([78.46.55.227]:36249 "EHLO r-36.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbcBUUbZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 21 Feb 2016 15:31:25 -0500
From: Christoph Lohmann <20h@r-36.net>
Subject: [PATCH] Be more helpful in how to contribute to the website.
Date: Sun, 21 Feb 2016 21:21:17 +0100
Message-Id: <1456086077-14163-1-git-send-email-20h@r-36.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Christoph Lohmann <20h@r-36.net>

Clear examples are reducing the entry level for contributions.
---
 website/index.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 3ac44b6..3ccca3f 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -209,4 +209,26 @@ Specifications
 
 * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml[6LoWPAN IANA assignments]
 
+
+Changing the Website
+~~~~~~~~~~~~~~~~~~~~
+
+If you want to take part in developing this website, do the following:
+
+
+---------------------------------------------------------------------
+git clone https://github.com/linux-wpan/wpan-misc.git
+cd wpan-misc/website
+git checkout -b myproposal
+# Change this page to whatever you like.
+$EDITOR index.txt
+git commit -a
+# be sure to be registered to linux-wpan@vger.kernel.org before sending the
+# patch
+git send-email --to linux-wpan@vger.kernel.org -1
+---------------------------------------------------------------------
+
+Next wait for the reactions on the mailinglist and if your change is
+integrated.
+
 // vim: set syntax=asciidoc:
-- 
2.7.0

