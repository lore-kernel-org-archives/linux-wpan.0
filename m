Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681E31E820;
	Mon, 27 Jul 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146821; cv=none; b=OBN6gb01W9l/Db1G2H/AWjRqCa9Xa1Zpw1VhmjGd3pabFu9JjbVwqoNnomA1lp6Qp97JHiYMTnKMMbJOXktv2dPd1ps7bexvvuxBd0PvLr7XFYUVDJ7mwqZRiwO2fKgH8S953FMVyxeWTOP1AlyjdX8fc80SOTZlj0nf7oqoY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146821; c=relaxed/simple;
	bh=4NPqPcWpwotJnjVLLDUBduZOBxwBnvIQGGsHSUwfPyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJyOMjCTFT8RE0OPCroK5lHPIdTdx6ve5F07I2oTStBtH3ByBtAMEHZc34rIcclh9SOuG1Un9KfPY3AmSNx25r9q6uqXAOzgYf6J7bTZd1aVOhsi8bYluPH4XAASp5DX+7gdw4rq43AkVWnTy5G59fqeKzfrt8/FVJT5uFLlEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NLWJrUXi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NLWJrUXi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GTyQHv3io296hlH7liLIH29JJ5mx+n2lNYZEFK3Ltuk=; b=NLWJrUXi309NY17PIxSi3Pjfk4
	fJN/bxrb6bjUvbYBRMLRB3vUSUQMnDzN922gTI9kv31T7k2snqH3Io1lTG+DbX1ExE1avg4uKJBSh
	lnoUlu2S0PxiaOE97qZVFitRC0Uob0iebzD3M95FEzG6pSqZ46X+YoEYJX4OKDOCCsfJFwWfytPRP
	joJ4gUanLK6cpciYA0hkq0iiUTXxTcDutk8lnILHr8SZ2mMBylNL83YepLj37cUJdkRvqMAopzeeZ
	jiIEeT3Jkwn/w68GMrD4pO4FRNM9gi5xL7i2RqABaJuKGJOHKhCmOmDOgzpBT2/Mg9slMyF7Tpvd8
	ncB59fEA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woIEW-006os9-38;
	Mon, 27 Jul 2026 10:06:54 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/7] net: convert rawv6, ieee802154, phonet and
 tls getsockopt to sockopt_t
Date: Mon, 27 Jul 2026 03:06:34 -0700
Message-Id: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKstZ2oC/23NTQrDIBBA4avIrGMZbf6aVe9RSjFmTKSgQUVSQ
 u5ekC5a6PrB93aIFCxFGNgOgbKN1jsY2LlioBflZuJ2goGBRNliJxo+U4peP/2aHuuiItVc9Cj
 xoo1uUUHFYA1k7FbMGzhK3NGW4F4xWGxMPrzKLIvSP277x82CI69N3ehRyElTd51otMqdfJgLl
 +UXIfEfITnyXmFvtFE4dfKHOI7jDSsokQUAAQAA
X-Change-ID: 20260715-getsockopt_phase4-180209cfc60a
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
 Joe Damato <joe@dama.to>, 
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543; i=leitao@debian.org;
 h=from:subject:message-id; bh=4NPqPcWpwotJnjVLLDUBduZOBxwBnvIQGGsHSUwfPyk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqZy22YWF3FuS8kdCv4poHO8A8p0UXAxGY7nXPU
 BmynVWYOVOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamcttgAKCRA1o5Of/Hh3
 bZrOD/915zPBkHco03W0L7IaQhHTq4Y0gER43Ch8QubBg3tGLY/GLul9xNsfpGrQufpZUIEJQYv
 aRXHEW2+WKm6c7cQIBQ6oSCoGlpIKdrS9pkHpTR8UG2A83YjW1+6O39FH/HssIh5cEVnTU/BCKs
 ieu/o7cMtQL+20+q3d3kRasGvDThHVrv/C27CoL4DBri5edrhWdey8V9dcFOFY9Uu9wk2jFZx6v
 curfCK3dAz3ynUrN2h/a3wLn0uKiUx/ulMQQwSkGy832/CBmmNbKOTbWdlEaocddE/r5Nsb3qPW
 /jzrHt9OTvzaRochx5p+9KsNXV1tAlkmCIA1GkH9Wp0RIHtJ2T5E491DgQs6MUq9sPmotCoWEvN
 8kW5BSqbwzJVLCOf0yB/UR5jg7q5Oc+RPrXcAt9GH/WY81WVeWtCRiAnEoxDQ1CV8Mk4PzKIQyk
 adQkclsB7RIMADZbw7Y0iG/1v5mvuRGvUxBLBeOCnpk5IcUxyGuEWvjyxBVY9/lkwmzmkOn4fmN
 vrdOrcC5v2mX+YbD7Vl8xr4vl3UIwf159nMK2wmFXC2QbgzfEZNGKy9Z2pVYk0FnctW6NSxRkPr
 ocym0qHs/hF3pyR1+81vqj4vyYrXBnK8iWPUCeTyH0zXlBevGnYYkoWuARIzqXoMMAcu9PJbrax
 6BvCgcy9NXVlraA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Now that sockopt_init_user() was already merged, builds a user-backed
sockopt_t from the __user pair. A getsockopt leaf can then take
a sockopt_t behind a thin __user wrapper: the wrapper builds it, calls
the leaf, and writes the length back to optlen. The leaf copies with
copy_to_iter() instead of copy_to_user().

Convert four more leaves the way udp and raw already were: ipv6 raw
(do_rawv6_getsockopt), ieee802154 dgram, phonet pep, and tls
(do_tls_getsockopt and its per-option helpers). 

Converting phonet surfaced a pre-existing bug: pep_getsockopt() clamps the
length it reports but writes a full int with put_user(), overrunning an
optval buffer shorter than sizeof(int). It is fixed in its own patch, with
a Fixes: tag, before the phonet conversion, so it can be backported alone.

The last patch adds getsockopt_iter selftest fixtures for rawv6,
ieee802154, phonet and tls, checking the returned length and errno across
exact, oversized and short buffers, an unknown optname and a bad level.

For full motivation about these changes, please check the initial thread
at link
https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/#t

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- min_t() -> umin() on ieee802154/rawv6 (Joe)
- Link to v2: https://patch.msgid.link/20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org

Changes in v2:
- Replace min_t() by umin() (David)
- Link to v1: https://patch.msgid.link/20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org

---
Breno Leitao (7):
      ipv6: raw: drop unused level argument from do_rawv6_getsockopt
      ipv6: raw: convert do_rawv6_getsockopt to sockopt_t
      ieee802154: convert dgram getsockopt to sockopt_t
      phonet: pep: do not write beyond optlen in getsockopt
      phonet: pep: convert getsockopt to sockopt_t
      tls: convert getsockopt to sockopt_t
      selftests: net: getsockopt_iter: cover rawv6, ieee802154, phonet and tls

 net/ieee802154/socket.c                       |  38 ++-
 net/ipv6/raw.c                                |  29 +-
 net/phonet/pep.c                              |  36 ++-
 net/tls/tls_main.c                            |  80 +++--
 tools/testing/selftests/net/getsockopt_iter.c | 424 ++++++++++++++++++++++++++
 5 files changed, 534 insertions(+), 73 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260715-getsockopt_phase4-180209cfc60a

Best regards,
--  
Breno Leitao <leitao@debian.org>

