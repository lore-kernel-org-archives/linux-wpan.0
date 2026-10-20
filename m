Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479094;
	b=33qTEvZSIwMw1pzLwCZQGFofpZ56E/iX55PHuguzhaFPSIOwAlyMG20Z0elKgfSqdVX4
	 /QSJg/i5uprb04c9p8qjhXNmgXGa8PNSdodJTY5uIlpmsEaMLgdBBzdwD+5T1VJTCQ1Oo
	 F0pGO9W0K68Z1RbW542bbcMTkSo6KQt5DJBNRz0sCj4AZfuTwGzFFpJnMvWzRrY9i0Xt4
	 tWJNNEE5cUOzH2aqIdBIWD1fEVUNyLw/9gIsHngkmdEouUHr+gjklxTXhggMDTTZbLJJh
	 k/9L9ZBxy3I5toXP88v9tGwgo+acLWLkzM2CLkzZPR+2YzZqIYCQ8h9bIu8EYEDJdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dHQhRD6vyxHfKtcPIP6kj0jtBv/cVh1zjgBd/JhnQeQ=;
	b=K1au/Cr/N29ZjnyVBcA/FIuUPgit1tL4Gk4BMHiQqpuewofwvOyC5CZ2urZk9DT89Jnw
	 ycAAt7/M7/AlbQTDJS/VTdp0O+pu/WO+zbwww2CtkBFF15ufJxixxz5SgTiLCEWGREuP8
	 jIWjfug99hkLo2UlF0h7lIyPdVZyXTByog7TAtIaAmk0dW9DYgejNGInlAfR/ruONcL0e
	 B0rmSOltOz+o0Oj8/E6qnFZy/6pCTcM+/Mn0QXFVSzl0YFqJx/xk4/lMdgpvNC41lmkAK
	 OSEivZbxXNnNOKy3Uo9PZMhE3iC1nJ23Pw74pc6xA+CgGZamr2QKcZSz+cB68FnBHIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XlsyYn4Q;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEA606A31C
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 06:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4CEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XlsyYn4Q
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2597140a91.3
        for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2026 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792479093; x=1793083893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHQhRD6vyxHfKtcPIP6kj0jtBv/cVh1zjgBd/JhnQeQ=;
        b=XlsyYn4QZ5xeFcxfmYe0YJbtBkOtdfi0jehGfY+o5BU0Y74fuNp7fOQIjsX5KqKHMi
         BkGGTDd19afZjuMgFZlYCMY2C7cNfgKjiiIN2yfrYPK8sP5OyQ+CuQATH+cZhDlDH7kh
         vrv+nGnm9HowpCUXOv7nXl+CAmiPsXMEMAxZxD3L0GP+b55VoxT/MlKYvyg7dU/58Lfa
         JFbAwvf0mcc3IYkPykpf0CRH1vK0mf/kFen+cmbfFhaW6VnApk9gwFlVRNO08br0nSx4
         /NIA+YcVR4mIvHEfyVrUS2xjEEEniVbgibRLENc3JM9yParehvYI6iGEhfQWo6UVgGok
         GD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479093; x=1793083893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHQhRD6vyxHfKtcPIP6kj0jtBv/cVh1zjgBd/JhnQeQ=;
        b=zsSabWKyi06RgFGX/sAhtenAL3Jb+gB6SwqlSoyLKjzfEnQ8Lus6xYfNApYsfnj6eP
         nraEpHGY6nv5ATKWwHc0qcCQYqtYcwXGFno2BhvT8OF/Q1TkyhECq406TTVqsX36RsxN
         TZxn3qGDl8u3F8sNQJJc28SfXI55wq1gFa6Wld8MHpF8A9reQfUrNxyCNQa1xcGYstqS
         3H3PKrTFseoooz+snzw00MH3bOiniKc9a9CvO7I2tVcDDImIZgTCe2nGDmv+bK62RA+m
         32bPvhS73vbyIO0AQshndpltiE0bbxcUCm63hbvYMBj23KAUfBph+q16mqCnkkScmr5f
         eNWg==
X-Forwarded-Encrypted: i=1; AKwUvByzDZ+ZgScRY2N1c/guFyyuzkmOSSWDBcaUFZV9M3lszFYFBInxOgeiDmAmhfqmB5bP43IcicGTjmZd@vger.kernel.org
X-Gm-Message-State: AFq9FYIFTVTiO/ws2mVL4NqwBXz58B/YF921/fJ7W5/yfnNb3PM4oew4
	y0RSepd/1d+jBWg599hGOF7eniFR0YTBtklEmF2h31AGzUJo0R/bU5lg
