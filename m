Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD21399019;
	Fri, 17 Jul 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271208; cv=none; b=MpOXD4FFAg5ezwirp/BrkLVVyy8PadUwx8m9JTUnie3kHpfu8YER1xni8ZFt/08o4MnU62KbE1+riRvNwWOIqZkSwlDiQE09XYhWy1AR4+6n+GePzusVbmKh9pQ9+er3oyRfLBFg1l4KQRQX7xGYTU4r4K8EjhGjCj2rGpBVFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271208; c=relaxed/simple;
	bh=rjZhK+rzux3E0Ho5AGauH7f2G2ySVu1fUzLTWtKffFE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kiD5Rw9VPIqzTW294iEfuc3vSDayYnUk1nMnIt/8d/WQ3fFZKVQZJ6MaqeFmFKVc3gqE/Z6yGUMaFQaA68loSBzf9nSu2GbAofzGsaEI6Nug0eAsC5pfYXmfUKWjJfcrqvwqDgBgX9vyS9ZMPb/YEHETYVgiZyetBMu7XuK/WjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id AEC40C1725;
	Fri, 17 Jul 2026 09:53:24 +0300 (EEST)
Received: from ehlo.thunderbird.net ([2001:14bb:cc:4294::62a:201])
	by ursule.remlab.net with ESMTPSA
	id lS4YIWTRWWoQhQYAwZXkwQ
	(envelope-from <remi@remlab.net>); Fri, 17 Jul 2026 09:53:24 +0300
Date: Fri, 17 Jul 2026 09:53:22 +0300
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Breno Leitao <leitao@debian.org>, sdf@fomichev.me,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Remi Denis-Courmont <courmisch@gmail.com>,
 =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi.denis-courmont@nokia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_7/7=5D_selftests=3A_net=3A_getsock?=
 =?US-ASCII?Q?opt=5Fiter=3A_cover_rawv6=2C_ieee802154=2C_phonet_and_tls?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260716-getsockopt_phase4-v1-7-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org> <20260716-getsockopt_phase4-v1-7-4f45cb12dce7@debian.org>
Message-ID: <9B622591-E778-4DEC-8031-890F4039E9E4@remlab.net>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Le 16 juillet 2026 16:00:05 GMT+03:00, Breno Leitao <leitao@debian=2Eorg> =
a =C3=A9crit :
>Add fixtures for the newly converted getsockopt leaves:
>
>  - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
>                unknown-optname case that reaches do_rawv6_getsockopt()=
=2E
>  - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
>                rejection=2E
>  - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
>                rejection=2E
>  - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
>                the base and full cipher sizes, the NULL-optval and short
>                buffer EINVAL paths, and an unknown optname=2E It skips w=
hen
>                the kernel lacks TLS or AES-GCM=2E
>
>Each fixture pins the returned-length / errno semantics across exact,
>oversized and short buffers, an unknown optname and a bogus level=2E The
>semantics are unchanged by the sockopt_t conversion, so the tests pass
>both before and after the leaf conversions=2E
>
>Signed-off-by: Breno Leitao <leitao@debian=2Eorg>

Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab=2Enet>
