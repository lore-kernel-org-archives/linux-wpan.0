Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CC48B373;
	Tue,  5 May 2026 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998737; cv=none; b=si7ujyMRfgZdRrdKC0t1C6CNHO6VSenryi8y3IX59htXta1YIpw1UY4ZIwy/qgHcQ327Dgcfhfei6NVRK2wWIPzR+cWrDViCRn9p9VWjA5neHMYGpYt5WXmYrNzh63vvJWyGYFaEaXGhISpUqkYwVNqN3mMJjVL5KZKstXj44k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998737; c=relaxed/simple;
	bh=+vyMnTr6IFtuhr4rM71FSbUsO13s44dHnGjiFObo7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asOYsvp5VIfSgXRmKQN65UPGP0L3OOxMMci7GnZJ41UCQdJXIlK1fQxyzmuoZkPyMS0ozEWoweM+Uy4O3Bf+Dl+LY+v9SM7IxDF3jDkSfHLwI3vny43HLaTjB3BdT5xmszojS1YVL0Evq3hAKQrBv7jvO+qvXC5olLCnqUr/uC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=iMaRd/U0 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="iMaRd/U0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=9XCk0dD/T5
	M1QjuGGaDOicMCn8hxUlDRWh0a8bw58Jg=; b=iMaRd/U0wG0TjU9d175Q+NLaiT
	MgOixab8wJpKhyiOyUaBFb8hT/RlGQBY399Q+0D51xTc+Mq97lNaR9nk1BcytHe1
	yfoRGjxCD++Ib660XQF2wDnFdAPaT/cVuTr6jaby72bWbiqaN8uxAltwW9rCwmjD
	W8z6ID71v8DpDb3cA=
Received: from hotaru.tailb307d0.ts.net (unknown [183.94.22.109])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCWfLx_G_ppCgHsAQ--.28515S2;
	Wed, 06 May 2026 00:32:00 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew@lunn.ch,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH] net: iphc: fix offset errors in multicast context compression
Date: Wed,  6 May 2026 00:31:46 +0800
Message-ID: <20260505163146.432309-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCWfLx_G_ppCgHsAQ--.28515S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFykCr1kury7Zr4rKF17Wrg_yoW8Aw47pr
	WxG3y0yFZ7Jw15C393Kr4vvr17ZFs5Jr1jgFW8C3WFk3W3Krna9F1qkry8GasFvr4rZ34q
	gry5KrZ8AanakFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
	0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUmhF7UUUUU==
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

The function lowpan_iphc_mcast_ctx_addr_compress() contains two offset
errors that break context-based multicast address compression
(LOWPAN_IPHC_DAM_00).

When compressing the multicast address, the compressed format expects
exactly 6 bytes:
  - Bytes 0-1: Flags, scope, and reserved bits (from s6_addr[1..2])
  - Bytes 2-5: The 4-byte Group ID (from s6_addr[12..15])

Currently, the memcpy() operations use incorrect offsets:
1. The destination offset for the Group ID is &data[1] instead of
   &data[2]. This overwrites the previously copied scope byte.
2. The source offset for the Group ID is &ipaddr->s6_addr[11] instead
   of &ipaddr->s6_addr[12].

This mismatch results in a corrupted compressed address being
transmitted. Consequently, the receiving side fails to reconstruct the
original IPv6 address via lowpan_uncompress_multicast_ctx_daddr() since
it expects the Group ID to start at data[2].

Fix the logic by correcting both the destination and source offsets
so that the 6-byte compressed representation is assembled correctly.

Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
 net/6lowpan/iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index e116d308a8df6..29ae68ca3ec15 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1091,7 +1091,7 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
 	/* flags/scope, reserved (RIID) */
 	memcpy(data, &ipaddr->s6_addr[1], 2);
 	/* group ID */
-	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
 	lowpan_push_hc_data(hc_ptr, data, 6);
 
 	return LOWPAN_IPHC_DAM_00;

base-commit: 95084f1883a760e0d4290698346759d58e2b944a
-- 
2.43.0

