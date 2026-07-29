Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8713CF694;
	Wed, 29 Jul 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317510; cv=none; b=fgcvu6wuYeTnwBe+USksIoyEwZO8qvVdDathiHrWS5rAhKJ0yAlXl9RZLdrMLRVY1ZXmMk3ysxcGBcIbe+NYDAfKvDCUUlXppR5Wc+2IJv8b4iWVac5JS1RdzkE+jDGgAeKO8QtQK0Gsl9ecUsUkUvrmNDgOE2a4v0BUKjb6pN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317510; c=relaxed/simple;
	bh=56hgW3H1tbE+xlsJdlAitQA9qB3r18TsIS+HpG7WvnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVuvLJ+EU0ZS3OmaBgAlfmFiqCkcYEakkzy1UT9lTOQ3i0JOqhBOlC+hh5NK8DYpJVoyEm9wYWchsAs8cyDIlcw6n6Qb3ddPDep2wAMe7MHy3RUH/q2a+eay0FAEBzQgvyg8Fj8Rc/+d8Nw8hUmpKGW16YtwAzBz8W9LIE+Op0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Y3sHv+T1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Y3sHv+T1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7zntm6j0Otr6as/RZyHmEd7ZkGoSj8qDBoJ+EEcHlDk=; b=Y3sHv+T1wyVvAbqxS3eMzxPxMe
	RTysBeb/DHMdNjGuGQGyOnJ9pgpIzA3AHGG5x1aTiOQokjTiNCTReSvOqffijudsvBZAT/kDN3OOE
	HRPFRD17CvRaETuDM2ZIrFI0q2UxB2uD4CizvkUlKoBfkzQtGkGaQca+GpJMdQTxEzXfIXDnz8cyI
	os3l9BIKXMog1EA06Ui1rwO5PoGyS68IJq6V+Lcjdu6vV66qlNTeAKV5Co6lS5CbzWAwyRP2ONDWY
	xXtHYYTQR+bZMUS1+fcc+BeDmHNktkg8ywHt/LddMumvM/rnLwIWxYXtqLMNm+9MbvDG/L57ONJbr
	RVkzV0ww==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0dU-008M1M-1p;
	Wed, 29 Jul 2026 09:31:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:50 -0700
Subject: [PATCH net-next v4 7/7] selftests: net: getsockopt_iter: cover
 rawv6 and tls
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-getsockopt_phase4-v4-7-c44576757c17@debian.org>
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
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7734; i=leitao@debian.org;
 h=from:subject:message-id; bh=56hgW3H1tbE+xlsJdlAitQA9qB3r18TsIS+HpG7WvnU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLXkJnl88O87bfWhS+SBXnAhantRqWRkuaG
 754NosjO1KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 baiWD/9mGq66JCUVxjA32OXlikL3sh+w370q54qO/alNsXRC501p19dNEVyEmrbolhSYJrYi8TK
 UO9lWvVj8beJUNmDqlyOvDetocBijauIfsGZdq4Ia9E8tzBgQFeIY1WWp99t6M5yxYp6OcBvYby
 kqnPiOgrNYq/Dz8E7GwpuexBWqWoPyg29IBUgBLdDFOJ4Qk14F9rOZYYb7ElGFt7DfOiUTpXV4u
 fYL50+0JvL5sX/S47DtzUKCbaCl8WnmFFY/2ku2AsEhblyldKkzzVlGbZCZ4F9V9ZhxTdLIgS3e
 74Lav+SDDIu/BsCuXTNnAOaXuGfcq+xlWHvCZbCr9ZVY5sw1WyYYetCKFGvQvyYQPK09gZCD9cv
 P1Qu5HbgFztTNQnNdWpWlzoVN3f0tFxO7KxQMWVtA5Ivgx/0Hcm7QVSDjBR6qjMimceLIYiYvrR
 LpUcZC5QCiH3sr51muPSEnYcivtyf2NK9TxdnNmz0yccXNkev08+tpQbP2n7NKQFOenol6BaOZc
 5ed/1YEPMT900nuVhGF9KrR1W7T4qsRBUl90+JjQ5kGMmnc7hP5hhLLpe4CxzC4sdfrlTwx3i75
 +TRQhqDnycY8+oYkPMN9yIuVuKcOAL/s8FaO6O357/T0nrAhlJivoiCBlJglOivElw7La0ubeNQ
 WK30cCG0jFO4ATg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add fixtures for the newly converted getsockopt leaves:

  - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
                unknown-optname case that reaches do_rawv6_getsockopt().
  - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
                the base and full cipher sizes, the NULL-optval and short
                buffer EINVAL paths, and an unknown optname. It skips when
                the kernel lacks TLS or AES-GCM.

