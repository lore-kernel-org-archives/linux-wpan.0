Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2243E49B;
	Mon, 20 Jul 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564618; cv=none; b=K+n06dUgjxtLHTjr24+ggWEq45IlQDAq9oK4Smu518h3dT06UY/EnlLgafKOkUZjpsYp56Vw2/gq5FNJngZXt5wBXjYtAFftbpm4SOt32iJo+04LyE25gTJuCspvcBkPU8IEf9GFlswnb8aNLdknZ+hHxYQv5QMGSPKC+A0GuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564618; c=relaxed/simple;
	bh=uQw9+P8SQcNospiW32OdIyj9mAmuKVQRv/ZlolZJPjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbisSMLolhQ0Y4WMf4z/zbGZ2hD6ZzHZeMvawalJpfbBLNQ0N5FVG8Ga6/EuSgAc/Azs+vYizKyxLvhyOPdSneyexRTN9jd+8PMWXf214PBg4Ge3cM890aHZoFCWtKMbzmQ9zsB1EP5OEsU9re8MPvTbuRonQgKVZ9NZyymyvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=X23DataA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="X23DataA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=p3olImzVCvMhNN+6I0jr7pI95BV7NvZBpFe/CbmtjVI=; b=X23DataArkdaCScBP8MsOfbhu6
	UoTf5fygffZu6VJBcznAr8n+376qgd2aNUZXlLeYxGdv3aCi4jVMjyrkt/WFobPBVoCwFruBzF9Cf
	CBTsd97vDaxauF4Y3xXwastnpChId/vzI6D7KEVT68amZIDLFkutcVBu/a654NXfq6j7vqL8zgrUR
	GMM2YdtwaEd5uTMU2Mm5KkeSCo5jzr1Pgyvkl1PDtLLXj3rle8IAvJvPq1q3BFCn7XEdjdW3tF5mx
	5l9BhABKj90C97YIEGuB5SNZEHL7h8BEt9vBx50r/2/rOpu0droBivRcyO5Sf18+Z0N4aDrqNzCZ1
	sec5uUrw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqmA-001YwP-0C;
	Mon, 20 Jul 2026 16:23:30 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:43 -0700
Subject: [PATCH net-next v2 2/7] ipv6: raw: convert do_rawv6_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-getsockopt_phase4-v2-2-8a08fcfa0d72@debian.org>
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
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=leitao@debian.org;
 h=from:subject:message-id; bh=uQw9+P8SQcNospiW32OdIyj9mAmuKVQRv/ZlolZJPjE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktyVkgCHoe3Jp8tvjpO+VR+nnGW0y8NsvM+o
 hJOknf9IoWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcgAKCRA1o5Of/Hh3
 bRlbD/9D1L1z4/Gfu4iqPI3HEHIkDL/vt3qB2YC+++5vlXkiXAG7ywpy/C0oJ2Ud35q3S82EKq6
 BxSby7VfFiG1KGmkdKFpaCVfrj1+AoHCyBU/5t+AeC8pC1JtEOCMG60OfaOi9RSrhebBDoBTd34
 Qg3IXLEhS58q+F9Q5hO+E1TfTjkBsz3/E+ve3oNHgVlikcPm2utbLNXq110i5QfIw50W8Fe7HC4
 it2mp59wI4mI+rQ1bfr4iFbQYZ4NTZiARKogQEcV/3vDq2xRlmP/WHwDF58/3vdSLCGLB/8Pa8T
 47iggpN50angGzbBCMb/MxA046DjoWqoi+w4z2u9BTTBT8ttSKWG4gzuUVMPw5gFzKJc6+gUQ6D
 4jpnYKKksl7Mds3hzOnN/6WFsfpk2vWz6xIFYi5AaCXzpatHvxT7XzdppMvgCVx9GOKQlMWJtZ0
 M2jpLXNIu9Vx6xaSt6e0KK9mNU0uWDBNXpbbn6oG2AruS/1JX8pkUpcH00JERvou+DkfoFi9++C
 ZD6WjcSRKHhvGGqekWd2BTc16JP5xpgcxG5zcKtyzrPsjw8xCXXm8abYADg4kdHfn7e6I8w3vks
 tCJFFpuQBeBhJtkzokX4t8i1Q9IrcMTU+td8p3Z+BOJZTrtSRfCLXtNGgfet4e5mHoEPMJNWrhP
 NyD9/odYpbCrrGA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert do_rawv6_getsockopt to the new sockopt_t model, mirroring what
we have in ipv4. The overall goal is to move these callbacks gradually
from __user points to use sockopt_t, and this part touches
do_rawv6_getsockopt.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/raw.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 99eec36796fb9..1f15942d14163 100644
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
@@ -1082,9 +1080,8 @@ static int do_rawv6_getsockopt(struct sock *sk, int optname,
 
 	len = min_t(unsigned int, sizeof(int), len);
 
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

