Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401438097A;
	Mon,  5 May 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486015; cv=none; b=i7It+gqt3e3a3iYwEBbPM6kq2aTiUyV/WeFxGS/cpVtOYpwb1nqMnENuvrY4/pb/NRvb8C75v6HWwj2csoPiZfp22ra8QrosYmqT8TiGpma3SFxXWHNFBcEn7P4lCciQqqVEBJZkR5Kc/XymCezDoiZP3vShZTuY6qoA/31JutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486015; c=relaxed/simple;
	bh=o3KuwVmsFoNNM5uAAtIqemYd1E85pxI1xkOZlR7TRfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW+/8Egd3pzgNpSCBExXvclBxsYPuXRXyMyodjqemYpqaa56XKIChhnb9aUm42SSRzuqfC0p1Af37qhvlnsHzju826gdgpNLwhaqk8EHbBqesv9ueQ+Lw/CFaKDKemyCL3B4WcLP2azEONFCK7DwXxwoFlU7WjDsjGUiqDu0NTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ0VWQgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ0VWQgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F566C4CEEF;
	Mon,  5 May 2025 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486013;
	bh=o3KuwVmsFoNNM5uAAtIqemYd1E85pxI1xkOZlR7TRfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZ0VWQgvDaIB8S6TruHcxXvwizvFBJruUQEzMlAP+X83C/s7ocNDEGSR+bIwRgiiK
	 EHmd7sn7kfYqpVj0p1u1Nm7xin1/QA607/YSm6Eb46fvzM3KaMw6Vvry5acw72pnIQ
	 pX4a1cepzCSTptKCuYMZ75nPq/c6GY90SdQlfLVsmVhRwCIev6DS4xvhR8OEYndMly
	 qxWD8FJ9jvEt5LCioYKyMVW7QrbaX8wi8MHrkn9ZfT80KC/MHbIpFNsYEd4WHYHcEt
	 W+Dt6VYpkWxibtCznV5Qis9HLLw5NmLA9yiBwNmlQttfQX5j0juhfJvdyj5kuTjoOS
	 9iLNjh/xyqQew==
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
Subject: [PATCH AUTOSEL 6.6 110/294] ieee802154: ca8210: Use proper setters and getters for bitwise types
Date: Mon,  5 May 2025 18:53:30 -0400
Message-Id: <20250505225634.2688578-110-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 0a0ad3d77557f..587643a371de3 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1446,8 +1446,7 @@ static u8 mcps_data_request(
 	command.pdata.data_req.src_addr_mode = src_addr_mode;
 	command.pdata.data_req.dst.mode = dst_address_mode;
 	if (dst_address_mode != MAC_MODE_NO_ADDR) {
-		command.pdata.data_req.dst.pan_id[0] = LS_BYTE(dst_pan_id);
-		command.pdata.data_req.dst.pan_id[1] = MS_BYTE(dst_pan_id);
+		put_unaligned_le16(dst_pan_id, command.pdata.data_req.dst.pan_id);
 		if (dst_address_mode == MAC_MODE_SHORT_ADDR) {
 			command.pdata.data_req.dst.address[0] = LS_BYTE(
 				dst_addr->short_address
@@ -1795,12 +1794,12 @@ static int ca8210_skb_rx(
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
 
@@ -1927,7 +1926,7 @@ static int ca8210_skb_tx(
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

