Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:56900 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbdKHQQN (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Nov 2017 11:16:13 -0500
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] nl802154: Improve unlocking of a table in four functions
Message-ID: <f2f31af4-d8a6-a961-aa2a-f7b29203a3f4@users.sourceforge.net>
Date: Wed, 8 Nov 2017 17:15:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 8 Nov 2017 17:08:55 +0100

* Add jump targets so that a call of the function "rdev_unlock_llsec_table"
  is stored only once in these function implementations.

* Replace four calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 net/ieee802154/nl802154.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 99f6c254ea77..33865d355433 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1527,16 +1527,16 @@ nl802154_dump_llsec_key(struct sk_buff *skb, struct netlink_callback *cb)
 				      rdev, wpan_dev->netdev, key) < 0) {
 			/* TODO */
 			err = -EIO;
-			rdev_unlock_llsec_table(rdev, wpan_dev);
-			goto out_err;
+			goto unlock_table;
 		}
 	}
 
 	cb->args[2] = 1;
 
 out:
-	rdev_unlock_llsec_table(rdev, wpan_dev);
 	err = skb->len;
+unlock_table:
+	rdev_unlock_llsec_table(rdev, wpan_dev);
 out_err:
 	nl802154_finish_wpan_dev_dump(rdev);
 
@@ -1697,16 +1697,16 @@ nl802154_dump_llsec_dev(struct sk_buff *skb, struct netlink_callback *cb)
 					 rdev, wpan_dev->netdev, dev) < 0) {
 			/* TODO */
 			err = -EIO;
-			rdev_unlock_llsec_table(rdev, wpan_dev);
-			goto out_err;
+			goto unlock_table;
 		}
 	}
 
 	cb->args[2] = 1;
 
 out:
-	rdev_unlock_llsec_table(rdev, wpan_dev);
 	err = skb->len;
+unlock_table:
+	rdev_unlock_llsec_table(rdev, wpan_dev);
 out_err:
 	nl802154_finish_wpan_dev_dump(rdev);
 
@@ -1875,8 +1875,7 @@ nl802154_dump_llsec_devkey(struct sk_buff *skb, struct netlink_callback *cb)
 						 kpos) < 0) {
 				/* TODO */
 				err = -EIO;
-				rdev_unlock_llsec_table(rdev, wpan_dev);
-				goto out_err;
+				goto unlock_table;
 			}
 		}
 	}
@@ -1884,8 +1883,9 @@ nl802154_dump_llsec_devkey(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[2] = 1;
 
 out:
-	rdev_unlock_llsec_table(rdev, wpan_dev);
 	err = skb->len;
+unlock_table:
+	rdev_unlock_llsec_table(rdev, wpan_dev);
 out_err:
 	nl802154_finish_wpan_dev_dump(rdev);
 
@@ -2034,16 +2034,16 @@ nl802154_dump_llsec_seclevel(struct sk_buff *skb, struct netlink_callback *cb)
 					   rdev, wpan_dev->netdev, sl) < 0) {
 			/* TODO */
 			err = -EIO;
-			rdev_unlock_llsec_table(rdev, wpan_dev);
-			goto out_err;
+			goto unlock_table;
 		}
 	}
 
 	cb->args[2] = 1;
 
 out:
-	rdev_unlock_llsec_table(rdev, wpan_dev);
 	err = skb->len;
+unlock_table:
+	rdev_unlock_llsec_table(rdev, wpan_dev);
 out_err:
 	nl802154_finish_wpan_dev_dump(rdev);
 
-- 
2.15.0

