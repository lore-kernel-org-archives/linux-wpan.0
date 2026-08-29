Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646DE2BDC0F
	for <linux-wpan@vger.kernel.org>; Sat, 29 Aug 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787998064; cv=none; b=GAECBbeYJF+X6eEt4UodrbMnG4bPPfy7TndVjfiEobGYtYp1SI4pW6a0V4/8qAqfq/FUxq3Xzz7qPqFIPmKJJ8Y8DNysnve6ZNbIRrBXbedG37xPhTbIU2S+ffFTW+4zjIbJh0P18b1nUTYdo5KkvdXBZdUy4JLVO9wUZKyBntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787998064; c=relaxed/simple;
	bh=yrjOVnQHXfTVLc31VqvBVnJU3G+wvHNrSuIpysv78LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxzCD8X6qC+9mRFgMBpxH5xE19xT+osX68+4pTjdxykMXH2TF9lCVhmKObNWF2s7QPqhaSiEzse4oJLuKl6TQAjeqxWgIj9c8Iogstglv/QfI9o7jLvToZS7AWZYj8/fFt4pz2ismpjAb5yI8/4WZmMGcMC970PJ9UY0gFpDhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=STl4LEvt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="STl4LEvt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so23815525ad.1
        for <linux-wpan@vger.kernel.org>; Sat, 29 Aug 2026 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787998063; x=1788602863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LzNeMEvhTmcCovzQFSGod2aF56vz8lZ3At1nWkywdg=;
        b=STl4LEvtA5QHjWVxE5TDZmddATPq1vTTFItrhm0KWBPtm7QpFrNq6tWMzVvzy0Pw6F
         jxRfkIJbbyfMgLz8BFA3CFEDPL/GGVK2ji21Z/5EixZiuyzgVaItu69kARpCZzyhsnGg
         Luyj617aDbL67bL4SaF/HZ2zf2aOHdlbBm9g2wZR8mos3WO3c22DoxuwRoz57PqhfKht
         ZB+Obd7RlEvSvcYXJ7OrzH1NmrEneapfAY+9vfTKsoHIsfv4PGA1BZUqoMkS2ATFEKuw
         l75EGM0PeMtZ4XXEUwpWFQOH5qNJ/92tFlsNkBdrjYliUgefUsYlg/IailxvT7V+YJvS
         cXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787998063; x=1788602863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LzNeMEvhTmcCovzQFSGod2aF56vz8lZ3At1nWkywdg=;
        b=V8A16Wt9Ci5rY1IpN2PjWBManeRalnBeIoNfnRDdKgsQ0PeJZJN0ZgFNuLNP44wjaG
         B+vt3dpGQo1aDj9NvUmuzJtYIzED+hq8DmEGep4BK+CjiCWpM23Yxgp5ePsEZFcF4JTr
         r/vs9nKzIKixvHZUu57OKfV2NOzLL9tapz64uB878gvBLVwmHnidATgs73zvneWnWskU
         incWlFa4X2xgWhxt6UblXf9BC9AE8fkXacB1IEihosIv8VB/Y25Z7BxT0/6BfI5NRo14
         OrlOO/izhHHmzXL5jrkK95mvyQVldq9sIm/Qv8N1fmEDOuspg95FLfuIxs+WZ+B0j2Pp
         Svcw==
X-Gm-Message-State: AFuF++nPJBMhzIvpW5pN+CZYlmT0p4/dvpQyVb34OlenNuNu5P2rJ0Uc
	r1VZyun6QeHzNR09PY5Qu18xE4MiNQJ4ZbPlUoyq40qUlvm4OVYLxc0Omh1SDlscbrca1G2q+5N
	8CjzSxfRb
X-Gm-Gg: AR+sD12Kvjz+2nIZSfej0v62yMuXPULwv+5RbgLK/FtGE1hb8DpkJ/NRvGaIUqaAo94
	e4B3XqKfFIl5tPK/iDLxzzszcY7JN7RJXebm78H3VPFAfrSd8iEzeSJlO58VhcxLHsx1jNw9HRL
	x9EE8TRwdQgijFosAIFkbppTHpsuXmNc6hY8kq1p1LotpCrfunNkcz3Vwyx5/pEc5N7zq+YYrrM
	h69YU1xYRNNVk7ea5ppP7UYISHPCO22SXRV/mlbVVJ2o5kwjZ1QzYPQExZZdhcdol4lNVyr9oD5
	i8rvmaEC25W8Avd7vV0vWF3ujIat/llFi/qDBW64+ImZvQ6MgXXdw8gmx9WLEJUHTDY5LNUlK4a
	RQv8yGKDrMSRK3neUemkXuT1WrrqVJLF6oWb0+3gHV/+07EUaR9Nf+v6cldOkddKOcC75Y/4Qdx
	QMuSBQenlV8of1eO1lbW3yokESPzomGX6cOo0+AW/A7p3wXJqxn0scwseeGjLpqAjfwPIESXiOl
	ywsEt0=
X-Received: by 2002:a17:902:ccd0:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2d725acf14bmr252118615ad.0.1787998062665;
        Sat, 29 Aug 2026 03:07:42 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm14008514eec.3.2026.08.29.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:07:42 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	marcel@holtmann.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
Date: Sat, 29 Aug 2026 18:07:23 +0800
Message-ID: <0b715da69bd15a86ddc47dad5cf12da648211050.1787997209.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787997209.git.zhilinz@nebusec.ai>
References: <cover.1787997209.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TUNSETLINK allows a TUN device to change its link-layer type to
ARPHRD_IEEE802154 without initializing ieee802154_ptr. lowpan_newlink()
checks only the device type before dereferencing the pointer, so an
RTM_NEWLINK request can trigger a NULL pointer dereference.

Reject devices without ieee802154_ptr along with devices of the wrong type.

Fixes: 51e0e5d8124e ("ieee802154: 6lowpan: remove multiple lowpan per wpan support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ieee802154/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 018929563c6bc..6a8d6852cb930 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -150,7 +150,7 @@ static int lowpan_newlink(struct net_device *ldev,
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
-	if (wdev->type != ARPHRD_IEEE802154) {
+	if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr) {
 		dev_put(wdev);
 		return -EINVAL;
 	}
-- 
2.43.0

