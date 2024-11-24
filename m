Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14071B4F24;
	Sun, 24 Nov 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456476; cv=none; b=IbnuPWI2R48/Z0s5w2Y8Ytemy+NW4dz8BrxhfXF92bcD/PEw1W7A/uv8D0nLDX5FDvp+0INt3Vo1eSmDd6ztnhVW4BJDBU7PtGtZVbsZvItX2znbDIvih7ZdXa2tvfuPtUI57tH0dU2ZpoNuS78PkJ1dqKiLuaS3dTXXMQlu1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456476; c=relaxed/simple;
	bh=uKdiKKJqqACP+Qy1Laq4AeYSnmYb2m4AnLOTN1v56m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XySJxGeH6RQL9jZ3lJi7uCpwdFy8jK4szUddJg0umwRsMpDyi6rEkpeSTIFQX+borbysbqKS3WIHYKjsD3QUYwmesz1cTaYBzSb2Eic5idlK/4MxjQGf1oHpBsrCcNsHI3+b/3xwXGplmh5SmAV2UT8WQlCqjSSMVUi+0QU/brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTw1S6Pc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTw1S6Pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7707C4CECC;
	Sun, 24 Nov 2024 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456475;
	bh=uKdiKKJqqACP+Qy1Laq4AeYSnmYb2m4AnLOTN1v56m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTw1S6Pc8ZC7NYxtHTbnCeT+NYpslXwpVFL+3/RjcYgZVMFDINbQvtt0/HPkmz8ts
	 m6m48Dr6nGDvnY3TpNhZoCU/9f/+kI6NU3QxAxO9HdqqlRxO6OqCxuWHh428etMgM5
	 UNd3nugBmWkzigky8gPiTB3pvirSqUOevJgad+2c+o1Kg8fi8kK1QGwRIRV1rLSdqy
	 fK2fRjbNa/xYJwAVykZ3vcGz+WAFZHQrO+NRADLY8InPK1HxQr+2gbnxHup61cJ6BO
	 2HWd2Apc+0TXql2b1olcgPHvjYK6l6BahQUwDMRju1HV1blTEZ8+05beudPNLXD+YX
	 djuWZjxq+5QhQ==
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
Subject: [PATCH AUTOSEL 5.10 13/33] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:53:25 -0500
Message-ID: <20241124135410.3349976-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index d4c275e56d825..c8b9efc92b45a 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1047,19 +1047,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
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

