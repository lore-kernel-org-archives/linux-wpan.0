Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeEDRwF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 13:52:05 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/2] net: mac808211: mac802154: use lockdep_assert_in_softirq() instead own warning
Date: Fri,  4 May 2018 19:51:44 +0200
Message-Id: <20180504175144.12179-3-bigeasy@linutronix.de>
In-Reply-To: <20180504175144.12179-1-bigeasy@linutronix.de>
References: <20180504175144.12179-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

The warning in ieee802154_rx() and ieee80211_rx_napi() is there to ensure
the softirq context for the subsequent netif_receive_skb() call. The check
could be moved into the netif_receive_skb() function to prevent all calling
functions implement the checks on their own. Use the lockdep variant for
softirq context check. While at it, add a lockdep based check for irq
enabled as mentioned in the comment above netif_receive_skb().

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c     | 3 +++
 net/mac80211/rx.c  | 2 --
 net/mac802154/rx.c | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index af0558b00c6c..7b4b8611cc21 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4750,6 +4750,9 @@ static int netif_receive_skb_internal(struct sk_buff =
*skb)
  */
 int netif_receive_skb(struct sk_buff *skb)
 {
+	lockdep_assert_irqs_enabled();
+	lockdep_assert_in_softirq();
+
 	trace_netif_receive_skb_entry(skb);
=20
 	return netif_receive_skb_internal(skb);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 03102aff0953..653332d81c17 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4324,8 +4324,6 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struc=
t ieee80211_sta *pubsta,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
=20
-	WARN_ON_ONCE(softirq_count() =3D=3D 0);
-
 	if (WARN_ON(status->band >=3D NUM_NL80211_BANDS))
 		goto drop;
=20
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 4dcf6e18563a..66916c270efc 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -258,8 +258,6 @@ void ieee802154_rx(struct ieee802154_local *local, stru=
ct sk_buff *skb)
 {
 	u16 crc;
=20
-	WARN_ON_ONCE(softirq_count() =3D=3D 0);
-
 	if (local->suspended)
 		goto drop;
=20
--=20
2.17.0

