Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36216 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbbHKTok (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Aug 2015 15:44:40 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] documentation: networking: add 6lowpan documentation
Date: Tue, 11 Aug 2015 21:44:10 +0200
Message-Id: <1439322250-32039-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
References: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

This patch adds a 6lowpan.txt into the networking documentation
directory. Currently this documentation describes how the lowpan
private data of net devices will be handled.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Suggested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 Documentation/networking/6lowpan.txt | 51 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                          |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/networking/6lowpan.txt

diff --git a/Documentation/networking/6lowpan.txt b/Documentation/networking/6lowpan.txt
new file mode 100644
index 0000000..498c81f
--- /dev/null
+++ b/Documentation/networking/6lowpan.txt
@@ -0,0 +1,51 @@
+
+Netdev private dataroom for 6lowpan interfaces:
+
+All 6lowpan able net devices, means all interfaces with ARPHRD_6LOWPAN,
+must have "struct lowpan_priv" placed at beginning of netdev_priv.
+
+The priv_size of each interface should be calculate by:
+
+ dev->priv_size = LOWPAN_PRIV_SIZE(LL_6LOWPAN_PRIV_DATA);
+
+Where LL_PRIV_6LOWPAN_DATA is sizeof linklayer 6lowpan private data struct.
+To access the LL_PRIV_6LOWPAN_DATA structure you can cast:
+
+ lowpan_priv(dev)-priv;
+
+to your LL_6LOWPAN_PRIV_DATA structure.
+
+Before registering the lowpan netdev interface you must run:
+
+ lowpan_netdev_setup(dev, LOWPAN_LLTYPE_FOOBAR);
+
+wheres LOWPAN_LLTYPE_FOOBAR is a define for your 6LoWPAN linklayer type of
+enum lowpan_lltypes.
+
+Example to evaluate the private usually you can do:
+
+static inline sturct lowpan_priv_foobar *
+lowpan_foobar_priv(struct net_device *dev)
+{
+	return (sturct lowpan_priv_foobar *)lowpan_priv(dev)->priv;
+}
+
+switch (dev->type) {
+case ARPHRD_6LOWPAN:
+	lowpan_priv = lowpan_priv(dev);
+	/* do great stuff which is ARPHRD_6LOWPAN related */
+	switch (lowpan_priv->lltype) {
+	case LOWPAN_LLTYPE_FOOBAR:
+		/* do 802.15.4 6LoWPAN handling here */
+		lowpan_foobar_priv(dev)->bar = foo;
+		break;
+	...
+	}
+	break;
+...
+}
+
+In case of generic 6lowpan branch ("net/6lowpan") you can remove the check
+on ARPHRD_6LOWPAN, because you can be sure that these function are called
+by ARPHRD_6LOWPAN interfaces.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 98ede02..5baa91c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -158,6 +158,7 @@ L:	linux-wpan@vger.kernel.org
 S:	Maintained
 F:	net/6lowpan/
 F:	include/net/6lowpan.h
+F:	Documentation/networking/6lowpan.txt
 
 6PACK NETWORK DRIVER FOR AX.25
 M:	Andreas Koensgen <ajk@comnets.uni-bremen.de>
-- 
2.5.0

