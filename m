Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD92F8E9E
	for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230468; cv=none; b=N+dtaupLACSMyDo3q173OckJkJ39inNkPhIKHvOejhNLJNxNFzGmWwN97qqAY8mzT4aehJyzb+szWUnoDD0TWHt5jSCKDvUvvE/MmkkaL7Nnh2c8GlAlj7az5wK9PimUrwyuv5J6yNk5YM9Uk7jPcep67NqDZkODH2eXDIRVxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230468; c=relaxed/simple;
	bh=6pGsiGHzTol19T8ksztlrGoKHMwqFsepeExiisUiMDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMGO/CGCmvzdVJ62QSDbSIFvBJ80HBRsJq/1KUKEwPFJCFM9Va9JAvT1e+eD5DyCnGezcDmm1QLzKvJqSkme8xuqFgcsLx2puk0oKtL2AuvgGuysF4kr/kb7gwriX7URYjHYLGujLpbyjuORxn65UXMd70KbBPkkKgPGAMu+Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=b1b4iv4f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="b1b4iv4f"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f6de72faso6656635e9.0
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784230466; x=1784835266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=34nlX8hiehezECUHqMooipflNwUN2ehZF7eJFTVK0nA=;
        b=b1b4iv4figVxQkq+P9wELdRPGTOl2rmsKeLw0dX42XIg4RUqOOV5Uv+dCI9kSvjpw8
         LInuTC6n9yGirYe4aJkKUkquk/MB5rdr0q98LxOKNLkf0plZ1QgnE7MedjAfGdFK13OG
         JIcJ4NQDaQ4v67k6YS/uEETH5wguMr8hgkYjl2z9P0cqWn0M72bE81Y2LTUBvRyIkTh1
         k/cyI+bPLv1kdkH6IjafuEf8Sbmi9I6LK4KZan8EImkdjSNaQn8moAxOCRz6klFto5iF
         bwxoB3jDYCZSPldDQfCNSgle6ZQWahgITI8YC+bS3gn5B2lqZUgc8W91UVfjXxX3mW6D
         kpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230466; x=1784835266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34nlX8hiehezECUHqMooipflNwUN2ehZF7eJFTVK0nA=;
        b=hnXjlb4WV4tYHrVQZL4SiqkraJuF4a/GGSJSrndy0Otv2GnwgAmcZv83qj8X+3qAt9
         Q4LGfhZd7VWdV8tUZzRPPrPjNJgJUgQi0XdhBRv1bLfgbh1lvFGnw4NX5BU2FWaTDNhK
         oDwUJJbUnuFl01GWIyuzWZMwSUyayJ2UvDayOCektGwxaEwVn8M+bxZ2wxqPaylQLIwH
         Z48sNqyG1HoN/wsRpAiMztPBCFSFNj9CRbpdOeraEUDH8ABDoWc6OBy6IpAgbU7ZLUX8
         zyR23O9VtSxAtvXtwegQmLNl/YRykYH6Fq8fMpoGmNP8h0OHamA5+f2ZGBhlXEMWc725
         psyw==
X-Forwarded-Encrypted: i=1; AHgh+RpUyCwBoZvk245CtzzqTdor4Q/eNYzuHm6eQdLLi9oexDFgmzxT0DN9pIcEys0sJaZfTzsw6NbMdrGP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WASGMIT6Z5MM9FnNja3nBJg/rBIMDQrO14A5EcmgClhsJKIK
	K3QmoXa55XTtGgJdCFl79QFTr+446x3con4KcLa8PzqpGRvd0MkRgEGN7f9wHRErGEhkCYbgt3Q
	V2IXuid7e
X-Gm-Gg: AfdE7clcY2MpT0i6mAIRk9ayyoOk1BG7qwoSR2M80k9BNYW1g51VNx3oIqSfVumuB6s
	unqw1gIE7O8YmgvI2H7QZfxWfoq9rhY35iXrHwWB9k7yfnko28TAxpx5YiAcOwz5hndEx1FpLNs
	rtMZjkSyqEy36e7MA3XKwP/5B7zoi8+q+WactEbkWFE+rrs2F1obmZmUsr1CrPKHAFOSOH8oTRy
	u4HCKL6RJTlZTEB51aTDa8g8UHnR0nN6HbMX3fOQwTKH5vlX6+hzKVJajIn+8vkk/Bw8GncrxLT
	eo90r41A+KZbWb6Fpc6mrr1GDDNpFjuf3LsRuKPd7SrKWcQxod3xjkc6GF/RbDKkxIfxJ1Q8WO/
	qe0xahh/wMFq0d/TaisHUW/87KK6ahGmHjDOZylMOrt04XOZOryD3SsaaLdvi+k4CLZ5s87lxhA
	vp3MoGGn56VQggIOTTVNX9hjm8AZavmb3HXXMpGhb2j/SGc9D1WF3xaRft7piWWcnxfQP9AKQ7q
	ngU2+elq72lqFGgu09Ef1XK
X-Received: by 2002:a05:600c:1f90:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4954286a454mr40557495e9.3.1784230465576;
        Thu, 16 Jul 2026 12:34:25 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9425asm123759955e9.11.2026.07.16.12.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 12:34:24 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	leitao@debian.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu, 16 Jul 2026 21:34:23 +0200
Message-ID: <20260716193423.32498-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llsec_do_decrypt_auth() computes the associated-data length for the
AEAD request as

	assoclen += datalen - authlen;

where datalen is the number of bytes after the MAC header and authlen
(4, 8 or 16) is the length of the authentication tag. Nothing verifies
that the frame actually carries at least authlen payload bytes. A
secured frame whose payload is shorter than the tag makes
datalen - authlen negative; assoclen is then passed to
aead_request_set_ad() as an unsigned value close to 4 GiB, so
crypto_aead_decrypt() walks far off the end of the scatterlist that
only spans the real frame.

The frame is fully attacker-controlled and reaches this path from any
IEEE 802.15.4 peer in radio range. Reject frames whose payload is
shorter than the authentication tag before the subtraction.

Dynamically reproduced on a KASAN kernel as a general-protection-fault
in the AEAD scatterwalk, and the fix confirmed.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---

v2 (Breno Leitao review):
 - drop the redundant self-Reported-by.
 - move the length check above sg_init_one() (datalen/authlen are
   already available there).
 - Assisted-by trailer -> 0sec:multi-model.
Carrying Simon Horman Reviewed-by; v2 only moves the same check earlier.
 net/mac802154/llsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 5e7cc11fab3a..85452ef9a58c 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -891,6 +891,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	data = skb_mac_header(skb) + skb->mac_len;
 	datalen = skb_tail_pointer(skb) - data;
 
+	if (datalen < authlen) {
+		kfree_sensitive(req);
+		return -EBADMSG;
+	}
+
 	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
 
 	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
-- 
2.43.0

