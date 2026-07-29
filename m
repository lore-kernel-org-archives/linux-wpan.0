Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883B416866;
	Wed, 29 Jul 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317501; cv=none; b=SfrLNe5KSQywyY/SGErFPNd52sBYCo+GVZ3RokIEYd0rchnPRGWuhp9XRPO+1bNddyaxWmZWBqMZBGz4zXiVfv5Yjt8hjch5Za7Gv76CLGJ6kZAg4c2+cZMH0QCFwhbgkU8dPHt7ESY2ufnC5sBbSpaj1fFuhL5Vv8yNOije0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317501; c=relaxed/simple;
	bh=gKuNfxTODiZw8CrrIDbE39oXFzOMjspsI1c0G3Ajc6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZ9h051Qt9owfi9En7qzT6LZnLgjDtApoJw7EGvO4K+i8GXBtW3WSBQQKEvFh5adOr6iJnlVfPCLQdUBQ4Pq95b7A6ms3873tJcDXOT8idW5/3XtOH7sLIiV8DpEUjTtGGrEgxkD6JNlX5vk13NEDIqNn9ZOL43OxM893kXIJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AKM2zqtA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AKM2zqtA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=mJjQvVWZZYwHOqSv0irzno4Dwl9tdM8w0Bstsr0Lza0=; b=AKM2zqtAie+DjcDoGdgBkO8dKJ
	r/yZDmxEeMAwrb+BVcz4SkIcJDIXw8d9njzygTqDTn21HNDYmqDhFhYBI4QkVO9sHzMijBkPkkps3
	nld3hehyGfSnTPXsHrvTziOV37L5bxyo+4bkTbA1+gqyvc3JaakEffXioXzS9hWG8tLUe3BLcZ5go
	EPUBoIvud0rpNrw5XYh9Z8rv0DQhwBZpXJ1x5sWfo26QI7Ok7RWJgp2SaQ4CPTmmu6lgrNN3FQzO9
	dAwTYE5x2lWIwgc9JN+afvKs5OKWzoOlzDT1YQ58cuQOPfPIQM/ciGy9yl7NgH6YC6B+p8BcAv2mM
	SgVoRiDQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0dO-008M0g-3C;
	Wed, 29 Jul 2026 09:31:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:49 -0700
Subject: [PATCH net-next v4 6/7] tls: convert getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-getsockopt_phase4-v4-6-c44576757c17@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6438; i=leitao@debian.org;
 h=from:subject:message-id; bh=gKuNfxTODiZw8CrrIDbE39oXFzOMjspsI1c0G3Ajc6A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLd2oXaOJNHNYxL2nhGodua0Dm7h+rAEe8Q
 BmUahu62ACJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bYQID/9w09pbv4qvsr7QEjnMrO83rfWq1jBSZj8XRWV6xu7z74ft/3ugE/2d6MAJMR5hsj6XV2s
 DkZRyj1AUsu7Vge54pj3mJ6GAmbN3NKjbhURZIVm6pYWXMN91QaXTBcIkc+a2KJcfym3RNdw2sv
 clCg97JAKqAhw455EMq94CNjOZqB0vMD3uzB58clZmKGxMBMl9A9LV0voRPcsLlh96LYc7EQnkd
 65qnpKKlsPG4WpaZV46yk+Mcu33splZqMwhNf4qF+voNDIR+nUqmSGiLH0db1utT2ulEA9p2WGV
 STkkCbNKHKf8SisjZbXyn4orRi1e7I4bd+5WJIagKUorq7GmIrJQcYeM9bKWrQYnz5Gv5xDjEAw
 ce4Ew3Aq5IcsEOF/VN1Td7NUYBmAnmdz9dOowH3Aec7MekXMiqjpMYGHsO0ceRbYSLDSTknQtlc
 qeVuIeqNsvNGtxbteAxqek9UlIRPIzMSk+M4hJt+vkdIM4q3F6TBKNoryMrrPVZaXZ9ITixUz4Q
 gv1m4BmhoPALCaGAeFGUQb4ZlBwMFT1HlN90RN9dxFp5nCTLKPTx9Blp6FSk0fdnzE26PZESbwl
 kf4+I5yJG+YbyYkw9lgQFTttZqPt+mONuRY4/QGXzzHziQ3Ktgn8MThufIUrpNSDIlGZjK5lscS
 MtwmUAyaiOg8t6g==
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

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

