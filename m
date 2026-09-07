Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8F44E656
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774709; cv=none; b=u1cWNdaiKl7NLxdtiZVknLY9vzS+LzUmcLHyxLtD6ZRCN5JGOdHElA7T5lSq0r0/nLVF8aaMWj2W0m36D95o4yQtS/swcmKUx0zhZ1rqOUggQZceUeV6x18qZAJpR38OzhoDpL8giz/qzJBtB1nMW9M7dL2wNhThRK5NTW3dbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774709; c=relaxed/simple;
	bh=sjxhVCH/bhx/nKVoP1DpZX/8EknekeeK+5x7U2iDC3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiBzK4qwDAAFc8RqRRSIw40JYFS4XQZkEFGW0iCiIdBdtMRrMU5OBWzEEIMODTf9mlhZgYH30sUVudJKo6gBHioAIoUPgW/xVVtSCeBInJHfauDDy0Mg2H1U0ZBAaOrXxByRnCGjedQanXynga0WfvtfMTSZ/Mfn+Lvm7i2/kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7Er3Pi8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7Er3Pi8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so2186324b3a.3
        for <linux-wpan@vger.kernel.org>; Mon, 07 Sep 2026 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774699; x=1789379499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ozc5aGre8dkihgDZN0g60I/nIm2ja/LB6Gh/3swjSPo=;
        b=U7Er3Pi8zvnzDom6yqTrzUtWmIv/3wHaumifRG4ZU5vUsgavYrnB++F1VuGbld94LR
         W+QxBSIZ76Xvd7tkHiTH951As/27mF9vtg+uc6Zfxok5u9sERVvPjLGPLeb09qU5huzN
         dH1MOMpkHEhqa2LV4p49upUuCWdx5D2IrBY6r0h57Owf6C5nHp985mdkWymtHpouBNa1
         i3gOcYHAmCmjVqR/HzQGcg3wo4vUJm22UFeLphOAr6eZxpbqimI3uRUwBM/XE1Y7qu1D
         tCUhzq20T9tNA9lSsJcQ7297Iqro9HRd/9hxyH59rfILT2+Pj0Iq5rTH6lNIaKEJxHBp
         cj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774699; x=1789379499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ozc5aGre8dkihgDZN0g60I/nIm2ja/LB6Gh/3swjSPo=;
        b=B6EhtPXpAXAN6KNhHpOJlAJZQ+ha7acGrTWVIOJjL+wx/WESAi+7dZMOI6H6+6tTn1
         g5siXYprdrC0MGUF4DVIH55wXDONbwI9gReDxGeJEYFd2MlemGa0eN3DTs/JFMoDYeuO
         Ld08fNifZKUn2Bq1Cl3KcJPkpakK2IYObgfANBMR0fN+ac1r1vLLSVsmT9ADp9Eb4kIw
         wNmv8Odhuqpfi+0Cvku0fUKkfH8tqsDvB1aoiMd2MUgEf9qST2+chH2lIxdbCzexQWsU
         nHASfY38qaVaKJUjwixNhqhwbnaSb2T5E81kn5dMkfr2MNNV1OLLKEaMGKSMuBQTyWQQ
         w2NQ==
X-Gm-Message-State: AFuF++nTd1TfeEgJ0D7MIbmIMz8F+m6SBuDaDWvo5F02ifmNXGJjABMl
	fzavE8ayCV10PmxiTLZG+Ohel65gwFBmqBBxlermgiQIUK5qqqOQUKc2GoidFdqKPqw=
X-Gm-Gg: AYBFou02CSFCxg5vW4PK9aowAzTFMfwglmK8DRephe7wcs8Y6aLpnE63bhvqXraWhtD
	OBHSFOrOs7gps9tugEuoL1B9YMHaFt8AL0KBIHuthEIEQ3yPHGC+U4hfxsiH8i2c8p5fk0rdkTm
	2FnObyQOIYwxrFk2YUopMxpQ9BjuDuMIkuFFtLVu+KuZPULdp7piMttodYy7UAXPDihqpIQyzlp
	ooXUJWwbIrzeYeB1+Dcdlu7e76SHRkeazIjgtS5alCIQW/Af9Cc/0/f7YgTaQDXekKpedaByLs7
	lowf1axG8N8fg9Dtlb22BiQascFvNgy0zqL3HW1bm6B+BwcSXCsH9olhKpY1K44C90dBp6YGtLv
	/hs8dTBcot4FDt7b7G1nlwhOQfZxg5MZCy3h+g+0F89LkFdf4GcUHtc6GGzBquloxFShot0DJMN
	PjfFe1KhKnCAo1JTLMC6TXC4SGkq/qAgerNeNWmO4B1n6hG/0MW8D4DbEyNr4mjiGk5o2qabSaP
	bdXHwrKyQU5b0BeB/iA4fjR
X-Received: by 2002:a05:6a21:6487:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3da3a0b2671mr30540627637.23.1788774699211;
        Mon, 07 Sep 2026 02:51:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm30049167eec.1.2026.09.07.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:51:38 -0700 (PDT)
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
Subject: [PATCH wpan-next v2 0/2] ieee802154: fix typos in comments
Date: Mon,  7 Sep 2026 15:21:30 +0530
Message-ID: <20260907095132.21244-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two comment typos under 802.15.4, split per component.  Found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
maintainer-netdev.rst asks, v2 designates the patches to a tree, and
each subject now names the component it touches instead of "net:".  The
series is rebased onto that tree; the diff is unchanged.

v1: https://lore.kernel.org/all/20260907064346.3288-1-hemanth.selam@gmail.com/


Hemanth Selam (2):
  ieee802154: at86rf230: fix typo "upto" in comment
  mac802154: fix typo "substract" in comment

 drivers/net/ieee802154/at86rf230.c | 2 +-
 net/mac802154/iface.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

