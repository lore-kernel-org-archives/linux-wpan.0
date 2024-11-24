Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD23BFDA;
	Sun, 24 Nov 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456364; cv=none; b=sQjHkt09ftGPVDJboRqDfGEvqNXgcjsySjbWxriG2GKODnYhefXUvwTBsci17mkGogcEH+vfTb0qLvKu1PHg1BuggnFBf5Hovg9MfcOppR8vCwLaIWAASF+EbGywfEwfysDAGDyJ64uuj0JD0PqYhJCTIZmD1LOnBatvky2Kq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456364; c=relaxed/simple;
	bh=+7IxDrv1f3aUn6lgz/8easzM6vQoYwkN/Nj5R+Dnv4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCufLKtboOmxDI4fC3oZHF54BKaLS0eyOJbsnIjih1gLRELcM8S+P7V10t1hHYeC/sZgRDTRjXOQe29fzA/4sDw1trveU2dGFE/tP8a3cV3BP/IhMwjT9edowKVbOVn0IKpi9J1s0/YPNzretEDhTjl4qgWw9yc1CnMXwJqfN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+yR2EMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+yR2EMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3612EC4CED3;
	Sun, 24 Nov 2024 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456364;
	bh=+7IxDrv1f3aUn6lgz/8easzM6vQoYwkN/Nj5R+Dnv4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+yR2EMSz0hdve7NeQ0a2+9HYBOrmToNjeAELcBhJ4vWSznPVnXitx0JYsIurWvI4
	 3wQRWI8vDmDydXVZDfKlw4jfbu9UwJEvqTSTNq51l+irbRPiA5DeqBz3lvhSLoZedH
	 XYw+KFplDLsBMUwG4u82uNxb8OPniyQUAun+7i4m025zRs0J6MdUzOAthb4YX/8Lnb
	 Ty/IeiE/TIJfvOOR6fEhO8MQiwc/7+R8AMtFtBPFWmpWmp6Dxh/qgBSBFZ+P8GQ7SY
	 4WcTsLXP4hqwdGXsjI/yEXr6gvPDxdqiMg9vRrS5GUdt5LQOtCshqmY+mnaNPVaROC
	 n2P0LKhhzn23Q==
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
Subject: [PATCH AUTOSEL 5.15 13/36] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:51:27 -0500
Message-ID: <20241124135219.3349183-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 586a6c4adf246..d7fa862b81ef5 100644
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

