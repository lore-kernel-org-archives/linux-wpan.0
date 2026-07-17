Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13A3C1097;
	Fri, 17 Jul 2026 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271128; cv=none; b=E1H55Yy96Zr1GKmSdKEx+kGOW7ZrxnaKg8r7rAqCBR77RBBZDpFWUEXT27/pQVpjLIwH6VG5z9ttYeDLt1J3LAGHyhIQh4TqVeWN3TPmc6c+47AhF1gYuHX66a8Vx4Zku9tMlT+O+MfjYFHTn38lHKHcBijFbNmDJRLZm975RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271128; c=relaxed/simple;
	bh=8eQMlvwWqC6eZ2DEKc1WwypOa6MvuryKowHtVa8tRpQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HxVqKV/pMqbLhFX7EtN4w2IW0+EGJxygHnF9ebS+ZN82bSeKllxtBB01CCrxuHZF5QufN2hkr/WC2opUcDgXsXpPEyj+yGuQ6wyzFYoQOx6Ns/nERi3CpKh7FSP1ZzPm2zB1AjMQzwyRTg60qvzukpWUk12SBQpJA0FUBzKf/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id C4778C016E;
	Fri, 17 Jul 2026 09:52:04 +0300 (EEST)
Received: from ehlo.thunderbird.net ([2001:14bb:cc:4294::62a:201])
	by ursule.remlab.net with ESMTPSA
	id xbofHhTRWWo/gwYAwZXkwQ
	(envelope-from <remi@remlab.net>); Fri, 17 Jul 2026 09:52:04 +0300
Date: Fri, 17 Jul 2026 09:52:02 +0300
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
Subject: Re: [PATCH net-next 5/7] phonet: pep: convert getsockopt to sockopt_t
User-Agent: K-9 Mail for Android
In-Reply-To: <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org> <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
Message-ID: <8CB1993E-75E4-42B0-93B3-6EF461A5A171@remlab.net>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Le 16 juillet 2026 16:00:03 GMT+03:00, Breno Leitao <leitao@debian=2Eorg> =
a =C3=A9crit :
>Continue converting the proto-layer getsockopt callbacks to the
>sockopt_t interface, splitting pep_getsockopt() into a
>do_pep_getsockopt() helper that takes a sockopt_t=2E
>
>The thin pep_getsockopt() wrapper keeps its __user signature for now:
>it builds a user-backed sockopt_t with sockopt_init_user(), calls the
>helper, and writes the returned length back to optlen=2E The helper uses
>copy_to_iter() instead of copy_to_user()=2E No functional change=2E
>
>Signed-off-by: Breno Leitao <leitao@debian=2Eorg>

Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab=2Enet>