X-Gm-Gg: AYBFou0eh5jB9HjYVFBWGZwltEO8K0ACn7iJ2rdQdZ1YHf1JhkcwEcaPbo8dufhqdKJ
	d52Khuy6nH0VNKMoDPYJq9CDjy9qzEHeO0EXdM1NwW59EeCwgndsgJA7wn0I0r3ZXYWmUz5v4j2
	mo/10RnDW+GUe9YJZH9JK5DK16xikfwoMnYiijuqG3pEeqtRuaQs30jeDHA06hmdn2rNOoJSVBx
	u8gpB0/1Z9vf+OuvE86m9ZpYJraE3JEgV2jyyzzud6vHDvx4ofW2Z5PJu933kt8CGXE4zLUI4w5
	ztQqYXOfyl7sjHB59zdN6IjIIPJt+sMQGOlOAQGl0kdnywyJFIAnjKtx5F/LrVPGlhTFRZHeNyJ
	+ku6eB0XRoppxERJ6q5fxnXmDwE3F53SzIjFR+6NQ6h/d0rRoCBezxJtm1MUc7jXQK0goSESRLK
	rffO0TN1TfP2TZx3WbK6X95BTNrsYNy2Y71HjDEZLi+8JbHTqKbKh3MFzgXioTd7b8CrtOX3Nvu
	vcmoMZzwiIYyalRuOkdWXSGHfOblk0UGw==
X-Received: by 2002:a17:90b:3ec5:b0:3ac:adce:60af with SMTP id 98e67ed59e1d1-3aceeb92998mr8773726a91.16.1792479093049;
        Mon, 19 Oct 2026 23:51:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d56eddbsm2563561a91.9.2026.10.19.23.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:51:32 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Chandru Gopi <chandru.gopi.dev@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in the caller's netns
Date: Tue, 20 Oct 2026 14:51:25 +0800
Message-Id: <20261020065125.896530-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nl802154_dump_wpan_phy_parse() looks up NL802154_ATTR_IFINDEX in
init_net, while the dump only returns phys in the caller's netns. For a
caller outside init_net, the result depends on what the ifindex is in
init_net. If no device there has it, the dump returns -ENODEV, even
when the ifindex is one of the caller's own 802.15.4 interfaces. If an
802.15.4 interface there has it, the dump is empty. If any other device
there has it, the filter is ignored and the dump returns every phy in
the caller's netns.

GET_WPAN_PHY needs no privilege, so an unprivileged process outside
init_net can use this to tell which ifindexes exist in init_net.

Look the ifindex up in sock_net(skb->sk), as nl80211_dump_wiphy_parse()
does. Commit 66e5c2672cd1 ("ieee802154: add netns support") added the
netns check to the dump loop. It also removed the "TODO netns" comment
above this lookup but kept init_net.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Cc: stable@vger.kernel.org # v4.8+
Assisted-by: LLM codeql
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I asked about this on linux-wpan and netdev in September [1].

Found with a CodeQL check for lookups done in init_net. Tested on an
unmodified v7.3 and on v7.3 with this patch, in qemu with two
mac802154_hwsim radios and phy1 moved into netns ns1. Not tested on
real 802.15.4 hardware. Dumps from ns1, filtered by ifindex:

  ifindex in the filter                     before fix   with fix
  4: wpan1 in ns1, unused in init_net       -ENODEV      phy1
  3: wpan0 in init_net, unused in ns1       empty        -ENODEV
  5: sit0 in init_net, unused in ns1        phy1         -ENODEV
  3: wpan0 in init_net, new wpan2 in ns1    empty        phy1

Rows 1 to 3 give the same results for uid 65534 in ns1. For uid 65534
in its own user and net namespace, which has no phy, ifindex 3 and 5
return an empty dump before the fix and -ENODEV with it. Unfiltered
dumps and dumps from init_net do not change.

[1] https://lore.kernel.org/all/20260920165057.3753458-1-maoyixie.tju@gmail.com/

 net/ieee802154/nl802154.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 115f43d0e158..fae5c413fa60 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -581,7 +581,7 @@ static int nl802154_dump_wpan_phy_parse(struct sk_buff *skb,
 		struct cfg802154_registered_device *rdev;
 		int ifidx = nla_get_u32(tb[NL802154_ATTR_IFINDEX]);
 
-		netdev = __dev_get_by_index(&init_net, ifidx);
+		netdev = __dev_get_by_index(sock_net(skb->sk), ifidx);
 		if (!netdev)
 			return -ENODEV;
 		if (netdev->ieee802154_ptr) {
-- 
2.34.1

