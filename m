Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DE453A5D
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774713; cv=none; b=tBHx1HWdDF2yHioOwBwGAJmAjUcVe/eLD5iVcPEfUzSXTaXWbNZocpIJo9afLI18bghd5uxPn1+JOL1JYyasuuvP6XACpXybaP8oxcbeWSVJ7+/jZf2zhx9+4J2ooUKZ5uCn1cx4qfAfm9SlPpSbUCfOumtCwksz6I17RzeDslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774713; c=relaxed/simple;
	bh=IEyCsBsVSwIqhPWSmr79dEU7ej538Sv/hLVY3DGEtxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB7S09O6JGP/3G2kOmV3c66RHnXDivXF7OvjomN0ykF1Bqz7rDYOiQFhR3l2Pon+5URqt749+jnmgbCEO/EfJOkMgF52flb3nOzh55F/EHpnjpeD9Lsez12jSpYWzBk0KbLExV3gh7nGk0PdePoCMONlPaJoHO2N2pjJG3iu5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKpV+ffu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKpV+ffu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so3419948a91.3
        for <linux-wpan@vger.kernel.org>; Mon, 07 Sep 2026 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774704; x=1789379504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NuRDS27i5Np0POtdxR7TxWtwB4SFITDFQVIRdqIJzqo=;
        b=gKpV+ffuY1srLKj4mECxg6FBBdseA2QmvFdbHr/w+LoUwUaQXXBxL9Ysrm0fqoEK3H
         rVoOWzDJb5vZ4uTPNbzyZsoXmOVjY+GUnYzUVRZSN8U6sPuNReJlU2viEuXOtGFmavvZ
         gZjjQTeDK5jzKq63O7T5BZArTrxbLXXC+ghdvBAPa/Zo4VEZmRCjGLzZ8Hl7oRcVC8RI
         PMlTgjhpzlrre9X9j5h5jx3DHz/SFI2HYunPI4dmZomq0zPXhkGU4CyOMqXYVyo8gbcV
         UbB5KpHoH4Mp5VMbA+JCYvTCzfIBsO7IHW3SL2qlQHB24BCzUHg44Ih8fpDn9mKR3VOP
         Ch9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774704; x=1789379504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NuRDS27i5Np0POtdxR7TxWtwB4SFITDFQVIRdqIJzqo=;
        b=aRTDsD4Q3Fgerb7vtCcExjTbOMlv5iIl/u+1Hj3MM3wcNyHWr/zhBiKTx2HHElVpMi
         zaPLcqrP56cjctEC5cc9Xi9+khzTkbhV4F4fqBavVpWUwLlPiv4OEb3Ik87gmgj5MkSG
         Mq+GAKBEUy6Q1wgnjsyfb/IPgOlf5e5J1sksUkK2QWzAlCAeP/ye5pEn0Mp7aO3/fkUa
         +vnIWPkgaybjknf14V/wopu1+gkXDXU0utkg1VRNGVl7qzLH8HVPKwx1BZaZvESErU0+
         wiWUxueSuqBUcvBSNvq0x6nroTwDZQIAaBD33tUeM2cehntB1mEfTv/g55DhiSIv8AMe
         LspQ==
X-Gm-Message-State: AFuF++n152QpPwjpCcBgMS19q/W+K85n8SxNLjWnxntAoR+5mHF+ATmJ
	PS2eDGGHintHTu6uC2oqVSk9THKxCW1h61no3dlS9F3QdOQ0v9CNDUEn
X-Gm-Gg: AYBFou3aghgrUX/xrOeftDDPMgdINPkwhZGzF1wcGZHzLtIE2fhHpxNyhqBNdeAJ+EG
	y2S+YZwlSmorSsIKqsKMAIWztScHetcGvIHfMwU1mLucogIyKpVLOH/RX6opjW+3r7BjrWiG8yO
	pdKrD0TvPiuzOMKnV1RcQAhdHpbH+UopFDqEeAxZFdi/s1YoI5+TkPeEET6pz6LRAz6vS/Bztpx
	XNmcrkuF4AzfbOJgds5kFqTjV5rGJeIc972QUXqRpCUKA9/xcYyI+hlxX5ZWG8ctnN/kH64hCXq
	gmB5Pi9mpQn5i7XQ6u9YRbxl81Dvinge6gi6XRBM7mkxB+D4uzMttp4KZ6ltVMheOCmHnAQtaKB
	r9tFKXetFfgRTDmI/jZpKZWAXhHwTi6hQ19xACLWEaRNZru6pNegGTxTR+6xuOyrr7s6MLDlK0e
	h5ErQrCvOaIe2zjl2XYPgjpr9cOCVh5akgjfyz8A3+7j/MHeZK8JYVvz54+DWQvsfoNdm0zj1vB
	LSm/h0xAsbCq0GChxrBGx3R
X-Received: by 2002:a17:90a:51c6:b0:39b:29ca:3d23 with SMTP id 98e67ed59e1d1-39b29ca41d5mr20436117a91.17.1788774703600;
        Mon, 07 Sep 2026 02:51:43 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm30049167eec.1.2026.09.07.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:51:43 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wpan-next v2 1/2] ieee802154: at86rf230: fix typo "upto" in comment
Date: Mon,  7 Sep 2026 15:21:31 +0530
Message-ID: <20260907095132.21244-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095132.21244-1-hemanth.selam@gmail.com>
References: <20260907095132.21244-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to wpan-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto wpan-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064346.3288-1-hemanth.selam@gmail.com/

 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6156cf379916..f1adca942e3d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1370,7 +1370,7 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 	 *	  but this is different on each board setup. You need to fine
 	 *	  tuning this value via CTRIM.
 	 * CTRIM = variable capacitor setting. Resolution is 0.3 pF range is
-	 *	   0 pF upto 4.5 pF.
+	 *	   0 pF up to 4.5 pF.
 	 *
 	 * Examples:
 	 * atben transceiver:
