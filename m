Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6B442FAA;
	Wed, 29 Jul 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317495; cv=none; b=EP4t0saGycwrxxk8uDmHDw51nR2biT9hnbRWkT9Bli66eDwOqLcSkCtw5nqMHbfVdGZ/9ou3monMxfPEjbGBMdnwVAV4oGD0P7RiLJETZzZ2T1YyC0MohVQxxYd+ElJMJXHFGi7g2hnlnh6EkW9GNhyVIa37Np4hag/Vc9+KR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317495; c=relaxed/simple;
	bh=H6TOTXfHyhkIDRY4k0gObNpkOAN5avpa5bn396cyTnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOSeVxFrOHqMVP3yDY4w16KjAPaF3jREAWvybGOcGRu7NTSrWHA+CQCQ7f4seU0rq1MAQSqXAcwgh1A/A/GE+gj8Ap/wMSzpyKBFcbxhCHJVvojaEkynwPHMNxkCiq0/TEzLt3P/fmDDOW7n3SBYzs+XcA+ZY5JcP2kbwdVDp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kxqoTgpE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kxqoTgpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QIgsXeAM8ZCQxwYoiI+R2Dem1Ve41SW/L0d/nThbbVc=; b=kxqoTgpEhXckj+oVG6G3soWRj6
	boSlKcIHS8eo26DtrlirGnn34Tu7zTjM/lWh2QsvIcoXM1Hspu5zKEjn4ZFWdT+OHo2NOCVZejqtz
	golvebcYStln/ZMprcxQSpmLNtXNDchKNplcjLNTRJJh3hpPquL6snkc2pIrdfX2pfYJKgrbxy3VE
	vcYh285CoPeKiHr1vCxiNzz+W4d69SYlscX3nsGe1qWMBW6Gmvn70DOcuzdID32U9oxlwZG5lXhFR
	E7D4ThPYCbWY4sxJj8yUyNM94MT8w9ikWFV+7LkddPtsviVD9QAhR3ddVG8n8PKip+N2I0aB/4ZnB
	nIjBbCXQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0dJ-008M0F-2Z;
	Wed, 29 Jul 2026 09:31:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:48 -0700
Subject: [PATCH net-next v4 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-getsockopt_phase4-v4-5-c44576757c17@debian.org>
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
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=leitao@debian.org;
 h=from:subject:message-id; bh=H6TOTXfHyhkIDRY4k0gObNpkOAN5avpa5bn396cyTnE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLv/96EgyeuAL2zCgdp5vJ3vvm7R2IQ3aul
 S6IqSx02hmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bYwOD/9kMCtW2iaobNOIZKKRQp0adTbC2urwUsimfgMVJdI/ZyB95DCIPLaO15TK7oqI7sEQejg
 gOKK6W1PbjboHa0+jV8+C2nopxm/qkFcWk/ubJHe0qLPj8IKF56aBv15zGnRAaSfpVXlpE3GObZ
 TKdivVA7Cq8lQb0KLOAIbVwkV6+j/lekcNtKCsn1K2xs84eh0kDp/lvG4B4tv7Psei3VkyPVGLw
 RG1ByXjo15IZ9j2/0qzSu3pYhryO30Y0UrijYmTyZ++eKB1LJ/v0GkhGc0HwgitmkHXyNHg7hBR
 pZAmWHvKmehTrfgbZ84BssEi66KxaZj4qTDz1ptu52VPpSG4DaI8cUsAs5nmGuPioGsLEHzobAE
 uBD78gt4sy8hzJt99NPll0zqYdgJI8X1muVSOqiQNAUWLxiylnbMq2sm6ukvOMR7Ab5EoaDyY/A
 w6aTWkqiPLs4lpDvT4oEMyb0iA6YVrLzzJTYRm3tdDH5jF8k3R4p4vcBp8TWjx26Q0uG+Rjtbev
 Wm/TsMrEm2DdzhGqXWL8enh0Hi2vHNZrUkQTsfwTgls7WM7fVV9YVZJH9Y4j8ncm9cptoTZH1CB
 AwDOXsRZshmFjrcwMWA/CLdeuAwUBLQvAYkBJeDGu8YRidxoGueT+izKF9gSBgclfdiA+Op9enT
 3Ttd8alDJck1ypQ==
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

Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
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