Each fixture pins the returned-length / errno semantics across exact,
oversized and short buffers and an unknown optname. The semantics are
unchanged by the sockopt_t conversion, so the tests pass both before and
after the leaf conversions.

ieee802154 and phonet are not covered: their CONFIG options are absent
from the net selftest target config, so the cases would only ever skip.

Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 239 ++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index fe5a5268bc34e..6c2408df46123 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -28,7 +28,10 @@
 #include <linux/vm_sockets.h>
 #include <linux/icmp.h>
 #include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
 #include <sys/socket.h>
+#include <linux/tls.h>
 #include "kselftest_harness.h"
 
 #ifndef AF_VSOCK
@@ -40,6 +43,18 @@
 #ifndef ICMP_FILTER
 #define ICMP_FILTER 1
 #endif
+#ifndef IPV6_HDRINCL
+#define IPV6_HDRINCL 36
+#endif
+#ifndef IPV6_CHECKSUM
+#define IPV6_CHECKSUM 7
+#endif
+#ifndef SOL_TLS
+#define SOL_TLS 282
+#endif
+#ifndef TCP_ULP
+#define TCP_ULP 31
+#endif
 
 /* ---------- netlink ---------- */
 
@@ -394,4 +409,228 @@ TEST_F(raw, bad_optname)
 	ASSERT_EQ(sizeof(val), optlen);
 }
 
