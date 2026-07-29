Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D767418A35;
	Wed, 29 Jul 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317486; cv=none; b=XffvcJR52NTu5xsqR2NPzhlJwdu2PR+HUX/t1lyuGhcOSiccfDe5EHcUv+YPQvyOacuCJDPZTF7Lx1rKAdMkYVtSbODUPOL5WYwnz9zUBIkYR+l2Od+3DGhIw1HMp+JK/2DP1CRqhsTCXd/IkedBLfmFT7QcaNHfoS+uDZi+nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317486; c=relaxed/simple;
	bh=bvI362d0FQA5pkvkZQTRGcodSqB59gqelOJHahLA1cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3AuMSPcwj0HWQ1hYitOKZWa22tR9B/0I70+M7AxVGzVzHUHyu3OFN0fhnmZUPDevuCvyss9+bcgxkTzYMHq5sjBrs8386DaA/auD2J6JXI7Wj8mwliQsmQOyHkMNwwqRpziRpN0TOYwSmGYEVA6cPtvtandquHFgVDKkzXqTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EwfeBvrN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EwfeBvrN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QqsXrc46KBhZndi+EgD9mRn3mNTmgW1IO17qgD6b+pk=; b=EwfeBvrNdNP9C3pfNPkCljCTe4
	hGQXM3Ur8uNGnKjHAQw0CmZrnsN869yaGrh1u1owMaP5V+nj5ilxtu/RxcdZtTui8+cKBrkRDtUOA
	tQlF4lofU6suQuc0u4xQu7Ir1nyGbQ13MEM7hLO7VBO7+A3GE5ThV/4NxzCt4rv+qnY0sOUfpERLD
	lil6NVYVJMCT0ywOhVGoPrrz5AC5glsgkgbJTwTl/2tVXyYfbsnuEoeTrLq8VlTuIMGk164Pw/J1m
	eBEsF1ziRubgLlfFLoaAqsacWMC8Y0nRdP3KRTEeUOfzVRHYza6Oy7H3PgG9V9ty4DvbC8GywbKWu
	EqWCJCRQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0cy-008LzJ-11;
	Wed, 29 Jul 2026 09:31:04 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:44 -0700
Subject: [PATCH net-next v4 1/7] ipv6: raw: drop unused level argument from
 do_rawv6_getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-getsockopt_phase4-v4-1-c44576757c17@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=leitao@debian.org;
 h=from:subject:message-id; bh=bvI362d0FQA5pkvkZQTRGcodSqB59gqelOJHahLA1cU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLKJlOBaa4xf631FrmuVfI8wb8IrzxKukp6
 b8LZ0Zmsc+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bbz8D/9vJngcMgJI/ec0D7oME/X9IIX798HIcXKF2QR+l+VEfwRdjwS80WheRtrn4Dg3LESGYEm
 e4gsmBaJumEyDR4BP1Y9p7kI+BoMHk4wkMQSD4ZLaX0D89ptgxDugvyFh2qz/otMAX9uqQFgLMQ
 tbWV5l5wS9iQT7/YyKjAnYMtgTbnZbkQZB71vf9BKzle6uPIylt+dOMSMO90z5m3vFi7sTFjiZk
 kLQOxNbNgVrNAuyvHtzyW7IKDIyYmUfh21tMqqJhisDaWLOZs/eXB7hPEzjt1FhhhvihOGPMtEL
 vbGXaXWStKEtKn7aUDQyr6T05Z1Sl80vDqo9Is0y2JwcMXzORCzK/RDo0hNieWpDfE5Sbp6ODDW
 PxFQldghkIxNcwfaFFcC6SvIIKvjA48UKowggnxLe1m3sHHSKHfOZxIpoqorhWTISDawfYLou99
 zIkQg7QTNBJwSVtVL23XYevvpdMTr/TBCDVq+6UaLrzBmP9Zfr7xW0F33SoqJ5pMtzQfnhN14GV
 /H0yvYPTeETVDk5FnKlA9KjfyG+28P7FE5wMlnoeFKBWRR4TS9AsboLBLS7Z3pqbYAcCap+ObFw
 V1K00d0ld+m45m8sUhQFkOQxmZ4F+HD3AY16r4veatXds59WBOP3vGOdVI9ufEXSwPL8Z3E8tKq
 CksJ8mqzw6LCQlw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_rawv6_getsockopt() takes a level argument but never uses it; the
level dispatch is handled by the caller, rawv6_getsockopt(). Drop it,
matching ipv4's do_raw_getsockopt().

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

