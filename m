Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002E346771
	for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230272; cv=none; b=YELRZpS0jpLbOdntlR1asIfCD4XJWjUxwV85edQs8hm6kQKpMIwknieauqRVqcikcHOTROmBIzjD9MLKwTDrsqXoUjQN1dkdijLUAcvfThxZydrnyzlV1PCjb8R7qDR48xoWaMI8X+P74ie2QjFSg/F3MTScMRGOP2A2N7vNMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230272; c=relaxed/simple;
	bh=6pGsiGHzTol19T8ksztlrGoKHMwqFsepeExiisUiMDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTJdJB0SzIEIB4FDFEuzyXKOubhtmROMjCGDQAXoH53+51lFtrk4alHtMZxSAPOsjgz94q3/9Ynsn9K/VZg0XEo+tl/DVxzBsrREVjekGB/RsARLTqkf5fgu1SoHEa/QDrYmW/h37vLUwrOa7iXEm3Vu6lI3uDfQmsmIZYtB92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=aBS/6RES; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="aBS/6RES"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4759b4f0897so2092133f8f.1
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784230269; x=1784835069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34nlX8hiehezECUHqMooipflNwUN2ehZF7eJFTVK0nA=;
        b=aBS/6RESfLbfQ4UQWQ/0Z+ELAgUhKt5jMCpMOtaWFOkQEdIVgH7THy/MkW6YKjGgTZ
         P7fwBrJ/DSwlXbNVo7H+AY5Y51mCiwVt3ExKg2/Jq4KSekbH4w5WBwSPBdr9QwG9o0Fr
         gzKDTtAK56l1fU+XXPQY3viAMa+dcPaNPhBwS1CIvddcPlwc5rXUwKpc0cNaBhLI1AfR
         F9dMGVKFHh+wysutys2FW/hVDQ8gbyJkuw7FPP6omBT5PuySflofoSj7TEB5HejRjcDG
         pOVhas2sVQ5zAlabr3Vt0B26BxV02u3rpkYix91CRp5Y9f9bFwagOuj7nwvD8PJYZvep
         zbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230269; x=1784835069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=34nlX8hiehezECUHqMooipflNwUN2ehZF7eJFTVK0nA=;
        b=BkCArqeXp3PXT34mZalZpNOaaNT68ZqWUvR3/S37HkonQRLVbGc9q/K27jTvwenjWa
         EvguMPVy3nLaZpkJ3Cr9+AK2OnK9PyEyeQUusLXHZR7r+UUnHLNQsZTadaqkOLl+EbVK
         98TG8PSq/kbdIEF5QAWn8W2L3D5W4uq58eAYuh96wMyb2A7tHfp2zkZd2/Db+uUzcE0w
         8OL53UGIbaXn9lXt/iHuQPmjuDEaDWHAdlwfKD+QgQiKhH0R9lLFXeq8YElw5dUx693H
         kMk0L32WLL7/WyMFnWMQZMzZLls0EVSle8nD/042UAzaBkpAVIAfGBDxBjMzFHbKC1Yb
         6rVw==
X-Forwarded-Encrypted: i=1; AHgh+RpetxW8wKZqvgb+3RIJkFGBrmjrxtTfxve5Q/To5Ph2NbdsFTrEiZRT9CLtYtysfeIUuJ5hkGPybmhq@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnJKkzuHR1vJ7bcboIYnt7Sn5S17Y3PNRQv1mAdXm7Jhrudl2
	S5ktXx6NiIepkh/GQ7MbrXKXJoM7SH4o8k3RlCh6S2we06sCmDS4FkupLypDk/lmTGTd
X-Gm-Gg: AfdE7ckGVOkedD9sqqDg0tdczTBk6BOjTQxD8G0vSz5xqIz070qdcopjWwToPTYRJXH
	rp8VMkIEdjdjT0lotJHs5ayNj7j+wnZg00FG244xrfikChPqfh+Q79ihnhuxnbZs7M2jgTveVD5
	DC0kCGPoqFkuihIUP5fBB5oOS5u5f5DAN5Tvcf63igZ///uv4c8HpQz5ynjH5JOrjvQMBCXLTYH
	Sg/+MAA2Yb77uQHg8ZY3DjBz7QhExYxwpjclpeuwMTiiNnY2D1fMRuDHOPOyB1aPISlLaX599Mj
	qqI3fe1NhmAgelW63gTKHbu1kFnFOPfiOJ9WCchw3Q5XjS2QP5b+imMazB7ejyeKlcN8ya/eix2
	fOmuYE87taCfifZhaMM+CDJXCKjgqng1XSV0tY9lmRIsyLpjViCJ+vxbq5oC/KejEbu/66VnfuF
	TL4n48UOlYXcNoqm1RO//DKnP3P6Hc+hPWMPA3U81sb91LFhJFabUhZJsniYWPCqWSC13XDw2lM
	0lHpPOUblmD09ev7oXzqIZ1
X-Received: by 2002:a05:6000:4710:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-47f608884f7mr449931f8f.22.1784230268556;
        Thu, 16 Jul 2026 12:31:08 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm24920545f8f.36.2026.07.16.12.31.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 12:31:08 -0700 (PDT)
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
Date: Thu, 16 Jul 2026 21:31:06 +0200
Message-ID: <20260716193106.30607-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>
References: <20260709131246.44517-1-doruk@0sec.ai>
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

