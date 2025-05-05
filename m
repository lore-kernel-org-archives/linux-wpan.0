Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54F2F7C3F;
	Mon,  5 May 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487174; cv=none; b=i9I203JC7KQl8ydDDIURh51lbS2CXD4v4bhboOTz8yTmX/Df7WxpwDEQIhEtCXUmGEwSfTgjPm7zak4UspNY60WMg6/5EbaXb61+WFl++T1BSWK2336oH82VOwO1P2yhiWUxlKSWlhv6TKgPhrLSLMRDZe3cFgpRPsw2F7aL9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487174; c=relaxed/simple;
	bh=hjO4GH6Uz3olfgGGUDJtPMJURRiLIfr0zPtlx2M1YqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzxrF3BJq6NWjcMNX1g0fVBwI7NYqImcjIPNaGu9nnvXhfOayGd9qUbiLbfz8QP3Su4/I1+6hbr5kDciKYR6jksrF2DahwtkMLS8wcV7plI2q050nOggzenyus8CHkco9GHNsyuRZ8YulEAAfG0Honsu2ebultJsf212ZrssFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4pWdRN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4pWdRN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBEC4CEEF;
	Mon,  5 May 2025 23:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487174;
	bh=hjO4GH6Uz3olfgGGUDJtPMJURRiLIfr0zPtlx2M1YqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4pWdRN7oqKZ+BabPG7c6oO+1/HWIiXKG1vEr4PgA5WZvKNayAJm7VGSHghS1qFid
	 tPcW0aytj630L9xDKqV7kzT+QtwB1mTj+dMEixlacdgLatRZ+rtwOGZPXEaxvk/pXT
	 Sh22P6hCeaILGQxt3EeM/UH5QtcGb7rVXhbExSzICMOP1g4fNSjpMO5m4d97n33/xc
	 fjE4+9G3hULNq2lSZRi4ZbQA3ET7ccH0wQi+ji/SQJcdiZqUoEwCW/xnfCe1YQ3oEt
	 sUJ5F236H3XxKJyb+MgIkfKnycefWWbEiQaEtJPyteV1nDS+9LoOLey3Pm1N1ppfvu
	 IIZPmm7ketoJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.aring@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 041/114] ieee802154: ca8210: Use proper setters and getters for bitwise types
Date: Mon,  5 May 2025 19:17:04 -0400
Message-Id: <20250505231817.2697367-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 169b2262205836a5d1213ff44dca2962276bece1 ]

Sparse complains that the driver doesn't respect the bitwise types:

drivers/net/ieee802154/ca8210.c:1796:27: warning: incorrect type in assignment (different base types)
drivers/net/ieee802154/ca8210.c:1796:27:    expected restricted __le16 [addressable] [assigned] [usertype] pan_id
drivers/net/ieee802154/ca8210.c:1796:27:    got unsigned short [usertype]
drivers/net/ieee802154/ca8210.c:1801:25: warning: incorrect type in assignment (different base types)
drivers/net/ieee802154/ca8210.c:1801:25:    expected restricted __le16 [addressable] [assigned] [usertype] pan_id
drivers/net/ieee802154/ca8210.c:1801:25:    got unsigned short [usertype]
drivers/net/ieee802154/ca8210.c:1928:28: warning: incorrect type in argument 3 (different base types)
drivers/net/ieee802154/ca8210.c:1928:28:    expected unsigned short [usertype] dst_pan_id
drivers/net/ieee802154/ca8210.c:1928:28:    got restricted __le16 [addressable] [usertype] pan_id

Use proper setters and getters for bitwise types.

Note, in accordance with [1] the protocol is little endian.

Link: https://www.cascoda.com/wp-content/uploads/2018/11/CA-8210_datasheet_0418.pdf [1]
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/20250305105656.2133487-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 9a082910ec59f..35e2b7eb30761 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1488,8 +1488,7 @@ static u8 mcps_data_request(
 	command.pdata.data_req.src_addr_mode = src_addr_mode;
 	command.pdata.data_req.dst.mode = dst_address_mode;
 	if (dst_address_mode != MAC_MODE_NO_ADDR) {
-		command.pdata.data_req.dst.pan_id[0] = LS_BYTE(dst_pan_id);
-		command.pdata.data_req.dst.pan_id[1] = MS_BYTE(dst_pan_id);
+		put_unaligned_le16(dst_pan_id, command.pdata.data_req.dst.pan_id);
 		if (dst_address_mode == MAC_MODE_SHORT_ADDR) {
 			command.pdata.data_req.dst.address[0] = LS_BYTE(
 				dst_addr->short_address
@@ -1838,12 +1837,12 @@ static int ca8210_skb_rx(
 	}
 	hdr.source.mode = data_ind[0];
 	dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
-	hdr.source.pan_id = *(u16 *)&data_ind[1];
+	hdr.source.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[1]));
 	dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
 	memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
 	hdr.dest.mode = data_ind[11];
 	dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
-	hdr.dest.pan_id = *(u16 *)&data_ind[12];
+	hdr.dest.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[12]));
 	dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
 	memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
 
@@ -1970,7 +1969,7 @@ static int ca8210_skb_tx(
 	status =  mcps_data_request(
 		header.source.mode,
 		header.dest.mode,
-		header.dest.pan_id,
+		le16_to_cpu(header.dest.pan_id),
 		(union macaddr *)&header.dest.extended_addr,
 		skb->len - mac_len,
 		&skb->data[mac_len],
-- 
2.39.5

