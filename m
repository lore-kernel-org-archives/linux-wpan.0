Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46409 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbLJWox (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Dec 2015 17:44:53 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH] ieee802154-atusb: Delete an unnecessary check before the function call "kfree_skb"
Date: Thu, 10 Dec 2015 23:44:34 +0100
Message-Id: <1449787474-24238-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, marcel@holtmann.org
Cc: Alexander Aring <alex.aring@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>

The kfree_skb() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
---

Resending after the initial one got lost and the resend had problems with
applying. This one applies, compiles and works fine for me. Added my ACK
directly.

  drivers/net/ieee802154/atusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 199a94a..b1cd865 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -310,8 +310,7 @@ static void atusb_free_urbs(struct atusb *atusb)
 		urb = usb_get_from_anchor(&atusb->idle_urbs);
 		if (!urb)
 			break;
-		if (urb->context)
-			kfree_skb(urb->context);
+		kfree_skb(urb->context);
 		usb_free_urb(urb);
 	}
 }
-- 
2.4.3

