Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9093A9DA3;
	Mon, 27 Jul 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194214; cv=none; b=mz50OjkF3aQT/VY2r8XJ2bgmUTlz/jmu9vaKBbxY2IqPIJRSJBdOvgXrrjgqJw6BPXaYWL7XFeYVRqgmHh2nZg+K1xYiMjAaKqgodxJX6jgxqWUB3lLfQuuqas1XsDNWsbniv2RhUiSIi04ayjaAAyCdLjsIlhimyenmp55HIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194214; c=relaxed/simple;
	bh=kZNXlNAfSVusVoPVriJ0v5XAtDbQ3QHe3+Vn4kPRYSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNDA7anV9tb5iNPndyqkyvU6VRjRbW9hkK7CeVKLLgXIqOYpxY7xPAOBOda0QXEIsRyh3BFCcVFW9W7yNNlxs5NtC/HSaRwH4HcdbaTGmHXMaiS96SmM34Khwkc4zqtvFmY2p2w93Ihteoz0IgHd/RYUG99bksE2ce7Qwg6PxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzNM3WgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzNM3WgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1461F000E9;
	Mon, 27 Jul 2026 23:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785194213;
	bh=rHrgozeDMsPrY0ICPPbhjDXHnrKHdRVo/MfyqWmfxWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RzNM3WgTC11of8b6sMJWuBJj6bkb4060jsIdJaXI71TBtU/xNIxCs/tBQDWo/riVV
	 A+v+PA9Jyad7q66wm5U6LYiVT/jtRv7SmK4fBua4LIyJ6IBNvYxk4+S/ImwAkLkRYD
	 t8QxxE6fGMmOAulciSNfDtvJ3raI8r0Bh/Xb2Sx/fdBrDglOjqCLXmHY35gaUv/qRw
	 fJfulV5KpE5cpoO5SedoQAtrx1n6U2BHfnnRT5Lcdlymed7iHq4wz4z+7y6yi3C9vo
	 7TGN0UgHNHfSQk2sZqdvhsUR1YA/bAGWDgsSn+i40V0KsyaQOwDSO1T+PR5qID7JIh
	 Fi7voY/HT5J1g==
Date: Mon, 27 Jul 2026 16:16:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Remi Denis-Courmont <courmisch@gmail.com>, =?UTF-8?B?UsOpbWk=?=
 Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, =?UTF-8?B?UsOpbWk=?=
 Denis-Courmont <remi@remlab.net>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <20260727161652.58de366a@kernel.org>
In-Reply-To: <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
	<20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 03:06:41 -0700 Breno Leitao wrote:
>   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
>                 rejection.
>   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
>                 rejection.

The config options for these are not enabled in the config for net
selftest target. Doesn't look like we're testing anything particularly
meaningful here, so maybe just drop the cases for these?
