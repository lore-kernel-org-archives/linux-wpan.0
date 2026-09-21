Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24B43CE58
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976531; cv=none; b=XZ9g+088Xpx63qcVjOE9KCAGv8gPL6ZFp7heC5IJ/9tgVpAjyvxGrFFoYNGk5DUN34x7nexNibJiNNDo4vtovNfW2OD8/BMLtGN0uSQP6Iv9cwaMGSMuQmKmYFmBr2qdKeliTH5TimfCM6WSiK8VvzAQwmNUt7bJ/7xVvLPP1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976531; c=relaxed/simple;
	bh=BbXoi92UlkhlGdeK8JNIhIfmhwJqCOsh6YgHaTnViyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ9a4fsULk3134quQnC8zxbzONs2RExiAcDX/hNlWhv53dLeFVnxAiznKGQJZDSRGxC4k9tgabSiL+/ll48brSb4bGfWoSFzYtAwZFfIZBOs46dKlDpntK4pjzjHxb4wJLBHjBqSvyoZp6MbWFmOyfkxYr2N7RKxvA7NJI4h6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moi0raPl; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moi0raPl"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868cfc5c244so1367871b3a.3
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976528; x=1790581328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lDJohtZHVUp613SJYT+/whB9vC5M06ltf1T0TWT1oQ=;
        b=moi0raPlQxbFAgSXNf0zQg2PmrJSI1ukF70ufvDo4vFwCYSDkmC/5lRutxILzuk4nf
         cyXdw6SIT1llOrMsBs9lI3TGDr6XceWtPUdQ/Tbg6Q88I/O5mEXqJ1cuXw2neOZcSrwo
         l1qoSO1NgEkktM9VQs+tY9i62dy8Vcm9OOM7PTPzciRzLIyoIsKxhV4dDSL/mnlD86x5
         NrBZARmz3nYuK7jsBsKlKk0HwVlkugL7xzPd5fE/f/j+QC4DXhLevGZiwY1N3yoBWHcA
         mjyajiBH8A7BknKlNm3s7jc7CmXxPA3mcuWPNAq6ZlvsYKA0BWg+6pasSzbrqdrsl2yk
         qtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976528; x=1790581328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lDJohtZHVUp613SJYT+/whB9vC5M06ltf1T0TWT1oQ=;
        b=dOXRoiCOQGK2yDBwdMDMSTfbCFeyhPa5Q+WVGcbvfyoyFCE8rBNtO5kpWickXcliYm
         Mu52i0T4vSJzZ1PpxVnT3Na9yjn+dfG75d2hlPuzNnjJtdcRW22Dpkb/c7/3GnmrRfny
         +zaNWxwwZpzq85ZNUXd6yJN7YSGqZjA57KtP1ilmQ8tnEl5aoQhS+AwB25/kAm3lQVGH
         YQvqypHynEpUJnFFzvdCQuJybXdjSpeVxMnad2mxVTY5I16gnnbti1UlDgBqF+QoePvI
         YX+9Rt8C8nwqKkeVVHdaBbI4+CZnHu2BluXYM9JeYFXTudY2UuIdhDjlzmte/9Y6AvnY
         SpoQ==
X-Gm-Message-State: AFuF++kkOTHYB41PR2iyXXGo9nP47irEi48rT7VvSrqLVIlW+8uDbjlL
	hE1In1N2nn1MYC+htHKzgRCtXBI7F+/jy3msHjqthtIGhLTqtpdQbG5k
X-Gm-Gg: AYBFou32oi7bAc4E2KJlETdnvQFQeBK2ofRSwOWGlXtQSKw3rA1HwPp89vVdUHSgF7U
	U0WYWhv4dzvU0ijg/F7U3JhbfCMVsmSte1tw8xwIh5uZgoZ4OwS4tqeUfaeTTVb1MCJjNr9fu5N
	7tn4dJRnPenvjOL+bwih4ya+5FnGU0ZP7uSNcStzV4gFN5Y7nUWti6xT04RVKIKDZQpVk6d5jix
	4lHOE6g3f44hIJTRZKzAmx/9ZYyHxSLIAaPFDoS7qiqxqB4MM5B72YfPQ8wX75QxW0ytmtB2ZSE
	ahXcX32m77HdgQFAqJy1qC4qpEpqWQVE6xVRjbl+yLF7lLHdg/RfGU8i8HZecscNBICkv+KO6C4
	54JtwO2EEqitCgddnKq8F6qUpgxeYLq/zgpB5kPc+YHeNRpVYW/PqxCtKRylm/e2XEW3NVyGXcL
	RI97+95V7/FDZhAxKNhZXgd8ElEvP21TD+//oqhGEi1KR4s23y3RHx7w4hSR2BTJ3ynDMNdkHvh
	AP8/L9VAXAkQnnO7nL+XlAbBAMOQxFdpNUKDDoDSt727EwokbyAQS8C61sOSEhugRf+4QHezHHY
	3vV1bu5TIcaFiXiDUO+6
X-Received: by 2002:a05:6a20:4393:b0:3dd:a00a:7ac6 with SMTP id adf61e73a8af0-3dda00a9e68mr10764183637.51.1789976528200;
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] ieee802154: cc2520: ensure tailroom before skb_put() in promiscuous TX
Date: Mon, 21 Sep 2026 07:42:04 +0000
Message-ID: <20260921074207.2289391-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cc2520_tx(), when priv->promiscuous is enabled, skb_put(skb, 2) is
called unconditionally to append the 2-byte software CRC without checking
whether the skb has at least 2 bytes of tailroom, triggering
skb_over_panic when skb_tailroom(skb) < 2:

  skbuff: skb_over_panic: text:ffffffffc080071a len:386 put:2
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  RIP: 0010:skb_panic+0x170/0x172
  Call Trace:
   <TASK>
   skb_put.cold+0x23/0x23
   cc2520_tx.constprop.0.isra.0+0x8a/0x1d0

Ensure at least 2 bytes of tailroom via pskb_expand_head() before calling
skb_put(skb, 2).

Tested in QEMU with KASAN enabled by passing a zero-tailroom skb to
cc2520_tx() with promiscuous mode enabled.

Fixes: 59869ebfe7a7 ("ieee802154: cc2520: Check CRC & add promiscuous")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the cc2520 and mcr20a fixes into four single-issue patches
  (1/4..4/4) and documented each change in its own commit message as
  requested by Miquel Raynal.

 drivers/net/ieee802154/cc2520.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index abfcfe0..5454872 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -482,8 +482,14 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	 * values on RX. This means we need to manually add the CRC on TX.
 	 */
 	if (priv->promiscuous) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
+		u16 crc;
 
+		if (skb_tailroom(skb) < 2 &&
+		    pskb_expand_head(skb, 0, 2, GFP_KERNEL)) {
+			rc = -ENOMEM;
+			goto err_tx;
+		}
+		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 		pkt_len = skb->len;
 	} else {
-- 
2.47.3
