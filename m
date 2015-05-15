Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62717 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030258AbbEOMyM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 May 2015 08:54:12 -0400
Received: from [10.4.18.50] ([77.89.145.139]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0Lzkkl-1ZFIRN25nH-014xlV for
 <linux-wpan@vger.kernel.org>; Fri, 15 May 2015 14:54:10 +0200
Message-ID: <5555EC72.6060302@xsilon.com>
Date: Fri, 15 May 2015 13:54:10 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Kernel crash when using multiple interfaces
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I have found the Kernel crashes when multiple 802.15.4 interfaces are 
used at the same time.
I have tracked it down in the kernel to net/mac802154/tx.c
The problem is the ieee802154_xmit_cb is a global variable so after it 
has been assigned and added to the work queue it can be 
corrupted/changed by another interface transmitting a packet.

I have fixed it by allocating the structure on the heap. If this is a 
satisfactory fix I can submit it as a patch.

  diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index c62e956..168d377 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -39,8 +39,6 @@ struct ieee802154_xmit_cb {
      struct ieee802154_local *local;
  };

-static struct ieee802154_xmit_cb ieee802154_xmit_cb;
-
  static void ieee802154_xmit_worker(struct work_struct *work)
  {
      struct ieee802154_xmit_cb *cb =
@@ -66,6 +64,7 @@ static void ieee802154_xmit_worker(struct work_struct 
*work)
      dev->stats.tx_bytes += skb->len;

      rtnl_unlock();
+    kfree(cb);

      return;

@@ -74,6 +73,7 @@ err_tx:
      ieee802154_wake_queue(&local->hw);
      rtnl_unlock();
      kfree_skb(skb);
+    kfree(cb);
      netdev_dbg(dev, "transmission failed\n");
  }

@@ -81,8 +81,8 @@ static netdev_tx_t
  ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
  {
      struct net_device *dev = skb->dev;
+    struct ieee802154_xmit_cb *ieee802154_xmit_cb_ptr;
      int ret;
-
      if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
          u16 crc = crc_ccitt(0, skb->data, skb->len);

@@ -106,11 +106,11 @@ ieee802154_tx(struct ieee802154_local *local, 
struct sk_buff *skb)
          dev->stats.tx_packets++;
          dev->stats.tx_bytes += skb->len;
      } else {
-        INIT_WORK(&ieee802154_xmit_cb.work, ieee802154_xmit_worker);
-        ieee802154_xmit_cb.skb = skb;
-        ieee802154_xmit_cb.local = local;
-
-        queue_work(local->workqueue, &ieee802154_xmit_cb.work);
+        ieee802154_xmit_cb_ptr = kmalloc(sizeof(struct 
ieee802154_xmit_cb), GFP_ATOMIC);
+        INIT_WORK(&ieee802154_xmit_cb_ptr->work, ieee802154_xmit_worker);
+        ieee802154_xmit_cb_ptr->skb = skb;
+        ieee802154_xmit_cb_ptr->local = local;
+        queue_work(local->workqueue, &ieee802154_xmit_cb_ptr->work);
      }

      return NETDEV_TX_OK;


- Simon
