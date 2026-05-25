Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2433F54BF
	for <linux-wpan@vger.kernel.org>; Mon, 25 May 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725893; cv=none; b=Q/TTfvsNPkLh4GKsEejgKu/4Y2YJM/nKgTGc6SB/7Ezjvhz+Xc6N1hYrRrfmL3ZxdhP2mloqvL6A9Th0U81/fmnvO2UIlDmd8GouMj6Zd4kqQISA/PDWQtpV5BbxGdXFeHQEOQhfFTnLL3u/5WoOXdTDpRzJG0QKXrlg4M+cFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725893; c=relaxed/simple;
	bh=Z9A6BlK5sqy/y1bSlbWapeXBeb92OXQH7UFq90QBLic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbzXIdHPJmUO03tA31v1lgaSPAyE54+1JX2yvamMATms9V9PVjihea9murzmGHF8Ytk3ga1ps3cepC5aGJMlVeW5fpQoq/Gw05/u9HfCz+n8UdXJod4wszbDOfdAYYjhkpxmM7JFQMOWtMN8wL25ESAgrGFJsjtZI9tCooYMu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=trEsvmkb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="trEsvmkb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso5385062f8f.0
        for <linux-wpan@vger.kernel.org>; Mon, 25 May 2026 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779725888; x=1780330688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBTZFEXLf4Ae4/qSPFb1sAKHfgjqYB9a6NWd+4a/d5E=;
        b=trEsvmkbMpAeKGcqEmnLSnr2rlgA3Q5G6yosAfx74Uy80m5Rr5QtYP9Ui+A5KldRlr
         JtUV49p8rFtLWnznZmn3/Uo2npvQ87wQs3PnJSKbAfhzRr9MikvBxA4KZS691JXPlciA
         XNiNGaoMUdfza/dQzVjUqQ6iVLsp0I3PHw4ZYbYE/E5BLNnwzsko8JDWrfCZxZThEIBw
         1S6h2g9Ri/nv+Xbk4+PC7iixXD5VUi0sPYkHmzwAx4/D38jlnSdH9ZwxW5PHCNfdlxhN
         Sr1ZTRGAMdAJ+S/HNNAP6frxt66v/LyTrBLhMpNhnaurSauO4hlBxz886SKMBx3VXghw
         8brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725888; x=1780330688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBTZFEXLf4Ae4/qSPFb1sAKHfgjqYB9a6NWd+4a/d5E=;
        b=VBryzNxei8xTf/v0h9I+8AYQ587kK9HskZsWfRBcv19fpDMgfFdfsYGQgSSkYon0/F
         x26RLLufZJ3pnb9Asqfd11guNRwZWJJDLK1K1+jC4+3XCmYJ4RLJrZclCfuADJyoAPhn
         AuNZLUmBMAA7mjzN69ZM/zfAELGUK1Iaq91cOl6iYWTK3kGxWnC4BuOZ2cXa6itepk2y
         pQ2foBjOGq4+R4pXtHxxdWVS0vHerCGQTIzH5hAZXtqi+7XiWmqN06s/r5yjm2/wcYVo
         zwYxfrPpxAA3FilT050rTIf5OgsGgp8ZEPPxx8opD2JLW1bSOnkOLsQnkF6qzzsFJa+Y
         l/lA==
X-Gm-Message-State: AOJu0Yz7LQOy9L7HqZ8aawlEqXIcqo3tfYYpAYDVBn9JA/DYgpV1crok
	FnEYgnLUbwdbN+o62F5IiI0cRzk+JoeMO+aKQ3GkaqGFthTzUMJknoc3LYUHdoJnYkFl1HGGU9h
	rNU3cI/ekV6Q=
