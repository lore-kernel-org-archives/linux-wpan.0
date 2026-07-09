Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF32727FD
	for <linux-wpan@vger.kernel.org>; Thu,  9 Jul 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602773; cv=none; b=HISoGTniRTZYQC4X5lX7lWIjJfjRIz3cnTaD/5Dom+jEZmK4TTmGI77jOi0hWcAiQ5caeJBidYb+yB0LPXP1GAEIm4ZuPqS30nMjlRgc37ZBnFsgWHYJDov9nNhhE4I+L+soNyCCDaWC+LMZDzGCox1d5jGGZ4L0C2zRpGSqhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602773; c=relaxed/simple;
	bh=eXV85UOU1zgi6P7JVWPpQKScckIM/nj9u0XFq3b/aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix4fFq/AFmMrYzmpFLWeMt7C6KhFPSR7NdYBggdJYat9Bd6czdqkamqwHiToxkZgFl8/06pHTtOkfM1OkR0Ss0Zcf0mWFio5/69fnHLW16nShZc9F6bTmR4+lMTU1BFzHkA+oR2/ILAdbXhT1Gu3Xv6bzX+g9zbJ+QUmBoKchNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=l9Q8teU+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="l9Q8teU+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470174001a0so1056911f8f.0
        for <linux-wpan@vger.kernel.org>; Thu, 09 Jul 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783602770; x=1784207570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=l9Q8teU+3ECZbFPdCVmRdNVCRddRzcmdJsUavDS6pylE+0jI6TAUd28Ugd5B8uh4e7
         XlpZe+oauY+WqhhnWHe/3Hv/AHUSVYyyVazzBaA2E5V9LZLdirBcK4xIrDtPavAJPJer
         19mf/2S42of0sq9AcsD0YfPVseRBFp+Lx8ijoFbr+9P74h96dmW8EHZPJ447/s9lHo2e
         zkBeSs4qybOIuhDZSus1bYzRz+0eVd+fYFD/LpUgZnaoHZ2oDCTEvbDbq5oKvMAapESy
         AkHJs4CBZZMqHRqL3d7fKDMKUzzs09JPrK/e9Ln9i6lRoDYvb0BnsM5MKfZRsI4B6SZf
         oKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602770; x=1784207570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=Sl3747E2WHTjQQ/chmE5axEaZqh29T4kBsZwfc/7fvuophPi3iCLSNVtSfoMO847NB
         5f896UsOtqbKCMS+K+aQ+bki/wPFQuaFe6DBLBgfGjJgpVUg74+wQhYSgQg6rs3tsmrM
         aBAXQysEhaxmAARSj5Nvfckb2aOQBHQWGkn+aBKbWDDWmM6jQIh5YuPFB5zycJie33bL
         LGpHqIwQdeBf36eR+VnSGGlCfCL8lLC+83y54+56WWxXENjEMfzlORNru2NuyJ4RFwYP
         3oGDilfXh7FNhazQIwrGck0ceC3SgirRTY9J3vyH57VLAl+1lT50W0EcR2cWFOcBtejJ
         HteQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAmQvQRfJ1icwauKtFzsbX9AdsiNoCwuBhxr6YIsXLLmLyWTC5qm7ABad07wHjNs6vdfVkv0b501Oo@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaK2FRUV7CfS9BqOMQ6JSh3us5zT2Y+YC8z+nxZ7L4rD2fWX7
	b38UrGVLWHgWQ9nFkaDQLr4qOETp6n9X8QId5T2QPPhc9i/liEzUnj3+0KtKS2jLTOB6
X-Gm-Gg: AfdE7ckBdnsMoWyGbXG8ZMZFiGJsXArDjNNo2j3lMxyNaGnwe7EFWSFC1LKcSWo6xAE
	W5GlmINmpMIln7Oa33qGei+nr0gsOJ0UgqmfalTz+kkYYfR+gM5nFA+MhwA1NRNb8rf0ZjVx/R+
	qB8BL6ctNcXStieW0lCwiSLxIMxLlFEzp1zx5mf9C2p1UrQs37Laqd4bhLxr5pEdqZTkN30tw1V
	m6FBpku2lhCzBabmgezUniAsbheAKOhIMBpimAVaOTtA4Twp66uqv+dpODnQpj4U92ycDM85XuS
	nYjAflgQYjt7KTBsf1wxx3Cpg14AVTPZySv65UWWDl4mABFExWzU0fb2F0r6z/SmPBN5rutLxt6
	pyQAmEVxwon2cX0l/aH7tlClwQBjwecKMB3ZvkUrsZThwFim4sxfrzSD2Om1jCDcZ6Md0xUqD6q
	vM9I0zAm7rL+QdFa+ibgbQvzOhw1Ah4LFBNXym6w8aDeabVMjpDoycFTcnJOEIdbQ3vZCPSEr2r
	5QfbJg4G2dU+gOatIcZmEQGnYxhyXDlr44=
X-Received: by 2002:a05:6000:430e:b0:476:d13f:bb74 with SMTP id ffacd0b85a97d-47df07ae2e6mr7871263f8f.15.1783602769947;
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm50243405f8f.20.2026.07.09.06.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	phoebe.buckheister@itwm.fraunhofer.de,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu,  9 Jul 2026 15:12:46 +0200
Message-ID: <20260709131246.44517-1-doruk@0sec.ai>
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
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/mac802154/llsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 5e7cc11fab3a..364a1ac1d771 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -893,6 +893,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
 
+	if (datalen < authlen) {
+		kfree_sensitive(req);
+		return -EBADMSG;
+	}
+
 	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
 		assoclen += datalen - authlen;
 		datalen = authlen;
-- 
2.43.0

