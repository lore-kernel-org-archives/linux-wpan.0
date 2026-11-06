Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005988;
	b=nps3bherJBlTMBndKvbONbZKjWDm3aDD2epBwa/RJEyLDo0COot9ns+qykoxNwuRFEOv
	 5Ije4MKANwIhOzMInOh4i2sRcuRa/a2V10r3lTm2hxpH4pVQZVmEu1vMR4amuqgsPO0x0
	 79+6bHsPwMayfvvpwUmfMnF1AD7tHkCYO1/YrFH8mIQaCfKaXsV84ysuA4DHtT8z5S6jv
	 8ZdCydcL2HlAgyML3JbnXgoA/lsL96QKlYoG0Ls8oqcNk0Cb0WLVWicGcH7qu2yif1cox
	 BLsBP/5/coK8Tc26AWKRHcWGfKAuJH1FJIb4bkNlR87jwFulNqexlJgR1A1qOtvxmLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1ROF08EgwNasXuxo3btYG0d75HLIqEGhXE/Y5ILr3Aw=;
	b=ySFw590XNSkIAuU4syyXLduHcdyc/3Knf2J5azko1zJZNhdLUu3Jm1CMoMZjEAh3ylJ3
	 sfpxiGSRdL50L2RGNeHVX6qvkT60SK5ENVNUk4/G6KqjMtrB3D6GyMo5ldG4NRSYYq/pp
	 ogYk6YXUkN8leCS5BQLDV5/PFQBtFQciZfKltLkYjL2X9ViA7W+9q3pnQsRPYToDXu3mv
	 tkLroXU4JQdMUDJf+izdkfLRODtDf/ubHSc93pjFfIIRtQZvLWh4x6XtJzA7WUwg9Xxd4
	 eoMFGUxpdb0zQ9rG6PMrSeGhOR5ggx3doXOh6MtjIOUBjwxz34g+Rwu0mmUb0zRlI+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SH3Wrkk4;
	arc=none smtp.remote-ip=91.218.175.232
Received: from mta0.migadu.com (out-232.mta0.migadu.com [91.218.175.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D61606A32E
	for <linux-wpan@vger.kernel.org>; Fri,  6 Nov 2026 22:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D61606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SH3Wrkk4
X-Envelope-To: linux-wpan@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L4ufDEEa2cDQOD1tieRWm/aNnrY0KOk7T1D5nMVlhHA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794005978; v=1; x=1794610778;
 b=SH3Wrkk4RHd7MrejZffSWADP4sedp2YtWXuVB4PRiAhqS8aJjvV6y/Q9gV5jjqZxno+ZVEH3
 zvCOlK6eU82VQSoMFHDCj7MzVJyVYT0SNTLH5nkAVBW4VLmIgy8f6BW+oF4IcFd5owFF1ujzrBq
 jXMkWyavrlkK5yqF0kA8/xGc=
X-Envelope-To: linux-wpan@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da53d83c3dc044e5;
	Fri, 06 Nov 2026 22:59:38 +0000
X-Mizu-Trace-ID: da53d83c3dc044e5
X-Migadu-Flow: FLOW_OUT
From: Roman Gushchin <roman.gushchin@linux.dev>
To: alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH net] 6lowpan: fix netdev_priv() type confusion in lowpan_event()
Date: Fri,  6 Nov 2026 22:59:30 +0000
Message-ID: <20261106225930.1379968-1-roman.gushchin@linux.dev>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lowpan_event() assumes any netdevice with dev->type == ARPHRD_6LOWPAN
has a struct lowpan_dev in netdev_priv(dev). However, non-6LoWPAN
devices can also have ARPHRD_6LOWPAN, e.g. a TUN device via TUNSETLINK
or a bonding device inheriting dev->type from its lower device.

Bringing such a device up or down causes lowpan_event() to read and
overwrite unrelated netdev_priv() memory. Since unprivileged users can
create TUN and bonding devices in a user and network namespace, they
can corrupt struct bonding and trigger a slab use-after-free.

Also check dev->ndisc_ops == &lowpan_ndisc_ops, which is set only by
lowpan_register_netdevice() on genuine 6LoWPAN devices.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
Fixes: 2ad3ed59198c ("6lowpan: add 802.15.4 short addr slaac")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-97b284e0-576e-4373-b62f-eb132f482b91
---
 net/6lowpan/6lowpan_i.h | 13 ++++++++++---
 net/6lowpan/core.c      |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/6lowpan/6lowpan_i.h b/net/6lowpan/6lowpan_i.h
index 01853cec0209..07f11d4dde6e 100644
--- a/net/6lowpan/6lowpan_i.h
+++ b/net/6lowpan/6lowpan_i.h
@@ -2,19 +2,26 @@
 #ifndef __6LOWPAN_I_H
 #define __6LOWPAN_I_H
 
+#include <linux/if_arp.h>
 #include <linux/netdevice.h>
 
 #include <net/6lowpan.h>
 
-/* caller need to be sure it's dev->type is ARPHRD_6LOWPAN */
+extern const struct ndisc_ops lowpan_ndisc_ops;
+
+static inline bool lowpan_is_dev(const struct net_device *dev)
+{
+	return dev->type == ARPHRD_6LOWPAN &&
+	       dev->ndisc_ops == &lowpan_ndisc_ops;
+}
+
+/* caller must ensure lowpan_is_dev(dev) is true */
 static inline bool lowpan_is_ll(const struct net_device *dev,
 				enum lowpan_lltypes lltype)
 {
 	return lowpan_dev(dev)->lltype == lltype;
 }
 
-extern const struct ndisc_ops lowpan_ndisc_ops;
-
 int addrconf_ifid_802154_6lowpan(u8 *eui, struct net_device *dev);
 
 #ifdef CONFIG_6LOWPAN_DEBUGFS
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 850d4a185f55..748103d37e31 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -113,7 +113,7 @@ static int lowpan_event(struct notifier_block *unused,
 	struct in6_addr addr;
 	int i;
 
-	if (dev->type != ARPHRD_6LOWPAN)
+	if (!lowpan_is_dev(dev))
 		return NOTIFY_DONE;
 
 	idev = __in6_dev_get(dev);
-- 
2.56.0.455.g6c5a503b38-goog

