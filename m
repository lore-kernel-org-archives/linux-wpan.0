Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD882274EC;
	Sun, 24 Nov 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456057; cv=none; b=g/q+AkjDiCbLpG0NBOvT1Vb/Fkdh/qhD+qRnwnulzSgX/fbJhadOwweih7NqW19bTBv+EKX3OKZPXrp7n8BLjtopaqGWBMAY5Gn8NY4XbdiWqfSVneJD/wXA+7T9b8YJ2glV9pucjzfNykjLzvhl9Vn87GIdSbhHZS60dvZgg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456057; c=relaxed/simple;
	bh=ul483cjRm5MzWt047bM8+4jbsTlYVo7wq+eIjVQovPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5M2a5vcrpE3E+wWSDPekW2jRsq4vp9wSPvfxa9BIPf4cOrdmLVOIkth3pNwXw4rjrkpaJlnOiznyfFabXJHi+H7U1sJNHuDICLgc+AGBwX9fh2IVw2hF9fj+DaeD8Se9WF9JiJyda/Lm0e0o3fTc56nyqADeB+zMnmAWyCVcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsliwUlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsliwUlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD1C4CED3;
	Sun, 24 Nov 2024 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456056;
	bh=ul483cjRm5MzWt047bM8+4jbsTlYVo7wq+eIjVQovPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsliwUlzFpryuy2rrIcDfAQWmrYtchLvM59XYN4f1h0b/LxhSpOQSsQErZBT1n2lP
	 qXvRZBao6DfYQTP12vCQFpHRaOpracXhDEfivQ5hr5RCjjWA/uKPoGFacafElvqrEk
	 vLWDCq0BJwmUdNAyAEvszmo/1m7igs7kSd6DdkgOnCRsRVi0t0R1A1S15x10afjmXq
	 kizbqAY5z/YRRXIFzdtHmrR/LhdJk5Hv/k1jYPlNhIQ/Rux7PhWOZhhmjpqFA+d7dk
	 7MHdtongfOoGFeWXdMH6ad9THeC60Pw5pPBUnCngtK5xzjlDL3/jw0+QAIIRpwpsw0
	 O8CF1lpj0MORA==
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
Subject: [PATCH AUTOSEL 6.6 23/61] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:44:58 -0500
Message-ID: <20241124134637.3346391-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 00302e8b9615b..cd4df388681e8 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1043,19 +1043,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
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

