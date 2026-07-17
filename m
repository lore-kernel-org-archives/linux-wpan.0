Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D4391832;
	Fri, 17 Jul 2026 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271060; cv=none; b=sj1jfzh7+DHbzcXJs3JXXnnV7fV2NzF7FdvZ/i/Z444l0CF49TeRmfkVrHDX12JhhOCkoiVirgx6u7YM2IPioV7fq2uT+LJrtOASsiK85G1e3cucbftgRCy2aioN+YPgUYa+LHoOklVASx387LMzsKuU9OMqDwH2yKYjKZQ2YhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271060; c=relaxed/simple;
	bh=tQ1b/9sAWVAQtrk+yZ0y7YQfgWnk/FgabBYf0B1jYJ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qMrPtQjLO8yWmv8/tPB2uFqshk+/PMdu+z0mM1Tn7k2vgT0nDcYj26KU1L6RaKqR3yrLusSADS0i2Tz0o4xOq4cFTAY1sbfjiy+b7I+a5frcr6dg4U21Ev64U8+2sIXaVk1oNeO+qG4WUYmpGdp4A0qvwt0mCRxTte5qxa93jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id D4CB0C0267;
	Fri, 17 Jul 2026 09:50:49 +0300 (EEST)
Received: from ehlo.thunderbird.net ([2001:14bb:cc:4294::62a:201])
	by ursule.remlab.net with ESMTPSA
	id YJXhI8nQWWocgQYAwZXkwQ
	(envelope-from <remi@remlab.net>); Fri, 17 Jul 2026 09:50:49 +0300
Date: Fri, 17 Jul 2026 09:50:47 +0300
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_4/7=5D_phonet=3A_pep=3A_d?=
 =?US-ASCII?Q?o_not_write_beyond_optlen_in_getsockopt?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260716-getsockopt_phase4-v1-4-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org> <20260716-getsockopt_phase4-v1-4-4f45cb12dce7@debian.org>
Message-ID: <3B919578-1330-4337-9FA8-2571A64DD9CD@remlab.net>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Le 16 juillet 2026 16:00:02 GMT+03:00, Breno Leitao <leitao@debian=2Eorg> =
a =C3=A9crit :
>pep_getsockopt() clamps the reported length to the caller's buffer with
>min_t(), but then stores the value with put_user(val, (int __user *)
>optval), which always writes sizeof(int) bytes=2E A getsockopt() call wit=
h
>an optlen smaller than sizeof(int) thus reports the clamped length yet
>writes a full int, one to three bytes past the user buffer=2E
>
>Write the value with copy_to_user() bounded by len, so at most optlen
>bytes are copied, matching the length reported back to userspace=2E
>
>Fixes: 02a47617cdce ("Phonet: implement GPRS virtual interface over PEP s=
ocket")
>Signed-off-by: Breno Leitao <leitao@debian=2Eorg>

Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab=2Enet>
