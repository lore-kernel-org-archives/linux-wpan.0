Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9B43C07C
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976534; cv=none; b=slIlKCnQ+JG5VGcPBcXqfXsoYJsmb9k/kEi946EpvYvPvrMdbcLx6Ul39ZsLe7QbZA/o5nCyMbBOtlP/0aUkho6Sx3XExVIgZhdJsas+N4myNsARm33TELe7XWZ5Tf+WQTVrrRVRKyebFMngwnHft/EZmX/HN/v/OiXNeBrGQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976534; c=relaxed/simple;
	bh=6q5OvduezYDttcoOa+Vp3n3pmhhO/TNjR5O4tftm/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAMj/+eosMj+P4i6r7f/S9Hg0mvOb4kg5ovMG1E1RYWfZJ4rqr5gUCdg/Cvr8Bcidav68N8ySk7g+d/fQXtV8rVb5pAHbEFoPOISjtY+TNRYA1oQRLAk6+aIvXA1qzJJCyz5r4/kREHoAnOV2wI7cyLZs4jo16V5NAdpE9zcT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms5BoYqY; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms5BoYqY"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso2156055a12.2
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976530; x=1790581330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=Ms5BoYqYr5teC5rECBj2VncEItGwRBZjcJIzSWBqb/CMQpwGP60/+zvTcBpqMdIF0H
         /CkVjPSpRlNsUY62IdICXOnwrD/M5ldxhcLJqmnDXiXIVxrzL1BDZDOtlLVnSnDyhOq6
         urIc2PALgiWt1+GkUSWasHn9dyTRUarEcerH8fJbEWN2wsHa1XIP3lOkmnGSx8/N24N7
         E3/+rsc6YUEqnxLRg3bwIpmJaet+NB8au5hJ0u826lSIK7aMTRaDAZIx4XC8zdoqeVj9
         8Z2c8ZNxXFoqJz0UXbeFULBHQX9cU8jS15S1g2sMKBge7L7A2/e3Zof5wQyRqoga4pMY
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976530; x=1790581330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=OnogjheL/sgSTiKyB9hbMDrkpq4L7tjzzRPcu98dIHgZS+FPDnJgfg2v2VBBWXDWuR
         /frS7C3F3hmc2Uw5RnkxBXV5w4jBz0f2I00qRKPEgH4Rmxm0Tcyi+KvoV0X5Os0dgq5U
         M6JmCuN9tFB9lL5v341tuQ9t+g26jXOkd20SqjV5FNKSxB1kN2aSZu2H+b9TrPpJlGwI
         8LPOMnDqYwxfcV1MI80gNxsGaaHSyIxZaNk1tA9SxvV34DCUZzg1FPMX7gEEniUDTIOp
         pNgRcU5iFZaL64H6NbpIxqF1R8ICgzZaxmdazb5r95Qe6ScZpY9cN8TBOlYj91JswDsK
         pRxg==
X-Gm-Message-State: AFuF++ml2rDWqWGiNbPqe1RL50gDxaG5PJesMtrD3eQnW56+yLFPvzdY
	zFxE7+9gS2omFKaICGiVnP/re1L3AnhGnFupKbS1zZjfWkmF+6l3Zohu
X-Gm-Gg: AYBFou1GHv0CzdB7Vw813XeNVHhubP+0grQQ8kxM9F6ZwsIP/ZNo0zUyziTX9nnTgMh
	A3feU1vzMlqH2lu44oS183ZmdO+wl8mEb10wi4cOHjAlRhMAnSJ/NGmvdIyJu4vCRM9BEgr74Qd
	+9LeSqhJVt902g6c2Ll3Rhizl/b2naJsumo4J6faeSdirpDEORVNtw8TW1y959AjgITgRlEKZp1
	o/QJEFp15UedSM8qZdXcPgj8eiaSpV32alkh7epcp16jRDRyZXopP7Wanxi8h9hWSqBzhfLmftM
	SUpwlF39g/431TVRyF38DJeMbWoDChw3xMAMIxG/XC75IXuZgOz7Eb+db7qpReW2THh91Tu8NvP
	lF/n2ugUtDXzPcRskqmgJnFsFck0NADQB/6KNeFXcTxEypVvpXMw3JX5VTJx3FagyJMwGj7EVT2
	eDwqI2I+hXyaZo9TfjMl9DDrHKhE/nIcE7jCu5xZihpCXjIsHVay3zybvp1vXS9EHbVDrEclCyN
	CF53r31zyZrZ1DT40cusMGXVwARTIPzFVzY004nHvF7bKJL+f0jo04t2zjijkmmvo17SFSv5oL0
	UhCHOT41Uw==
X-Received: by 2002:a05:6a20:1605:b0:3cc:2552:ddd7 with SMTP id adf61e73a8af0-3dd8c2ddcb5mr17987536637.5.1789976529965;
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/4] ieee802154: mcr20a: fix 1-byte out-of-bounds read in mcr20a_handle_tx()
Date: Mon, 21 Sep 2026 07:42:07 +0000
Message-ID: <20260921074207.2289391-4-benquike@gmail.com>
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

In mcr20a_handle_tx(), the 1-byte psduLength prefix (lp->tx_len[0]) is
already sent in a separate SPI transfer (lp->tx_xfer_len), while
lp->tx_xfer_buf transfers the payload from lp->tx_skb->data. Setting
lp->tx_xfer_buf.len = lp->tx_skb->len + 1 causes the SPI transfer to read
1 byte past the end of lp->tx_skb->data:

  BUG: KASAN: slab-out-of-bounds in mcr20a_handle_tx+0xf5/0x150
  Read of size 17 at addr ffff8880057f7500 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   mcr20a_handle_tx+0xf5/0x150
  ...
  The buggy address belongs to the object at ffff8880057f7500
   which belongs to the cache kmalloc-16 of size 16
  The buggy address is located 0 bytes inside of
   allocated 16-byte region [ffff8880057f7500, ffff8880057f7510)

Set lp->tx_xfer_buf.len to lp->tx_skb->len.

Tested in QEMU with KASAN enabled by transferring a 16-byte tx_skb->data
buffer in mcr20a_handle_tx().

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 4/4 covering only the mcr20a TX SPI transfer length
  fix as requested by Miquel Raynal.

 drivers/net/ieee802154/mcr20a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index d01b277d33d2..d7e076397550 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -867,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
 	/* add 2 bytes of FCS */
 	lp->tx_len[0]		= lp->tx_skb->len + 2;
 	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
-	/* add 1 byte psduLength */
-	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
+	lp->tx_xfer_buf.len	= lp->tx_skb->len;
 
 	ret = spi_async(lp->spi, &lp->tx_buf_msg);
 	if (ret) {
-- 
2.47.3
