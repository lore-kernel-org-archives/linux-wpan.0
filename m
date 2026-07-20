Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24660443ABC;
	Mon, 20 Jul 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564636; cv=none; b=Nm90vEMr+oS435OkPYMnixool+8fRM+kpBwNEA6zBMxB0AIb867Oo8LbTiVlxlIEWWyvZY52DWhO1bt3jrDpGJ6qxq180pHnttssj9x2YxojwJP6kEVMAFpvVB2yqIno2+4vr/k/w6YN5ALRImWypxUrMNRfNBjI7QEWjPxsX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564636; c=relaxed/simple;
	bh=wWFaQ5ynwu1/IC8Glfj8Bzym8FfGbDbR0VDBbfDT7PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uI/jbnb6yPF67VJfd4wQ9NPWI1b9GWGz3HO7UkAIvUAsHNQJo/Y+B+jzy48YuEmH//ODfRUCkJ/v4wndtMQ+MyGoLdkCW6VK0t9ndQa6O5IhGhFE+3fW835c6ApNJr07uRzbruOU4Ss54ZLq21sSOc5c/aRM/Q2K1MVUu9nXZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Mdvxyc4s; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Mdvxyc4s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=H/2DZukIeT/kuRVW9vKE8nHigf4+6Pq0DhLaCLSGQWg=; b=Mdvxyc4s+KSW7B2cgVSArcvydu
	meJT5K7R7eUYo3g5PgGFmLiL4sl9bWLe/BljRa6T69VDTvGxKGg3d0ZD990UFp8tXCK01uaKvXl02
	+LpHOKocOV4d46V3Na3ibOCQu1zc+NfMaL87IKYln1nkUWR7p7cmJl6cbILzXS3fAEmzrgu/O908u
	H3CylxEUJMa1P3686Wu6knc5rNkypFPQuJ5WNivp+g0hroI7/NqvajHNJMB/IFlpyNY15PwZQtyTu
	SzvvysCyKw/N9DOcG8gUPQB+JJFO9Akiw4J4NTxxP6h80Qlbhyzs2ORj8f9WqlJEjNU4YiXWQrKHI
	AxXcfqFA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqmT-001YzX-27;
	Mon, 20 Jul 2026 16:23:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:47 -0700
Subject: [PATCH net-next v2 6/7] tls: convert getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-getsockopt_phase4-v2-6-8a08fcfa0d72@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6300; i=leitao@debian.org;
 h=from:subject:message-id; bh=wWFaQ5ynwu1/IC8Glfj8Bzym8FfGbDbR0VDBbfDT7PA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktyWYttCgzgMWrt3KMdASejTcl/Vpa5/Ce7q
 nclpz8sejWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcgAKCRA1o5Of/Hh3
 bW01D/9G8tOQgSZdsTJjymcHuceYd2UxzuZoBpt65/1mpsU2Q15R0SVuwn/MyutQkXdkA0soxfX
 3OpsuRh4bNjB0E3Y9BUiReSLZrgR7mMrOLcVC3eU+pPjxAJvBBprUYoHiQmbjvwh32JUdA/3Ru0
 mk71VPmud76OWP9thbQdQEQ3U6tZ/Y37BpK3JeJuBNWEZOyJBSM8bSA05ooQqkrmoqnKygZBiV2
 eEzCwOGqARiF+mXBKUfD8lxJdo3CP/FnI2C2dNRFRbsFVaCza46Dx305mqrCeT017e/RR/Q92o0
 AZZ0Ktaj48xdnCfCLhKoyX0Rc1AGV/kxtP47iQHfJ4N/ppuAC2KDYcxI7teg1bgeQqR3vuFuV/m
 vVtWv0k1RSAFU2l/4IAtNSRFSERLjprbnnxBTp7iUkoMi5zD+gxMxUKIkimcgq4abuBSLZj9PAW
 NzO2jpz6ZX0CequX7gJ+Jmd1hQPdP+PlMHrG8Sf0og3vpAwzIUtzPWPeFV6Zd67btcls69i7cr+
 9Ub+Qgc8w+3KVMbP87LPf31e940ezqw/JC5D0n8G8vrinfL6Sz0cRXQAxms4tsJ2E3DmsAXMwVP
 Mn8AIpbdMU8pgoqjiM0mbfzQj5KZBXTg6r0BOTJ04SwBSU6gOcNvEaZcBO6D1/vDW+ZrWbV8Y/N
 BVzGJBsXLgylu5w==
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

