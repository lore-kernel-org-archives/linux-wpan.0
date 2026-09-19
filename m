Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7E3A3826
	for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857280; cv=none; b=FVwnVRNwYG52pNHbqAZO0GHTZN2CPJtybUX7t3SktOrcwci8VHdLIthSn8DGcJtBRorsi6/S9ogBf5KDSppeYHTQaITQ07PU+vZiOg6sNcjsIbL+mG31zsFxcuc6sD9plA4uvCLnt6Wql5lrIPTI6bIFuBMtutYsEdKeLHQDvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857280; c=relaxed/simple;
	bh=YJzIm5QA/CHQO6n6vteWNo/Y1kHnMLjMisvbzcEtMco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP3xCrX19SY+5ZfkO1FBrmQlh0V5ifvwqhGtpFd+YLB6numKlC60oAUqi1L3OQgeFyCudNUpYtF9EytOUXDIUfnetrdcOUFDKGl3ZNtwMxliVT7MemJMMLnmGkaK3Om/jJ+50YUX/w/YVp6b0RSoLPUswbxC+w3BDxwavr16udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFFLTC2I; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFFLTC2I"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a8568e9so1580516b3a.3
        for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857278; x=1790462078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPaps3uZw3+pSOsVulPRPw9JNmYOgWQLZSyhTH36qMY=;
        b=pFFLTC2INjED/CG7b4vrIABeK9tfcCeOqbsqZRsl0IlL1uFKuZk4S7pLCGC6+cWLp3
         Rs8x2D9I1QEmVN/PLwoeXseHE6AYP1z87CmL/4Bo22EjBE8A9BDlqxvHYXTJjoz4Awd9
         KYKoGIWC6yd3fJgv6q0rO5OYiCe8ijSOO241gdvxaX++AH2BVVv8i5eZ5MB1IrLXGLsZ
         QFGLRo2Xouj8MyXJb3ak+r+ApwYpeMIU4FT5MEiBARnChf9qJI8HjvbZ88rkgzSz7tT8
         5cfmYE8JOwRE+dN/PDLDkvr8eI8+pO6h8zWZ9vWvxpQWEplrkVoZwsPGb1yOdnUwtu+D
         VS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857278; x=1790462078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPaps3uZw3+pSOsVulPRPw9JNmYOgWQLZSyhTH36qMY=;
        b=1zvqPIE4zs0szwvQ6trK/H1ctB/EHAfiRwjj/0ZlbDUb1ndI5nZNOTgzEVfjETjns/
         pK6LbMrEr4sCFB56H+Wny3gvcOw3f4tmsduw90GMrQU9EqK+xY52XX+WRvVziFfRH7fk
         DT2UrA4H8xDH0wzhqH7HhklDL58BgjSCcF5jzpdoLCjUaz0nzjo7YY0uPtCp0DqY/v1H
         HUo0PlSQLdqNJ30RHK0WHNCJJ9ZWaOGRYH9W3P5gAjlqUS4d/T5xgLoCeSQbRgu+w+DT
         RcfI14h8L0XlHGQDCHJtcUXM9W4vvCpRODaf4N5NuvERiwELOqItAoIbfXHVK1HRnT3T
         /MiA==
X-Gm-Message-State: AFuF++nSIveAYdoaaKDMyHJkcEGdf+EM9HXzX8JDNtWzcpphHc30aZVu
	uL5tK3UIknCkDxOu8q54+ZI6fjTrDispY97R6wkkpwqo4bxV6Q7XMgLf
X-Gm-Gg: AYBFou3CHhyfbPf6jyhdbvG9iwfrf5C//MM0CPE/OsKAjEkK9aWipzkTVehbN6RbKyA
	mYybs1pU3L1zBQxCKEc4EpWSQZS7mqWbBn0Ha902KaMcrfe+Yx4ceIR5FpPaeKXOLSReB1Y09ZN
	KqiCiCBWsRtHTshCkjywxnRFO+euYjFf3KXZJ87ZISrOFNcbn/IFv+g0Xmw9hO3grc27OHrAUyp
	zaH5AhLLlBHKS5TBkkDLVvYD9UuI25YNiTLX0UmbR6367PAzBa2oAuCTL8Rg4Ua4fj6jerqjk44
	/QG+Y1dHtk3IrPQhfL5tmiq6D9lU6jVdMTUZQp3+8MnyZkITJ9MmW57F4xYpEupK2oZPqlRb+KT
	Q2X5VCmM8SdhqQ+eT3s2XC89LUSbn8AD2JPmC+XpQNeFAVnerSVRHndHNrmqFbeB6KqohC9Uk2a
	IaWlp/NEXGYeNeLOavqSgboCYZFU+JsnhVju8iOh34RN8Vlw4Jsw3bNgYCqn4Nz62WMHNliY1PI
	A2UToTcw+rfphtJ7F3tq+Z8YtQkvC4oX1WjRdQdvN3M+Kfyt8zMH3CH8W0SfuzHKHfQvmBWcl7w
	WyrJOZaVQg==
X-Received: by 2002:a05:6a00:3982:b0:878:3811:237 with SMTP id d2e1a72fcca58-87838110992mr2854371b3a.51.1789857278259;
        Sat, 19 Sep 2026 15:34:38 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f4a10sm1362241b3a.22.2026.09.19.15.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: cc2520, mcr20a: reject invalid RX frame lengths from SPI FIFO
Date: Sat, 19 Sep 2026 22:34:37 +0000
Message-ID: <20260919223437.3883127-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/ieee802154/cc2520.c and drivers/net/ieee802154/mcr20a.c,
validate the RX frame length byte read from the radio FIFO before
subtracting the 2-byte FCS or allocating/trimming the skb so len < 2
cannot underflow.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index abfcfe07246a..d2c8484d8fea 100644
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
@@ -1147,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
 	return 0;
 
 err_hw_init:
-	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
+	mutex_destroy(&priv->buffer_mutex);
 	return ret;
 }
 
diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 020d392a98b6..d7e076397550 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -790,7 +790,8 @@ mcr20a_handle_rx_read_buf_complete(void *context)
 
 	if (!ieee802154_is_valid_psdu_len(len)) {
 		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-		len = IEEE802154_MTU;
+		mcr20a_request_rx(lp);
+		return;
 	}
 
 	len = len - 2;  /* get rid of frame check field */
@@ -866,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
 	/* add 2 bytes of FCS */
 	lp->tx_len[0]		= lp->tx_skb->len + 2;
 	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
-	/* add 1 byte psduLength */
-	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
+	lp->tx_xfer_buf.len	= lp->tx_skb->len;
 
 	ret = spi_async(lp->spi, &lp->tx_buf_msg);
 	if (ret) {
