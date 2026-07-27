Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93A3F58CE;
	Mon, 27 Jul 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146852; cv=none; b=FJm0pOmfLJAQMw43DnBpABWXwD5WNUsfWWCu1D9GaEGA/7YVkfSgiAFF02QLdEFYUkuHdcu7pvRQa29+sM1OkKIWc2rLbsU0zCice+8SW7Uhoh/6B8nb9eop5RF/1ETaAgGGKA2zze0/sUQcXeodp1euFCZSFCvxItJMTTcI2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146852; c=relaxed/simple;
	bh=hmQ7OIgMG0xVeEmd94p2yKoZIDhG9EWObyAw0T4pVbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9i98mpccHg8qqp4LVOOeLsAeU2ToF/5J8ncqnOylr7eTFuq+wI4IWxx9MSztvQ01dmaTiD5TrRX8liGsGsraw/qQ5sVKQBW0w/il6Nn2OlvT17wwWb/jxpKIMNKMxWoT9eiUGTspdjzVUbp8mVsHnFKD2LH5I/ozP6aQVmtMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jM2wKmF+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jM2wKmF+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yN4OOX7RVnfLwVpBUlP45Unu74lIsFF//Q4pOXJM0eM=; b=jM2wKmF+VcQsP6fcn0PMlxANym
	TOjIFw/huTyEDmuMd88YBgyaHcxysLR2iz/AQhlw5r1u4oXKoI6o1rabnZ+BNc34rvwM6bihRJLE+
	/+ZNmoNF9AW2jCVNE2HGe/IgRaSWX08I1XM757zmVsa++H1Z9rKDGKpDeoLnzTcx/hGsr6CejQDU+
	mqJtO5MRnbbIv1whgXg6j+G8v3rJ1JInoDNqsxuTKRCKep56WPTs4HBw5tIcvbdgGBKftS3fQAKTI
	veejESKvjTku/r3p84pH4ECzCeKyDqJzSFUom7OvPy5f1j7UeDq6BNPXGO0kJ1b+/e3NP+yA3cYQM
	+f7P5vuQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIF6-006ouE-0f;
	Mon, 27 Jul 2026 10:07:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:39 -0700
Subject: [PATCH net-next v3 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-getsockopt_phase4-v3-5-e89627544639@debian.org>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
In-Reply-To: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=leitao@debian.org;
 h=from:subject:message-id; bh=hmQ7OIgMG0xVeEmd94p2yKoZIDhG9EWObyAw0T4pVbc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy23Fa93CvbE2rcZ3NF2+cDtgJy0DbqjbNDZE
 k7Fd5CWbzyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttwAKCRA1o5Of/Hh3
 bTKID/sHXNJtDyDYf3TZMPZ2BLtPV9GJ3jk1Hz48PTvc514bmRlKjiqpgR6ltwmGShvJo4dCd6u
 T1pv8GJ544dImjk2evRxd0o3OP492kRFCE1Hqu7z8f8iRwi6/kqDxLnSkIvtgNNi5DlqI9wnLGJ
 qaah8V6PHFL18IqlVRdgALiGo+75TEXwJ5s4ZD/+u8D+tDMwkcAVYoT9xCE8XjCsmoxCMC+r3mS
 y6TiDo4ZXyneGkotzocJwgxbGFmZbDmyWWwF2eynwvaPWHRTe0Wrt3DbdzZU9s3CJ/ZQuE7CmcB
 zjyQpSAM6a+lC2cxoLJVUAzZFU5M6d6vj+Fyc+4e8Ln0xxcNt7UWWLG1up8owFk8u/J5/G+wYtM
 +81sUMUlDlRvIPj4M59eDV8vrg1qNWHUwz8uK1aAGOSXVwaQEm38e8RIx+mMH6E7jFTXuyC9vO+
 HykTG5NNAYVbfPsirAhFq1d1KX8gTJ3kKz6rp6EWGHoNqNiYBzEhd7WGwuT7/g0gCp9FwSjPCQT
 MOw8p5SZadZ7rAFsHv8K14drMa7+0twzWdQFYHHQup5sPEwDy5Ouo9UHz8h+OpIRCNKVJ6UXyCB
 0OckYPLYOfcxCUceNYAXAhsiv8OPTCzxsRw8eBM09U7LJok+qKg4L0YDpM9/oPNsUdzVGZS3Dl9
 xvSVAHanNoxB9qA==
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

