Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E043CEF5;
	Mon, 20 Jul 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564611; cv=none; b=kiJJRrPEU2AQpJ6LfR0bdTpqaj791JX1dPgOgcyAlaYV6OmI+NGJlQeZYof5QlVesPMXstj1LLgKKHQmj8ya9DmPI7U71D5cRp/PM+m5oEJoYdm1kX7v2j8SSDhc4isNMs9KHvUGntSBVhRFL1NRc24BcQA9FsNYHrZN8W/ZCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564611; c=relaxed/simple;
	bh=c5PglPwUQC5mxsBdp2RPxVvoUHdq1cPtE8naNu9cnIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQWFUTlCm62fRc5ObrwxkD3EJGfi0MzOH86XqmcRcJW9Xc1m/mO+rXTbebddKnjnHgbOZf1StxIzrcwp0UYglkbt7wKDqnV+/KZisnRRA1UXCcG3LRZkueGmHyWH0wj7SbHUnAlv0mnlmunfBfozTnPYRydxH5JOoQ85/W+gsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D1IZ61kp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D1IZ61kp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=XC51hEuGBD77AWqPRk8uGjYTB9yK3f3l1kdf5Rac8+0=; b=D1IZ61kpYVggCfa9oeH2cEpUVm
	8s+JryBkmlj1FZZLVJ40VQAX+xHFDiwVw1CNJihyJqeKRv47ox/PAVtcVNJ2gre0bPq9ehV24hJXG
	FZ3124Su49Yj2QQs6FmlCoytb5BHWJBDOSHBd+ZwXMssE/kJyr1RsI62cxnxzEjojhhnhDy0JnGWj
	liHHEX9TGo4eEx5OManUnJZParjdIDfJpHZWmk1Gjx2zpBGQSxSCP/MQ7vLnBLuXrGaNe0017WuFl
	b3OW4m0hcK8tGkHv0VRzcwOPtMo6yvCvvU+thVVM6gAJiuKklU4XRCXQRL3dezEvC8jbER7PShNnf
	cX4Dc1jg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqm5-001YwC-0C;
	Mon, 20 Jul 2026 16:23:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:42 -0700
Subject: [PATCH net-next v2 1/7] ipv6: raw: drop unused level argument from
 do_rawv6_getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-getsockopt_phase4-v2-1-8a08fcfa0d72@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=leitao@debian.org;
 h=from:subject:message-id; bh=c5PglPwUQC5mxsBdp2RPxVvoUHdq1cPtE8naNu9cnIA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktx5EqWpml6AIsP2IxWtrO17EGeUi8TRC0wS
 ekTiUtnh5SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcQAKCRA1o5Of/Hh3
 bbdUD/96o9fCnaJd5Xu3TR/ViCiXKEQHCL7lEj9f0Y7t7/veawT01/H9wT3Lg6wJmFjxB3hUUYD
 Ea2rdioZ3+XCrmPoblzPNj4x8hhZjuAQew9qaR8HSYmFLva438mavwPELJfB1p48hGqOZseE/7n
 fPymhtFfw/+58OfzzJT8o2pbru5Q6OYdn5el1V1a+vaVZ+vCj1c9F27aEuHmwZ61WlDsYrW7r+J
 a0wkCU92bBDRwfJY3gRWtbRxTsWrg/oQ1TDTD9+/f/QVEnc2NCvNsIOM930DMIsON7zhFkhlD8F
 EZ2rUZnm1AkcaL8zfuuLi91K5DZCNdYgjrCK59QveiiHcCiVu9iutzH3Ze/FoYOUqO95JUJRNFy
 5/+hU7AzrNNXqpADm/b4j4GpvMlfJGV0nc/lEaTpCMrvBIvUjC2OQN+Jlou40XiuKOoLeV3Ssf6
 xBlQw7a8jbmS40UyBOhZsnDxjbhhFRrY666z9uRyDk4kVowUxyoyNeSOHGYAF0Iy7h6WIA6VM1x
 yfZaJqxVcSO5xsOvZZIW+19Lbsi4xr1AyFt0Pdq5VKT+GIpg1LdmeiM1Tp7ZA8V4FxE7eLBgAX+
 vCoievxojRGu9o8Ujm/IxkoNj5HfKT/Znk/bkmDGtsvJE/qYnk/b1pWiemrOjl3wC9nLo56DzaR
 /uBWb7gXDES29YQ==
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

