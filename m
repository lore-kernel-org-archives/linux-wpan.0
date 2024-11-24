Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4A1E8820;
	Sun, 24 Nov 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456571; cv=none; b=Wdu1n58wH713SFvVdlLwrW7PlPYvTQvVd5ZmIX82pESe21hef0MzFzTZmYCK3DRIvTjC/hUY/+CTg9x6kTyu2GaMGvdVPizU4LgqjZoXONOyR53lZookffqKzo/9KJ2DXJgiom/fz8L4XLdFeoRW8n6P9pBUXHomQIpChQeIdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456571; c=relaxed/simple;
	bh=DWlW9or5fSNNot99iiqB/neuUKCGlZTIwIIb3IhLYy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV8EXy2OT1yu77bP93FZnolKMhtxeW+8hxotPYMsGukBBEJ7o8Szm8K7Y0xkil8dVxM16sKT9m51OqCgOZeqfswIxmKf/+2VMT1HJO5uceB79dP+aJqG/iEuYQIcL4NsIJEHm/8omt4SHAQvq9uiencIpdaTLw+lauHjByI2v2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhKlnDgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhKlnDgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF0AC4CECC;
	Sun, 24 Nov 2024 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456571;
	bh=DWlW9or5fSNNot99iiqB/neuUKCGlZTIwIIb3IhLYy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhKlnDgyqYzLdt7azqbWD2Bt5NPrE+sdcXDKMOpYFiKtw2eE+QOZLUJcVm4ihJisf
	 37CYCsj4Ylbsef0KjJsJChuQpJ/EJSKk2h0q7dAXrggtFnVz0nh899zujhL9RTtDE9
	 zPY8mje7tqWLlGWfyqWFwRZa18xWQxC4c9O1w+NWEtMGkoP4ak6S8q340ZGYRvjSkJ
	 NVIXxxtgl3BUBoUrPUqqISMleu91Lhkvw7iDUWa/xdVH5A36GuzZXkjDB8huX1uHIy
	 hsh/kMMuwXS0Zap/CKpj5FggKIE0Yqxi+b+w2xoL2wfC4UG0mb3Z6AqKGO0wXkhaNY
	 GEvyAh0UKSpEw==
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
Subject: [PATCH AUTOSEL 5.4 11/28] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:55:11 -0500
Message-ID: <20241124135549.3350700-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index ce5f25c89dfaf..b5f8aaa428844 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1055,19 +1055,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
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

