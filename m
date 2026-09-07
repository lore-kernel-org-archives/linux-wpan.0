Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F3211A09
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763435; cv=none; b=VeKJAXd+TefVG0z2k2D3OrgErrC5DAmD07dfM/TeAj22VdKaXdUTSQx6YbiGk7NO26LMiEHo8xFQEpZWGex1ZpNcIixhUOO7d5QfWvVnxaCX64QP2pnn1D42q5HB5x26mtS0owV2FydqmUOVu6WMS+LzWHbdXMSYhJOtu9d5HPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763435; c=relaxed/simple;
	bh=YSOgfYZSp8SrbWiZSUofEBzDTvr3+SvBNc0tqAr8jTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ao/58KHkKwQ2CToFkq+nrUzy0sBJDe0mVLZRcK3IuWfoZk0Z3BlJijMWr6OP2pU6z3YyRSGkJmicDI1YoBhpDRpcBfV82ZZRUUVrHX2c8CjoThss43YpoMrtYeKU+xEXgJyJcL4NCAIFoaVUIONyS4Xotp+wGhFNm8VE4hub5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaUQXxa0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaUQXxa0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2555909a12.0
        for <linux-wpan@vger.kernel.org>; Sun, 06 Sep 2026 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763433; x=1789368233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CFZlOFvP6r7OTGSRxMmbvfbXTssOe5ta1IwHi1yqgQ=;
        b=OaUQXxa084JHSuiWVj2ZvhicYKuepXIcxzGM5hMiYUJ9EvoUJ3GETU7lBckenl/orf
         RL+FxwfSg2F1Fj2vARl8IFJDqu4xhZPpgHz9p+FrmvJn6DM+U+U4xDYyOU7X5PMJiP9u
         0wcTeWAwJK1yog4FxopuET5g4laryRb6LENvNqbgz+b2f3mIsGHGRKaYguvf4SvQqaFK
         lmVo9jM7LNXh7q+lutYSuFe4+fMFv8yfge2qERbxerxgYBFhyHqb4x8aA2aHDuxcm1oD
         dbKrDnveiMyrLYLL+CU5+hVLMxWZAP/xHse0tJ31dsY4I9xriObh+HbJma7EvBtXVytm
         seJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763433; x=1789368233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CFZlOFvP6r7OTGSRxMmbvfbXTssOe5ta1IwHi1yqgQ=;
        b=DKd24MoVvBYacgDe/cZ1Alz6Syux3LZJ3AyMXqyE6ahEYVEhC/hAf1+bOClNkWvOBq
         VRMFga54R6MUcQtAXSvxHlsMg9ffi8e55i+2590Xrvtd6v1WGcsOxvnOmshwYM97QLfb
         PHX+MDjuwE6HrKQdFbW27gngnZnP+T2WxxR5Fyl0HLvwu/J9Kobkd6clUE1F+hKlYP7L
         NiyQLm9uDwkwQ84sKXHcFS8KPqj/gRD54RtXLKvoq1dXa+r7ccmkFPZBDL92a1f+5oAK
         a/D954a7X/Yffjk4IwEi4AE7sN496xryJVMKWuYCTBrbQCtAzgzf97PfYglhrfCuG5OS
         jPjQ==
X-Gm-Message-State: AFuF++lP6+38+qZUZFbLkxllMNxK/KzeVAh9bbJdu/RcHJsv/cjzkp5h
	xtvO+5uEAYDEKBfJDmot9CTx8jAKp0bhMJ72lvNN2uVHkrcOr4N3Id3v
X-Gm-Gg: AYBFou2XWgUq72KAcVvYD3UpGn5w3KzNAFuwbqEfoJiHJiYv2ETDMHmB94vW97+Yxdc
	qTMoCBZWN1EXjSqK4QzTKT8fXQFP5eQ7FS5Xkg18GvcuSLlrLDbeyZXBKeoMce8jDbdZG4StdQV
	OjU+WF3bNF8R2DWncGMcjJ06qPTIFOceCPaVgV2OqrOB0BzFj2PDN90+YSc3mvBrABUMtqPivCg
	aEqzKMhhP/Kj1Pg9ft2o6w1CuuIV+827fP+1hen4Ux4MA5dY62Y5DDEGUnQElQ5TrfS31eSZ5LD
	14jbtyrOWIlVUy25ho4EVDj+zVOK89B/JIxjOtg/3TvhnIuOF7dpDeWMHfffVuT8Qm/buJA+VKv
	0uN9o3Wy9myeyNIDJrv/vg72Fy9if5rnALJaVrekMU+ROi+SWEp1rUMmvfxGO630DlUmhzIR3n7
	8rY7crRew9PHtmZ617CGZznhOKUlK7MozOipcgzz/hZoUO2/gznrMWt8uDK5ql2TWEVmC/hKedp
	4nfKTBYa8ptLg==
X-Received: by 2002:a05:6a20:9e4e:b0:3d3:ae40:51e0 with SMTP id adf61e73a8af0-3da3a045196mr32280359637.20.1788763433116;
        Sun, 06 Sep 2026 23:43:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm39367339eec.16.2026.09.06.23.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:43:52 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix typos in comments
Date: Mon,  7 Sep 2026 12:13:46 +0530
Message-ID: <20260907064346.3288-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 net/mac802154/iface.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index b823720630e7..ff6e99257bc8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -521,7 +521,7 @@ static void ieee802154_if_setup(struct net_device *dev)
 
 	/* Let hard_header_len set to IEEE802154_MIN_HEADER_LEN. AF_PACKET
 	 * will not send frames without any payload, but ack frames
-	 * has no payload, so substract one that we can send a 3 bytes
+	 * has no payload, so subtract one that we can send a 3 bytes
 	 * frame. The xmit callback assumes at least a hard header where two
 	 * bytes fc and sequence field are set.
 	 */
-- 
2.48.1

