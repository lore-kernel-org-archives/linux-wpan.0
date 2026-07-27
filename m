Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609833E1CE4;
	Mon, 27 Jul 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146840; cv=none; b=VdGZG3S7OYvqmP+SpJxSZUo5k9jYu/IMBBLaqzVOW3hjxCo1NxTKkA125WRZZekwj+mA6DAw6zOvTXWapnmB+t+nqkRP6yWnXCgcOVm5cZtgIp/rVlqsvkg4yxb7RApnEJrlrdqdxU6vu4QdtaITUVqvD1YCsW/6JJ97F4HkakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146840; c=relaxed/simple;
	bh=vE78mOdJudExm0QrVUUs4tshix0FA5wKZno4hBwQU5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J95PEJOYpVNGeAsB7DCFn65SJ1TmfdH+NwKQh2nIV1o8w1T898tb2l1b9XOXz9iyy3n++jQai1CeE2UzhNSG5M25WgyEmk8yg2t5Q3ca4oEio9c5qv6o+k6U1f9cQ4/IBUA7R6JdWSLJC6WCSqjBX3hmJPGDh8ghheujwSpeDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UdSUyoce; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UdSUyoce"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Omz/NQzNtBgC0/1nTk+u6wNUOybJibcM5UY6h98PK4o=; b=UdSUyocedot9NFY2WxEZhA7y9/
	R9gq9g28k8MPLHrN6C3jLVUWGkqTjJ9t6dt5ibdZeIoN9y562deH2LtzPcqF9SMkfdrzmp59N3gfm
	XJ8F4FzdKhvgRpL3cMxGq2uVzQtdrZvE8Eg+MyrVWjt5nsstIQ1djdawbbKMrTUJ2seISRHG4VdSS
	IBMmgd6/uyodn0HqMu2Dy3go94qVudVBG3EQEGwBeXkJFQFfY3FHbadKbi1LforfNgcuD4GdDCN2P
	yFBy9hV37qwhQgJgiEQZhOiz0eftm/ktdsC5BjRMWq7TJhplSQN5zepbluqVHvKBcTjsuOn1Do/1T
	sWItMB1g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIEv-006ot4-20;
	Mon, 27 Jul 2026 10:07:17 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:37 -0700
Subject: [PATCH net-next v3 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-getsockopt_phase4-v3-3-e89627544639@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=leitao@debian.org;
 h=from:subject:message-id; bh=vE78mOdJudExm0QrVUUs4tshix0FA5wKZno4hBwQU5M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy226Nrai9TDpUl3UCQNmDurJW28GvJP9Qxt0
 i9pAz2ciTiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttgAKCRA1o5Of/Hh3
 bdzLEACuHq6TFtQ1OmRAojPAC2J+KgoQ4EuSP11l/Pnz15bTSIdhB49gdJibFs4MVDiC1ki9YVJ
 szndV8RK1xaXmwlexDFOlBTqETXivV88ZormXpTGy4Uj4EUQgnpVSFaVZV72pch2aKPPCSqQ8V3
 Ahl3iZ/NM3cFyMsJTU08jZeHmbBs653i2CdxnPn/bDELhdLs0MHMy/mfqsXUiISv+PSDWyWQnBP
 KU5YPT8xqEtn//iVzYSr7qdNHpMMNzcX3gex9dXjJAv3Xts2qeSMCDtfpL2PKU7X62aW8+L2KCp
 rzNJphcEAjPzvvhuYDEoP5vPC6ODHY8Ps/TdXLDl7pO5EEHpxUCiu7koNPURJjpZTOfQFO6g8uV
 iH7ZvXhetIlkdQbrCnOTxciR9R0mol9zmN8UEIAArUgbii4mSmVoqdRuV+lnY0W5vLZBaFX9LLp
 pVpQiqH2khXMyZ6I9Wc19NGyAHuTQzd9HP4A2I/ZulGjA7x3dl6C+x/oPpAk+slu0bhjDle0srm
 H41SZKRmw10FXhNgfEOkBwh/DciJ22vO3g4EG8OszWaer7xHzmlvIh9WHBpWaLFJHle6b7Pjk6l
 mXrxbtUJMZkoxy0muI/QyTfTyI3jV2eMBBkkHvPAlnLQ7Gd0qZD9Xrr391I3LH0WIcrlSIZiXNq
 yVk56FHLtfpySiw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
that takes a sockopt_t.

No functional change.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 85dce296d7513..5a36e87893f64 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -831,20 +831,12 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
 	return ret;
 }
 
-static int dgram_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+static int do_dgram_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	struct dgram_sock *ro = dgram_sk(sk);
-
 	int val, len;
 
-	if (level != SOL_IEEE802154)
-		return -EOPNOTSUPP;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	len = min_t(unsigned int, len, sizeof(int));
+	len = umin(sizeof(int), opt->optlen);
 
 	switch (optname) {
 	case WPAN_WANTACK:
@@ -871,10 +863,32 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	return 0;
+}
+
+static int dgram_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_IEEE802154)
+		return -EOPNOTSUPP;
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_dgram_getsockopt(sk, optname, &opt);
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

