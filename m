Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D11D5AD1;
	Sun, 24 Nov 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455324; cv=none; b=g/jh92/N3K14nOV6KFZLieacQxZGXWtWLSZ+XsCfzdlThRaClldCnaHbmn+qE/8tfVIy3ePUEc5PXso9qekIJ6FMRc4Job3JuIeQewlDwZfUTxpKZWi+60Gp11jPHY7e8gHj/Tw7uT3NppPVcapezAo/aWme/xccwg1rcADrXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455324; c=relaxed/simple;
	bh=2P3YUjH5nQjbTs4MGpcZG0JsYaqdj7aLsfjD8A5RQAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVgZ3BGvyM+PiISRy9E/SoAgyCExQ0UpQd53ZwDLqlTEXfcRtRs2iYAboXMkxXb0vrcoR1R9RYpq2jDRIRbNsBB6ZcZjbK+4jRItpr51F1BxNhtwhS3U05SlNzIuU3LiBR6SeDznW2pm/bl5Q/DbFiQRiPuGwP2dMeoOYHIPTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbyf3y8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbyf3y8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADA6C4CED3;
	Sun, 24 Nov 2024 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455324;
	bh=2P3YUjH5nQjbTs4MGpcZG0JsYaqdj7aLsfjD8A5RQAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jbyf3y8GREjROHXKJR8fQ4eWbT8/krz0q7JddB04UzaIrHLlh5mH7xCPgo32QtLzE
	 UstoDCELsIbWs+Jz/Yg9PLEGTKIrrgf0jquhjJirEaapNNlOnKxAt2hWFJgzx+rXfj
	 F2kelckPFF/FSns2qqZWvGFTNiJIDPzMjerKW/AYrWI0yHOSsBYuSQMDKgrUM6ID3y
	 vJqok0NksUhxlmA8PvJx6rt3zF1L95NjfFrapcdUALCScteB+lqLJHURt7PcMMevJ6
	 zGA1cFX3LMxZ4pW4i7ZWrQTpOOnoj3PHOWBfVSsiy+MOU3KBJyqKzGG9zXhJeK9yYq
	 00mDCJymtxXow==
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
Subject: [PATCH AUTOSEL 6.12 042/107] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Sun, 24 Nov 2024 08:29:02 -0500
Message-ID: <20241124133301.3341829-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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

