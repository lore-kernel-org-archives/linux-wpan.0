Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5B4229D8;
	Thu, 16 Jul 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206937; cv=none; b=KBIyCaHax6BanBuCm4xRxjSGtcGA3RwfYN1yDUSbCAUd8xaIQI5RSthAjtP2r2pHC1fsO3LEexhfO9c0ZWwaJrU9DaSO9rS3GaHLORFL8t3EYvsee3HFXulnGtr5utwX8dHfNRBZrXzn1G1u1XEjZSy8dxNczPS/4oUBFrgskd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206937; c=relaxed/simple;
	bh=Se87aCwC+fMAly81DUym+4s1VCr+FdNCwHJxoY2el/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkQV//gF2fr/hzyobhXCHfyJfvXLvxZer0vwoe4bNccuFkcqVQZ5TYw/vn1ZPdSPa4lXAynCeoyyvC6FaOWo3wVsMAzBzMZmbSTKi0qAMw8qf9hiExYAuMB+EBxTS4zKrTROH81FoSTt+k0xawVynAecuFg/7eLMx2rft689pUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=btyIsQo6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="btyIsQo6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=cRVSHKeCMo9N4rQFaonUdaNrdsEEhIRj8z0XSdd0ntc=; b=btyIsQo6gjGBk83Kax8blVhvnM
	5p3DAqsxNSergq4O7fYBryuRLpxPJ9m+ZRxWK2fueFIrRsQbrcDNP0d4UHALaTDgegRa4//jxPUBC
	xBB+FXeIzICjFav4oHuaEAuwsSZDbcxSt0bm3M08i6zv+v5tI83Kb4K3Lkc92/Ha+py/wYaRXL+OK
	kW9GTXysOv2wi0g5hlxOXGnnGX8a+Mb5yR8LcrL6byqYDYMF1mmprb8VouwYcGm0OqUsrtlIojj31
	tsdCbBukGyVFQgJWH+CvJbVh8+afPkUWEWqs/+3B83anwuZpm1sogSdzldjPBFfpYiys3/9bqRnuO
	RFSCBkDg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLj8-003q7N-2H;
	Thu, 16 Jul 2026 13:02:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:03 -0700
Subject: [PATCH net-next 5/7] phonet: pep: convert getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=leitao@debian.org;
 h=from:subject:message-id; bh=Se87aCwC+fMAly81DUym+4s1VCr+FdNCwHJxoY2el/M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0jt3nJWJzYShVpMobhGkyc2S4LTYivPDay
 7o5bsp/0iGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bT+dD/9zc3rl8rsq056KUXMATcYgDNmQhgFtdTEJa/Ff7xNiTR9DcVFmtYsM88sll7ApvpL2FZC
 Lt9Bh1ZHvMF1womtHsKi2nLJ5ZbCdOFPovVKGiMs2JLwXrO9MpOLANrIpmsDF8gCj4NNnXhtDak
 hNYW7M3SCEEC5ZXjoMq79ABXSuWUNUmpTa83Rsq1ofvhenDaI5KXSV5dxLWQuG7ibitoEsmC+o2
 EBth1mvQXDn3vzGwRyx1eyDIMm5uXV2/JRWRxNhupudriNgwKfUnmrh8n2wGsPnfndW9JE1yHye
 SYx7iN+Rbm3fS0icyR/wKxknI07KQrPg3eCQNenJqVJPmx8U17XfH2pwrMWlJ5ixzWHGwAqis2W
 q9ciN3RnDFIiZKzD12ROCAc7mW8pKCk3fMlYcNeicKUCd5MRQ+idBa5fbLSFF1M8TaNW/r+NxXC
 h8GT0pOQNHHMJmrEzPARUc/jgPW36wawwfRrM2xWi2BRIHx3/+DxaBGooP3xTmC8omqo9PvU9Ya
 pwXkavZ304m/qGbaRBo9o7QoHj0wCosE/8crnRLsjW8fHV2RMpnlS8/DLX2Qn+Y4087tKSkreGp
 4+fZ8VRtHLqJjsU2aGxqRKBG961hTQ84frLuMeA2+SjB+tGGgIzYGQAHNkQVABHBcYG96kmxM25
 o2o7/EXgBpAB2Ig==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the
sockopt_t interface, splitting pep_getsockopt() into a
do_pep_getsockopt() helper that takes a sockopt_t.

The thin pep_getsockopt() wrapper keeps its __user signature for now:
it builds a user-backed sockopt_t with sockopt_init_user(), calls the
helper, and writes the returned length back to optlen. The helper uses
copy_to_iter() instead of copy_to_user(). No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/phonet/pep.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 60d1a5375725b..c7f4ce894af56 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1078,17 +1078,11 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
 	return err;
 }
 
-static int pep_getsockopt(struct sock *sk, int level, int optname,
-				char __user *optval, int __user *optlen)
+static int do_pep_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	int len, val;
 
-	if (level != SOL_PNPIPE)
-		return -ENOPROTOOPT;
-	if (get_user(len, optlen))
-		return -EFAULT;
-
 	switch (optname) {
 	case PNPIPE_ENCAP:
 		val = pn->ifindex ? PNPIPE_ENCAP_IP : PNPIPE_ENCAP_NONE;
@@ -1112,11 +1106,33 @@ static int pep_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	len = min_t(unsigned int, sizeof(int), len);
-	if (put_user(len, optlen))
+	len = min_t(unsigned int, sizeof(int), opt->optlen);
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	return 0;
+}
+
+static int pep_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_PNPIPE)
+		return -ENOPROTOOPT;
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_pep_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
 		return -EFAULT;
+
 	return 0;
 }
 

-- 
2.53.0-Meta

