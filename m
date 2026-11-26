Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691115;
	b=as3hqJvlr0ydwRR1uO7pM7suvX3yzypqfeZELEBpuxIj8+d97+t0iQOV6Ulpb86gqN/J
	 LioLlGrjIQh7f7fJ2/WGQ8hmQyjxRvRonP1hMBVEqE/AGB7tefxnfL4QswpG78I3vhEDL
	 xsgmBiky6hM6JhRtww3OC4GHkxYrI1ZzPl0hhpXx0Tsy1LczTZLm/09c/oekSASSxvXQV
	 ng6CvWC7txzmKWzJcmfWbTH0/t97/Gv4xN3BZGSb8fEJNW53izKv5YHKYh4n/al/9DnYV
	 vpoindxG4U81bdm8HnkoEmQwJGqbQOWcKnRjCV500gO3AYPrPyehvKr9QgAB6HEc0WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691115;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=HFXWiHAkj1wetLgDRhC5nOLmwHP9VaiX8muRd2DNVr0=;
	b=qEjIJs00y7CAmUx7fFfFmnEFdvA2EqmaWIOAZE/wsnqsbZWdVLkKlSftDSMYCCEcIz8Z
	 1/P+pS579r/8076M2XBbi0rgZJIEhRHL+19Tl0tItXfD0j/v28DtbeM2w3yOfdf0Ek6Br
	 3m27o0PwQTFHzizLQw+sAwbhXB9nvYoHkI3oyexJBiyiJHUbLcNTE5QF4+2UZq05DpgBY
	 1/9t0iHf+57W4+rEzUFkcxfae11rltbUOdvn+0gLOD4IK/aX6IWSbHmc4h7FDHQMJHNCU
	 jhT9YV+I6v6lNFmowwrXx8Z7QVkpnleoGqRQcHHNqj46eNdR9FQpCqjjH4Dc5KDmLlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srQDhuHh;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C88606A31E
	for <linux-wpan@vger.kernel.org>; Thu, 26 Nov 2026 11:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srQDhuHh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 49A5A4E4179C;
	Thu, 26 Nov 2026 11:05:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 181C960237;
	Thu, 26 Nov 2026 11:05:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D46E011E6B363;
	Thu, 26 Nov 2026 12:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795691112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HFXWiHAkj1wetLgDRhC5nOLmwHP9VaiX8muRd2DNVr0=;
	b=srQDhuHh3/St5JIqeUCZsPEPot46UAXyf1g0XXjWn6KPDCW2hNOcFBdSyxkkvIOLJtlGLo
	1phyIDZTF/MxOUg31RFM29QT2zQrcBw0J1X1ghIoVYzDVxXm2vuqQtpSwTxBFRCuuIwRDu
	LqTmK1pKiTxMbI2hyRcKyqRes6evzVE7eXQ7vweTt+4Y9VQ/eltvIyWcNVQenD52exccHi
	4BlxZ++n1NnnsTc+6SUo7fJofsQZjbDzUbayLBHhQdxoV8svAbyj6TJxASgw4NaimwfXNf
	kvzzyL+8Y8zjxoziWHtqGRL0l9UPZuPHNb2qLoKkuXXezNMZxswHs7I5IvLbtg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?B?7J206rG07ZiV?= <leegun25@proton.me>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: take RTNL around ASSOC RESP transmission
In-Reply-To: <-4vARCf0AvznsCw8bnUA-0HXh6HLIvZclkIK_aUJIf4ULKof8WuzgWidE8XZJi5Cndbt9iMVb_IiHNVA4W6GDQlym0Ny8mSRaxRCojci95o=@proton.me>
	(=?utf-8?B?IuydtOqxtO2YlSIncw==?= message of "Wed, 25 Nov 2026 22:35:11
 +0000")
References: <20261121150835.256812-1-leegun25@proton.me>
	<87se0qqd5l.fsf@bootlin.com>
	<-4vARCf0AvznsCw8bnUA-0HXh6HLIvZclkIK_aUJIf4ULKof8WuzgWidE8XZJi5Cndbt9iMVb_IiHNVA4W6GDQlym0Ny8mSRaxRCojci95o=@proton.me>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Nov 2026 12:05:09 +0100
Message-ID: <8733snyhsq.fsf@bootlin.com>
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

On 25/11/2026 at 22:35:11 GMT, =EC=9D=B4=EA=B1=B4=ED=98=95 <leegun25@proton=
.me> wrote:

> Hi Miqu=C3=A8l,
>
> On Wednesday, November 25th, 2026 at 03:48, Miquel Raynal <miquel.raynal@=
bootlin.com> wrote:
>
>> First let's approach the numbers. 4ms is on a locally run simulator. You
>> are fixing a subsystem that plays with radios. A physical IEEE802154
>> radio would probably bring the usual bad case to > 100ms, and worth case
>> would be above the 1s boundary. So taking the RTNL lock as you do it
>> there would no longer warn in dev mode, but might lead to a DoS.
>
> Thanks for pointing this out. I also found that taking the RTNL in
> the association response worker causes association between two PHYs
> on the same host to time out in hwsim.
>
>> Reviewing your patch makes me realize we do something even worse: up to
>> 10s waiting with the RTNL when waiting for an association response (for
>> which we are ouselves the initiator). That is slightly less a problem
>> since it is not remotely triggerable like the approach you propose, but
>> still.
>>
>> I don't remember why we *had* to take the RTNL in the mlme_tx path.
>>
>> Alex, maybe you remember why?
>
> Commit ddd9ee7cda12 added the RTNL to prevent ndo_stop() from running
> during MLME TX.
>
> I also found your 2022 device_lock proposal:
>
> https://lore.kernel.org/netdev/20220826144049.256134-11-miquel.raynal@boo=
tlin.com/
>
> I tried adding a per-PHY mutex shared by MLME TX, ndo_open() and
> ndo_stop(). With this change, the association response worker uses
> the new mutex without taking the RTNL. The existing MLME TX wrappers
> retain their RTNL requirements.
>
> In mac802154_hwsim, association between two PHYs on the same host
> works, and I saw no warnings or hangs during 5,000 association
> requests and 100 interface down/up cycles.
>
> With an artificial TX delay of 1 second, bringing the interface
> down still takes about 900 ms. ndo_stop() can still wait for an
> in-flight association response TX while holding the RTNL.
>
> As Alex pointed out in the 2022 discussion, page/channel changes
> also need to be considered. These are not covered by the new mutex.
>
> Would this be a reasonable direction for the fix? If so, I can send
> a v2.

Yes please, let's see what it would look like.

Thanks,
Miqu=C3=A8l
