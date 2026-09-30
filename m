Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443A41D22A
	for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752760; cv=none; b=q5j4vLgMYpj8XC9fOxPf9kZspZWo8bDmWvYlCEIiJ0cqAe/omHdmVbXgriMBFnmUxaiXCaXNUG2mHvwQE8UUrwT5ITdu224erGS/yn4LLBY4jjtpYInjxOLI8Qu5gugrXI1IOyzJTTKzPs2Y6Ck3sDjuYVUImUySnjML4oh0RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752760; c=relaxed/simple;
	bh=8n4IhzxLjYl7HTSiJyo9dgWou+NdEFWkn0ApdKjkeKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhkHBR+ptokD0HZQfeQxJMAHfxcIF5Pthx7OTkudURTNy4KoP9prHMWD4wdQTfoYH1LXsL9lMF3TmjvaWhu9ByYXvQbg8vHujuXwgMzj3J7MJbmUIwva1HYlwEDyxy1TZA+CgnyCczcXhtbH2/d8k4J7JBqOx/bF//aKvx9cJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTl9c0Ct; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTl9c0Ct"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b4770191so616932a91.2
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752758; x=1791357558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpjVkotq4ymVbBexed9Q2u7FUNUeANInboIGD5bfseA=;
        b=MTl9c0Ct6Nj8WsJ/Exp1NgyW+ldkvgJDTmoHtUmx8p4WXraIK8xtILYANtXxflHURa
         5AATeE4sVA77b67uFcuXfw2LntehGTxsyp3YPyCZpneCwWPbwQG8fxSGQGXA9+Uq3317
         BM5py7KTM8IvEkBLX1hxLoFSWaD5qBq71jkpJWC6Tx1rtp5dRkKe8BDsNG/yEqNhC7B7
         hl2dBLep9fVyINILUSBhVhqSVw5i2eTowJN2L96dhEA9q/6n+yJAUneN2s7S/bW6WcwV
         qgcJgozira6Xs3VP7NSJNHHDTr1L/6Qg524lHJ6AyC0j+QZOrnBZ30YSuPhO6BLWZiS1
         Ommg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752758; x=1791357558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpjVkotq4ymVbBexed9Q2u7FUNUeANInboIGD5bfseA=;
        b=bpmFqfCRbk4enABEz2VxuMaeN6MXyPagTeaMwH5VXZfFwGmzDGnqNQ8NazwAHWOWNk
         KJxWeJX00C+Y10YAJRPULe19s+kh5HHajGCHMNNc8xv/JAbmyFgBv03bQz/pN2Hyhg8g
         dHRoOWOd19s3r2jBMOMIZuDNuO/YRhoYQ00AE1LgcW5iaFbmfdlsjsHxyhGPbUtOTOw7
         y1ZQhJ+1aiXmR6ZWaiLTb8uka2vb+GrN7vyiieOve6CjCEQB7Hv6Ei1cMi6WdBH6Qb4Q
         v1bpH1YzjpkoKXfomte/iAVlju6cP0Lwf+Hw32COCroygk9COFDKEexx03NEOh9kIr7/
         vFfw==
X-Forwarded-Encrypted: i=1; AKwUvBzQcDaiSfC5mgtFChKt+FKbPA7ZCh0fU7pt1RyOzCPTCYBzEVjDWczDoZNAup26lIBqEcr+nJOAmmqj@vger.kernel.org
X-Gm-Message-State: AFq9FYKHkzcntFoCt0p6AqXcnDIUaeEGiEJMH1wNJIfP08O5AqAqrx97
	eFURC+kYZ4Ir53LgCFIydE1ps/M7uwBkNVr7sXqPlm9fI5MHLz5umqIn
X-Gm-Gg: AYBFou0YlgqBZisI2n1A3oaKM+J3/s8nj/CgsElRicblGCriGyePGs7gZmh7E42TWWo
	QLI295iUl3hGcrVjgRzoaofRalrG0s2nlDxpY6D91qzx4CZqPLjD+bjHRXIiUZkkJmf2d8L18C2
	VnEpaJ8xSe5d5sIr+RXTt29BDPM462Td2cAB4747/rGfTB05wb6M6U2xWzkQsPdATQSAGihqPkJ
	mrdt/1P5cB8ukGwm8QS81991rxcBTZs1x/rrstpTlQpNgJX0FEth6Nd4Nf7wdQo1q+67z7kbAyM
	HfxA6O9jMxyHUv7TpR9bc6gbiXR5sVCaX2ckhzb2bNOh3Ij/hNhaBwVa4+OtVgcCHc6Pw3aWDn8
	JCRfZMxK8zQhISNDyQdGZus98DT6eb/IJMUydjSn9E+Cqe6gihX7W951iuYf9aZmx6cUhdKEogO
	ZCBe9nxV50i/GLcFgCvvpvEvR3a1oj8ZvxxnrFM6RbYWFDHA9f9xtAfAzNMPMTNpNLUAHoEX438
	y4vxjeIFc5loPpn1P3QX2ISzwUSeHFPv7Zk1eB5lpL53VYBmQ3qdFqJtSYc6sOZ41F3kU5XiNAe
	ZSf/rBpoYA==
X-Received: by 2002:a17:90b:4c4b:b0:3a0:b809:b9e7 with SMTP id 98e67ed59e1d1-3a4d0f0351fmr441328a91.4.1790752757725;
        Wed, 30 Sep 2026 00:19:17 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4caec0f28sm2256687a91.17.2026.09.30.00.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:19:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Wed, 30 Sep 2026 07:19:13 +0000
Message-ID: <20260930071914.421586-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930071914.421586-1-benquike@gmail.com>
References: <20260930071914.421586-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
bytes into hw_attribute_value without checking the caller's destination
buffer capacity, overflowing level on the stack when hw_attribute_length
exceeds 1:

  BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
  Write of size 16 at addr ffff888001907780 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
   ca8210_get_ed+0x9c/0xf0
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 48 in frame:
   ca8210_get_ed+0x0/0xf0
  This frame has 2 objects:
   [48, 49) 'level'
   [64, 65) 'lenvar'

Initialize lenvar = 1 in ca8210_get_ed() and return
IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
response.pdata.hwme_get_cnf.hw_attribute_length exceeds
*hw_attribute_length.

Tested in QEMU with KASAN enabled by passing an oversized
hw_attribute_length response into ca8210_get_ed().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 2/3.
- Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
  and an upper-bound check against *hw_attribute_length in
  hwme_get_request_sync() as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index a990a0f..8aa7ffe 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
 		return IEEE802154_SYSTEM_ERROR;
 
 	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
+		if (response.pdata.hwme_get_cnf.hw_attribute_length >
+		    *hw_attribute_length)
+			return IEEE802154_SYSTEM_ERROR;
 		*hw_attribute_length =
 			response.pdata.hwme_get_cnf.hw_attribute_length;
 		memcpy(
@@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
  */
 static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	u8 lenvar;
+	u8 lenvar = 1;
 	struct ca8210_priv *priv = hw->priv;
 
 	return link_to_linux_err(
