Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A442254E;
	Thu, 16 Jul 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206932; cv=none; b=SYutC+TIbOiFnY+tvd+xsyCx9Yt0vNBX6Hve8bo4KzKauQyw7ZtHU41izQ6Tt7fyS0a45syh/J7qtsB6DSz9V+EGS5VAUfEG2Ytic6ULbyxNtNk3Jy0ex3D5AG8yX3ncCXGy5sHstq1qX3FCwBVTjKwLHrb/dmxiUr0GlYzZEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206932; c=relaxed/simple;
	bh=PoF+I6ssQG2B2zbMCV8FyPh8QahdqUGCIbDFI7Zv1ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jUt2LUG1DWk84jnxOj4KZcMYYLkGy/c1BN7CmwLlclm94vyoyW8wu3/Nbv3svSLJJpmpES7AD1bOBp+DJzJ2o+C7GIbCS6r8VtNVSu3DstHUcutQ3eJQt3amp+YwUY8h7VKgSA59TpP9o7+F1AyGrhhnQ7sKObARAhth+oNFXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=COYHvFKo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="COYHvFKo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=53F5uiFFmgq0z8s+mP8+crYqDFByovEg9NEkQH5u4DA=; b=COYHvFKoZsEl6f4bkGGF4+Cuh9
	SudYgt+r104FLKjtCHkYKY6C2qwOKrZYAiaVSVNOIiw3EIXFabwtxmJk8Zd02Mnp5/7+muEdh5rMb
	h0X4LfFpxBw4kvKWa3JYzuKZsmT8HRTQjnwiaS4e8nvXvx7lSZrjCwiCvrbDlfxF8RrmLqVoscS/I
	ssaDe1c0JV516pVJeno7cHrA+uvMwAucJqQyJrLAR2b9jZLNmKirzMQ6XO3stHJ8lrDsEjtOUllmj
	xIQKc9bhVaTGbpDb2TPj5VBAYaIgrxkSvw5B/5L8WtBpS12eqd+t1bJ+3m9ElORMsp8buDz225mPf
	QN1xKyvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLj3-003q76-10;
	Thu, 16 Jul 2026 13:02:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 16 Jul 2026 06:00:02 -0700
Subject: [PATCH net-next 4/7] phonet: pep: do not write beyond optlen in
 getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-getsockopt_phase4-v1-4-4f45cb12dce7@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=leitao@debian.org;
 h=from:subject:message-id; bh=PoF+I6ssQG2B2zbMCV8FyPh8QahdqUGCIbDFI7Zv1ac=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0+X23HeBiZQXOrW/HXpXu0zHZNdpQqfVjA
 cx1Ys8avCaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bXecD/9anz+ex8bWFkr/bXKcbn15hKPBn/bNiA9P+vAosgkHq8kWyslFSlQKQxWvib7oSdjr+8B
 /dYeqUOkIIt5uBqGDhSsG7AMmqDFHAfUCZch8sJQnXZGBcxW7Uh0rqihx+3zgZ+59ltkKdXL/EN
 QWzFgKQ5ZmsbC/bCthhuZ5vU7ZjL/q1kwQaWcACzropG1+Hidy56xtktScowj4hvCnAUiYl6BAI
 KAKjimwQgk6x4ybRhV4ie7PY/O6vPeyqxkYAWviMEOvc7cKwyY+NqIFn2PN+se9m/wHh2j46Qh0
 YMz38FNC5tJR+GEDX09sBM2EQq3YzO4/I0gjKTNK4kcGY/JJGP/mqk6ffJVdpWTsVYRJBHR2SZL
 damSYCN5dhAKRmoCmw8NRjRvH57xOlmbY2SiVkt+DMTG02x2NlTMErKPiMfKZ6lv2AohuDA52LQ
 Bhd/p+krZxXEiODHYGpvSd2kx1QsRf2CrPXcz/W76C/AYWT+vyfHHFJG2fCTmSpZDva50pnrZnO
 kBzgq/he6v7DLg8krrtIlbEdJL8F0Iz1KRsA4AotJ5iYuj8VMDz+KJh++pltmjtugVYoavGRRE7
 kylCJMvCPQnqZ8PFOuXA7NbeDz4MJzats1yMZ22vwDw1gtv6ssdvkVwGrhv3xME6478Xhzpe9QD
 M9AvLXBjSQ+6IjA==
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

