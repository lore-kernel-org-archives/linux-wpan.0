Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFF37BE7E
	for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853806; cv=none; b=ANLr1XmO/RRPlPtdOrujB4due5wxuKLIqk5AphkOcZgFYJ4JMdiYSWoGV/ZOsAX0b75guJgMPspVNGtR0C4cSnk9ZpIMgAzACK4V5jiHGKXBZQ8Jab/n8prZIlgX7qecjduO9QtrbbjXwMJRQoAmPBUvUmGKyhmpgVEpMoQ0eoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853806; c=relaxed/simple;
	bh=JzVmTdq3Q7Iq2TH3qdkMpYUeDuu0LJqEMcRNJCqtMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvK3ct2PMN1RJUwfHfGn/xzfixn41bVML5snysahrn2RBbk+MnKJAaTDGvrjlD/27Sv46851R2/2poRrCXHSA99NCCVUQEfc2BfVUha57vdzcTOJ3/matNFSd+txoPnn3VUDQiKP9aT/GkBMP/4+b4xHDJ+R09Ha0F5XPMAD5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSkGLWk9; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSkGLWk9"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so566901a12.0
        for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853799; x=1790458599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRiAGPXf/bDE6W3u+fknYqS6n6eKeAu3CAyIqYAtulg=;
        b=aSkGLWk93vpkFmPKP4eU5BGpqsr026Sz1L4HmhdQCM/eM4pQD+q5xWUZ5X+VGDsdHx
         fk+sXPrMbzKOHgzjUsiOnNeEBwWcJZ9zxo7W+jxoYwWlcvU/kU6HEOqPr0IIfdSlZsJy
         HlROJgXVKQTEzh+k3+By4yQ6/qFC9To3ehNs6o7firnZZhnWBUiUCCM2FF9Iw+GCY3Ro
         vgCYu/Vm/S/4DZvG5FtQwtmex/w7xK2EsoJ8NuWnO6dzjrBCfM1oIGly2q7cTdKvSdkU
         gKSGX780UkR2b5GR9xXuJJRrRCMTnd+Fey/bJOmO2pGjLdc4yt5OECDxJJFv4w/Wf3Lx
         QEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853799; x=1790458599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRiAGPXf/bDE6W3u+fknYqS6n6eKeAu3CAyIqYAtulg=;
        b=mJrcOgJB1e1VGG1xNoDr5TYMLGWs7tOwzra/WNqz9EboEwrPBxaZyAbjoUQI/gfyAL
         kwoajVi2EljnbKZ48ZWB3kGTbEqcn/WoPiaQBvGCA3Mrqjbz+I3r1x/6hRVDtXQJvMY5
         +yKl0p95XUZZ13/9GpzawiqdBGs5jkHwMQtlLvWqyUpgsGj5XUdd2VEcuG3aN+tQffka
         zijRoYNCcpSYrmUHFR47AywdRrvZjYl4UwLQJ/uYLuvSseX4OHh/UpHvctWMy8vCQsLH
         Ysu0zak50cTGXxt8sXvB59Akguso2ygKaMovRRERyd61YPFwFscGu+FehQb0/7SZ9fhr
         nzwA==
X-Forwarded-Encrypted: i=1; AKwUvBxRbyfTz6BEMx768Q0RdaPOcfs+K6JI836J78KfQ8ni6HD7x/zpdH9UMjw+kiQEI03I/lgVc+Adzwy6@vger.kernel.org
X-Gm-Message-State: AFuF++naJKy/HbKpS0uUsHoJrYo3EDL1zsNnF0688JjvJ+TUI1owJu81
	9LUqarkirdZYeGAdIb6X6WuYQwibis8OdcOtBMQdlwJmGm15Y51PEjsA
X-Gm-Gg: AYBFou3kf6/A6Yym+hKYMi25H2iW8SeQ76PbWxD89kDBEous5OFz8wfz2B854w1ZtYN
	ma5jsRhtbQestv6WG5OLWnAMskhJ5aru4Wx2dufAFCUC1P3Ly9JZeJld5GNGGmcCFdloRwmC0VH
	/d2FG9f5JMgDwzt79pE7XH1CtK70dBp9Lzzln+/le2Ybe+SzcBUCYEkAjzzvvQin0C6Uu57Wvjd
	8IJVzjTtnZWQ0p1Nx47w++V3Ggt3/DkrOCWKCcfYlgln+yIWVHu0iO4xvF/3bSwLkygA95TXz1Y
	4/RI7+ISPxEtSEzHVc0Rt02KCF999ESDS4DOCaoW8vB17WGxrjjpG2h6OPoiiLK98iEQxk3qBBh
	JL/95Zn01FckGXkcw1SuzgFNfM/pu2/PDxa9jO94HS/Q4Yl2He9doIFWYHXqefBpsSg2r4XRPqx
	egNHeTzZPESBVcAr0M5NIgOy1DeHwO1i6ViFyPIsPASsXNmowVx1ZV05ZujEQzrwhJM6OUB1Ckr
	tGgKEZvGNS6pfkFLOEAaH0nNIZKYRzY7yFgzi7l9bKo0f4dfs0Eclmearg1RvJJVaFt8ALTfFd/
	tgtN0Ycowg==
X-Received: by 2002:a17:902:e946:b0:2dd:c100:2516 with SMTP id d9443c01a7336-2ddc1002577mr36107355ad.31.1789853799128;
        Sat, 19 Sep 2026 14:36:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm12928885ad.82.2026.09.19.14.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:38 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 6lowpan: add missing pskb_may_pull() checks in IPHC and NHC compression
Date: Sat, 19 Sep 2026 21:36:38 +0000
Message-ID: <20260919213638.3314763-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `lowpan_header_compress()` (`net/6lowpan/iphc.c`) and
`lowpan_nhc_do_compression()` (`net/6lowpan/nhc.c`), the transmit
compression path reads `ipv6_hdr(skb)` (`sizeof(struct ipv6hdr)`) and
the next-header transport header (`nhc->nexthdrlen`, e.g.,
`sizeof(struct udphdr)`), and then calls `skb_pull(skb,
nhc->nexthdrlen)` and `skb_pull(skb, sizeof(struct ipv6hdr))` without
verifying via `pskb_may_pull()` that those headers are present in the
linear data area of `skb`.

When a short or non-linear `ETH_P_IPV6` frame is transmitted over a
6LoWPAN interface (for example, via `AF_PACKET`),
`lowpan_header_compress()` and `lowpan_nhc_do_compression()` read past
`skb_tail_pointer(skb)` and trigger `BUG_ON(skb->len < skb->data_len)`
in `skb_pull()`.

Check `pskb_may_pull(skb, sizeof(struct ipv6hdr))` in
`lowpan_header_compress()` and `pskb_may_pull(skb, sizeof(struct
ipv6hdr) + nhc->nexthdrlen)` in `lowpan_nhc_do_compression()`.

Fixes: 8df8c56a5abc ("6lowpan: Moving generic compression code into 6lowpan_iphc.c")
Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/6lowpan/iphc.c | 3 +++
 net/6lowpan/nhc.c  | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 37eaff3f7b69..b2be70036ee7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1140,6 +1140,9 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		return -EINVAL;
+
 	hdr = ipv6_hdr(skb);
 	hc_ptr = head + 2;
 
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index a4dde85664f2..a9bf340c090a 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -79,6 +79,11 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
 		goto out;
 	}
 
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* In the case of RAW sockets the transport header is not set by
 	 * the ip6 stack so we must set it ourselves
 	 */
-- 
2.55.0.1082.g2b9226bbc0-goog

