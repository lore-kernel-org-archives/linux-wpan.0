Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4E1F811B;
	Sun, 24 Nov 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456229; cv=none; b=g3HO+UPkYa7m64ZeoPTEHaf3zA0RkyWAzJB6GsIf08j83lHVnHe/Ac0U+f3NyQdjOW5Apy3RQo82/q4Xe7WfknFm1EtsUdQIu9jcos3x0aNC6KHokHEmchEmHeUIOIk2Eg6z0fmrVuPj1a3TvVqRNAQdiL+Fdmo2ZVKYx4SrRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456229; c=relaxed/simple;
	bh=eEXRAo1+YR31ykRWA3YQmrVkhKw3dod8idHYCjwwLCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faWqGr/NqwCM/OZxZh2iSKrnL9wE9pccLRev6LrGDl5dYj8RTDoOoIw0u0GSefkEQObdLErCo73f/Znr23lw0B1RagNdx2mrvn8+/a/RZZWtspIH2U2cKxEUnKRbzW5ZXgRQUXgc/Coe925BxtnWXAo8UTP33sYTfUCi9uwIt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdR2QdsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdR2QdsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408D6C4CECC;
	Sun, 24 Nov 2024 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456229;
	bh=eEXRAo1+YR31ykRWA3YQmrVkhKw3dod8idHYCjwwLCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdR2QdsAcufrfpsAjtpabZquZRKUrl41VMxZzjrdaWpyGdUgLfcj8esjtayrnnM4R
	 q/URuHKlEv1bZ8tszJcBkapknDsm2TrXfpXTkeiYA/xeH2K+MRR60koeiQ35wAx1Un
	 ukoOr2K5IciBIBKizAqC4/tGJEXJtNbWK/VAEQCfU9Rwp6iK0meXa58YHrAFLBveA1
	 gAlrRKn2W86mMmBCDrtEir3B532XN3/7F8JJvuzG7mCxxW1dwwYQpvw1X9jNZat9cw
	 Zp0klwBksGhczXe7/UrZ4YB4TK81Xu/fLKv3tNBglf9oM+nM1V7Ov/Nx2RqfHNXKBC
	 DD7R6RVs0EhlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/48] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:48:42 -0500
Message-ID: <20241124134950.3348099-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit b4fcd63f6ef79c73cafae8cf4a114def5fc3d80d ]

sock_init_data() attaches the allocated sk object to the provided sock
object. If ieee802154_create() fails later, the allocated sk object is
freed, but the dangling pointer remains in the provided sock object, which
may allow use-after-free.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-6-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 1fa2fe041ec03..9f74be2aad000 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1046,19 +1046,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
 	if (sk->sk_prot->hash) {
 		rc = sk->sk_prot->hash(sk);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (rc)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		rc = sk->sk_prot->init(sk);
 		if (rc)
-			sk_common_release(sk);
+			goto out_sk_release;
 	}
 out:
 	return rc;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static const struct net_proto_family ieee802154_family_ops = {
-- 
2.43.0

