Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F44219EB
	for <linux-wpan@vger.kernel.org>; Tue, 26 May 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820652; cv=none; b=MgGph5hiQpbDoLlJ4B6Kufnwg8U6o9dXZyvH/g5r5+pPr5X0XSmUD0VFKInOTIct87mRGj9KU3VtRIhb2fR2JeIq7OgKIYcSbLKfoD1smfGXYokcdAbBp5QqdfkyJoTy9D4Wy4Qy/XSlCltxZoMk1qBGB9suyxldWhJSiB0Pbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820652; c=relaxed/simple;
	bh=qMZKEzKm2QuHaMTiZQhoB7eayvCxCYtSQW0Pa32K1mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knJYSxiJ6LuU+7PThtB/i649VeN0ebaL0nB7OXrUUiJUG9RURrTxG7XdFUXSlL88FFqa+YvsYeiuUGEYzNQGaAJkTSDH4fZBU8Zf2LbeLcvRyiUJSKszlP2e+MoN/7j0G3ZrcWf3RAfaF6uHNHTRbu9ZP6cLcw//ZcCcyG9Qxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=s+Edj5+Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="s+Edj5+Y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so80101355e9.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2026 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779820649; x=1780425449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyPLg68IB+9zQ8MOCEl3EcTRfH24d5QSaojSphJzQ2Q=;
        b=s+Edj5+Yyc0SFmNsSKO8eM5sr7tpUgLB2/2q2jAFn23stPaHk7KxED/1r4OBlFOtri
         JrX3wPd5jeqLIYPBxANJctLuCEIX/mmbV3kVW9O1vvA0McOJUw7goqJhr4AzvMv2m9KM
         ZGb+eZ+Fb2pHkxoRNEq0b5RNRNFS2yHQG+oVW6eRKqDa/Z84yDayuLvtto/QnWlUPUpf
         9skgph6eptV5X4p8bGRU38PEpRAT4zC716ZlCRwG1MQQ8vzav+ytx9FQCZIydxTOK7Fr
         tOFV9OxpLcdk47nPeK0KZddLEfQhIGhLFlzSyyJKpPAKlFsm/QIu9zaSKqLKTBVMW+cY
         cRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820649; x=1780425449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyPLg68IB+9zQ8MOCEl3EcTRfH24d5QSaojSphJzQ2Q=;
        b=HhBpvO0O8OG8IwUD5MwVf91QIN5ynXI9JyDu3Vi3uRoxEGWnIeFL+Kq5M9NYZ2w/Sz
         qCW+ETU5gpM//sGFk5K5VUMQ0XlAKQOsxnzN+O4xeiL2Fuwdqy4ZFOymHFAePhyKCw+k
         dSDP3vk9vZ4GROh7+OSo/5ZrQsoXJaSXC6jrVkqWuaEpKddiN0DZHJNPuWrFBO1SLikJ
         Md/eWC8dfJBQAZ25aQTY4zn1P8DUGoDCtT1AdObRf4b8y3QKKbK5DbnpAlNtIe4Xzqdx
         oPvMWfqu8yZAHwcXLlcrLbnBbbanmyXt3HsXaSP4zv/IMdypnrX3jxjg9x/yeVD2sJ/I
         72dA==
X-Forwarded-Encrypted: i=1; AFNElJ9eupFCCoZHi+whMd5W+VrBXHvAWTl8yVVc6jAfZm7R1pET/WxYLhh7Msc5DZV90vxcjXiv/Zo4NYRK@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuiVkv6g7cYM+KC683ivBJ7VfXAAgYf3fq9rX2XybAkzZgl2w
	Jt6vXrRmNWl65rkzfsrJYbQkP8YCa29DwiSIcS/c5o6UoMSl2ke/Afhtat6DfihT1Lmb
X-Gm-Gg: Acq92OFLVHtJwwUxeDg5+HI3frdJ11F6VSyRyf49FXvm4ar82Cf0gwmzz0YnOPr8aNl
	0ZkG7pl3lcjiatzgPbi55XMN4NJAIaW23kbHNp8Vk79b3h0VlAlq29bLq5JZ1scE57mF/SIpxWz
	AlEppHEf5fCFxGtMhfs+pvB/c7b9xhjnPthkmBv0NEiIRaNuNpbhJ7tsaZLbtxhoiHEZZ09nuok
	XWbKWbFcdHXzw9D2j4VT8Z63Y97qhOSokJfMmNWs3+aK9cNSDJbJvVA1hjIRprjzKqhgXg/zWqq
	kvXJ4sK9e7hc6bE3i0LAEO14VXqj0eaev+fuIrDt6lmU/6XgBrtfyNvDyarBNUzzqjzaVGpw+/p
	mphC54NfA5SeWQSgdvoXM1r3sr1NJw/q/j3EFU1Qb855OCSE/gbQAn7pvxLAD1ZWnJ92oipXa8h
	RBDgp9ql3rCrAW/2tIW7dcV0V+d3RucBmwzhKM8mZDfgv2SRkHEpu/xoR1ap02Q3UhJHLjLC8UL
	WxnSnCkv9WAyfgN40AhXOt8gjdRxik9GR/ARw02WEQp
X-Received: by 2002:a05:6000:2883:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-45eb38ca1cemr35106577f8f.38.1779820648940;
        Tue, 26 May 2026 11:37:28 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c2323sm68164f8f.34.2026.05.26.11.37.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 11:37:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: aleksander.lobakin@intel.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Tue, 26 May 2026 20:37:26 +0200
Message-ID: <20260526183726.56100-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525161806.96158-1-doruk@0sec.ai>
References: <20260525161806.96158-1-doruk@0sec.ai>
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

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/linux-wpan/20260525161806.96158-1-doruk@0sec.ai/
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - mark as net fix per Olek's review
  - add Closes tag
  - add Reviewed-by

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
