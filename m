Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33032 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737AbbEOOUg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 May 2015 10:20:36 -0400
Received: by wgin8 with SMTP id n8so114772890wgi.0
        for <linux-wpan@vger.kernel.org>; Fri, 15 May 2015 07:20:35 -0700 (PDT)
Date: Fri, 15 May 2015 16:20:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150515142026.GA11157@omega>
References: <5555EC72.6060302@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5555EC72.6060302@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon.

On Fri, May 15, 2015 at 01:54:10PM +0100, Simon Vincent wrote:
> I have found the Kernel crashes when multiple 802.15.4 interfaces are used
> at the same time.
> I have tracked it down in the kernel to net/mac802154/tx.c
> The problem is the ieee802154_xmit_cb is a global variable so after it has
> been assigned and added to the work queue it can be corrupted/changed by
> another interface transmitting a packet.
> 
> I have fixed it by allocating the structure on the heap. If this is a
> satisfactory fix I can submit it as a patch.
> 

first, thank you for finding this issue.

Yes, with multiple interfaces this code have issues. When we declare
ieee802154_xmit_cb per phy instead of one for every phy this should be
fixed.

Can you try the following? This should be a solution without calling kmalloc
in this callback:

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index eec668f..c9b38c0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -28,11 +28,21 @@
 
 #include "llsec.h"
 
+
 /* mac802154 device private data */
 struct ieee802154_local {
        struct ieee802154_hw hw;
        const struct ieee802154_ops *ops;
 
+       /* xmit worker handler
+        * TODO remove this xmit_sync is debprecated
+        */
+       struct ieee802154_xmit_cb {
+               struct sk_buff *skb;
+               struct work_struct work;
+               struct ieee802154_local *local;
+       } xmit_cb;
+
        /* ieee802154 phy */
        struct wpan_phy *phy;
 
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index c62e956..afbddc0 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -30,17 +30,6 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-/* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
- * packets through the workqueue.
- */
-struct ieee802154_xmit_cb {
-       struct sk_buff *skb;
-       struct work_struct work;
-       struct ieee802154_local *local;
-};
-
-static struct ieee802154_xmit_cb ieee802154_xmit_cb;
-
 static void ieee802154_xmit_worker(struct work_struct *work)
 {
        struct ieee802154_xmit_cb *cb =
@@ -106,11 +95,11 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
                dev->stats.tx_packets++;
                dev->stats.tx_bytes += skb->len;
        } else {
-               INIT_WORK(&ieee802154_xmit_cb.work, ieee802154_xmit_worker);
-               ieee802154_xmit_cb.skb = skb;
-               ieee802154_xmit_cb.local = local;
+               INIT_WORK(&local->xmit_cb.work, ieee802154_xmit_worker);
+               local->xmit_cb.skb = skb;
+               local->xmit_cb.local = local;
 
-               queue_work(local->workqueue, &ieee802154_xmit_cb.work);
+               queue_work(local->workqueue, &local->xmit_cb.work);
        }
 
        return NETDEV_TX_OK;




I have anoother question? Which is your use case to use multiple
interfaces? I am still searching for one... The most multiple interfaces
can't be running because if the phy sets registers like (address
filters, promiscuous mode, etc) we can't running another interface with
different mac values (because we have only one registers in the phy).

This means we have a lot of multiple wpan interfaces with the same mac
address which represents one. See [0] which checks on different
settings.

The only one driver (which don't do any mac functionality) is the fakelb
driver. This driver is compareable with a phy without any mac
functionality.

I was thinking about to remove the multiple interface support and only
have one interface which can have different types, so you could morph
node to monitor and backwards for example. But maybe there exists a
real use-case for have multiple interfaces on one phy...

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/iface.c#L165
