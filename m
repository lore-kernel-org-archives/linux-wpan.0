Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094B4218B7;
	Thu, 16 Jul 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206921; cv=none; b=G/OYJTi7vAUb2m8kj43lq88xmjFeHpASufFzy2Lq5gc3c06Jih0fvUbTFhkOrJrQpfpw2vgz6uKu1hcuqamm7MqGPbnlzqB8DbUbTJmXMSHOq4Z7lS1AX9T3LZTcJclYrW770ABzkrtG+qDUyQ/xmrnyqdusQnIUNum4GXcmKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206921; c=relaxed/simple;
	bh=uQw9+P8SQcNospiW32OdIyj9mAmuKVQRv/ZlolZJPjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsbwqZnpvJjjiEziskYnkHwgZT1rnIhkmZNLLnKNbESQAHSkG4G6613v9J4t2Prax7fZDAX4leY1MIwLOPBKqGjgN666uDXbP/E22s/SOODH46obyO2bfKE3NDbOZlAamA2n/4kQHmc3foB22Qt4U+VP5WZKD+rceQ6mf8cl4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UFwdLbsE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UFwdLbsE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=p3olImzVCvMhNN+6I0jr7pI95BV7NvZBpFe/CbmtjVI=; b=UFwdLbsExjAVEJpoyhbUk6X0kD
	/sD1JxfYOPlysOCg3Vb63eOrY67/hmMNQpSIJx72tosjVo8t5MtE3BQfOLvhRSXLtv+BUZGSY0+V+
	MSy2hN1Y+S5lb6XKv6on+Vo8Wz+BN5TNGqjSnvc5b1xI84GjB+dk30FImkt1R1g3yVjdVqTxUFLxJ
	mwEeMOXJ1hzRw656p8UyC+SwVS6U9hOHDUrqAm9HxLXp4CnNNS5nAgPLs9et3VZrSS10yq57Bat4w
	i4F1vH5tYCzLK3FSyNl0cW2Zs3CIAVxXnjm3CGxpBXsdNhdA6zPoAthPOq4PrtC7KzUidNErPc0A7
	3QhRQErQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLit-003q6V-0j;
	Thu, 16 Jul 2026 13:01:55 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:00 -0700
Subject: [PATCH net-next 2/7] ipv6: raw: convert do_rawv6_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-2-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=leitao@debian.org;
 h=from:subject:message-id; bh=uQw9+P8SQcNospiW32OdIyj9mAmuKVQRv/ZlolZJPjE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY03APvwX1D7EqMUjHiOoA/gBnHjgZMUrP1U
 jEjneGK6juJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bYpfD/9xnxHPKs5oBP5XLDv7OiS5ujz/eAUjzMPDI6zQSHGiNKjlv8oaslzWZKvK8Isxx4RIMF+
 BgnonQWyV6WZM5VrI/W2X2RpurIOCZoOrlKCCHJO9mo2mG/6DZaXDjcA4hraAUjFhPcLS4t9NS5
 y0S6cu6MCzoBDJbBkQiVGzZeQAi4n5ppuN2koUM99l/WQHCADqO6oR92PoRp+J6nf28QqBs5o+s
 geFAjch0XBmC7EAmeahMSapt0WMsCgUuexKIPBQpT266VnM608BFyEK7LMZP8FVuzUzFf5FTdNh
 H0BBpEfFbiipDM3RTFMI/x4etdmG7s0bEjmKw0XqO9whv6FF5epNl5HYVpkKuPYdd9Cg2qZXNKg
 Z2BvIqiSGjQ1hae48IuoMY2a/V0ZQWB55+YtMnXzeC/9R1BW0N25cqmaYfpz1rGzJnCYBAWN/Qq
 MEqO1ugWpvS//KXHExoEhBRq4N910Iyaa/5acRjtaU4znskPmvnW5v/PGPTVhwrcRJCylMQoliD
 rGhpWSbgC+T+rDtam41jtSoMAOqhJwHqAXnS8YyfuE6Uirrin5hyjOZGZyNliNfL6PZASGCo+xb
 cCs9tyHp+hPnXRPpym9/UNB4kXLqzQ/VbT8WozWDFuI7OGuI2cDo2ZHdbvr90igul9dY/0ve0aw
 Z68P2hQAtbO8O/A==
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

