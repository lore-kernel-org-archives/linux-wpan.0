Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3D4457DD;
	Wed, 29 Jul 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317490; cv=none; b=iRHaYB/4QuIE9WKjxizEc6I9JqFXVuYXTqg+2/eQ+mJ8RT1uA9CVXSRnnKSMZ3jE0OmIyOarHFLBzW+S39hyYsjea/CCeHMmbD1iNT9+ssxmYU0MTt+n/EY/oBRcs49zNvC1gpo1ge5y0ODZTzBw2ZLk1gTxozjga8MJ+oTd2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317490; c=relaxed/simple;
	bh=1NrNY+r4xYOGN0JH6XpA5g6ZxfNL4Eq/GaaITEQSorE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDZ4bcuVeZPfyhHDdFqEVem0UccPzVjMpDQ3URJU2E7CY4+jf+bNNehzSyvXin6yIjA+GtZXIac0VYZiOdndhvwPbmX66iObv0eUxz5GuvVZ1vm/rb+4uF3BelX9o3cFiB4uzHaEdq7KLfNJW2Oeafm6oGykuJqybtVKOrEwQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=elh0hd6E; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="elh0hd6E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=1IKXkR5PsNTL+UNImRoKO6WL2KC3d6ptd0mnVVEqdyM=; b=elh0hd6EeWdHRjbOEOi3pMtvxu
	ZmGsrevSrHM0yB6Y8cbhYJZIgb0CanyrzpZF2mNHuSVsnWecbsPvkOoP8eKd/dBnvj9UvmdBXmLtU
	KrSg59726zIbDz/5lWZVsZO/LUIjrxyvtehXv5SCjMGssyrfSejS/eo67q7oi3A9BlJbzb+FePH9j
	faTzhZBlrUq7f1Q/90+WG3xTXvsuOqfnQljK+NytZYJcUvoERNCqTDNoWqF9qwjlhj07GtIzTMosg
	xEPlOo/K/LPsA7b5x308pLHKcG9IpqsQvgkeNFJQ9B7+BJXrMvNluElr0qHaah+n+rLMNK3g2xfMA
	8BepTAyQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0dE-008Lzu-1N;
	Wed, 29 Jul 2026 09:31:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 02:29:47 -0700
Subject: [PATCH net-next v4 4/7] phonet: pep: do not write beyond optlen in
 getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-getsockopt_phase4-v4-4-c44576757c17@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=leitao@debian.org;
 h=from:subject:message-id; bh=1NrNY+r4xYOGN0JH6XpA5g6ZxfNL4Eq/GaaITEQSorE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachLKdQH3psU5OQXQp0lqKvbk0MDseLj5VEvU
 /fLm9Jwf6SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bVYbD/49L0epPgbeGjS0lUIAKN5hqsjFZgBUwth28jh0U+8KmdW/f/C1W+zW5lnESfIDOSfwVVv
 J3BWE20wRZzMQ7RFuXOgRSIv0OAKJze5fF8bHOdiIelUg9rPoe4/7UAXKfbJVCZLeb1URVLjbbY
 yT+L2PEYITRMt/FGuf7RTXB6QN3Nrbt0Pfjuo75FVYNaIlJeIUXp3DGrp3Z6tFk8f5q+3syStlN
 tt3GZ0dJHalC96+rcq/Imge321qJwc0xI0sJzsy881isZ5kHlOa07akqGGoAHT2V65lUdeXcHhB
 Wr5bSW1cLS7YeRYfBMEFR/LBxCnejBbe1uMcWxtXg8HQ9JxqQqGVdvlykeA4tU41Ia9yl2vBaDJ
 y+kAJZNvyHAS9B887dEpTZbXPMDWQAFciJ2uG4dnFRV1+Noj7NRiErJFKMcq8W2a/mvPF/UTRKx
 eECrUFNAay049GUGLLWrOq8wWywh+iSWyaBl7BDkbTN+yevHIFBmZ7UnWdf5Cwsw0R5M8+NR0Ol
 6T5YZYJ5HNGKihg1vhUA1ArEYAiJcjgF9l5g1Ry6F+qt6Fqcfo7kgyruVqgUdCLJmHnTPDn9IQq
 lqLZihM49vsJLFURA5Z16HOKXc22FbETc0r4+LTTjwG9VVDV+Jts3qdU/thd4h9qecqP+BgFl4g
 IeOEhPi2mNrX5fg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

pep_getsockopt() clamps the reported length to the caller's buffer with
min_t(), but then stores the value with put_user(val, (int __user *)
optval), which always writes sizeof(int) bytes. A getsockopt() call with
an optlen smaller than sizeof(int) thus reports the clamped length yet
writes a full int, one to three bytes past the user buffer.

Write the value with copy_to_user() bounded by len, so at most optlen
bytes are copied, matching the length reported back to userspace.

Fixes: 02a47617cdce ("Phonet: implement GPRS virtual interface over PEP socket")
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/phonet/pep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 7069271393933..60d1a5375725b 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1115,7 +1115,7 @@ static int pep_getsockopt(struct sock *sk, int level, int optname,
 	len = min_t(unsigned int, sizeof(int), len);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (put_user(val, (int __user *) optval))
+	if (copy_to_user(optval, &val, len))
 		return -EFAULT;
 	return 0;
 }

-- 
2.53.0-Meta