X-Gm-Gg: Acq92OE0T49/VAYzAzDUqPv4z2ZdsK6adQymmbwCMHTVZeCYuMVUYdBqr8chhqv+v5S
	yE6H4OFpiPdp3kK052TGEKeJiGOFZ0O4OZKm49dgpHEetDW2F8MqgasMa42JdsiYn9vYPKl/2x1
	HPsIt1eeFLQ2kueL2IP+du+doAItK6A36oVTD2xQj+qu4B0uud/JGKCLUZupM2gix74KrzpFG+y
	A5N3uFsexVKrg98cn5Fn0WXsiH4l+6qh8DEOIvxEHypPd/W40DfD7XIFA7tAMhuINRAiroQvQWV
	Av791RqVsqwxFKbXGVs/+a5ptjoWP0gZHw6B453rRFwMTpPepN0B+Eig/YWxxq3XUiDvrQV9Zx+
	p/qb/I3zE3yROuN925UDdGyNK/rYOedPuSF32W7oDY62W7NWA2bKcJL0hH1JHDD+rSLTGdUHXzG
	bF4gyzZKtx+tM0gfaKfQfTchrsSb+ZHDgghWC13UGqvQ25NELctIxqTEZvWHYg1RA5bvk6vF4cL
	06jLqmyiS32MBAYjgy4YXd7aOGUPXb28jiYC8EKJ23U
X-Received: by 2002:a05:6000:25c2:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-45eb39fa851mr25720549f8f.36.1779725888100;
        Mon, 25 May 2026 09:18:08 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ec7fcd7f9sm14841234f8f.37.2026.05.25.09.18.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 09:18:07 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: linux-wpan@vger.kernel.org,
	security@kernel.org,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Mon, 25 May 2026 18:18:06 +0200
Message-ID: <20260525161806.96158-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
in-place cryptographic transformations on skb data.  They build a
scatterlist with sg_init_one() pointing into the skb's linear data area
and then pass the same scatterlist as both src and dst to the crypto API
(e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).

On the RX path, __ieee802154_rx_handle_packet() clones the received skb
before handing it to each subscriber via ieee802154_subif_frame().  The
cloned skb shares the same underlying data buffer via reference
counting.  When llsec_do_decrypt() subsequently modifies this shared
buffer in place, it corrupts data that other clones -- potentially
belonging to other sockets or subsystems -- still reference.

On the TX path, similar data sharing can occur when an skb's head has
been cloned (skb_cloned() returns true).

The fix is to call skb_cow_data() before performing any in-place crypto
operation.  skb_cow_data() ensures that the skb's data area is not
shared: if the skb head is cloned or the data spans multiple fragments,
it copies the data into a private buffer that can be safely modified in
place.  This is the same pattern used by:

  - ESP (net/ipv4/esp4.c, net/ipv6/esp6.c)
  - MACsec (drivers/net/macsec.c)
  - WireGuard (drivers/net/wireguard/receive.c)
  - TIPC (net/tipc/crypto.c)

Without this guard, in-place crypto on shared skb data leads to:
  - Silent data corruption of other skb clones
  - Use-after-free when the crypto API scatterwalk writes through a
    page that has already been freed by another clone's kfree_skb()
  - Kernel crashes under concurrent 802.15.4 traffic with security
    enabled (KASAN/KMSAN reports slab-use-after-free)

This vulnerability was identified using 0sec.ai, an open-source
automated security auditing platform (https://github.com/0sec-labs).

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/mac802154/llsec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index e8512578398e..b6a4a8c93d72 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -710,6 +710,7 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 {
 	struct ieee802154_hdr hdr;
 	int rc, authlen, hlen;
+	struct sk_buff *trailer;
 	struct mac802154_llsec_key *key;
 	u32 frame_ctr;

@@ -769,6 +770,12 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 	skb->mac_len = ieee802154_hdr_push(skb, &hdr);
 	skb_reset_mac_header(skb);

+	rc = skb_cow_data(skb, 0, &trailer);
+	if (rc < 0) {
+		llsec_key_put(key);
+		return rc;
+	}
+
 	rc = llsec_do_encrypt(skb, sec, &hdr, key);
 	llsec_key_put(key);

@@ -908,6 +915,13 @@ llsec_do_decrypt(struct sk_buff *skb, const struct mac802154_llsec *sec,
 		 const struct ieee802154_hdr *hdr,
 		 struct mac802154_llsec_key *key, __le64 dev_addr)
 {
+	struct sk_buff *trailer;
+	int err;
+
+	err = skb_cow_data(skb, 0, &trailer);
+	if (err < 0)
+		return err;
+
 	if (hdr->sec.level == IEEE802154_SCF_SECLEVEL_ENC)
 		return llsec_do_decrypt_unauth(skb, sec, hdr, key, dev_addr);
 	else
--
2.45.0

