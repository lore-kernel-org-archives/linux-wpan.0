Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02042378B;
	Thu, 16 Jul 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206941; cv=none; b=CGtFZJvGWBFdawGhJVLcSA7xoBX8BnjZCQKLLeLCCiTRB4eUpwoyPikbUeF7RBx9ETzGJWKox4xK6IQ6fGrX4eQWA4cEBQH/iMRl5tXGjq9dOwxzV8D3x64qc80esxe9OwkqfZtehJynJTI7Z9UfpIDhbSGuNmX71oG/FSgAV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206941; c=relaxed/simple;
	bh=wWFaQ5ynwu1/IC8Glfj8Bzym8FfGbDbR0VDBbfDT7PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abMvroGs7C/wpKa8W74IjrKSH/83SHV5GefXHjzzUq7VwG+/y5ViQRJfmxFwbxpbHPNCckgwruXa64l3gTbpbblssIPpUCb8xSQisCJBdSBK2Zsu4bOATv4EbolhDVfmv4AGR+vJoJ64IBu03tFBaq+hfR8Kk98RwF6QJIFK1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HOQHS6zB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HOQHS6zB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=H/2DZukIeT/kuRVW9vKE8nHigf4+6Pq0DhLaCLSGQWg=; b=HOQHS6zB4MunfVz1SoYvNMpzOW
	z0giAQLnDjrDDeB5FpCClnz6CoOm+6jlKNDgi2S/QkvIQWwax11KViEXCJccaf70GfCPQViRYRbey
	6g1kpNZI9wRc4wdvFqJnI39fJIac3e1+U/ecCZ3XGeJpHf9KkW18cuC8zMDd66KFc341oVJPaJ1AX
	bGi0FyJYgHn1oLYwWW7vtMDslq7oevW/4dZ7wvnOtYeHwRCLsjD/xGjDAZFZrf9SnlIvvOLSp5TMA
	bjw035Us/C/H6XLhuVgnWr8nqQzjAenAji/mncLFgqU2/uhrOQCVmFIK1sWZ/fkdJATIU8Jf0g/b2
	lgvQRWaQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLjD-003q7e-1s;
	Thu, 16 Jul 2026 13:02:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:04 -0700
Subject: [PATCH net-next 6/7] tls: convert getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-6-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6300; i=leitao@debian.org;
 h=from:subject:message-id; bh=wWFaQ5ynwu1/IC8Glfj8Bzym8FfGbDbR0VDBbfDT7PA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0FXvwy1vHQxKxe7gS0lUPxzmRwwCdZ+YdE
 uAMYmsp9y2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bb3tD/0caCuioM471j3ExUXC9alXCrgOqh3Edx3jpLf3IFainBZs3k0u/ptJ4LZJTygoVt48TDz
 54hFojPsVK30cg1MnhGt5Hj4IgJfNhSaaIKdmTmlWhxojyuK3zl6zSjPvdEPFzxAKFtanorHdCx
 NBFw10+WiTEu8oaTk8NKKLnWxltciKvgxRQVqcYabnNHpmLO/Ai8gaEneTzMOyt2PS0ydu/DMfo
 IvzRQTK3kIbLUAb4AmFJhhxhA/Dff/iThr4uvAFQpNsm40zJ9dDQkafPcS0C7EP55jF2KIHp2vy
 wMBJ+cit0NARxi3naG4hycHPdIApmHrhGO2MNyIQtMRLtit0YVLpxQTPUZIQXorBSCySQmnPV0r
 QPRC50C1dF3yGVOISL+GDwL3EJv7kVixkSaNH1F+CcwfW6glibF+weodjZS5rRhepqJhrmTab6V
 MmXX+UspRwD1heeHVqlKIdq2xfi7SuyDUj8nja/HP2urXUkRInAMMDgn2vnIDFBx6/jy3g+6gBH
 YsDOdb0oyJXxoqDCvnq38ZLsHP560lqHbkDj2D1KuyWWYZbiLZO+cIhI8I/KqMch64OSwFx9o5m
 d8hkHHqlscqmAfEyYPYww24VoBiKO4Z3IBSXNhJmC4cHQfR42dOLqRRTq4ZdXzxrijpnxVCJ8G+
 AW7uww1JQWqMrSA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, converting do_tls_getsockopt() and its per-option helpers to
take a sockopt_t.

