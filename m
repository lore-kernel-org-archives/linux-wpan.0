Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939E3CFF7F;
	Mon, 27 Jul 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146846; cv=none; b=nydoTV8QyoZhy9qxedCb6C7gAUr8ms6c6BOxEMSGlTeLXPdAxQm07C/RVFnJh9FTuaoI0Q7GYgPMM1FYQyD27Dq9nP8mfV91NQ4z8jkn80zMKDkovVXRWM3l8+Qpfvc77MAAF5gAp9MOY0ADeIlFTDr+gJRburJsvztcczqfDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146846; c=relaxed/simple;
	bh=GgXKMHDK0me6efUc8/5zIk/fsw1W8M0GPj4q6iMwcPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhJJRQuW7FwFCYkzXlyWyl5oXJqHkG6k5F4z/tBvYckWQjaaoEdkYwq9/rGV+kBXRF2CkqMdtjtH5+kOR/ewN0iI3fTD9Hcc3UhWbpbB7YB6FGwrPmPx4D0gyXZwX45guh6uDfue/eLKvFM8A5xeQsFBJTsbxwkgsIV1tINiKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qWO/3mV8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qWO/3mV8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fTfL/jDhM4OHXtLgYNY9+NbalgDa4CGzoaUr6+xBA4I=; b=qWO/3mV8NCMwzS6H5zxdwRCYFQ
	1wVM1s2rEoQflLiV0X2T2e4BoLFJHtJxxPoAQ6IdUOV2nIEiVFlh8V4MLSAzhwTX/HgcqmtHbyA9L
	oMyHTDDJ4z8BWtTmUcBzh4n2+5Xr2sDlhMiWpN6FnT4dvi6Mdze+HHIuL29wvIxQNBaAeZS83hmbn
	ExqZf4o4Fvj77r3O0vKUvSWmKlzwNrivRsleU9dTi2TN9dMGoZFodEg8iJ39BL421ucYYzFmrtJX+
	9mQbu8FpgW/CgcyAEm2KfLGpilQ02yGrRinhf5+WsxCMnrbbqFjH6h9dTI6NjnOTeneDd82ZP8Eav
	Sho4S+BQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIF0-006otx-2k;
	Mon, 27 Jul 2026 10:07:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Jul 2026 03:06:38 -0700
Subject: [PATCH net-next v3 4/7] phonet: pep: do not write beyond optlen in
 getsockopt
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-getsockopt_phase4-v3-4-e89627544639@debian.org>
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
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=leitao@debian.org;
 h=from:subject:message-id; bh=GgXKMHDK0me6efUc8/5zIk/fsw1W8M0GPj4q6iMwcPg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy23PKq3EJqLG0Psv32twPzLr0u7JhmRP3daV
 TkF/o+8kQKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttwAKCRA1o5Of/Hh3
 bUDvD/4/O9Mi4UR7JiiKYVgxBlraj0oTk4J72Azglr1BMwHgegIkeX/COampuz7NB/yj3TEaeD9
 4GLGYcIORXZEVT0qN/fp5Z8220zEFJq92f48epINAxCcwax4LtWtQaqIiCj7H/J9Ovh2x/ykr0a
 jzwl5yBbgk38tHgPQic7LYJt5Jft94Ovl6HpX/4B25Z1ohE5WnsSbMQ4Q9faNGpAkqUn98PfbfK
 dNDgH3ASUPW9cyKkwLEYLwwcz7nlL7KQLvf2Iq51ZwuRq8H/sp0jLy9pc28dXELtkY50jkxnuBB
 x+aKxKZwNCsdVneqPZOSx6fJ9zjNkKfsZ8N1XOBsby5hC5y3Oi07ef7o87595u01baCn3nsw54B
 UMIjm54AxFuQ9CwDAMEFacF4fLlAK8KVbvVwMMJkzO3jXYa+uK9n0Uwh8q/GRWDnDCgOEnQ45ZB
 AximmYO9So2IockxwvbZo5O8cy8dxhjZQilbXZawCHgKPYaKKjBPRTK9BE38tubceviqYY9m0dS
 ftuOI7YunufkvVoKApWwQcuEw+oxVPac5Fy1/XOpVgD7NB0sHY7XouoqBpE1d+MDiuJc6L/EXYH
 t9UIOEBHR6aaB0cq0ylyOmQAzpAyBKd5WhnhuqKLhWx5nWXPrVUo+QH2rFZAfkio6tiGxgYEGrB
 oVwRLhyuMNq0pQw==
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

