Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5341D63A;
	Thu, 16 Jul 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206948; cv=none; b=GQy6IdgvG1oBSKAcW7omNX1/FXJOCKHDixXx1q7y4lc6g1M8s84M1J+GW6hHVwGpBaTQiDxgdVXDakGVoS11NImEH3nNkYCIbwrbMxSLtezhuUHiH8fEaUfubVQweGwHr8sY55ITrSM0fcslwaVWOsXFp65slmoYWxBYbw07Nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206948; c=relaxed/simple;
	bh=3hdAT9EyFQMQiq38tK6EUbVUFaxBUaaYguf18gRo0Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSNlLCExyRo4ukzeaVYfem5+yURTESdkBrfRTu/hRhhZttFf/GmPeHv955guvSNjYip/gbAzXCpTxc7CZW7tDaU3u1VNBPTzwbxyCgrzjVMPK6nOPtCRHf5160bPG2zN4qg/Oel63Oepbg7GdAVj8dPxmbM7/RMV4I7Zyh0Oe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZeLhXRzh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZeLhXRzh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=CwlOBsweskXoWiiCSdeL2Spah7OPud7ghVOdgEgoOqo=; b=ZeLhXRzhi235SjgS8M+dAMMA95
	XA/QRSjE+j9YzDUF5PBMa6iXAQS7jDYwcQ4Cs/cGQi4oR6J1oLBM1sGXiiz5tfzjcg7C/+vP+ytL+
	jxfatDBorCiYR44ISgWhfr6aIbVe5sIOYw4nt3A1ChcgVNZEEL4H802dXmrnA+6DmIRRZzSUG4PSl
	9ZVl86n4XiwbQyrfVAng0pnXdXEsDDPB33jYQRqa2aKpJpUiLAmgQGGs9WGOAxXCFXHhKoWWGLdRM
	xzcIaB5tyKvYbAKtbn2PfNHdkOvaBTaFVfyprUxYlVF8AMtPv2xEJEIBAVL1TWZ6oXgmWbYhXGNQk
	X+e2XLlw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLjI-003q8B-1G;
	Thu, 16 Jul 2026 13:02:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:05 -0700
Subject: [PATCH net-next 7/7] selftests: net: getsockopt_iter: cover rawv6,
 ieee802154, phonet and tls
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-7-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11664; i=leitao@debian.org;
 h=from:subject:message-id; bh=3hdAT9EyFQMQiq38tK6EUbVUFaxBUaaYguf18gRo0Rc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0ICSvwoE6LZLvgbjfuzYzBEO48A/xj2sz2
 JZIfEnAxguJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bfcGD/9KMcdwl3btkogCI3uu6SeX2sSegleHArjQbxHT8PdEUw2WVU/svQR0/A5eCCUeCDmqWR1
 8VlZkoPT37ZGFPXSs4jgsLRRdLv0jMDkytm39jYT1PQ7eZr2FOiGyGCr7xDWU8j8NfJcXKQcorK
 qv3oULz3Qn1zZIzqkidogjrCmPOA10gMAws6YfXNk5FJ0GliCm5InMrJX6BIO2I1KRLFD8g9AtE
 60TU7laaa3WiSa+jtzJ8EODXMmfg1bl5kjXIwDzVqXK8VxXDU2N5vVAjTExnXCO1bu4Paqa11A1
 2b6uYvTWWg3iVQ7U9bW+TjQUCGCQswAo2HR31to7aJwLVKmk7i+B76FLBefQtKKMQSRzE+a+2/g
 3ldIsFFCtQMGMm7dd4lDO6Fa3uy981wA1VJ9t9Oca7ziVdAnbcYAZp6NiFfiMHKI935LWf9eKWo
 FecL22r2xiFlFtsJyeQ5sPQ4KQjRZlqgEFFoSLpoKs5Zva2TJ7EwSDj4qmhIVb3gtjojWM9kFlP
 A8WFuSo+U2CLv1n4HTAxKuWdpWYCnt9QkmrVVmJND0Sd0mDPj6WlQvsc2aiF0qtsMx6TPwvp6KC
 PvcwTAaj/iFwKFpttgzxz2l8YY+OjnqqDCq59EvLw7eWLoOGbbMBOisF3QdERmEk4q/9DibALQP
 dWsRM/x2HolpktQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add fixtures for the newly converted getsockopt leaves:

  - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
                unknown-optname case that reaches do_rawv6_getsockopt().
  - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
                rejection.
  - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
                rejection.
  - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
                the base and full cipher sizes, the NULL-optval and short
                buffer EINVAL paths, and an unknown optname. It skips when
                the kernel lacks TLS or AES-GCM.

