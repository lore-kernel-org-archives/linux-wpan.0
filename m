Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55E1FBCBA;
	Sun, 24 Nov 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455788; cv=none; b=D88m+6snt/MbczhInFzpTof7YJe9Jxhw7Fu4VlyN4gIqK0JdFqoYtG9ecr8lGsPSFNeYi4cXF3hLTG52G8D1CZO+JmVRofytEQ5amWTtqOYcXsa730ag6gQqnaPRGWIf4u9QToMXvjjbGT9xfINsjBX3VvpIDG0DqultTGX04zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455788; c=relaxed/simple;
	bh=2P3YUjH5nQjbTs4MGpcZG0JsYaqdj7aLsfjD8A5RQAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2YtFhEmNUm9xoatTL4BVuFWp3Kl2R2pnSLqAjnpwZvODYt2bZvsIV3KfcTwFOh8kMftqSZzA6QPXia5pzLamL1ND/pxC8Jczrx6ZnkvMJnDrP8alVpqQORlLV0jcMJz/Pp4AlhbiW4O+maJdmIdO6MA1hSjJIAq8f98Adn+5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IszLYH+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IszLYH+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B06BC4CECC;
	Sun, 24 Nov 2024 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455788;
	bh=2P3YUjH5nQjbTs4MGpcZG0JsYaqdj7aLsfjD8A5RQAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IszLYH+VwJ3g1+BoxZG+TYxGvGJBsmanlCUeQYkQfH8GciZMWWqkuIsBDw29Ynqt+
	 FNQt03nfPMfTc5irPg9pZ/32czgD4Lt1f1arrlfL0N3bsQINWr+NdedgHtg8DgZaw0
	 Lqe6jzbd3lcIUJFwhGaITX3eAj+ctmI3F8AbIBk8B9jcUCvED9l73vFzHK1xFBAHII
	 s7Tb6C8Vy/KAqwdueE9EnHA92iwIuen4LWcwPnSkFNigsDgMHBQr5Hts2WZB9Bqikf
	 sJw8d9qS/442NvJwaxXQDxe3uQISKNnwX1TgQraGVn7V4kRlf4sM0v3vLPVNXMx5C7
	 TYAAIIQJVLjAg==
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
Subject: [PATCH AUTOSEL 6.11 36/87] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:38:14 -0500
Message-ID: <20241124134102.3344326-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 990a83455dcfb..18d267921bb53 100644
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

