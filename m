Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C7450407
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774723; cv=none; b=AccbTwd4WdpiwD2JVJXO6G0EHJqi9p5TCwS5tP5PQvHsrpfB1J3sH1LeVsDHiYvv9jPYNjRSxcm3iwQCDLQgliqnGxLGsTJ+Aq95o/Neo/P0xMmeENENsjDkNstsy26HjgB7n2cRURIl7Rl47Y+OfyiCUCedM80IX+YhnPuRwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774723; c=relaxed/simple;
	bh=q8AQh/Jdl7kkNyeKYqO/b/5eoQwQe5/Rapj/D4WZ5kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFfc85YPuXwzlQgoynV79WSnfhihEz7dCX4r7Y2jxIhGcp/RbqjZ2y+t3PsGK1NNnFP5q0vg8iSB9OKB9ePyr5v9Ve+8trPKN+Aq3Go/weigjN7IUomiyGF+ARJLUlqcd7AXCr1EuxksY4JJOIvD943TNZMoemGpGC+TqbWwLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2VvqeLM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2VvqeLM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so3328454a91.0
        for <linux-wpan@vger.kernel.org>; Mon, 07 Sep 2026 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774708; x=1789379508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRV3VX28th3l/YUKQYZU4Bx7v7ROHkdn+qJgfLM6OBo=;
        b=h2VvqeLMs4tNgNCneN8uXEd8WJ+7JcP3V1+YtTup0gKIkVmXuxVBp45ETh2AtgUfEF
         hhuR6U3hTumrSdRUq5Raa9v+Nni/JZBW/LxnnSxYmZGnjIVxSUfGnOBQIU6s6fw64fD5
         Rllai7THzUzeTva7eIvAPRt0RsUMOltxWzPsPlbd4x0cm86mzy+bkJQZWEXXy5Dt6cnl
         mzh5fs7W0AhxbbvGsqE9FkdrUtCVuKsJYevz74vin/4qfWZqA6i+kq65fZECEZ22iFp5
         czbIsO4Q13PgoPMaVuO7MdvgASx/Y9ug/hkCREtjReIseA0TwfbbfHtgkjcm7PA1iufE
         4wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774708; x=1789379508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRV3VX28th3l/YUKQYZU4Bx7v7ROHkdn+qJgfLM6OBo=;
        b=POZecBFVzBy9L2NSMkt2Gc2X8Gt3hF8uwGGxsPKw5AZGtBuTWy5rQwT9Lw9BpfHbU0
         OB/BvquD5Olh8fyJG6qwbnMrA1xOqO3OllH3kFCnmRFNC6oFrfjpx5Agv8JRQjWkS8rL
         VHhEo5rQPPT5WxQQ/W8cVmdVcNDC6IUUfusQGSCHhebJgIwjz7LPn76GdV4cmA+Yue4Z
         ovHf7gP5iZH7RVMriKHcgtWK0Ju1Jg/bUpns1dWadUa3m2E155vt7axjhkwT4X9HTqfZ
         hqnas6D7L86TczcJbaySc4gaUfKuME/ZA2mJGMn+lBQjg68SREBCeDquLZQ37GaQNeZ8
         XiMg==
X-Gm-Message-State: AFuF++l/sC+vd22cl6jx2/t4ZmM82umw4Gl3Ros5MsGaNz95mNepoPdn
	oxWyKbOkxs5Pe4mA9LhmboUlf2bME1KWyXBYt1Q/MU6amdCL4s5zjcnf
X-Gm-Gg: AYBFou1YRFHibXPJEA9rC1SUFiZ+RNeSKZHpxzd/vJ3ttHCT8x7gu2HkUUW3je16iMz
	S9BsO9WfMzbvSW8wiXqI/kNF2wAc/Wv0AaXq9pSCGNmgjukq87MZBrQgqEdmZPbpKurreSz5SmS
	ylYNqsO5f1/NQqqi2w9VebdmGi2Vw07nIvM4iNvSBKhSKi9eahki40wfqtvU9Z2a5BrOPit1f7S
	c2Ie8c2NrvD3ZUOJkI1YQxuus601lYF+wa2Y0MQa9fP3I4Ub9eWwGbvzxr23wuCHMlJe1wCLhlc
	ytW1annXy9m3vryfbZ23GwA+CDa70o3fA+mkWQ0WTvqjdTV2ADdDcWAUJorT+NVG7HEFOxZNhuD
	ksjBByGNErTfsx+/7m+22D7581j4NMFZesFvcrlxTtq4MjPKef+UGcdPGDgAphi40WjI9F7l7i+
	niIfTUYnz3DPUXZq7ZmGq4Ny5JCPgtb06FW+fBtP4UjW7zoDr0mIEAeaxWtU7ORoQXJIJp+xUxR
	r2EYi93UYTEwA==
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr30316424a91.10.1788774707944;
        Mon, 07 Sep 2026 02:51:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm30049167eec.1.2026.09.07.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:51:47 -0700 (PDT)
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
Subject: [PATCH wpan-next v2 2/2] mac802154: fix typo "substract" in comment
Date: Mon,  7 Sep 2026 15:21:32 +0530
Message-ID: <20260907095132.21244-3-hemanth.selam@gmail.com>
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

 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..8f3968d2e516 100644
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
