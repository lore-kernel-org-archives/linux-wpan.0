Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DE2DE70D;
	Wed, 29 Jul 2026 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317486; cv=none; b=IfivW4CipLK5qx4J4aOkS0qHnUlIjbD6Cw1qKJ9THh3w6YsNQqfDxT4bcuutuGaLhOZ6cSuZk+SjcNtayd0PYEudRkzhGFqi8bSx3r3aeeVu0hWtKwTwFbwhWamcmVMovebXM9hFDvO3/TSNftn7S+e9r+wh8H6pwns6ceEI34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317486; c=relaxed/simple;
	bh=ntPDVjqv0PJqbLVl2fhS1avXv8b8/XOeUz84eM4t/dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjBgLqZqQvIp9xDeC57Gq5w08nn/uDg3ZLiv1rqV+Am0Wm7kmzHCgPY8qocz4EhOrtalyx61XQXWZKSCcLsbjTuPetdK3GGiU6j4wYenhYmbkMIKf0CWRnUKJkKtI/KQku73mLTtqjr86K1lQDol/0k59M8IyYHZ2tbD+2apZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AS6GRsrJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AS6GRsrJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=exmViMPNhq7Zx1YDpfndYzUplH/gmfUGqxLGBZF7jb8=; b=AS6GRsrJXny0UD53R7455SyYEZ
	9AXricl+G3oDblEYvtRJg4JyupFrgW6VMX/On27rzxR8lGRlmBBTqUZgP0qKt86UPDR78oKpsTmre
	jtMTsIayo4VdKNr3gHVzPGjD6Xqcr32LYQhKBmbArE+eRXfghFXpVMVcfyZaPecyuhrqGZnYtLNyr
	a0z2MvpTsRv5160u82wK6odWJPNAkLtVqOdET2/FON+X1xq1CZvpLDglcnuo2h0cn6/LIlSoKtST8
	IQMa4C7LKJIQNEn0l6z3YBtYnt9gzuz8Pic8qirVI6t+hfL4PYoIptA2G6RpDz3Rn+2DKzUnGWkaY
	atV0lPTw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0d8-008Lzj-2y;
	Wed, 29 Jul 2026 09:31:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:46 -0700
Subject: [PATCH net-next v4 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-getsockopt_phase4-v4-3-c44576757c17@debian.org>
References: <20260729-getsockopt_phase4-v4-0-c44576757c17@debian.org>
In-Reply-To: <20260729-getsockopt_phase4-v4-0-c44576757c17@debian.org>
To: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi.denis-courmont@nokia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=leitao@debian.org;
 h=from:subject:message-id; bh=ntPDVjqv0PJqbLVl2fhS1avXv8b8/XOeUz84eM4t/dE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLzgiJekLPsLpGoFPvd3c1OKCKvpBPm2pNx
 6t7vTfJN+2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bRr+EACQ/eTUaiZo+C08AiD1t5jYEMwoRWCqzXRDjPJeiLO3+PdsIPUZq6xaNnhQK2+WE/5KGEE
 ErKaUYr4X1WcHFnvui7jZa6WDhCegspqT3X9nXMyq2YKVOPffYDTYlTdRJBbPV3LBMbLP+RiTEx
 8Tq+xDe+9iJs0cGfkLTZayWSJT+u4qXKuqOISbE6P+tknZRmegUt1vSTlJbh3kHQZIwY02tviOw
 5rb+nnqaDklb3+xdVOtbOp/gwxYs57GO3/DeKXojy0fBkDA+lLb3mwZKuwLdcuLQSWBj00lubcd
 czlSQWwMjgeoiF/Ycnmi4Z8PP4eOiSWYxIwXomX0rq1/xET6e50CcHgChB5ggF2UJSo7UDjULOz
 jrYaxZi+OyQrqwu+VJogdDjI+Ks508cjvjVGp05jE78swPiK9hm30hFugzIoNa7UW+lNE3nlzMB
 RJBSGDNLNMftBiX+sqR8dTNM7UA3nRUlcVXkgxLQhY0t0pGAnLm/WhAOJ1Z0wgV0xB0OUv1SueN
 oucBBXDQfaRMSCDEpFUjNIYdqkQJDVCI2PVn4CaNBWvgjfz1QzIvONnZUHjwco+avbK0qOdAQX3
 uo7mxdCzBZ/AHo3M0bZYF1rDD9EzH/pad3hooxuFZCZtDJ0pq1N6DquLiLwzcVCT26RVpYnIM9g
 L1X7SOBh1xUnBVA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
that takes a sockopt_t.

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 85dce296d7513..5a36e87893f64 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -831,20 +831,12 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
 	return ret;
 }
 
-static int dgram_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+static int do_dgram_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	struct dgram_sock *ro = dgram_sk(sk);
-
 	int val, len;
 
-	if (level != SOL_IEEE802154)
-		return -EOPNOTSUPP;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	len = min_t(unsigned int, len, sizeof(int));
+	len = umin(sizeof(int), opt->optlen);
 
 	switch (optname) {
 	case WPAN_WANTACK:
@@ -871,10 +863,32 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	return 0;
+}
+
+static int dgram_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_IEEE802154)
+		return -EOPNOTSUPP;
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_dgram_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
 		return -EFAULT;
+
 	return 0;
 }
 

-- 
2.53.0-Meta