+/* ---------- raw (ipv6) ---------- */
+
+FIXTURE(rawv6)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(rawv6)
+{
+	self->fd = socket(AF_INET6, SOCK_RAW, IPPROTO_UDP);
+	if (self->fd < 0)
+		SKIP(return, "SOCK_RAW/IPv6 socket: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(rawv6)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(rawv6, hdrincl_exact)
+{
+	socklen_t optlen;
+	int val = -1;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_IPV6, IPV6_HDRINCL,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_TRUE(val == 0 || val == 1);
+}
+
+TEST_F(rawv6, hdrincl_oversize_clamped)
+{
+	char buf[16] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_IPV6, IPV6_HDRINCL,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+/* Raw int options clamp the reported length down to the user buffer
+ * instead of returning EINVAL on a short buffer.
+ */
+TEST_F(rawv6, hdrincl_undersize_clamped)
+{
+	socklen_t optlen = 2;
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_IPV6, IPV6_HDRINCL,
+				&val, &optlen));
+	ASSERT_EQ(2, optlen);
+}
+
+TEST_F(rawv6, checksum_default)
+{
+	socklen_t optlen;
+	int val = 0;
+
+	optlen = sizeof(val);
+
+	/* A non-ICMPv6 raw socket has the checksum disabled, reported as -1. */
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_IPV6, IPV6_CHECKSUM,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(-1, val);
+}
+
+TEST_F(rawv6, bad_optname)
+{
+	socklen_t optlen;
+	int val;
+
+	optlen = sizeof(val);
+
+	/* SOL_RAW reaches do_rawv6_getsockopt() directly. */
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_RAW, 0x7fff, &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* ---------- tls ---------- */
+
+FIXTURE(tls)
+{
+	int fd;
+	int sfd;
+};
+
+FIXTURE_SETUP(tls)
+{
+	struct sockaddr_in a = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	socklen_t alen = sizeof(a);
+	int lfd;
+
+	self->fd = -1;
+	self->sfd = -1;
+
+	lfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (lfd < 0)
+		SKIP(return, "TCP socket: %s", strerror(errno));
+	if (bind(lfd, (struct sockaddr *)&a, sizeof(a)) || listen(lfd, 1) ||
+	    getsockname(lfd, (struct sockaddr *)&a, &alen)) {
+		close(lfd);
+		SKIP(return, "listener setup: %s", strerror(errno));
+	}
+	self->fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (self->fd < 0) {
+		close(lfd);
+		SKIP(return, "TCP socket: %s", strerror(errno));
+	}
+	if (connect(self->fd, (struct sockaddr *)&a, sizeof(a))) {
+		close(lfd);
+		SKIP(return, "connect: %s", strerror(errno));
+	}
+	self->sfd = accept(lfd, NULL, NULL);
+	close(lfd);
+	if (setsockopt(self->fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls")))
+		SKIP(return, "TCP_ULP=tls: %s (built without TLS?)",
+		     strerror(errno));
+}
+
+FIXTURE_TEARDOWN(tls)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+	if (self->sfd >= 0)
+		close(self->sfd);
+}
+
+/* do_tls_getsockopt_tx_zc(): fixed-size int, exact length required. */
+TEST_F(tls, tx_zerocopy_exact)
+{
+	socklen_t optlen = sizeof(int);
+	int val = -1;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_TLS, TLS_TX_ZEROCOPY_RO,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_TRUE(val == 0 || val == 1);
+}
+
+TEST_F(tls, tx_zerocopy_wrong_len)
+{
+	socklen_t optlen = 2;
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_TLS, TLS_TX_ZEROCOPY_RO,
+				 &val, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+/* do_tls_getsockopt_conf(): NULL optval still yields EINVAL -- the
+ * converted code tests opt->iter_out.ubuf in place of optval.
+ */
+TEST_F(tls, conf_null_optval)
+{
+	socklen_t optlen = 64;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_TLS, TLS_TX, NULL, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(tls, conf_short)
+{
+	socklen_t optlen = 2;
+	char buf[2];
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_TLS, TLS_TX, buf, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+/* TLS_TX before crypto is set reports not-ready. */
+TEST_F(tls, conf_not_ready)
+{
+	struct tls_crypto_info info;
+	socklen_t optlen = sizeof(info);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_TLS, TLS_TX, &info, &optlen));
+	ASSERT_EQ(EBUSY, errno);
+}
+
+/* Set TX crypto, then read it back at the base and full sizes, exercising
+ * both copy_to_iter() branches. SKIP if AES-GCM is unavailable.
+ */
+TEST_F(tls, conf_crypto_roundtrip)
+{
+	struct tls12_crypto_info_aes_gcm_128 tx = {
+		.info.version = TLS_1_2_VERSION,
+		.info.cipher_type = TLS_CIPHER_AES_GCM_128,
+	};
+	struct tls12_crypto_info_aes_gcm_128 full;
+	struct tls_crypto_info base;
+	socklen_t optlen;
+
+	if (setsockopt(self->fd, SOL_TLS, TLS_TX, &tx, sizeof(tx)))
+		SKIP(return, "set TLS_TX aes_gcm_128: %s", strerror(errno));
+
+	optlen = sizeof(base);
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_TLS, TLS_TX, &base, &optlen));
+	ASSERT_EQ(sizeof(base), optlen);
+	ASSERT_EQ(TLS_1_2_VERSION, base.version);
+	ASSERT_EQ(TLS_CIPHER_AES_GCM_128, base.cipher_type);
+
+	optlen = sizeof(full);
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_TLS, TLS_TX, &full, &optlen));
+	ASSERT_EQ(sizeof(full), optlen);
+	ASSERT_EQ(TLS_CIPHER_AES_GCM_128, full.info.cipher_type);
+}
+
+TEST_F(tls, bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_TLS, 0x7fff, &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0-Meta

