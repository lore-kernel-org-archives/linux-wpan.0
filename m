Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E273F074A;
	Thu, 16 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206915; cv=none; b=AuIXKZNhBjsgEPfdMQ4qhyc3/fI3UT4aMchN1NhE9+Cc48pEfKPpcAFWWK0K/mk0WipXtvaCQZZs4cvCg7hoK3nctm35SdwnkObbXPGSDuSGmvtq99buI2SgwUZTOM1tddVHPB4z4EZC1EgsumszeoQx0yVDvG20Boh/AIzQc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206915; c=relaxed/simple;
	bh=U4GAGj2YU4eWmcdtql84XfYU7hSkRNHblJ6pBV62o30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k02THZg1DmeXwdRPHakihGqzBYXv/2mIN2aYJCq6CITK4Tc6pay0O22aKyBjuddAG1s+ufjnRvBtcCBEBf3GG6yppxn+S/Z1kQK8G9zb4NECovq6LDcRan9MlPvLLBLXlG2+ZgM9yu3XNzNOxuMbT3RxepliRCB6T1yy/BFA4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vXfhm9wZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vXfhm9wZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=/hcMmjX6gOl4gfgW6B1YWlbVzKj0O33UhDJ5XPIjAT4=; b=vXfhm9wZN9VRPszj8LUxvvu99U
	RHCNsreGFDtl9eSyHrp/wzsiX1FAEIe8fb+o7Ww+AuJS6AhhWl3gnu9pZHbKL0ObW0C+YWvLdACzV
	zTSmzbeZdORRM9D+1MdGbqfqQOG/u3QQ8aGqIT+B6ayuZXaPaNs6DBk0Ht//7s4Puqj1FcbjcPrNV
	uQJae7hgxNsv8zhF8D7DyMdXY9UheuGtsI8iXiYZ8De4QiAgv7Hou7JkWB8o4lTMAdtEwTtj/fsZh
	RE4YBUvQJfDrw6K7NgUe3zhLfj16PAfX6P4KApzasVRuyYu+SDaHPMjVjitX/J7VDEvgGyhxNUzSb
	5tJ8oEVw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkLij-003q60-0I;
	Thu, 16 Jul 2026 13:01:45 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] net: convert rawv6, ieee802154, phonet and
 tls getsockopt to sockopt_t
Date: Thu, 16 Jul 2026 05:59:58 -0700
Message-Id: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/VWGoC/x3MUQrDIBAFwKss7zvCKmnaepVSithNIgUVV0Ig5
 O6BzgHmgEpLovB0oMmWNJUMT3YgxDXkRUz6whMcu4nv9mYW6Vrir9T+qWtQGY19sONnnOPEAQO
 hNpnT/j9fyNJNlr3jfZ4XATjn3G0AAAA=
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
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=leitao@debian.org;
 h=from:subject:message-id; bh=U4GAGj2YU4eWmcdtql84XfYU7hSkRNHblJ6pBV62o30=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWNY0MNsmeuJOzouE6Lb9bvlX3qczyUYBbuxOk
 w3GPbAATKiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaljWNAAKCRA1o5Of/Hh3
 bWC6D/9Ce+QxfE2apqWaAXFIYHeBF3cU8FTVsNDpSYXAQY1THiYLTVg7EZ2cgKSFsRMuJAhGC96
 zy7iORE2n5kw9+GbAX7fax1qFwYe8mIplHlIaBclznrAN4Pra/EilWxsxtu0JziMWPcRg0VQTrI
 3esdSzkAZsVLNtA1f1HkE4Z7RxCgXujItyaX3sXMQgSt9OavGCxOjtiE2V0z0E117PEDOiS9esS
 jZ6PM3PhsskTi3KGxtN6te2HepM+hxkD8h6FHeBDUR55ZdYzCORbxBNYtyfGJavFdvDBWeFDWAx
 pXQ0iIYIZjlQ+gTOEkPp22XrJSIKpQP/TedrtQ5Dx1YoqSoJQb4S8ik0dR6KpdEYtC0bqiI8myk
 Cx4/oVU1P8PhZ7z4XDa+ZE4abjVZrwWVeIKKr+FMUwBRGr/HokBBm51e2cLotJMLZJWU6Rm4i0g
 H73sqcNna/GwYrUd0HQpLOtL3IHPYDrR32mGXqqzsZ5Zb0GcqKgEIsqTxEEOlnV69G8rsIhva3J
 NsZ77klb9K2G8xDUKUhancC8QSm1nDxNB64/IHe76ExA0G5Lt5/no/aDXdm4kV+4t5OtGGWmR0p
 5ergg0TzfikPA9coW7YSXYoQIzg7GeMTAu7RwGvksZQH2GATAw9GCe6HImjorNS7zSGsJ/Isq1F
 Z8lA/KLNInD1uGg==
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
Breno Leitao (7):
      ipv6: raw: drop unused level argument from do_rawv6_getsockopt
      ipv6: raw: convert do_rawv6_getsockopt to sockopt_t
      ieee802154: convert dgram getsockopt to sockopt_t
      phonet: pep: do not write beyond optlen in getsockopt
      phonet: pep: convert getsockopt to sockopt_t
      tls: convert getsockopt to sockopt_t
      selftests: net: getsockopt_iter: cover rawv6, ieee802154, phonet and tls

 net/ieee802154/socket.c                       |  38 ++-
 net/ipv6/raw.c                                |  27 +-
 net/phonet/pep.c                              |  36 ++-
 net/tls/tls_main.c                            |  80 +++--
 tools/testing/selftests/net/getsockopt_iter.c | 424 ++++++++++++++++++++++++++
 5 files changed, 533 insertions(+), 72 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260715-getsockopt_phase4-180209cfc60a

Best regards,
--  
Breno Leitao <leitao@debian.org>

