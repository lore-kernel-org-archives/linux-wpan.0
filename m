Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9116442FBF;
	Mon, 20 Jul 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564625; cv=none; b=WOnKjPrJed1W8orGw4d1uh4ojfwm2eDyhzjYeGgUMPOQ8YNMZBCjLKRI7VVnhb9M871PWY0hjHCpJFrGh3fQkBGmyTt/cLeMb0AGVLaEAWGNv7PTmh8wl6v2Jy9zKs128qyKukyBgp2vazWaSkDRdxS/DjPKVLNoiGZN1Q94tKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564625; c=relaxed/simple;
	bh=6dTiZSpGCbqFCq3KjHoAffMf/x4ridmrJaJCEm/zBcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMCWwa8XKUC0naKrvdGnpKh55GGtTGHbSqpr3mRY2f0zFYG37YX/vo6rN5Mz9CALrUSHsb/UqeEQ45fdHQ29tDy/hZDVrMzWEacA+LGn/TAGq2f8rimtX4JRFxyRXe00sCqjbiIR7b0CSItsP3ATneVf7C96rqQcy8uqX5Bdcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Wb1nDJe5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Wb1nDJe5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=abIVjDnFy7gZAhxkN2TMc+r7TSyQ51iHfODbPI/91jQ=; b=Wb1nDJe5opwAQnPqw+8awCXRWt
	DIjdV/yEZsMeYiUb5MZ6hfPhWMD/noIDC+Mv7XbpwHvBtk73jXaSw5GaBM2svaPYfJqQCT0L0ct9N
	YmDLC/jizWqUsNq4QbGL5fQo+J1tbvvNDbMd5GgVBJyfiIW9n6vjfxfys9wsYM+F/Vuky3eh/bwFf
	im6oRWTsRS11QGmX0ce1+x0IBQg3s9UkLYEpSY2jF97jnlOW+qg/IDg0H0TI0Yst/X43hydyLu61D
	IsZ/p5U1A4q1st+wpPEKN4VlZrwiigfgQUDuo0zZ3ou8ihZnzlB46JCy0h9K4EneRLYWEgZifm76y
	WK9dBrdg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqmJ-001YxA-2j;
	Mon, 20 Jul 2026 16:23:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 09:17:45 -0700
Subject: [PATCH net-next v2 4/7] phonet: pep: do not write beyond optlen in
 getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-getsockopt_phase4-v2-4-8a08fcfa0d72@debian.org>
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
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=leitao@debian.org;
 h=from:subject:message-id; bh=6dTiZSpGCbqFCq3KjHoAffMf/x4ridmrJaJCEm/zBcw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktyZrYEEQw71oYvCUsG+oUT5fFjVI5iUocKh
 eJ1gsKrqOOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcgAKCRA1o5Of/Hh3
 bTy1D/0TWHJI4tM/v4J26nJUrsABKnDIQkqHc1g9NwRzly03k+Z1PLI4a2RegwTct9FiGn3GItQ
 DEzCphca/+bKtSDN/84afQN3tsafQw8v4kqeDGwK2zmENS+0bass5euiSclzwMFKX7kaP3E/tPp
 zSd+KzfPfjB2kGH6FLcrIXZuYr3H5mae4S5HsEILHSFbY/lTMT26jm5FjIo3+5hHvhZUQjIlh7k
 UJT1VqkHJvvyiBcrL3qUCj35yxVvqkQBKLyu6l4b3MZvl6LMBhm444z5ArvtWURc9/wzSnX4m2G
 2mrkT3MTUkfdqXqmiW2uYETvJ3Xfx+ldpTWGslnE5KS/SnZdIdBRxaPmgtOJcFn/oH4hjR1OWo4
 V691OOYxjX66eJh8Ymvn3eIeoCdGmU4yTxENxqk0qqIluZKdd0icfmHougvz3N8F1Y1+wINufsF
 Z4SCAk8lz5Duzq+RqffMAi7Bd0PNPPZHl9NOATn8AxaeRNA5f6Ha66n4p3EhjEzW5/K4UGt0Pv8
 wE5GDv0cFP0gKAXbT1ACSwLCzv/eN7iDuJk9hrwf/jCNMMzV1ubh7lL0vxpO2ptcqkWA7MPfuc3
 lxurmwzVStDobOJNIZqucLkT+YZdxjqgq/UUH27Q+bY9iGNgWPRVVSWkG45VkAqgnT9MrN9X//9
 xyelBSYMQAz+EzQ==
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
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
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

