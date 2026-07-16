Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC241F7EC;
	Thu, 16 Jul 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206918; cv=none; b=WrX1+/e/AhlrxCxtKUMHxWbFLJsV5rtiAf1KXoxaaSo7PBWy4mrA03jX5fWd8MbxGs1a6+icUIl64swxcqFTCWwIOg09mD8iGhF49cHgdgPbtqb+2JRr9pvzPFyRg8uy4KIcQIkkQmE8OYXWamLsITz0XnO9V+P9uAln5I5c+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206918; c=relaxed/simple;
	bh=c5PglPwUQC5mxsBdp2RPxVvoUHdq1cPtE8naNu9cnIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYQBXu8EduHwabfbLSJCzFOdeu+YaS1ITw+uJTwwEaJTQ1oDhp+GKgwDyMBOHapmmdKe5JZ5WmQkSdJv9uKYJTOyFl9kKZwvGkWEMP9WPPqnBkL3aB1+RaYKrekHnsOt9KI7uSBxqWInK9DWlIyb2fmtEJIcRLnQyowvNfwj0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fDIZA9eW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fDIZA9eW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=XC51hEuGBD77AWqPRk8uGjYTB9yK3f3l1kdf5Rac8+0=; b=fDIZA9eW68iFFwYmEf3KQxG85y
	pMEf95m8Ib6u9Gua7zaebrempeKJMxNo65UAM/bhi8viQdX8ZSKxVKrq0Sn5KFTeKNNfukbDlGQg4
	VQJ9G6cYxx8sK8ljTfji3yVPkmPo7m8jyC6da8uzMjyGvrGKx1GffewLjsdZAv9MJaY4EFY07LG+T
	Px+Q4iyURbaqwihNNf6C1MBhNLLkSZ6EFhX5l05jBVU3lneDx8QF2eiU4HwBAMHJfINNSfFsivwTz
	BC9xNQcRvtVRyPsA7ZrIRIVkEv/wM6sSUi5xVRnBEVktpvDk5TfOSa60KvXrzMgQEPQQcfvi02HSi
	HCAAiuzg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLio-003q6G-0k;
	Thu, 16 Jul 2026 13:01:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 05:59:59 -0700
Subject: [PATCH net-next 1/7] ipv6: raw: drop unused level argument from
 do_rawv6_getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-1-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=leitao@debian.org;
 h=from:subject:message-id; bh=c5PglPwUQC5mxsBdp2RPxVvoUHdq1cPtE8naNu9cnIA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0h32R7rkywIx559Uynp1WfmV3umKVOj3Xt
 nO9mXXXTveJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bcoRD/kB01Z0rx9N9J/Bha0kXR8tivdHpeBuZXx1Mhewr2WscbzSKnd4S1BrpXy0oGoVKTOR7cu
 TiWWb080AIkz39o1FBOly+blxhJKJ/lnHq8qBE0hCW7Y3rWPwQwJaynMkU7lhqpB9ebonxJFEnS
 Rbiya+clIIFx3EkH9pg/DgSMs0iyNDof7ZDSG9RhIN2wP3E863XInHtezNHmjflesi2QL6I1dgb
 d6do1ZYq9biRIH6do6YykslTzLI/Az8FMQVozuMBm6K38qcTUI+QTtd1qg46jIa26O6AFi9cN3J
 5kgidKZq0Xp0zzRsoPsElNvUqnmArWSkQkJSNX2dcsMdPTlVOSH4xrvdUg7a8xZh/9lamLVQk9R
 LvfEmqgHfmt9ZgGAwUxYdGt2+TzVyrAhQYFeP/K8brwvNWywwZ+54BOUkCtdz4k8d/uX7g0s29N
 S+65ltCmrqwdN9Pg++Gyq0wlQbnSuoJlrnbl3JdQsuWlXkx+D8DxzhratwfhEBv8M/BpQrsjvFR
 E6w1+mDwmwW6pBvcXgv5Q0MB4QVCN2zXyYvk1e+7hYpgs8yKsW4rlZzLSKhWljoQ56LPwBZt0xZ
 TzOk7+kPHf7FC/Z3OeE78aK7tVP3omn4fi+5++mNGGKuTr+sS1nfe5VxCinQZIgelzYyZvVCaD/
 poAcfIc2L6jUd1A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_rawv6_getsockopt() takes a level argument but never uses it; the
level dispatch is handled by the caller, rawv6_getsockopt(). Drop it,
matching ipv4's do_raw_getsockopt().

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/raw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 3cc58698cbbd3..99eec36796fb9 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1051,8 +1051,8 @@ static int rawv6_setsockopt(struct sock *sk, int level, int optname,
 	return do_rawv6_setsockopt(sk, level, optname, optval, optlen);
 }
 
-static int do_rawv6_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+static int do_rawv6_getsockopt(struct sock *sk, int optname,
+			       char __user *optval, int __user *optlen)
 {
 	struct raw6_sock *rp = raw6_sk(sk);
 	int val, len;
@@ -1109,7 +1109,7 @@ static int rawv6_getsockopt(struct sock *sk, int level, int optname,
 		return ipv6_getsockopt(sk, level, optname, optval, optlen);
 	}
 
-	return do_rawv6_getsockopt(sk, level, optname, optval, optlen);
+	return do_rawv6_getsockopt(sk, optname, optval, optlen);
 }
 
 static int rawv6_ioctl(struct sock *sk, int cmd, int *karg)

-- 
2.53.0-Meta

