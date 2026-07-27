Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628993ED5A1;
	Mon, 27 Jul 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146857; cv=none; b=sWvMb9fvqeUrL8IVmC/02ivTmWYNqfd/j1GvK2fv6XYB9PcMFQQ0rqjY3JSZ50tNzg9CLicyo6RY6t6y+KK88RPoe6p+czTJAATIyBDBQnVnQWjWBNZvYNf2ekrsDpvoc3YcDxJtfxNEN+ERqA9NcezxP2cT2L1Mq1UjPZY9hS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146857; c=relaxed/simple;
	bh=8/TAFTVD/Dcp8VGcpBB2xzCrOir05GUZG+QVQU4lnxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+NDZsQihTSJGcKuEP9AxwOIKzPGfoaNDHtl0NOE4tr/+Opx6+BpreFArilIaS2e7Re35wlbgQhloMD3axtEBW5rdzQh0biKs2mJKOqT4DsV2Gfgt61+IqKlOts7uCGNmpZL3yqP8SZhlybGMh0ZIBV9JBUJFiqSHaCSR9P1Ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OKGE69xo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OKGE69xo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pPoImAIZf0kFZ9foeNXPZS1rdW6j+IcLxqfAhB9z2mg=; b=OKGE69xoLfdb2oWcmJgsVDSlN1
	k+ClPSdbn0xnyMkF1+DEYBqETUbWiuoQ7IBFYv6MKq7QDXP/ZI0b5HYHYjpGqazaBoq1JqVu8kNQ9
	m1b0omn0z/XE4zmxZj+1qWLE/y2zBOIdxRlJ+fLSTFUO2qg7rAppy7dt5rb9xJ9DvguYtAv0jKzGM
	F23kzOwcU0VytyySB0RL/xhvVvwFaZEPkOqP1QpHOYZU5YjGyRJX2OI0EOQGyIMQ0/kcQn1PoayGx
	HxO0t9DmDDUJDJR7E7WkGmi/xHJEPAv0vn8frdKcLfsM6EMNc18cExA0U6PVvA64iCeiKdsUtQv2M
	1CKA5+EQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIFB-006oua-15;
	Mon, 27 Jul 2026 10:07:33 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:40 -0700
Subject: [PATCH net-next v3 6/7] tls: convert getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-getsockopt_phase4-v3-6-e89627544639@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6390; i=leitao@debian.org;
 h=from:subject:message-id; bh=8/TAFTVD/Dcp8VGcpBB2xzCrOir05GUZG+QVQU4lnxw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy23RGT3zkZ+6be2D9l4ARmXk3maKybUKxGqI
 65nWB/YscWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttwAKCRA1o5Of/Hh3
 bRztEACqA9MdZhxb9K044o80Qx4XqOz6EZ/XrL4Pr7xTk62Uk1EoUQetZ4qxY6yI3Nrahqzwc25
 sOdE6TfBJ76YGT6ZF4ZajblIV0anvhsecov0Ho4kyLScnIVShVYeiQtRnAlfzHlJp29rTd0QMpL
 VJ1xeR241De4o2eCJKxlHqI0k9bGS81ye6W6Q3yI3dZRZ8Mrjwop2rx01NjQZVl5nz3zLvf3uRH
 gqNM8EjWAzYshvStCsIrX2vQb0rmSiMmtPfNzgZ6GptB3XaQx5gg7detGT2BJKfh1dnFbfNygRx
 IdnkSEZkWVGVfFdBEr0BzR/Zwr8guyVFEETHMmIjayuEFqX4XRghZMlJ2FG35Hx7SqPR76gQw1A
 l/+OHEHP/AB1E1ZQzVVTZuL8XnlIv+j63qpuxe5mZ22JzgWaLw+S4QHTSs7L0C5H4VGwuqKio4B
 54E3ZmOj1ekO5H3HKvPylmL3lKpfnQrAOpMyDzajVxvGJqTU7lizx9I90BYBeeFErbwDh05ceNb
 XIy19alCNKrzFEMNHKFtI4MleYVZKiZgUCP2EkbqvzYeak619L6eHxRYg7AMh6vSbUhNr8dYVjY
 Jm338k/NT/Th4g1NUtMCCkvWEwuVQu0c0wgapEmhGMbTvMMzDXoLXbsjeAjD6y/8J/5+3f6Kltq
 DT3Fz0UWVTVJOJw==
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

