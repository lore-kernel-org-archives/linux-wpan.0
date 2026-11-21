Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269660;
	b=NsmrGqM66qEhaJ2UmRV734NkfTpdHKwPGvSq/guhiaPq8XgS8lJaWPNrXka618OQjBv2
	 gKts1pmwkwBpRuc4sXpAAq/U/hp4/x4S2zSyzGey+tz5V3TIGGfDtEt0ggJNEyNNwCj6D
	 x2tod/RpsQCv0SII6xLGOW96AVDA8jajev+GqYwJ3UuRY3/qHsYjRzPlG3kKM74nGO+Yk
	 0F8qtEo63dY2wU3CETu/qZhsY0NRHhLiJK8rIc7FRg0747YqXLK3Eeb9qeNzCUYegdhuN
	 n1IW1mesAWnNxr2L6tZgX3UODlMW+/KmEiS3mlDdKOu0N6uGsastCRZuVkFALPkk5ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269660;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MwFTW8oABv8FW3oUTjGDg1HMmAJS9XYM3X/J2mQ6mgA=;
	b=42hVtZlF5cUvi+KuS1Wc+zsVtTKrR5SriGTc1hFdVZa8ku0PrfQeIbpZba8sJkgMIIV7
	 8x16nH1J8+X8lw24yOS4dYECxIP7VO36phejy9oXZyXPRnDbEahJ/qhUvsiexmi9x0U8E
	 IeTunjijDWz0dtnpSN8Hy/ynuY84y6z3Z53+xfIyUkq0v/fsCq/79lTC2vAO9FCsSxoNS
	 Ao4to3PQ2iqoAy04Ss5GEOimt2jb4jVKr+aSw2eEQLCJiOylew4hRmYpfKOVBne9irOCq
	 tIiCdgxNKq3vXtMhAhhlTpHVjZBVly/+1whLjRW6A9A91l1IamnkKLeEbPzytlFbzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=AKkEwbTK;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB4606A330
	for <linux-wpan@vger.kernel.org>; Sat, 21 Nov 2026 14:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FB4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=AKkEwbTK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795269656; x=1795528856;
	bh=MwFTW8oABv8FW3oUTjGDg1HMmAJS9XYM3X/J2mQ6mgA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AKkEwbTKMGOJzYcBVnQre/pbYc612LVYn/48s6qAVMNnRMVV8e0XE0/4A2EZcOEAE
	 51aPTK29KLU+OOsSL+E9DNlmd2rFQDGS5rbOPNxQgc+XW+e3uQe9zh7GrROmQA+XdB
	 p7xnzCzG01bX8o2/TwmYSwm8USqvJnlApSFuiQDUByReLhgp7UF05LbAeAkNKI4Gal
	 7Zurw2+KabK2cTZcBcvuYIg5M3Cma6CjCnnn8QTSEDlekcp2deiDFWGeuAVENrj0eD
	 TLIYmaBp+MxQMIN70Z0Kjp0tnRrWVoE57OfwxhPXk1K6kKEE42elcCfw+eA7TAdJkJ
	 EFQkSHuOsQMZg==
Date: Sat, 21 Nov 2026 14:00:52 +0000
To: netdev-bot+sinfo@kernel.org
From: =?utf-8?B?7J206rG07ZiV?= <leegun25@proton.me>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: fix duplicate association handling
Message-ID: <Fycaz3bGVoczsk-b7KYJTzGdI6Q19DBz_P0ISphwC6vfBJ8wCkGZjmI6nZ-Xr51K9ZJPZSiv-57hMN3eTxaqcBE6azf55fUQ-_xXChb4UKw=@proton.me>
In-Reply-To: <179526791776.3294.14103729218391473997@kernel.org>
References: <20261121133101.240921-1-leegun25@proton.me> <179526791776.3294.14103729218391473997@kernel.org>
Feedback-ID: 167971190:user:proton
X-Pm-Message-ID: 438c4ab8160b448d5e2a12d322d6f4196d3bb831
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The issue was identified during an LLM-assisted code audit of the mac802154=
 association handling path. I focused on this path because unauthenticated =
ASSOC REQs can affect the coordinator's association state.

The audit revealed an incorrect address mode used for duplicate-child looku=
p, a missing kfree(), and an incorrect nchildren increment.

I set up a simulated IEEE 802.15.4 environment using mac802154_hwsim and wr=
ote a reproducer that sends repeated ASSOC REQs. The unpatched kernel exhib=
ited association slot exhaustion and memory leaks, while neither issue was =
reproduced after applying the patch.

Best regards,
Lee Keon-Hyeong
