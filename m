Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45329422555;
	Thu, 16 Jul 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206925; cv=none; b=KltOheNc2oYz3s8ekUNeq4qZdquIbg1q7HLXNLh71pjuNliWCTllf1LsjKrSKlcHZKy/NRgMNsP4s+su+UpZSFGcNKL+iH846Mw0HNbVhIEnTUas/9h0K6wMPNShva74jxMqEnv0Jx8iSDYdUPsBx9FBFacGpv8Q1bMn7wt9AWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206925; c=relaxed/simple;
	bh=cAMTjzFtWpssYhGMnYLYloL7+e38m8IMj+86usmagk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ddm57HfS2tjt9DMando5lmkJ7dBZRLnkH+kzT9kInU3TdZlIeJwgUgR94x+BABb2JGqTJrvdFzHdcNXX//Orz37uew4qO1pGcpjaJL5RhoT439jiSY65l+Z1A+mcyW6p/6KDnnNNmfsch8FgUYqLC1kUiWPs427Vw6uaHsGF7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o2CZB8RX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="o2CZB8RX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/ULuSXe8cMJt1jfaDloF8ljpZjBOJlHguRmjs+r/CiQ=; b=o2CZB8RXCyL+1mY6ivSVh1CScu
	KMYrZeF8IqX0wytJwihn8mxXjCbkISgazGAlHPHiP44KHgIwPBjUMmAWLfvdnuExNPnrepHnHTadO
	ktaj24cVnUEURRZs+g9rkeu4TRTPmv2p3dQRvSRARF1Q3X8OR8RkAyO5Eyrsx1Ak8kBamRUXNnR7v
	PotAGdt9mH8qJ3HOREqsSPPNNVUiaDFjJX01ybbU63satV/vpqYLaFBI/fuqgEklFXEcqQ1/zZx8+
	5v1eQIjnSkM1CDwLR/Zun/RTWIjyl4Q8nPhVw7vIs0jwhOfmuo90BGbODSX2pagrE3yZ1Y9WlJOnC
	V59MEpAw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLiy-003q6h-0f;
	Thu, 16 Jul 2026 13:02:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:01 -0700
Subject: [PATCH net-next 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-3-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
In-Reply-To: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
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
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=leitao@debian.org;
 h=from:subject:message-id; bh=cAMTjzFtWpssYhGMnYLYloL7+e38m8IMj+86usmagk8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0Z2IW793tC3PkXGaq6JPsqxAJ3yimolzQ7
 WQjXLsQl6KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bfQ1D/0c5UKoMN66y1FjrvjsWn8xg+C2Yqn2/WAorSfPmPiMI+mWsr+n+BPgcVtWEaVLvb2xXNg
 GnvK5+KGAOzF7j39vGXdGs3eKerGhqkCQW4bEIR6jj4WZsBBQzXCu+kGLxR/k5zHzptc7jJ3Z3M
 h0ii3I1IB27RxZQmyWXaDzdggcTh59LO+AC399iJT6dxqjhgcpzQd8hlGtN2STGNskCZ5oDFIvt
 p6icDiczgQOGcFcumEiKL/z8Rv2Ai4ypiyUwmLSOQmyV7TDSZ2KuvOuDY+Gli0yTIWYZzUMLm7V
 qYiyAmS7Gdv3UmmpEWahWj4Ga4B+g4X+2/y5jf1jAOItmq91zuoVrK0RGgfNcf/mwHpRcOztAMs
 6FiVBB6tGGlZdeViXbWV4d9ZhLd5ncwR9cqukOUMQ/p4Yqgid6QcdA3f2pPsBxQRIrtBJY7wbk6
 TUgFFGU8XHp7KSCHGNYWPAwLQy6rh3yzpjEkJbkW8Jd2/fchDnAraZFGOm23f4I1FkIpHLKnbYc
 czPcEhtxsPulp/cw4zxLz6nAfZ92580I4ec/DBiByDkvS34oigfbYxkL+Hl4pC+yigNqQR4pwWr
 9wcLzWcEyUEoBAybaUMiCpgKcHJM+TU1WmoV0L9ytCWJQ3NUFq4zvI9TcAF85smnzlI+7P0Vsdt
 GeWZJ26OhTbsvwQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
that takes a sockopt_t.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 85dce296d7513..763f63e48afe4 100644
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
+	len = min_t(unsigned int, opt->optlen, sizeof(int));
 
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

