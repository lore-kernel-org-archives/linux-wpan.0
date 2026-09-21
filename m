Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B643B4A2
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976527; cv=none; b=vAeMyUkc5XHiF/pZ7rpw1O5nYnaxiej61mOKQfCrrf3DL2STt5gKt7nv5zJ4teD0ePBM3EzSLSbgvWu/CpO8iNLf+/dgJGNRnul3Zwpmg0JIs5rcL3vTW3w90wD9cwN+80GgnRqmI3i7eFkjbJxLwLeTO90AHz64hwXaoBz7Okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976527; c=relaxed/simple;
	bh=vSpK+C5pyaQ2+gljxZXl3+/lbaSVGdNsU+FgzLAv1qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkEWW7jkKG4lhQtjCVX4wUEfjpKyCcMsvBQwu4/u4wZJZZDOWT60DXTzQhgrq6r8oTUr6bFxDQBXlBxF0FyJ78rNHQc5rHjKO6qJF93EH9z0561NGlL0zqRvcf3l5jyaNp09J4Uv2oaorVq3e3Perx9MPooPyzB1yabnN2s/Mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYXpj7gZ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYXpj7gZ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso2056634a91.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976525; x=1790581325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLvaiOprHNCFNGuXuFEkMmn5a+uIlIxvauRxRVWqnRw=;
        b=cYXpj7gZQRSxtdR/24KVbN2BjcD4bF37zaSmLFblHnNuyn7rZRnhdcILqT8TKbFV9/
         DJLT4IxnHJYql8/DbTrzprie5XH3eY2hn242vQp5SkGIGA/mSyKiiWd3fmxyqz6wiGvs
         YyC7/xfaX0BL8zo+nvhksg+tMNFK36zEH5hjWarmuVwagrQOBm5aoGGnHWNDV7tFTTYm
         ivM4G2AKRNvbDAwJVvwSEdS6VahR2Be0bSpDKyzO5dk1SVzKdh+vfAXW8wgLrrQTP6O5
         VFpwy9/7wRVCxz9O2BvItqq0ptC6DD/MD68iHfsMbqtnKMgZyeGo8xc3ap8lXuaNDDEw
         jntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976525; x=1790581325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLvaiOprHNCFNGuXuFEkMmn5a+uIlIxvauRxRVWqnRw=;
        b=hHPCDwYV55Qkbf5i5cKaxqyGBeBuI8dVEGZLB69jSdBA6VEZoTm29Soo5aLarNeAU7
         diExR/vxSR7vwN7Z08u1iOfxsuAdLc4f6r38ip+2f7WSKel6BI/fr0eHk7qQffyifU3X
         S8GDt2+NODKZ51m3pf6+7A3TJi7invGWppAwo+u9DqGyITvc7LDG2G8AAnfXiiuq2f42
         NHod4/ttkAZvV3Xldg7J28MyzUd4lXeSlJgAsmnpEtoF9DiyHRn0owGuKHd4xWOXu73a
         cSWS6RFtSQB4oyTMXbxUwIyGIcl7JfCtEWyElM0mjXoTKXgi+9/rAAtuzaG2fIAJfeyM
         /2jA==
X-Gm-Message-State: AFuF++nRwz1FGLeJbs7Zq7hBvDXs285TSoz5Chqy76GXzC5YeeNCBSVG
	U2cm5b9O5u7mMOtkNaqhsjfm4TODIGjWUII8YGyVEdgjlxbLLA15Nen7ZIAS/JqE
X-Gm-Gg: AYBFou02Q9PGUDC6aHwzRhMTakd3ZWA1/qJkWW8XhloexHf3GLYWsyNFVEEbioY4QcG
	nE5rXM32E7Fbm/BaW/9Zl2xhMP1CTXsm8aXOPWFaVoGukvny65eCzBdgjUlvjIVkNVVQxPKGJRY
	vYICIqfTkWeQRKkLr/+4gtSDvQ8rGA6k0ba1mrbFVYlo10osfGHv+XV2uuAY6VcTAnVfquBMLqk
	QptHZwiisO+7I/xrcyTbjHt+jdeR3xJjgUuBy6VeOAOrwXTp35/RCFMDSGY+nJcyvji4EXatz4Y
	FaRmdllkJEXIdTYlraKl3Ba7KRdfX0uQTk7/1WmYnEbQZ68Jfa/gRZYAZH2boc4ndVWELgWJXAb
	yWwFw4TgnL+Q44ILQmBViAEbKMwB2MYzWOXfBC8718Zm/qQ52nYF9n+2/GkykDUefV35vt5gNvU
	+QFYgzfMcCt927BIno/MSQaCjAD2yE+wmJHNRfOQ29EsW9FwxJwF1AG9oJVEE4+JjUVfQYVEVIb
	Ui7u4Gtw8po5J6vHePs0tZ/2PL0FeWWjJ202QbQNcb0n2jjxdSRQNmPuR03edH3AQXEHQYdUgnk
	MagOsU+vFQ==
X-Received: by 2002:a17:90b:4a03:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39e54d38c48mr20398806a91.8.1789976525034;
        Mon, 21 Sep 2026 00:42:05 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm12396602a91.0.2026.09.21.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:04 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] mac802154: rx: ensure tailroom before appending CRC
Date: Mon, 21 Sep 2026 07:42:02 +0000
Message-ID: <20260921074202.2289040-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213636.3316565-1-benquike@gmail.com>
References: <20260919213636.3316565-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When IEEE802154_HW_RX_OMIT_CKSUM is set, ieee802154_rx() appends a 2-byte
calculated CRC via skb_put(skb, 2) without checking whether the driver
allocated sufficient tailroom in the received skb, triggering
skb_over_panic when skb_tailroom(skb) < 2:

  skbuff: skb_over_panic: text:ffffffffb6e61896 len:386 put:2
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  RIP: 0010:skb_panic+0x170/0x172
  Call Trace:
   <TASK>
   skb_put.cold+0x23/0x23
   ieee802154_rx+0xb26/0x1d30
   ieee802154_tasklet_handler+0xa9/0xd0
   tasklet_action_common+0x2ff/0x850
   handle_softirqs+0x188/0x4e0

Ensure at least 2 bytes of tailroom are available via pskb_expand_head()
before calling skb_put().

Tested in QEMU with KASAN by injecting a zero-tailroom skb into
ieee802154_rx() with IEEE802154_HW_RX_OMIT_CKSUM set.

Fixes: b7889497d306 ("mac802154: rx: simplify crc receive handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split from the beacon/mac_cmd skb leak fix into patch 2/2.
- Dropped the redundant skb->len < 2 check as noted by Miquel Raynal.
- Only call pskb_expand_head() when skb_tailroom(skb) < 2.

 net/mac802154/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index ad602d2..6aa5920 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -487,6 +487,9 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	 * solution because the monitor needs a crc here.
 	 */
 	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
+		if (skb_tailroom(skb) < 2 &&
+		    pskb_expand_head(skb, 0, 2, GFP_ATOMIC))
+			goto free_skb;
 		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
-- 
2.47.3
