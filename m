Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A843C7BD;
	Mon, 20 Jul 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564621; cv=none; b=qLfLXkZBl6Ms51IFOwo2eXQ5V0y+uUBP/OxDEsvSuitFNNDaeeRpCGHib7ZifBHz+clwMeMXlnMBH1l6tXPT7Kaym95ucSqZ8U5L7acJ1rLxW6ELjugsXoSyLy7+dEGpUHQQ2xsZUWOA179U9aL6zWQfcJZRAhB3AVOTn0IiTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564621; c=relaxed/simple;
	bh=cAMTjzFtWpssYhGMnYLYloL7+e38m8IMj+86usmagk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OShIDNynhmlWiK0VlZCdTteckdqzBMfmuIdF/6/onh8iRyQ74ApLa8jx5ZUSqwNHvBlnLLvMkkY202G01YUuQPcOfKD7voI1liIPiN11Ccpa6n1i1DuZ7gjywXROsLhzy/m3yoESS2vNz5Wl7XjX364hxctaZRm0WStzWJ5ucQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EWiXlSdi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EWiXlSdi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/ULuSXe8cMJt1jfaDloF8ljpZjBOJlHguRmjs+r/CiQ=; b=EWiXlSdiYZCDDPDrX7Fs60nTOs
	ZzxzABpta/4PaJFgZw4G89NyU1bbXa8hDqAOeUxTaDDVP17rnfSOrFdxa64VBpUvifh5h8BAWobf/
	MzXAiCljuRJqpjbrAKPOtNj4SKWoMtD9T8V0S7sM13QvK8f7HjhdMMLqW7fpXtu/lYUkj8BcA4oUC
	9Y7sp2NUkrEL7JSlletTnPkxXYGnd8Dh72a4Escx3VgA5Mv0j+UNhlviPAV23HfpzoVFDhAnThh+X
	bCbikyENmIOgTPsG4OSqloRyQJpBeqa08S5LhKLzC4eEQ9xKnaAAbMLw1kOr4IN/RejJMA69glSTG
	x1924FtQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqmE-001Ywi-2W;
	Mon, 20 Jul 2026 16:23:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:44 -0700
Subject: [PATCH net-next v2 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=leitao@debian.org;
 h=from:subject:message-id; bh=cAMTjzFtWpssYhGMnYLYloL7+e38m8IMj+86usmagk8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktyBvZQT7BsDUarMHnq491QUdug9sIneZqMG
 WdIsRuwnneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcgAKCRA1o5Of/Hh3
 bSX0D/44YpJEX/t4E7Xk23fZpN/2mD0iChvD3yBRWqpy850iJDbd7OGtPPOVB/nBpujwM9B29a5
 AsmSg4ud0OY/xuwBo6EG0KAltxGiBhMHbyKsON0ofJNF/UiFqnztRZPK2OrV0vOX2hs71hLgvXS
 9DFzlhr4B+eDxSfl0S8TtBCej9XV7uPMcx1q1ZAKSPkmxU1CM5gHhT8ZV5b+eunDRYaNi9nuDMZ
 lXc4SbEc+ogjwKLRw6KP5UtxizonTlnV8JIERVkGO3PlA/T1VhVjyiQiuYBwWJyA9a68Hwdav/m
 oCsJFtJv594KAn//LlAPUPcrNLczfGV1NjZzToQSIVlMqu4XokGFrYG7tperpLtlVMeiP0SMcXY
 foPTyIkjy/aV68GULFB8VG1E4l5KIUa1xYDfClQ+6vA4k3ytBnNziuWN9WMzkgtDQPH7fHQw3pe
 l0KAGo6mNW3S6ApGX22xscVVU+/iE0J1CGTBNGHiaLEoffcdF0heUx1uTJgZjfSkYQF0wMn3/BI
 YBxApJ3aCOegNfVazMkTuRqVux+pUcmu3cJgqLIBi7CdPB7nkP8Ufvs4ug0gfKvzz/u0MI7/iio
 zvk8/xvpBUFaRZGI2nSyxsTrPk7hOeScskPgO/F3phI+iSAhBmSCWbxWNXCzJst83EnbXV/PFU6
 u3c8XboQm+fMEQQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
that takes a sockopt_t.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 85dce296d7513..763f63e48afe4 100644
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
+	len = min_t(unsigned int, opt->optlen, sizeof(int));
 
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

