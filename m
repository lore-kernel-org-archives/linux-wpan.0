Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012693;
	b=ls9n68TPd8zGbqm7wuY+LdMGb1XTC5nJdLe6nu/Ar6dSg3Ee7YhnRQ8m/fbrMPOt3V2i
	 4NnBKdRelcg4y5QU3jc1s4d7uF2Xmkek/u07fGCVUtNJenkmzWWH7VFkgq3wOV34FvQ4D
	 PZzH9vF3MpzyL5YrccHuXImUJcvX+fqwUg8C+UJpjx+UJR8SOGAJ7ZUU/KNKBhA7PlRMU
	 NBoz38wii2yBaAqdxbItGoWP1wtjv+ZQ9DHGymJdIXMXzSSW3RnwWaRheCA/UCEAeNPKt
	 Rg7GSy7PrGmUJ3XmOvz5TVluLTLq20VHNwkjw/GWOicoaPnohIHAD+6w2sEfzuIiGJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012693;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=3+Zi6K2OfmBkf30MZlAKpFjBX1WG9A4Bx3cdtRChyMw=;
	b=Iib30mknhSI3HUk86k4Q4Fzn77g9ihAXYhFeYd56h9Pw+OgH+TJADZCtn3XzOFdOG8QI
	 g8h0PzN4bCDba87S72rdT0qB3zn8hBR6EO8wSGLma0STHiYNU1CQa0ohG63uMbQ57ZxhE
	 UWjAU920y3yRW915pppFjB3mSAm6hsU6enoOWEAOQJxWJnpZfunlgvx/hF09Ke0fiuzgX
	 1+oUJycQQWSPBJAjAIWdDg8ZUDqhiy6edIHm6gz/EJK7+Z2xvVCSzhsnIFSH+Dmy14O4s
	 90BwDTIpyh1329il8uk63Qzw9dVF4+caJNM96VQszZrDxWEQNL10e9uWkMhXZ5mYSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xia49CV0;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EF606A31C;
	Wed, 18 Nov 2026 14:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 982EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xia49CV0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D0C7FC4F77E;
	Wed, 18 Nov 2026 14:38:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F30F35FE9B;
	Wed, 18 Nov 2026 14:38:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA58911BC228C;
	Wed, 18 Nov 2026 15:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795012690; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3+Zi6K2OfmBkf30MZlAKpFjBX1WG9A4Bx3cdtRChyMw=;
	b=xia49CV07DCB8eNdPiTE6ffzODkNtXu8Z0vsVx4re4WBOIrqKNtNhurWm1k1YFCZCEeAJn
	Zw2J8/mJVH4oujc4bm9wesYnS5tz49LPd0q+sGw7rUBVHbtKRfjaxwbuozhaABbpu0/cZt
	AXd0mFxi8UUiA3xhG47B8BQVpcPd6stV61ycKG62TEqtUWgyoKkBPjjU5cGkWLYQ8pJ6pT
	RPavpAjoGK0Rf8vOzpPFMy6WKEFX1xhta/0RE4IpONc5nai8wQHsI4mNN+xKp2M6RNjy1t
	ZaniuP6bCl7P5xJQgia11Ewdlu0XQfvlL/41+S3g29D3esVptsUXAPmEUCzoSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aryan Arora <aryanarora.w1@gmail.com>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  David Girault <david.girault@qorvo.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during
 hardware teardown
In-Reply-To: <20261116141114.30ead071@kernel.org> (Jakub Kicinski's message of
	"Mon, 16 Nov 2026 14:11:14 -0800")
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
	<87v77626rq.fsf@bootlin.com> <20261019190736.33bc37e6@kernel.org>
	<87a4n8rczw.fsf@bootlin.com> <20261116141114.30ead071@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 15:38:05 +0100
Message-ID: <87zev6gq7m.fsf@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

On 16/11/2026 at 14:11:14 -08, Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 16 Nov 2026 16:51:15 +0100 Miquel Raynal wrote:
>> I believe the flow that works best is if you (net maintainers)
>> "continue" applying the patches directly, especially since these days
>> there are only AI bug fixes. We can definitely re-instate a formal
>> pull-request relationship between us as soon as there are new "features"
>> being discussed. We (wpan folks) will do our best to respond with timely
>> feedback/reviews.
>
> Alright, we have a lot of patches to handle so having more help
> (IOW having someone else handle the patches fully) would be
> preferable.

Yes, I fully understand that.

> But if you review in a timely fashion we can handle the manual labor
> parts.

Thanks! If the load switches back to "new features", we might indeed
take over the manual work again.

> FWIW you can use the "Maintainer" filter on this page to quickly
> https://netdev-ctrl.bots.linux.dev/suie.html?delegate=3Dnetdev
> find outstanding patches to your subsystem.

Yes! I've started using it thanks to Maxime's presentation at OSS26 :)

Thanks,
Miqu=C3=A8l
