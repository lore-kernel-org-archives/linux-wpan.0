Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131543D4EF
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976529; cv=none; b=sGk7l1W3xCB61cjwF8o9rOmwg7cn+ZWuAPnhFO3Oc7QbChaEAK0cYObB3AAG149C7ivlyNXoCowae97yfSXRXw17Nmw3NpHMYtWnJr3jhy35CvWShlywphkOr1heZPTBqzS0D6VeWS1smMUlkMMd4UMiy/6Dohg+r3Mu4SMc0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976529; c=relaxed/simple;
	bh=DRSbsEZlYqRU2ZFuKlgyDsGV2nz0JSOXB6TyqyEq7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9hi7l3xQDJfsxrjOTyiRddpO1nShfiOU4jHAtrKALUUDVoiuyejmkojexpGaNZ+UmjQPQfXFHfR4HwdW+OZ4MUzSGOD6/jmlEiSRfck+PHRe0m6PUnexXOSWDZUyhVqNdKjx01SfcHRX6TAItPK5/0joj6N2og6TxuzrUrjn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1yJiLDP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1yJiLDP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so2545522a91.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976527; x=1790581327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=A1yJiLDP9PGZxGGRtHL1bUKeU11xKVtc7lAoDUBe85brLViJwITGIRezyfTB3uzO2M
         tdOTF8C5hx5Qe9BM+fVxm3WC1D72z8Z2KCWgxi1YOrXiyf/0n0wEbPIXNrIGCfd3ic38
         htyNEb38eJpD7j6dgWr9Re9d+/3TvZcs2YMm5S4t1igoR7hTjWphu318p98kJKCcad61
         gCEJcAP+sxC37v4w33e1/xviZ4NnRKKJPDTEi+vvHn/qcMXNFFt5WhyzdZ53Fmj/0F4Q
         8X6UCosu1Dy9dM1kbmpXYFVlAeQ6x3h1XnwVzWgQYuFyvLhzJM0k7MDUjL+MmmFQLB4u
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976527; x=1790581327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=hLghRV4lb0Ytnvk3omBNaTf+yqzP6YGrzzYF3m/S/a4YQeRJAxy2WsP1+2ogx4B0cJ
         0JSCJlkACQ3moXeqleQmlm+oyQ4amOk1WC+3FiRZbxZrIsOLW5ZWYXZshP6lb18DawLe
         JH0dJoln1u9IO5V+eTZOUSFUW3X7Ih+ACVyhkq5kukyA8LXmJVY2L1UAmt3Ctgc+2fNH
         vzGRcZZ4FquZd32DkxoRrbudzmxOIXNOR7oOwVDk0UlU89UjBDmxegZXbGsQ7TJy0rn3
         Q8VH2pyVVUE7JpvWVtld07J4epYihwOmkIv58eJ4eh5rX7BpWVNExRi3NwuRCHtP7Lgz
         kiwQ==
X-Gm-Message-State: AFuF++nAwYbI27WjvummBcdhOJRPShZquN4f9VZosarhtuHyZgD5rLzw
	eD4p6STrgViF3wXaFz87uv1LRz5uIz0+ACYKAizsgDPfZSt/ZFO3ByVF
X-Gm-Gg: AYBFou1Y9oHJBYhyxfNToU/d0DtAaA/sV8nICYVqU5tJl5bN+H15yKguomM5CQjMxfB
	C0L0pIPuMO//BANM9uuKtOJ6N835ADE7lBrjqqKo0N/a2F1H9ncwfzuU8k0f7qvZDeqmINBq5yP
	j76oZSD8+DjfGODCszDUKigr0xgAV6QyY2UCjmdKxr8i4yzVppuBjFM+Xb4j3VRMtw7Zjs729+J
	r/VNp2tRimgzZNQwLj6bsnMlIa4qAlBlAfJ7KhUnUPCT/8fqs0Y/ewSSFUVJ1PRruRuzfJ3YxSC
	ylJDUGSOJ+mSN69+36t+aPpUoRgNp8WMyB+wJzXJLPfRmf6SJKGBzP6fktcw3C7X5G2oo/j25bp
	bV1ew6trmMcn1o5vLj9sFju/9RazEygKWT0E7a0ZcZT1nB1w5u+4rr1iyzDbgVZjo0XDYPg6f9c
	HBs0vGEvOqt3C/U+lALLivnk8EZ1XLk6e6zm7wKYqQdFB47zP3BeiYWl2Of8RlLMKhOk+/6v14d
	fA9YE24Twldong9nGznL4iUngSp3Vfkt7I5+/iUEmCQqgAfJookodQWVc3AkJumieekz9f8KoSU
	h/qP5m07gg==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-39e6a81fcf8mr8609680a91.36.1789976527065;
        Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Mon, 21 Sep 2026 07:42:05 +0000
Message-ID: <20260921074205.2289211-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213637.3316595-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
(mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
(security header), and 29 .. 29 + msdulen (payload) without verifying
that the received SPI frame length len covers those offsets, causing an
out-of-bounds read when msdulen exceeds len - 30:

  BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
  Read of size 64 at addr ffff888006453ddd by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
   ca8210_net_rx+0x96/0xc0
  ...
  The buggy address belongs to the object at ffff888006453dc0
   which belongs to the cache kmalloc-32 of size 32
  The buggy address is located 29 bytes inside of
   allocated 32-byte region [ffff888006453dc0, ffff888006453de0)

Consolidate all length and msdulen validations into a single upfront check
at the beginning of ca8210_skb_rx() before allocating the skb.

Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
msdulen = 64 and len = 30 into ca8210_skb_rx().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 1de6314..2aa7d8c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1759,19 +1759,15 @@ static int ca8210_skb_rx(
 	u8                    *data_ind
 )
 {
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = { };
 	int msdulen;
 	int hlen;
-	u8 mpdulinkquality = data_ind[23];
+	u8 mpdulinkquality;
 	struct sk_buff *skb;
 	struct ca8210_priv *priv = hw->priv;
 
-	/* Allocate mtu size buffer for every rx packet */
-	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_reserve(skb, sizeof(hdr));
+	if (len < 30)
+		return -EMSGSIZE;
 
 	msdulen = data_ind[22]; /* msdu_length */
 	if (msdulen > IEEE802154_MTU) {
@@ -1779,9 +1775,25 @@ static int ca8210_skb_rx(
 			&priv->spi->dev,
 			"received erroneously large msdu length!\n"
 		);
-		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+
+	if (len < 30 + msdulen ||
+	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
+	     len < 29 + msdulen + sizeof(struct secspec))) {
+		dev_err(&priv->spi->dev,
+			"received truncated data indication!\n");
+		return -EMSGSIZE;
+	}
+
+	mpdulinkquality = data_ind[23];
+
+	/* Allocate mtu size buffer for every rx packet */
+	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
 	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
 
 	if (priv->promiscuous)
-- 
2.47.3