Each fixture pins the returned-length / errno semantics across exact,
oversized and short buffers, an unknown optname and a bogus level. The
semantics are unchanged by the sockopt_t conversion, so the tests pass
both before and after the leaf conversions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 424 ++++++++++++++++++++++++++
 1 file changed, 424 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index fe5a5268bc34e..974065a23fa82 100644
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
@@ -40,6 +43,45 @@
 #ifndef ICMP_FILTER
 #define ICMP_FILTER 1
 #endif
+#ifndef IPV6_HDRINCL
+#define IPV6_HDRINCL 36
+#endif
+#ifndef IPV6_CHECKSUM
+#define IPV6_CHECKSUM 7
+#endif
+#ifndef AF_IEEE802154
+#define AF_IEEE802154 36
+#endif
+#ifndef SOL_IEEE802154
+#define SOL_IEEE802154 0
+#endif
+#ifndef WPAN_WANTACK
+#define WPAN_WANTACK 0
+#endif
+#ifndef AF_PHONET
+#define AF_PHONET 35
+#endif
+#ifndef SOL_PNPIPE
+#define SOL_PNPIPE 275
+#endif
+#ifndef PN_PROTO_PIPE
+#define PN_PROTO_PIPE 2
+#endif
+#ifndef PNPIPE_ENCAP
+#define PNPIPE_ENCAP 1
+#endif
+#ifndef PNPIPE_ENCAP_NONE
+#define PNPIPE_ENCAP_NONE 0
+#endif
+#ifndef PNPIPE_ENCAP_IP
+#define PNPIPE_ENCAP_IP 1
+#endif
+#ifndef SOL_TLS
+#define SOL_TLS 282
+#endif
+#ifndef TCP_ULP
+#define TCP_ULP 31
+#endif
 
 /* ---------- netlink ---------- */
 
@@ -394,4 +436,386 @@ TEST_F(raw, bad_optname)
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
+/* ---------- ieee802154 (dgram) ---------- */
+
+FIXTURE(ieee802154)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(ieee802154)
+{
+	self->fd = socket(AF_IEEE802154, SOCK_DGRAM, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_IEEE802154 dgram socket: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(ieee802154)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(ieee802154, wantack_exact)
+{
+	socklen_t optlen;
+	int val = -1;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IEEE802154, WPAN_WANTACK,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_TRUE(val == 0 || val == 1);
+}
+
+TEST_F(ieee802154, wantack_oversize_clamped)
+{
+	char buf[16] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IEEE802154, WPAN_WANTACK,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+TEST_F(ieee802154, wantack_undersize_clamped)
+{
+	socklen_t optlen = 2;
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IEEE802154, WPAN_WANTACK,
+				&val, &optlen));
+	ASSERT_EQ(2, optlen);
+}
+
+TEST_F(ieee802154, bad_optname)
+{
+	socklen_t optlen;
+	int val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IEEE802154, 0x7fff,
+				 &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* dgram_getsockopt() rejects any level other than SOL_IEEE802154. */
+TEST_F(ieee802154, bad_level)
+{
+	socklen_t optlen;
+	int val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_RAW, WPAN_WANTACK,
+				 &val, &optlen));
+	ASSERT_EQ(EOPNOTSUPP, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* ---------- phonet (pep) ---------- */
+
+FIXTURE(phonet)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(phonet)
+{
+	self->fd = socket(AF_PHONET, SOCK_SEQPACKET, PN_PROTO_PIPE);
+	if (self->fd < 0)
+		SKIP(return, "AF_PHONET pipe socket: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(phonet)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(phonet, encap_exact)
+{
+	socklen_t optlen;
+	int val = -1;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_PNPIPE, PNPIPE_ENCAP,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_TRUE(val == PNPIPE_ENCAP_NONE || val == PNPIPE_ENCAP_IP);
+}
+
+TEST_F(phonet, encap_oversize_clamped)
+{
+	char buf[16] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_PNPIPE, PNPIPE_ENCAP,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+/* pep clamps the reported length down to the user buffer. Use an
+ * int-sized backing buffer with a short optlen so the baseline kernel,
+ * which writes a full int via put_user(), does not scribble past it.
+ */
+TEST_F(phonet, encap_undersize_clamped)
+{
+	socklen_t optlen = 2;
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_PNPIPE, PNPIPE_ENCAP,
+				&val, &optlen));
+	ASSERT_EQ(2, optlen);
+}
+
+TEST_F(phonet, bad_optname)
+{
+	socklen_t optlen;
+	int val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_PNPIPE, 0x7fff, &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* pep_getsockopt() rejects any level other than SOL_PNPIPE. */
+TEST_F(phonet, bad_level)
+{
+	socklen_t optlen;
+	int val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_RAW, PNPIPE_ENCAP, &val, &optlen));
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