The thin tls_getsockopt() wrapper keeps its __user signature for now: it
builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
and writes the returned length back to optlen. The helpers use
copy_to_iter() instead of copy_to_user(); the NULL optval check in the
TLS_TX/TLS_RX path is preserved by testing the iterator user buffer.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/tls/tls_main.c | 80 ++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8c588cdab733d..fbb274287aa5f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -424,20 +424,16 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
-				  int __user *optlen, int tx)
+static int do_tls_getsockopt_conf(struct sock *sk, sockopt_t *opt, int tx)
 {
 	int rc = 0;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_context *ctx = tls_get_ctx(sk);
 	struct tls_crypto_info *crypto_info;
 	struct cipher_context *cctx;
-	int len;
+	int len = opt->optlen;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	if (!optval || (len < sizeof(*crypto_info))) {
+	if (!opt->iter_out.ubuf || len < sizeof(*crypto_info)) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -462,7 +458,8 @@ static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
 	}
 
 	if (len == sizeof(*crypto_info)) {
-		if (copy_to_user(optval, crypto_info, sizeof(*crypto_info)))
+		if (copy_to_iter(crypto_info, sizeof(*crypto_info),
+				 &opt->iter_out) != sizeof(*crypto_info))
 			rc = -EFAULT;
 		goto out;
 	}
@@ -478,44 +475,38 @@ static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
 	memcpy(crypto_info_rec_seq(crypto_info, cipher_desc),
 	       cctx->rec_seq, cipher_desc->rec_seq);
 
-	if (copy_to_user(optval, crypto_info, cipher_desc->crypto_info))
+	if (copy_to_iter(crypto_info, cipher_desc->crypto_info,
+			 &opt->iter_out) != cipher_desc->crypto_info)
 		rc = -EFAULT;
 
 out:
 	return rc;
 }
 
-static int do_tls_getsockopt_tx_zc(struct sock *sk, char __user *optval,
-				   int __user *optlen)
+static int do_tls_getsockopt_tx_zc(struct sock *sk, sockopt_t *opt)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 	unsigned int value;
-	int len;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
+	int len = opt->optlen;
 
 	if (len != sizeof(value))
 		return -EINVAL;
 
 	value = ctx->zerocopy_sendfile;
-	if (copy_to_user(optval, &value, sizeof(value)))
+	if (copy_to_iter(&value, sizeof(value), &opt->iter_out) != sizeof(value))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
-				    int __user *optlen)
+static int do_tls_getsockopt_no_pad(struct sock *sk, sockopt_t *opt)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
-	int value, len;
+	int value, len = opt->optlen;
 
 	if (ctx->prot_info.version != TLS_1_3_VERSION)
 		return -EINVAL;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
 	if (len < sizeof(value))
 		return -EINVAL;
 
@@ -525,38 +516,31 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	if (value < 0)
 		return value;
 
-	if (put_user(sizeof(value), optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &value, sizeof(value)))
+	opt->optlen = sizeof(value);
+	if (copy_to_iter(&value, sizeof(value), &opt->iter_out) != sizeof(value))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval,
-					    int __user *optlen)
+static int do_tls_getsockopt_tx_payload_len(struct sock *sk, sockopt_t *opt)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 	u16 payload_len = ctx->tx_max_payload_len;
-	int len;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
+	int len = opt->optlen;
 
 	if (len < sizeof(payload_len))
 		return -EINVAL;
 
-	if (put_user(sizeof(payload_len), optlen))
-		return -EFAULT;
-
-	if (copy_to_user(optval, &payload_len, sizeof(payload_len)))
+	opt->optlen = sizeof(payload_len);
+	if (copy_to_iter(&payload_len, sizeof(payload_len),
+			 &opt->iter_out) != sizeof(payload_len))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int do_tls_getsockopt(struct sock *sk, int optname,
-			     char __user *optval, int __user *optlen)
+static int do_tls_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	int rc = 0;
 
@@ -565,17 +549,16 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	switch (optname) {
 	case TLS_TX:
 	case TLS_RX:
-		rc = do_tls_getsockopt_conf(sk, optval, optlen,
-					    optname == TLS_TX);
+		rc = do_tls_getsockopt_conf(sk, opt, optname == TLS_TX);
 		break;
 	case TLS_TX_ZEROCOPY_RO:
-		rc = do_tls_getsockopt_tx_zc(sk, optval, optlen);
+		rc = do_tls_getsockopt_tx_zc(sk, opt);
 		break;
 	case TLS_RX_EXPECT_NO_PAD:
-		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
+		rc = do_tls_getsockopt_no_pad(sk, opt);
 		break;
 	case TLS_TX_MAX_PAYLOAD_LEN:
-		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
+		rc = do_tls_getsockopt_tx_payload_len(sk, opt);
 		break;
 	default:
 		rc = -ENOPROTOOPT;
@@ -591,12 +574,25 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
+	sockopt_t opt;
+	int err;
 
 	if (level != SOL_TLS)
 		return ctx->sk_proto->getsockopt(sk, level,
 						 optname, optval, optlen);
 
-	return do_tls_getsockopt(sk, optname, optval, optlen);
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_tls_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int validate_crypto_info(const struct tls_crypto_info *crypto_info,

-- 
2.53.0-Meta

