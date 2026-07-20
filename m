Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15E434E32;
	Mon, 20 Jul 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564611; cv=none; b=UI2oS+HZqqVjEWiHhqnAj8ppKbVgMXL9j3JYtb2LEE+Nvjz8rDTf+FLkwUg6U99QDSl0bgrQey108oSTIwDjqOMju/5JZR2hktr7LtLp0wiaMlsyZ4DGsnbeo8W4IFJNEt+DRQHhnG3bT7LRriMb5d27z8hUUIFPxuW3WJgOvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564611; c=relaxed/simple;
	bh=SzejrOriLA+cpeUfeVMBvF7siN5Wts8gy49a2m3ipqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GQ+6l1/78rU4cI9Un6141S1Icv2Z9oSD3l36vYN2zIqJWNPtaDjW+XOGeBU4e2zYFGmihAnUgB5qz1mNmVeDWX/GyjhmAnqBv7UErJSzn+haAd+RHfo+OJ8HaHPyJymPOoQkn3ajpim0YQeTqYdw7004ICoLbIr8V1KHOmTtjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hFrpIxz5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hFrpIxz5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=osmz0xC6Hl6TK7fE2mvj2DgB1mdDxWmK+OnHbECW97E=; b=hFrpIxz59VYcm2oLOwjTDNF/Vn
	WpL/WiultoCdnZE1OmMzzlDtzzNALJRhIbQMgReqt/b66UwVwbP3ePbqf1atI05KKEqIa7a2KvZ/5
	Qt/7ydwDPcz+MCz/C6MnZYWA1AD2tCDFCHzuqwKNEXcVVm0z2jQsJyWgWvtqLgAIPgJVJvNFisC4c
	tJwD9uy77sGH5ySB3sDtjUIZGv+ZFboeItzBkIxz2Dya0Z4GbAlzhVAOdeiTvHCZHcewguBohQYNn
	nYVn+RAwIukeq/celRb9jiex5W+Yn3uHorjmgqKKpJKdV5RR11zyzemzTo+y2ZHrKLeK4Son9e4JQ
	EhT14yug==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlqlz-001YwA-0H;
	Mon, 20 Jul 2026 16:23:20 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] net: convert rawv6, ieee802154, phonet and
 tls getsockopt to sockopt_t
Date: Mon, 20 Jul 2026 09:17:41 -0700
Message-Id: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZKXmoC/23NSwqDMBRG4a2Ef2xKEny0jtxHkRLjVS+FRJIgF
 nHvBemw4wPfOZAoMiW04kCkjRMHj1aYQsAt1s8keUQrYJSpVaMrOVNOwb3Dml/rYhOVUt+VUQ8
 3uVpZFAJrpIn3y3zCU5ae9oy+EFg45RA/12zTV/+59R9301LJciorN2gzOmq6kQa2/hbijP48z
 y8bJMN6vQAAAA==
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
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=leitao@debian.org;
 h=from:subject:message-id; bh=SzejrOriLA+cpeUfeVMBvF7siN5Wts8gy49a2m3ipqs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXktxCH7/7m4CIqmlMiR0MUh/4rusN3XCGhWmH
 OdSZVbKN6GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal5LcQAKCRA1o5Of/Hh3
 bepUD/0WmPmw7NzIPKp++5TGTArimtckAzt3TvUUNUoRaDzff5Lfuj1gcLjfAp8XcDseJZApaXL
 LFXS4Rq5+/Z8Tb6CPbYOZNCE4y0Ezh+3B7TxFGpPCzKnLLS+YVX3GCl+xUe4/MkFIF/RPca7WaU
 ripGvHmVmGiZxRI/g8PWV6Gop2wY7IFjQHMcuqhthwvw+mQ2ue8ns/gLnIbfacvDaknK2xQQXld
 lOpOb0ySoW3AD1vhw/w3TzTF2QkmjnwK2mOpzABfJfWkwZYibxoKq5AitAZzNBaw/+9C2QK/YIp
 stLtV/bmRjWd2kfb1d/2S9iWPLQX6OlhzgnKKWQ5j7NmF37QKl/8Im24yjDf1A3w1itCVMtxEg7
 z67jn/otq3A5jjnFzPHO4ssBgSkJVHgG++PICvMbiW2mhMCStLHU2aKque5z6DnG5UC5GYUjIyB
 6iiYiOcYc2jf/cvs7KPOs3AIo+kCf5xF6aaaTSPRdcByXigJVa5XHhO7Z+HQltYsgy5WobgJwMv
 qcFbBSmD3IwHZXnUDko+t76Vq3T1e5i1kvhrr+0RCoJMWzwELVxvF0ooyiDvn9QMkN2anVFnD0X
 NjJX2bSLpoedgtkciNhKvrk9c/boQQbegnWF35SIcP+H4jAv3uO0EIxhOhyInTdd5sN4yo4QF0N
 T+KD9WMCBILXQYA==
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

