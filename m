Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35446 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbcKUUae (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:30:34 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] net: ieee802154: constify ieee802154_ops structures
Date: Tue, 22 Nov 2016 02:00:14 +0530
Message-Id: <1479760214-32624-1-git-send-email-bhumirks@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: julia.lawall@lip6.fr, michael.hennerich@analog.com, aar@pengutronix.de, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare the structure ieee802154_ops as const as it is only passed as an
argument to the function  ieee802154_alloc_hw. This argument is of type
const struct ieee802154_ops *, so ieee80254_ops structures having this
property can be declared as const.
Done using Coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct ieee802154_ops i@p = {...};

@ok1@
identifier r1.i;
position p;
expression e1;
@@
ieee802154_alloc_hw(e1,&i@p)

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
static
+const
struct ieee802154_ops  i={...};

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct ieee802154_ops  i;

The before and after size details of the affected files are:

   text	   data	    bss	    dec	    hex	filename
   8669	   1176	     16	   9861	   2685	drivers/net/ieee802154/adf7242.o
   8805	   1048	     16	   9869	   268d	drivers/net/ieee802154/adf7242.o

   text	   data	    bss	    dec	    hex	filename
   7211	   2296	     32	   9539	   2543	drivers/net/ieee802154/atusb.o
   7339	   2160	     32	   9531	   253b	drivers/net/ieee802154/atusb.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/net/ieee802154/adf7242.c | 2 +-
 drivers/net/ieee802154/atusb.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 9fa7ac9..4ff4c7d 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -874,7 +874,7 @@ static int adf7242_rx(struct adf7242_local *lp)
 	return 0;
 }
 
-static struct ieee802154_ops adf7242_ops = {
+static const struct ieee802154_ops adf7242_ops = {
 	.owner = THIS_MODULE,
 	.xmit_sync = adf7242_xmit,
 	.ed = adf7242_ed,
diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 1056ed1..322864a 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -567,7 +567,7 @@ static void atusb_stop(struct ieee802154_hw *hw)
 	return 0;
 }
 
-static struct ieee802154_ops atusb_ops = {
+static const struct ieee802154_ops atusb_ops = {
 	.owner			= THIS_MODULE,
 	.xmit_async		= atusb_xmit,
 	.ed			= atusb_ed,
-- 
1.9.1

