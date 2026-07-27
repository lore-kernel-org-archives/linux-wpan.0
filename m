Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356553EFFCE;
	Mon, 27 Jul 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146835; cv=none; b=Ioz56z6EDO/CWn88yl13CAmasaT0y4mlHQiX8b60hM5wrnHBblG+iobSCRmee2bSrRSblA3CvUVqRbOpquLbO40JVH54+RkkM9ksBC1Tv2bBhqUvEZhFRnh2RN5t8y9Eh6Dx/ZEC/g/dtkkcufgHMmBPYYKmBZ6kLSlQGISHo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146835; c=relaxed/simple;
	bh=kTU4l61U6cDK79Js9atUgIN3WP/HE64FgHF/Wo3u/8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rk8zi2n/GOXitxuZkWY0h1T8cUq8XGXz1deNgA48xiGT1bbea0P20pT+aZXvCbk7Ze4WBPiO5h8p08RaA1r3J7I7ky2p4quI5W+g/XdXn/ptZeASymuMLQNhBUt+oPjJEA1/go4FXy5oUHn1DeBInK8FMcb/4oKx11T86H14czE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EK+vZvFW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EK+vZvFW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=9hQ8W3BF/zJVCv0Ft5NUV9uMBWRqBCXw3cGASht3xQI=; b=EK+vZvFWAnh6n0hDgjCLqCB5uM
	z3pAps5SzAmCwBVnJ9G4EW9WGCeKWSGoPMtXBSbNNPEHgjhhtr8HxA2qii/VRn8m8PYrqi5SAmGaw
	X/CGcYRMNMi260x81uk1lbAKsqwIB5R6FguFa6hKJ69dODJvQrsorFVoTnBwkZliUL8+ype3D1jUy
	ldzFLjeE0ejQhRE5uFr8azC9wfxuJR51D5+jDuY5NARG0hlUYnkArw0b1AFIUahwQf4hmSeWzou7J
	qBm69tFKslRgsQos381pG/YnQEd9LmkL+PGNqjrNTJQuwD5bacm7FZmTM+GLr7IR1LBolle94iwVo
	KqjS/2xg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIEq-006osx-0l;
	Mon, 27 Jul 2026 10:07:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:36 -0700
Subject: [PATCH net-next v3 2/7] ipv6: raw: convert do_rawv6_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-getsockopt_phase4-v3-2-e89627544639@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=leitao@debian.org;
 h=from:subject:message-id; bh=kTU4l61U6cDK79Js9atUgIN3WP/HE64FgHF/Wo3u/8U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy22c2rM6AiDoF6FtfIKprjSxg6PvdR6LbzHO
 SJF0RjCArSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttgAKCRA1o5Of/Hh3
 bV4ZEACdMgXMqvBbD6NT+VTAdq6RUkAkvPpE9O6d6h2duUhAuwnH3fK//MFYHJXJRTNxR/fR2nM
 OKTbHadpFLrlMnbtGpkNn4wi/792vTjtvtSZRGL0Jh4DAtWbVfr7t/6wr33Dh6trXGcP0oDIBfn
 kVsxGG18KOu3LYp428trlQ5kpl5f/zq1xuVWUNOt+mRtdC3WZlc3vTBfJajHNDMkO20H11WiS3u
 xO25gjh1L1PnR+KcWxsIv9w1DCigvBtSnzxjAb2h7QdayMBxMMtdvYkBljh1Z5VsNXU50Bm5nRY
 gJIIKGl3btrnCZO1BbMxNA6nKzNKtPJjzqMN0f3NhRm1inV9geLO2wBOYpjVIyDPIsTK/ADuroS
 maFyb6lnEQbIVCJbbour7OTfosJwAi5C8ColNQCopPylOrxaF9hG22o3P08gS/oTujN5gGm9J3J
 mVyXhPX+WatYAK2TafJ4CGIkUehJCB07PtOqd4vCbgYCP5JUXQolB5n+V0eKWKcFSs2p1fgLr3r
 Syp8UaeUtusnfq0zc/H798Mr6MUtyLPWEBcm9L6fMXBWVJC1DuBaKXtx5ONZTKaYWhUX9ws3s25
 AsVO/IevOFM6hAs5sJdsMd0VubgUxyTAc0QdqE2NvMW+QBmi9zO//npn16VGtK18n1PCkMeYF/4
 5zHa/ftvv6AeLDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert do_rawv6_getsockopt to the new sockopt_t model, mirroring what
we have in ipv4. The overall goal is to move these callbacks gradually
from __user points to use sockopt_t, and this part touches
do_rawv6_getsockopt.

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
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

