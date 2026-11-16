Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844289;
	b=L/RmMiyppGgBoXy7muy5TOZkx8g71Ga2uAL3StBL4msP5a9OHKjsqNtXqOH9MiaVm6qH
	 3Ac9lx+8IN8DlInaIF2v0CbpjK8v5nH9zgdzuIemaSAf0Sorp3cDasNM9B/vX7wtnw3V7
	 5Kkv+9EhtrPvAtarYQlV1/90aoFRtpVVonWRVcCpZ/tthi3hTn35jFvPvsdnr0leHn4dY
	 JrcXJD47Gt/UKeOIZ1c5ncDd3DgKHMFkbNca1R2xrOSURFnxqHvysstcYOdTBk8GwaOat
	 jXa+tBLSqGvaBc4/5+4kN2MjNPHfutmSkblHvSQ+7l4DoKPDTUuz/LbVq+OXtPJPZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844289;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=mfCjSvCuwLkjK4efdjwY+e1pbUHdgjIa23tD5eKc4ts=;
	b=N2Qu1nBHTYPjt8/5Og780G4JMPavnCHhG20Dz037uDCuIUzY2GO+abyiWZEx7CmSlt2x
	 hq3o4ol5nPjQHiYzU+qLeYVok66VPAbk9MZLDhBuFFl7GNx27FR+hew7rKJr1fWt/Sni6
	 17zj7L4IRg+4DfVTliZpW0unOcjKQ37Rsux8Los9HXmOlXtebt2tEJ3s2nAMPKsKxT1Vm
	 /ckN6l8W85JfevXj+cLg77Z86jbshMjgeDAuVJwQS8CEn8CWd2oNqSKYn94+Ta4rL67ua
	 xMhLqvgXXJWyRIC3LrVyWiCLai37CVYRfSHD0xfRk/y6U6/lcHJgQx0hxCJuzhhXBRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aCXp3fgK;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59049606A31C;
	Mon, 16 Nov 2026 15:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59049606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aCXp3fgK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC36C1A1698;
	Mon, 16 Nov 2026 15:51:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 869266023F;
	Mon, 16 Nov 2026 15:51:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4FF911BC118D;
	Mon, 16 Nov 2026 16:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794844280; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mfCjSvCuwLkjK4efdjwY+e1pbUHdgjIa23tD5eKc4ts=;
	b=aCXp3fgKMC41JzORug4XNR2OydC9p9Lo8NRkWNucj6Q2DQ+HBMeC38m3geD0jgzW+xdY4f
	1pQ6S6V5vr5PhqLUaz7sqdcrdZUZmG+D77HJY7HDd2yqAZGYPmzDcFIZQ426IFWS9WJyaA
	3F8fU3vFsjCcQW3qYcnIssoPB2Qua684bsPWYY5SKVzmcS6ek9fSQn2hBTfidqaXMHqVjR
	MVFIQTk8dFFpgcEfLI4GgW/IboPekS9BiiWF28gtxXw5ByIq+zHHvtaUR3+HWGPhfkKwFm
	QaGt/QLcsIHcDyMe0lC8aqJVX5ESf8j0rwH5zehG0RSb38P4TIYd85QJoS+dzQ==
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
In-Reply-To: <20261019190736.33bc37e6@kernel.org> (Jakub Kicinski's message of
	"Mon, 19 Oct 2026 19:07:36 -0700")
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
	<87v77626rq.fsf@bootlin.com> <20261019190736.33bc37e6@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 16:51:15 +0100
Message-ID: <87a4n8rczw.fsf@bootlin.com>
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

On 19/10/2026 at 19:07:36 -07, Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 12 Oct 2026 19:00:41 +0200 Miquel Raynal wrote:
>> I thought this had already been fixed but apparently not.
>
> FWIW / in case it's falling thru the cracks - we're expecting Stefan
> to pick up mac802154 patches. Please shout if that's incorrect.

Stefan will probably explain it better than me, but he has been our main
"sink point" :-) and has been handling the pull requests for many
years. Unfortunately he reached out to us recently stating that he was
lacking time for the maintainance.

Right now there is a bit of backlog since I was off the past weeks, I am
catching up on the ieee/mac802154 reviews (except llsec and 6lowpan,
where Alexander has a lot more knowledge).

I believe the flow that works best is if you (net maintainers)
"continue" applying the patches directly, especially since these days
there are only AI bug fixes. We can definitely re-instate a formal
pull-request relationship between us as soon as there are new "features"
being discussed. We (wpan folks) will do our best to respond with timely
feedback/reviews.

Thanks,
Miqu=C3=A8l
