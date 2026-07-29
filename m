Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C2417D9B;
	Wed, 29 Jul 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317487; cv=none; b=JbjbZp0pSMHi40z4ExziW1W6tvlLwduHFyedZurgGYHuujXRrnEPGiVxlXVRnRM8+S1912S2iQVHUI31+XZnfueWF3pK3Nzj4k1hn4MCjUwjyjZZ/JEuX+oQo/BJb5m4rIdAq5u58Xyb3pLlG6tpipiHr2FHz9XKLqLyUVRXCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317487; c=relaxed/simple;
	bh=JrydNJmSFCN1ZehZfmSeEaHKvD6jtlJ9XgBAuSuyxzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nq36VwSVP3AubWG6qyancL6+0SSN4kgb0JFQN5O6wfM0gk7W9ZPruDLntJMamAKgoRP+j58EIFwkdf92FofMsKFZqk7LhSEIS0CpftdcNUT96vChNOwvuj49DhPzdDljxBSLzLNvQB0GIwyJ8LgrxKYh7OQSk9BogCE7j8WqcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=L9LCcUKS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="L9LCcUKS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=rDFfY6W+bh8Sl9MFMdOlAZcLrtb5wGjSZOP1urxLmv0=; b=L9LCcUKSlD8yzlCPooXMRH20Uc
	dNmEVLYrr6BFBC2TrhIFCDzWZttJ9VkBkX4ELsXpEgsWm8l2aCg0f3/i6oA5qy32gPXA7iYCn6LT5
	3ea1VNFxAWDdOHS2hIQ0IV57USjcVxHtwv69i6j+A8m1Dz4aNvfxCPMuPfQIjP4tGZSulzoT+n46j
	MgRbvt+W67FZFS4PSt7db6iTRk5PkfSWkoy56GVOQL6pA9jEBsBkikbGItP5GreOBwk+bG/5OXl5G
	45esRUNlH8NkuvlX/Q0/HkQ7pgRh4XrZ9GySIL8BAPD/KhTWCjM4j6rMIbegtfsmrpsX3ZErW59YJ
	Ov2yAIbA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0d3-008LzT-1s;
	Wed, 29 Jul 2026 09:31:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:45 -0700
Subject: [PATCH net-next v4 2/7] ipv6: raw: convert do_rawv6_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-getsockopt_phase4-v4-2-c44576757c17@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=leitao@debian.org;
 h=from:subject:message-id; bh=JrydNJmSFCN1ZehZfmSeEaHKvD6jtlJ9XgBAuSuyxzU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLQVuoveLN5Ih2uSruDqNjsQApCd0SLgNNI
 iU/ZKd/6wOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bahLD/480+n4/tVeazXiS+OB2IbS4vRkGzZySyOfm2VJRlRv+HHeYQDejgaZ8QN7MfbHqua7L3H
 JQhbTb0yK87yEUxpQgd8JlLzfMH9BUvHzMSzu3H+KILxo6VUi13e4sHMhoTng9TC4SwJgTwEIR+
 fijmFJ0vrSHVHZyhYCCaxZ+ij9t2lGf1otHaMT3X9Vz+DARkeG9OVosA1WE+KJ4z4R/GWjXudJz
 1+XRHp/ZDvAY98T6Q5EAYRMaY/rZEdIizaeSoo+h8G7eAbY5mPk9+7QceI5ZslUZjgBnYKAGNm+
 1P5fyrcJOlsMT23I8xNwekVAYPVs9kUAJRD4183GkRyNI8joBBoQSyjt1axRs+s39+1NHqVj4O7
 h3zSI8bBkRxHZ1zdmRmOTwgupzR3wL5Dlw85f1O+i+JElkYVNHkNdIcOyXFzRKxesuTOD2QO2Vw
 uPoFNNerePl7oNlVg8Ms4ZF2ztALjmu7CMm+d5AqyxjFVpamY8VQrojsednYwqEaih2x7FNJQD7
 RrRCHNQDi7G8xmbSUm9rDx3z2DdHfkN02UxlBDruPr4DhvGC3akReShDlsjDYaX9KDvVYBD5rwq
 yN0kTeNhJT+5jf7neRAuJMVIJGE9sqFFzue2gDAlL52r1HrI/QHwatqcXnaaGOi6N/5nvCkwpC6
 AdKKRwLek91wjwA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert do_rawv6_getsockopt to the new sockopt_t model, mirroring what
we have in ipv4. The overall goal is to move these callbacks gradually
from __user points to use sockopt_t, and this part touches
do_rawv6_getsockopt.

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/raw.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 99eec36796fb9..c36152d2295b8 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1051,14 +1051,12 @@ static int rawv6_setsockopt(struct sock *sk, int level, int optname,
 	return do_rawv6_setsockopt(sk, level, optname, optval, optlen);
 }
 
-static int do_rawv6_getsockopt(struct sock *sk, int optname,
-			       char __user *optval, int __user *optlen)
+static int do_rawv6_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	struct raw6_sock *rp = raw6_sk(sk);
 	int val, len;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	switch (optname) {
 	case IPV6_HDRINCL:
@@ -1080,11 +1078,10 @@ static int do_rawv6_getsockopt(struct sock *sk, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	len = min_t(unsigned int, sizeof(int), len);
+	len = umin(sizeof(int), len);
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -1092,6 +1089,9 @@ static int do_rawv6_getsockopt(struct sock *sk, int optname,
 static int rawv6_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
+	sockopt_t opt;
+	int err;
+
 	switch (level) {
 	case SOL_RAW:
 		break;
@@ -1109,7 +1109,18 @@ static int rawv6_getsockopt(struct sock *sk, int level, int optname,
 		return ipv6_getsockopt(sk, level, optname, optval, optlen);
 	}
 
-	return do_rawv6_getsockopt(sk, optname, optval, optlen);
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_rawv6_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int rawv6_ioctl(struct sock *sk, int cmd, int *karg)

-- 
2.53.0-Meta

