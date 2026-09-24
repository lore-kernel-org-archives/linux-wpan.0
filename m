Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E53161A1
	for <linux-wpan@vger.kernel.org>; Thu, 24 Sep 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230969; cv=none; b=No4gghCGeDTNIRHgxVGradypAqM7JjZDj4pyS7XzS8YI4IcphJCj/0lC2cNtVBwWPjOMh1jC0y0Gn6YeEAW/e1ZgpDXCZKbO72Hh5iH5wyO4wO85+qFzxEcM5T05WkpdZT8IFjpdSYbXD5zLz7sBnglhHriz7QkW6lcClIiBGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230969; c=relaxed/simple;
	bh=aJVsoy5Trk1oVXSy6lO13HBYy2aSxZSVKLzYy8qqiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIe8/aE5Z2nmTq7XCxfwSwIPCjFSCN86SJ71KaVAT3vAC321Z33kU6ZnQ2YZhscJZEqBWTs0fLreQy+p7TdTCah+mFYcmavl1wXfhJcylTCv3EnyIyNjNH/95Ppgs7EW7gO45WagyncCHs3wwmquIXmrdye7BcprniB9JtvkSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL2+PYHS; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL2+PYHS"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso1364101a91.0
        for <linux-wpan@vger.kernel.org>; Wed, 23 Sep 2026 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230967; x=1790835767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=kL2+PYHSbvVod/8YTeyijkwoOjc4szvjElPnDw3KcXq17Iz3Au+Z6EV0c6daCRyMNy
         LcAvI3+HcWdQ8NBE/9Ugbo/aQLsNW2nT9wJbPy1pUtvt0ppsMJeYhizAGQG3syW7OM5k
         6pATeqj8FAnUoxsGaV7UPanYs6CM6fILOsgb6LGyaayuykczBj/seSyeIdTZ37eKH7EF
         RHT2h2PIfEM6Fd5jY/U9W0sedX9RyokubTLnRD6uX1fIbG9A1qeUU210ZHZLOSqTlDs/
         174w3IZF9ypI3TYha9wTyKBLVyEzwlpxj469EVYtvWKVeidDFS/fzRReuJ1hHRp2X9hp
         viKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230967; x=1790835767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=VGBep0rE1O7ozLD6JsfJ3AkKDs+8s0E9mxnZubaHu2gtGNSKcuUaosTR83v3TbdzMO
         KCxXMdPpjDnVtpn05Dl1Y9hdYz2Sn81N2u4T/fUhm9FnTqExepbLqqNvwIK4Ymcf7UzF
         YmyGVbfG8SHFKwZh4lEJCyMC4rcVuFKjba5E/TyB25v3H4L81eswvLvLSUOghn8MDSTh
         oEsW5FJGLMUslOUvjnzjOZriLXoUnQhvitn8vybouTvSvWsPZ4D/plyxnl2CY+DV+qyF
         PLJrULjeOwCQhczNAu8wrYosdJnggLf/GFr1ugM6OB5+AFagT+USvsi4KMrBC+BLbTMl
         Q5aQ==
X-Forwarded-Encrypted: i=1; AKwUvBxucAwHbO2WPEGh69os/XRxSsT7gKpgQhQ7kYuk9Ke8MikON3VjiD149wFQDEi6R5vkrW9+7uzmJV6n@vger.kernel.org
X-Gm-Message-State: AFuF++nXvAQzSZfI0V0mYL92QCBKj8mEcYGxFNzymmrPvAwV1yNc2wSb
	ugk8zvviv8dtUMrdosnqVtwLe21PdWCOtEoCfW0QswQoOslLFOQooO9r
X-Gm-Gg: AYBFou3Nr0/pu6nI/xyNM4syR0yfVphCKoNi7RHd2WbyRXQcfy8gtPl9aC7JdUhtjxy
	gP80ycQcVBhDqi9G1sXkgiMLY+J4riuK0IwnqnrA7Zy5xltMqMhWbrHqzNJJNs9E7/AiJ6BUFk/
	rqF0x6vWSE0gb/6FNHF4HA6GJBPFjrcxRvnaUoCSCJ6dsuhqta+/udm2jKnwfH7KFHYU0XK55y6
	HqYwOmU7h2nCMMl4dF1jIzw2jSLxjNLUReXFSxwn45xs7HpuOVrkH5A5BBKe4JjTkKgsCrtidPW
	rvlDouIpgp6eesvIziqTI0iIrxtdp6Ru+QmPpUeYIIoULzQAIQJtSul0q9c48MsJQZj+MnDsT86
	fcOj/PraEr3mb0FWbUub0tHfD1WewwDC7oKyXouwKG/x7jmNvbqVLkduwwPY1aKMjYfB9D0dLN6
	L9Jex/mks7I2BespQWbuJIJKPZI1vBzPFDHQukgKV+eNGYcbaCJatL8gg5+ZJHMSJIND498PkQ+
	OEYfz060A8c9ZS3c894YgOje7heeFl4HSnNn2gxrzwWn6G5onlEwTgRLXUbAqjkdIDG3R3UPEIV
	gXEnf3m2l0hQtKEK5dDr
X-Received: by 2002:a17:90a:d446:b0:39e:6c69:9b8d with SMTP id 98e67ed59e1d1-3a099230f6amr1282682a91.50.1790230967061;
        Wed, 23 Sep 2026 23:22:47 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm21220615ad.48.2026.09.23.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:22:46 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: h.morris@cascoda.com,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: david.laight.linux@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
Date: Thu, 24 Sep 2026 06:22:42 +0000
Message-ID: <20260924062244.2444225-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924062244.2444225-1-benquike@gmail.com>
References: <20260924062244.2444225-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_spi_transfer(), each SPI transfer reads
sizeof(struct mac_message) bytes into cas_ctl->tx_in_buf:

  cas_ctl->transfer.len = sizeof(struct mac_message);

However, ca8210_rx_done() only checks the received packet length
len = buf[1] + 2 against CA8210_SPI_BUF_SIZE (256). When buf[0] & SPI_SYN
is set and priv->sync_command_response is non-NULL, memcpy() copies up to
256 bytes into priv->sync_command_response, which points to a
struct mac_message object on the synchronous caller's stack, overflowing
the stack buffer:

  BUG: KASAN: stack-out-of-bounds in ca8210_rx_done+0x117/0x6c0
  Write of size 256 at addr ffff8881009e7c40 by task swapper/0/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   ca8210_rx_done+0x117/0x6c0
  ...
  This frame has 1 object:
   [32, 182) 'response'

Check len > sizeof(struct mac_message) instead of
len > CA8210_SPI_BUF_SIZE in ca8210_rx_done() so that any packet exceeding
sizeof(struct mac_message) is logged as erroneously long via dev_crit()
and dropped before copying into priv->sync_command_response or passing it
to ca8210_net_rx().

Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
into ca8210_rx_done().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Check len > sizeof(struct mac_message) at the top of ca8210_rx_done()
  where dev_crit() logs the error and drops the packet instead of silently
  truncating memcpy() with min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3).

 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 01af4f9..a990a0f 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -686,7 +686,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 
 	buf = cas_ctl->tx_in_buf;
 	len = buf[1] + 2;
-	if (len > CA8210_SPI_BUF_SIZE) {
+	if (len > sizeof(struct mac_message)) {
 		dev_crit(
 			&priv->spi->dev,
 			"Received packet len (%u) erroneously long\n",
-- 
2.49.0
