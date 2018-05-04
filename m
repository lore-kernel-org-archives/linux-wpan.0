Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeEDRwF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 13:52:05 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 0/2] Introduce assert_in_softirq()
Date: Fri,  4 May 2018 19:51:42 +0200
Message-Id: <20180504175144.12179-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org

ieee80211_rx_napi() has a check to ensure that it is invoked in softirq
context / with BH disabled. It is there because it invokes
netif_receive_skb() which has this requirement.
On -RT this check does not work as expected so there is always this
warning.
Tree wide there are two users of this check: ieee80211_rx_napi() and
ieee802154_rx(). This approach introduces assert_in_softirq() which does
the check if lockdep is enabled. This check could then become a nop on
-RT.

As an alternative netif_receive_skb() (or ieee80211_rx_napi() could do
local_bh_disable() / local_bh_enable() unconditionally. The _disable()
part is very cheap. The _enable() part is more expensive because it
includes a function call. We could avoid that jump in the likely case
when BH was already disabled by something like:

 static inline void local_bh_enable(void)
 {
         if (softirq_count() =3D=3D SOFTIRQ_DISABLE_OFFSET)
                 __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
         else
                 preempt_count_sub(SOFTIRQ_DISABLE_OFFSET);
 }

Which would make bh_enable() cheaper for everyone.

Sebastian


