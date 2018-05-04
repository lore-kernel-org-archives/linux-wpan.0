Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeEDRwI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 13:52:08 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/2] lockdep: Add a assert_in_softirq()
Date: Fri,  4 May 2018 19:51:43 +0200
Message-Id: <20180504175144.12179-2-bigeasy@linutronix.de>
In-Reply-To: <20180504175144.12179-1-bigeasy@linutronix.de>
References: <20180504175144.12179-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Instead of directly warn on wrong context, check if softirq context is
set. This check could be a nop on RT.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/lockdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..59363c3047c6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -608,11 +608,17 @@ do {									\
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
=20
+#define lockdep_assert_in_softirq()	do {				\
+		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
+			  !current->softirq_context,			\
+			  "Not in softirq context as expected\n");	\
+	} while (0)
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
+# define lockdep_assert_in_softirq() do { } while (0)
 #endif
=20
 #ifdef CONFIG_LOCKDEP
--=20
2.17.0

