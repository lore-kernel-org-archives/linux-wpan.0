Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C603457E60
	for <linux-wpan@vger.kernel.org>; Tue, 22 Sep 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069491; cv=none; b=l9EKzLm1ig3rlKa/IStiCjoJEj8F3qmUHYIaru1y2hGV40XW2ckbl3f5u+RyQzW09Ui3zx5R1L4EaLx6jtfF/zCiy6LSCgWzYJEIkOhO+7Mzl9jQyccHMKIVTakQAVHh+f4bAYcNSGAqhmgi2TKDxB3h+PEZWqNzWWL8xoNWuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069491; c=relaxed/simple;
	bh=aJVsoy5Trk1oVXSy6lO13HBYy2aSxZSVKLzYy8qqiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlyEkJt7RtXVB08zEVNig9TP0WXPYsZgSaWs6ZbFv507qtW2WUZjSTrVTdyPZxnNA+WcBQ6+2pIKvAGLAqH2QmNLSqeg3HQh1AnNOQe4ObzZ+8tg2+wBhCU2Pf4kCeoKkfy+L6EjkTIjc3vBuxhGA2s94/YD8o773V0VJ5Q5y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHeRpR3x; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeRpR3x"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so35123535ad.0
        for <linux-wpan@vger.kernel.org>; Tue, 22 Sep 2026 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790069488; x=1790674288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=oHeRpR3xi5Bk3lr6BWOxege83BSI83jVqgb81lO+9IbZVEnDHIoJBT0PCs607MtviL
         83YiRrWHTCUkCwlRwCCBiFGZOAR+oIMiVgO/W6WvqjRcCLrgHmUoWtkMP5EjwTfv/kCy
         +yswd6ZFh4M2gzBNff2jsEHF21lHdrT87w59VQOYgkfhn1lUcyFzQ5OxjA8mAkmUzBdm
         Xixf44j9xT2X1n0MlmkOV1Ow/uUrvEuNViQ2yut/U198Njbp3axXNIx1mMUqtt9SDUmu
         2DME7Xc0UMgSUZ1d43Av4lggC9sgjstcR0527f4Y6ewi+0E0aISbVheDVhiFayqoxExV
         EqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790069488; x=1790674288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=yUFqZNtaMU2OAEze4Vvr3Md8PHUOMBfwi0pZJiu10dpPDChApJ5qdRLFhW3lIdvgXU
         Si3JWcAXFVdsdUcRiX3gOn3byfAL2Fa0DhnDem7G25sG09pEH3+JKD7/leZuUUQEsG3S
         aI0i+ExY56boowx/kvSw3L41IpWhJj4B2yuJS480BRau59VBLMNYZtuV7zcViGvq7wEh
         8/X6F+pei6NY1Ofh1M6mJpj0EcpdXtwgldxxaACG8wPqrkDOyHMJRiHBVJEXgokC/GMe
         BsjkvhkyTfONGdjMyo9dSPWq5IUrp0PWwAX5sC7EsasC94hUq97jpjRetst8IBlsB4Ct
         ASUA==
X-Forwarded-Encrypted: i=1; AKwUvByQylXVb7Uz2Jrur8SRrYSSso35UTcxWbcgh3FK9mdxB3G/00/OUVrpSo0u6sxv/cejFJA/QTem7BQ9@vger.kernel.org
X-Gm-Message-State: AFuF++n9R1g7GnjODdbAApkaFu0aNtlqjp0YLwkbvECVpJUlXNeZK3f0
	e5NDL2nuTJVxakQaZ2tV5syhtaiOJ36UWxkcEeB7Om4Y1skyVni2DbxO
X-Gm-Gg: AYBFou1/nBeGQkBPSDGe9MfyDZzsJ6M6E2CUaY+EJZbcozW5seCbZAh9LdBoKimJAN7
	SSLWxdToFs23MT+DPsydDPSJ80kYvZcXjw1Obokm3MZjHJ6vgbV2MnbORt9G+cg+8bHC5PwXfeW
	n/wNIbX4HK9JAl77Bui0yqBNORT9RHs+UmA7J+3DvvzWc+zVwOIMXhyIk0Xhz4KYpzYpv9qNeHD
	tXZg0GnWg6gGrACOJ4IQEQoTFlbCyQYe9TV6v2rqPnlrSqfFGdvPvHvy3R1QHCBvfeoacG7F2Xq
	W4GIbsPfsP9MDEzqxaP42TNl4a/cgO0hjmZSehjwIJ/7RpYcIscGqT3zq6WnrCpS6/YSu4UpQQh
	GcI6CMifaq/n1gDOgHxOqf3ssPXNf6Y7Ph3iobXw4zvpcK6W/t0hGbedbtP/SNf/oVqyxflrDxa
	MsHC978RYbng+lIa3mpy466lJFaFu7pkec3evH99upeJ7fsxnXA2fzx+u7yz8AF2pa9xr5+NJsC
	rG2OjXpHiUCvaHS3+za0YCpOkLEkwRwoaTk4+yaDQQ9dXIxegmEJQnDSrMDZDYUNID2PcMqG9g7
	D9fu4uSsKhMEpZW+ONkj
X-Received: by 2002:a17:903:2312:b0:2d8:d4d0:7931 with SMTP id d9443c01a7336-2df609d5e88mr7101585ad.21.1790069488413;
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df63a22f54sm103915ad.61.2026.09.22.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Hui Peng <benquike@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
Date: Tue, 22 Sep 2026 09:30:23 +0000
Message-ID: <20260922093126.141969-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922093126.141969-1-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
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
