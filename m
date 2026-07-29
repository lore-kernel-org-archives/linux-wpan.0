Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC57418A22;
	Wed, 29 Jul 2026 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317486; cv=none; b=j1zsDMPMDO5EDN51fUUVCi5hzAkkBJodzwgPKSAdj7Hy3nHj3x9YYqdP00hZIMlK17hKK18eclfRnqjIc9epEoyE0WoTDnC2lvmla4haD3+1V6hjshctuerl6LgeM34moDUNkLXfOaeDWfojkbmUgSXPybSqX9MNtbVXNLLe9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317486; c=relaxed/simple;
	bh=goi9CPQwE8TpyR1lM4/rc7SLFyr7ChfGkPjSM3o4Kyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uuaUReqBp9agfaZiLhNJw1UBMt0EBuxrfQJahkG6iJJHWWD/cfcCFGiRG+d8kk7HBmxF1Xa+VToIWWwTxDu2xyti4wcTxr/mDEAgsMUKiH3o3i5+JnglmccgALa0q6ZC8WLHB3GyPIn0l0bG+Ako42i2LYAi6OqpfAGnpBujFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=orvOppBB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="orvOppBB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Dr94O1kir2CwIJCJZlyBCOCuwakMlQfT+sHqCQ+HbGw=; b=orvOppBBD7UEuy84K3hRDClzQ1
	GSP5ZU7QrSYTk4/Wlx4SH4ySfWkf0cRs0cHlFGUB5WBjwrXzn4+Ax9jqBdT8P16p/LvitQ5Ez0oaA
	uzgsAhWZ8JJOJyqVTQWNHKfmq2Zj5g/y/YjLBbztju04RG5oiR47BCBKMDQBo0o4s9Z2JQC1P1DwZ
	6nid78iYd+ogCezNAUNPghNojg2hVBSDcb6dcc/LRGhLIRVy1sOhXFNZHxiT6b5hYznpj3FKmLVnK
	8eFlNpIU5meHgMNk/G5KvC34nO/PBdwGcWGo3ZitCKG+MxGJj5gSJo9BWJy3gNXRiuKthi3xPkQQe
	FJ2+LrtA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp0cr-008LzA-1K;
	Wed, 29 Jul 2026 09:30:59 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/7] net: convert rawv6, ieee802154, phonet and
 tls getsockopt to sockopt_t
Date: Wed, 29 Jul 2026 02:29:43 -0700
Message-Id: <20260729-getsockopt_phase4-v4-0-c44576757c17@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjIaWoC/23NwWqEMBCA4VcJc3bKJMZEPe17lFKycaKhYCQJs
 mXx3QvSw5Z6/uH7n1A4Ry4wiidk3mOJaYVR6EaAX9w6M8YJRgGKlCErO5y5luS/0lY/t8UV1ih
 7UjT44A05aARsmUN8nOY7rFxx5UeFj0bAEktN+fuc7fLsv665cHeJhDrozt+lmjzb28T36Na3l
 OeT29ULoeiKUEjYO+qDD44mq/4R7Sthr4gWCbkfjLKd1qYd/hDHcfwA7BBq4EMBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=leitao@debian.org;
 h=from:subject:message-id; bh=goi9CPQwE8TpyR1lM4/rc7SLFyr7ChfGkPjSM3o4Kyk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqachL3sSXl6xSp4F2vxG+qvFn6PGacTQxbt1ro
 MtXFUuv9nWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamnISwAKCRA1o5Of/Hh3
 bRDSD/9+E21HheE9lEFh3E7b+v31ombrGv6cAWNscdKESvr3iAMepcsvVTO431FXrPqV9Ld+tE5
 ntw9jIAviWNIUOAVt7H6dMRFE870+a9VzczWvAJI1MtrfB8ny5T/+QEs8+/SQ1mM+qLZyZYpu71
 7nsMNuij/4KlzXSwdhe2s+fdNdGhsLFeUkdYiOJFAVjfzeZ+3DgmtG5L9CBx6+ztdSoipV8r70w
 q4i9bU7JezUBV3aEugzGUFMDlCe/NdeCh/PB6KWMHwzLXYYl4jKpQBuxZvorR6UYrFQWz8J4/AL
 dIXuxg+f6t9XIjkYAh0XoxVho7oTGHb+tVBE5bpYNET+Wr7REWd2IzbgkCb6WDw8oXq3QzOgqvQ
 Pb+5j9zFn3y8rv985cUECqRVxULx2Aq4CLphQpiMXQ0amKL/jupIVi8sILBR+xXaQI8YsN1QsCV
 +WR8DficJkAJJK2oQd1MSqE4T8ktwH4/LshYBfAZnVgy1Oqk2Bz+hIHxJLq89GeDb0zUuJDW0XA
 YdJpljxqW9AkiwhID0/vxMIa2JU9aihMMDEl+Rz0AAhkRIYpMgk0C8WEiilIV7EqFr8H3km6LWA
 OPTH2fOT1nr5ciEDevpa5/WqRnVYjRLLGZhXDaXtHFJtALwxup7VunYt4dKi/Nu/KgRJBDtan6w
 UrBK1TDDLGVWteg==
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
Changes in v4:
- In the selftest, check the return value of socket(2) (Sashiko)
- Drop ieee802154 and phonet selftest cases; their CONFIGs are absent
  in NIPA (Jakub)
- Link to v3: https://patch.msgid.link/20260727-getsockopt_phase4-v3-0-e89627544639@debian.org

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
      selftests: net: getsockopt_iter: cover rawv6 and tls

 net/ieee802154/socket.c                       |  38 ++--
 net/ipv6/raw.c                                |  29 +++-
 net/phonet/pep.c                              |  36 ++--
 net/tls/tls_main.c                            |  80 ++++-----
 tools/testing/selftests/net/getsockopt_iter.c | 239 ++++++++++++++++++++++++++
 5 files changed, 349 insertions(+), 73 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260715-getsockopt_phase4-180209cfc60a

Best regards,
--  
Breno Leitao <leitao@debian.org>

