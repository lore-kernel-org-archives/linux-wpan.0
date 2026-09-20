Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C443C07
	for <linux-wpan@vger.kernel.org>; Sun, 20 Sep 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923066; cv=none; b=tHd0JWzRKV0k95ikN6UjHzG364TIrLB7z9Oc2aG1j/ttcP/BEs062MnTlo6syhwcdkR82kZbnSCPQGFODQ3jpFxKlgxaUNZkX5Cgwxc1R+9KXfkEH0UB70KBIhhkgRd2DwqmKrozqPoPol04ffrrVSc6r43nUTOVkerizfgn1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923066; c=relaxed/simple;
	bh=tbd2Eg4QOD8NNjEddaEgnAr5noFlw0X5iAOBeVffgDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXzaEf5Mt/gUbwnVJ1GyyJJP06W9/1fopBR/u1xGvcNg/dXhKs89hDmHzkhbQm6cimqN/jiVukoZfgFflEdi6wCTh1wS9FCo1mzslbxyN6SxUdCYZHzbR1/H+haP/UtPhsJZ0ON7yGTnH8wBkZJ0UE/UF1Ead6CvN0jfwH5yvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3fwAO1T; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3fwAO1T"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so86155ad.3
        for <linux-wpan@vger.kernel.org>; Sun, 20 Sep 2026 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923064; x=1790527864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOkhHWyrIL8ES3fC1gwQCcd9SLJNHTZ5yicxilPJ7Is=;
        b=m3fwAO1T1ip3AaIGxdvEadmvOxsFPP4o20VsFxIS++W0cfsh0BM8/HlUuLMDp/ejVH
         NV7epz13iLJkcQFkB1gS66NOfpYE0ZrjgIbtRM4XA2qvcWVh+u4A5kgMGknPsqj77miA
         0HYGJlebJkCclB1bXM4oxBFi4vs0HfWcqquCBgkwT0JXk9PxQ6xXPl+vUaWhP+dEY0Dq
         1rUbCoCmQ7tUAlfQ5J6U9E7k9gkWnPWzsaLwbPcmGTASrZjcijsj7FaR0O7dYvwiyi2J
         0osbzqNdxHh3GPpdNSoa/0mR0jok9drkyMIOFZxUVFlFNbNNMLGnT0Q/HSMqfDe/ZwlH
         0vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923064; x=1790527864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOkhHWyrIL8ES3fC1gwQCcd9SLJNHTZ5yicxilPJ7Is=;
        b=EBvvdQ8WvQa26dNHTdkui8xb4crQ+qzYbGLyrSm6JMbljD9gaxP0tSNml1HoPE1Trs
         ycOQUsDGC6JnZ3qdYUSExSidDGqXicTxxwaGUb0ca39iLL26Y1uAvi0LdabqWEHlZ8h8
         3UbF61y0K8TVxlB1APTP1dPJNXFYNiVIS7+Nqs2zlDv+2Fkr56Cfj9T1tLWeqyHfuwZB
         uS1zRFTDksMD96ZW/oXCE6h02TWS+r1ArDhmDwlpciV5LUB+YDSafvRxjfd7URDhTvGN
         WQWkqudSgD2r5yqpR7Pd6w3PbsLjMcVYomSAuT2rPcLIE2ICfZYlNfv2R0vOhHVcFrzQ
         DZwQ==
X-Gm-Message-State: AFuF++mXcH3t1yoTwg70RAs7iSKUQ8mpU9z9xc43j/l5D/1YnR9wRWT+
	42Z7PjhGpZ0OiDLTPyuc/pXf6Fgt4CvB/OjFBAq2V0oHFHdzbnaWVaIO
X-Gm-Gg: AYBFou2l9yVLN7My2Q3H2d2nWsFBh8/OczfYXkFxIH/wsj80w3XsHGTAPbkyx19QOjO
	DJlcei89+5hJqIY8Nx4+/TvJY/BHXT0WUi4xaxto0JC6h4pRTQ0wUqgWPa5MKcCXhYP0ajgKacP
	u5Px0xVCL1DdkURefTHr8ShS74zBy5jHFkFjlwtIm73mWaUKSzKrp8ezAqf4C7n6A1efRrG4lbx
	tc1RpEnetlEkOYkoaRzBqYhzgCpkKfXIvoLzP6SKU/mphCoIfwtIESzYASLb21K4HidMmRTAvCG
	1XShfsJhvojYRQf9NLYjBawHCgUhIw+4ycXFyz3h23eulp7GhWRCkNqCEHn83l+pN5t6JVuFBsj
	9uhUvTviy/3qrO6D7IeMWqah8JgAGB3xQKwW2JkVv1NKtC/d2edxOF6zYcj4v6jMc9pVrmcmX3P
	VlQyjBBsu9NzKODEjbMgjjwt0cvvYfhl+zjwz23UZERkb9t5QW0WkhGx3STUrAkxyqqrORKvNgN
	QD++wRp+vgtcohbC+GwK+uP
X-Received: by 2002:a17:902:7005:b0:2dd:c0ff:e734 with SMTP id d9443c01a7336-2ddc0ffe9e7mr49192205ad.70.1789923063841;
        Sun, 20 Sep 2026 09:51:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178701csm21511905ad.13.2026.09.20.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:51:02 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: nl802154: GET_WPAN_PHY dump resolves NL802154_ATTR_IFINDEX in init_net
Date: Mon, 21 Sep 2026 00:50:57 +0800
Message-Id: <20260920165057.3753458-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I think nl802154_dump_wpan_phy_parse() looks up NL802154_ATTR_IFINDEX in
init_net rather than in the caller's network namespace. I would
appreciate it if you could take a look.

The lookup is (net/ieee802154/nl802154.c:584 in 7.1-rc1):

	netdev = __dev_get_by_index(&init_net, ifidx);

The dump loop below it filters phys by sock_net(skb->sk).

It looks like the same kind of gap as commit 79240f3f6d76 ("wifi:
nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump()
continuation"), where a dump looked the wiphy up by its global index
without checking the caller's netns.

I found this with a CodeQL check for lookups done in init_net. I
reproduced it on 7.1-rc1 in qemu with two mac802154_hwsim radios and
phy1 moved into a netns. The reproduction needed no kernel changes. I do
not have real 802.15.4 hardware. From inside that netns, as an
unprivileged user, a GET_WPAN_PHY dump with NL802154_ATTR_IFINDEX set to
its own wpan1 returns ENODEV. The same dump with init_net's wpan0
ifindex, which does not exist in that netns, returns an empty dump
instead of ENODEV.

nl80211_dump_wiphy_parse() does the same lookup with sock_net(skb->sk).
With sock_net(skb->sk) in place of &init_net on the quoted line, the
dump with wpan1 returns phy1 and the dump with wpan0 returns ENODEV. The
tree has no wpan selftest.

Does this look like a real bug? If it does, I am happy to send a patch,
or to leave the fix to you.

Thanks,
Maoyi
