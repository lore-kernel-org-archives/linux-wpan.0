Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AA353A8A;
	Mon, 27 Jul 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146822; cv=none; b=l1f8/ZZplImeEuKAmEyoHus7yHm9lcge5mu/JkuAh7J+jsVIb+EjoWJ1a7Hd/bwN82M8BLs9AbThEkAKa6SnMDew+x7oPprnFPl3/U6FSn5bLoJUd8ozKATZBJcVYYe4VIleQyKN5lgQhIFMbhKnBA/sxaUWyk2qnu1+7RPXd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146822; c=relaxed/simple;
	bh=MGPc7Kieopi5t8Sq1wn7OeUeaEygyd0WJo9BWtp7zYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlxt1zIkLMwo3brtpOKVmftKCWbFnLeYjICgurMPrcpFT747KXrBbkRvLhGj1aUtxgcvQc3BKyQ05HSCx4CWtBzPRmxAACkBwwqAOu6hc9YWmmWNUcgCYs2Kpefk/LN+EY2oNWLg5Wbm2TJ7iTHK7qdeCugl+ykxZUQBxRMjU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=j2nkAYFi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="j2nkAYFi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=vs9G2J2jgiR/7SDH/A1+sKxixtpBxmS/58zZtUb4ueI=; b=j2nkAYFiOa+6c122ZODMR5c86o
	tLvicr4o5oATbKb9gCrubMxX73cjSTw6znRzaXty3m5REpShVr32sSwM/b8M74Y0Z56faQ+BjYdzT
	RfnY+GfFIqyTBQXZHAqOv4eAz3Kp7XfTe51FFx6EA83UwpRg+xAVmQ/y5H67kOBEHNAEflzPKt2ip
	YeUgNgSE4ExObGR+QzHN+CC4ZdxwnyLsesd18EKVtpirTF/1dSCBbwJX5zJFFaWIddnhIoZ1qbAXC
	v4ipIE2ETTtYUw0YxZEUPd7sjCDv7oxu8vej1Pw2Ws6WIdqrjODnzN2dXYCB9hcemX6iv3Pa/Ostu
	yab2A/TA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIEd-006osF-0Z;
	Mon, 27 Jul 2026 10:06:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:35 -0700
Subject: [PATCH net-next v3 1/7] ipv6: raw: drop unused level argument from
 do_rawv6_getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-getsockopt_phase4-v3-1-e89627544639@debian.org>
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
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=leitao@debian.org;
 h=from:subject:message-id; bh=MGPc7Kieopi5t8Sq1wn7OeUeaEygyd0WJo9BWtp7zYA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy229Df1kjDIh/I3Ue9xB+G9q7rQrDYnIGj6s
 utQc66GgkuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttgAKCRA1o5Of/Hh3
 bavbD/9bK9X/KDfurOPRNmEwv6onGOQoF36N2+q44GV8LGfiCBzom0KVNIZ8UylwZDKzyelEHiz
 nwbx4M5ueEhfmH7NGJ/3e12kdB+pVlQvf4rj6gbV1TtRNy3CA+Q6BwT0+LyriTx9D9B9WGKpDz9
 Imhpvr3Mx43S9rWmMTNNvTAouycmPUStk4Q9uBdr3dfWe7rjel5g4/eFqjn6SicHijoCermpUfZ
 aZzo+W37qU0lxlrzFw0gsKXWfMrB1GTl1JMaWOCP5YYjHlReYyKk9pkiZ66k99LI9zBX/sQpFMm
 /TXZ1FophfElEom1SzBYITPpfy5aXPBGzOKC9DyonndQ2ulrfICyjta+rX/sr4488G2l6BhHNmC
 m4yAUfXsXyHeBZBMOzdO63ZK07aV8P4WoyyIXUBKCLTGl9gn3oDiHSw8xvLS15STtFdVLy+HaHm
 qNJCuWCU1p8wc5Qpt7Fc8dVE8OtbXpaLIYuiIMzNiDmRRZe0WyO7akL6ipZmRthlFnPF44/1mTq
 0R1dAHXbj/4MW+h3lI+7jO6atRNtE/2p68aPMvwY6O+Y1ziREYUmxWog31BK+FHqjvdaYg4jobg
 3EDlrPUMJnNnN20G0uAq4OtOAZ2zlaTdLP//eLwc0xHxWac7dg+DqpntfHVO77QcsA7Dr13Rlv7
 7cDhsqeZXxsTy4w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_rawv6_getsockopt() takes a level argument but never uses it; the
level dispatch is handled by the caller, rawv6_getsockopt(). Drop it,
matching ipv4's do_raw_getsockopt().

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
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

