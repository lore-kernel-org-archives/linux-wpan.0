Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B578442FCF;
	Mon, 20 Jul 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564631; cv=none; b=NszmivX2vi9vQCVbxqmrnxYzGW0QExn9RF10rz4fmJ79lPrnwp/mhsxd7Qppfl25qOPeSxz7NCSWGl7R3z4pzU+yMyZ6BmCwgaKFkd+RDM6W1PgBUPhO2t0aps9q63wkzQbd+63AFh169mn3/Ku4MysQ6b7tU1wwfJtfodOnV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564631; c=relaxed/simple;
	bh=NcuZltcOYUOEoxM7AkpOgNmQt761dSxlEbopnNwn8k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpGUC3R83FjaaqNNvCvXHy5ScoZcfqTROcr7e9cKlanfCxpHPwMXfvC4EpsqA7vZk9A9KVBH29JeiCWf7XG1GeSj6LBvXdmz/B1oiruGBC3bpEIP2vldl898rlcayd+oA/O8o7jK4cACsXbLhRnfoAVfLVyMFgmEhG76+tngszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MvQNQ1rs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MvQNQ1rs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=W/z3gIgAJ7klpH5Iao6y/vj1/0Pubri+AyfX+X+HL8I=; b=MvQNQ1rshH8YsWbX+t8DuykI7o
	FeejTnJymISlMVdhDkE2JgTaSCVMFDvpDcBD0+xShgdt2VH2baQRCiqZGNiNyqhOnIz215ae2CBDj
	17z3QCNovzf8kshHB45h/u+9M4VfT80uarkp7V2tzrI9mllm5wkrnxt7omeUPp+Kh6HL5jJs0qKKn
	L8g1BuHD2Mgft2NJCRkMlmnbc56/xcEBZqjS3go8TRUohMFfZovhMXDwFotAkrwJrbQ+GO2gDIp4R
	uZ2mu8ndBNW3r9+qAJUm1JCkS1X4CDH9Yqn6Hp5pVgf+epshUFnbkBPx/WvWYGcpBq5ITC9KCEbOX
	ifYj19nQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqmO-001Yxa-2r;
	Mon, 20 Jul 2026 16:23:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:46 -0700
Subject: [PATCH net-next v2 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-getsockopt_phase4-v2-5-8a08fcfa0d72@debian.org>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
In-Reply-To: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
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
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=leitao@debian.org;
 h=from:subject:message-id; bh=NcuZltcOYUOEoxM7AkpOgNmQt761dSxlEbopnNwn8k0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktyxW3PxpQpc+nvJTcPrtha9hhp7bFAQkdc9
 +Ikq3HQftCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcgAKCRA1o5Of/Hh3
 bT8rD/93f9hGTA8mfwtmkeCQKeMykceXZY7l9hi+yZKJrSU/F9tDt46Dy0vWHPm2OPwS3i/O2te
 6pozMX3P9xT1iT0kg+X1z0IrsaNcBIMotBGgrOnHsus/7iLUIb288NJq5HoQdjgSBCwIeIoZzxC
 exXcKmfA16ME58apnx6oybO2/C3u4HKpgor6b+4Ae+sXlyE9KRbwFmAM3y24p/DNoyOFyMAZN2f
 0YTW57AU63DQzroGLYdM/sH/jln1yu/TSOp90EJ4rnjPRF5HoORf31Y7UsVlMWpcYbzrfHDBfkw
 p2CgpwjWlHHjP4LLBzjI7semp1fOrlqzcNwxN6qxmCvac/AKjVQzrdT0AraMx1jxRYrorhdRx7q
 PaxuFea7oRByqz9nEPw4ouLcb32MHdek8RuKltQKbe0B6Ou/pBH3Zu+53UsJ94Pgn4I6HT4Do96
 k/vJpQvX6zEiTGvmDRv8J+8fbHb80N1oHT1/83Ot10AgWdK4QYfyud/lATWmMiIansYPl6JDKfq
 XZdDEvtKjT3BBlVZXpNGWfovdsLdH6B8B1XS9vy4qCqRHTPdUXFuW+caULYedj5KkDSkwA+oPr4
 1tv0xHjQr34+e2RhADPFcKd7UakFw38xYaMPyC6IN0uSZ1bmZPpdfoCBbFIotT1YznknLwlodWE
 Te1GFZt2x9wYjzA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the
sockopt_t interface, splitting pep_getsockopt() into a
do_pep_getsockopt() helper that takes a sockopt_t.

The thin pep_getsockopt() wrapper keeps its __user signature for now:
it builds a user-backed sockopt_t with sockopt_init_user(), calls the
helper, and writes the returned length back to optlen. The helper uses
copy_to_iter() instead of copy_to_user(). No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
---
 net/phonet/pep.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 60d1a5375725b..7ef4a9a240ef8 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1078,17 +1078,11 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
 	return err;
 }
 
-static int pep_getsockopt(struct sock *sk, int level, int optname,
-				char __user *optval, int __user *optlen)
+static int do_pep_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	int len, val;
 
-	if (level != SOL_PNPIPE)
-		return -ENOPROTOOPT;
-	if (get_user(len, optlen))
-		return -EFAULT;
-
 	switch (optname) {
 	case PNPIPE_ENCAP:
 		val = pn->ifindex ? PNPIPE_ENCAP_IP : PNPIPE_ENCAP_NONE;
@@ -1112,11 +1106,33 @@ static int pep_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	len = min_t(unsigned int, sizeof(int), len);
-	if (put_user(len, optlen))
+	len = umin(sizeof(int), opt->optlen);
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	return 0;
+}
+
+static int pep_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_PNPIPE)
+		return -ENOPROTOOPT;
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_pep_getsockopt(sk, optname, &opt);
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

