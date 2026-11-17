Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907451;
	b=IZAfh1Lxb4vz+lI3mgWx9NJXrnIhaRhgH8kXpF9NDmpENWkJdxECgkJMwmqINjPEZz3j
	 y1h/lmROQegjRVR17t9Fs7PkoZbgA4PW0ibNDob65bI4vvdgdiCj+P7L3IcKcdZ+tpFV0
	 gv/1YTz7brEWO9LGhGhBOZHkFCsIwmVvuYtSOtiZoQwuhMbuDd19QtBflWvexAx92xQzp
	 DirTQ/TascU6+eKKWvtHbQ0dNnw5joAmX0q5kGIys6FQwoOq7InUE9Il6tcywksaw7MbX
	 B2tb2nsc30yvAxdm2hECL9HkkBkibFh4+io2RDut1snCLZTAj5PaWXwRaSzX94ypX2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907451;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=5Fgatla7G4BQ9VbTqYsdtMkxbs0oWIatlP+v6q9VnlA=;
	b=pK//1on6ZRGD0rO3h+89Pb9aUkeMT9kBPmt/MUl5jS0yyCLTQBdJoszlWxPUE1Xlf/l2
	 jjON7jCy4El6wcjCFb2ntGvemDtmUPeIn7dzLCzzi/j+W4ZIr4xrUGmluYbsVl+XJiBeI
	 gA7rYfCdt3JeBB4tsbRgh6IOjsMgL3ZIQuQU+6RvkCCyFhAoomDVQPa6v6vRenlmIEvkn
	 sA+N+FJyhftzcNpnU/BsxTAgHl87uouB9VcETZ8VonJ83s0L6JecKa30Nm5v9Yrviwz+j
	 rPh4JZmQF0Xe6bGNGcYGtUKNXRL+QrIeO//qIrBca/4U+Oa7E2CcMDToqNi3P3B3mKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apVvXnvg;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1A606A31C;
	Tue, 17 Nov 2026 09:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apVvXnvg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8365FC4EDB9;
	Tue, 17 Nov 2026 09:24:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23D765FC81;
	Tue, 17 Nov 2026 09:24:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94A3511BC09A1;
	Tue, 17 Nov 2026 10:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794907448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Fgatla7G4BQ9VbTqYsdtMkxbs0oWIatlP+v6q9VnlA=;
	b=apVvXnvgzsckndn3i4IkqcsaEK4ZinZlIpg5r3VDIVJCZ6Sr7xQiqfTmxzMl0/7s3EMJQu
	hCdHv+9tIeqZURkOm0cCgrzc7UNDi35ZgqR35zv+oPkur9xHBs57CPLpf0ZeZV0QiBu8lQ
	+CUXD2CQMgXZKLthkaasqJ2wWZAp/t7L+HDY3i2ZHqic9w8Lg++vDf7dalIxMcNbY5R5DJ
	T8apEnXxxH8apMiNjw5DvEqA41trvu38wLbwh6WRa8XJ8cmFUbHLMhI9g9/ex+WkHjxlsh
	ZXnCXpW6lQNHZSR8vWiWPPJuwnNT+IC7MhoArNMqyhnxicXmrb3UECygLYqj4w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR
In-Reply-To: <20261107093601.619363-1-tjdqudcks0424@naver.com> (Sung
	Byeongchan's message of "Sat, 7 Nov 2026 18:36:01 +0900")
References: <20261107093601.619363-1-tjdqudcks0424@naver.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 10:24:05 +0100
Message-ID: <87jymboloq.fsf@bootlin.com>
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

On 07/11/2026 at 18:36:01 +09, Sung Byeongchan <tjdqudcks0424@naver.com> wr=
ote:

> PF_IEEE802154 DGRAM sockets are available to ordinary init-net processes.
> Their family-specific SIOCSIFADDR path calls the netdev ioctl directly and
> does not pass through the generic network-device setter capability check.
> An unprivileged process can therefore change the PAN ID and short address
> of a separately administrator-owned down WPAN interface.
>
> In a local fakelb fixture, uid 1000 changed both identifiers and the valu=
es
> remained active through a later administrator interface open in three of
> three fresh KASAN boots.
>
> Require CAP_NET_ADMIN in the socket network namespace before processing
> SIOCSIFADDR. Keep SIOCGIFADDR and all existing state and value checks
> unchanged.
>
> The fixed kernel rejected the same unprivileged request with -EPERM and
> preserved the administrator identity in three of three matched boots.
> Administrator SET, running-device, invalid-value, wrong-device, cleanup,
> later-open and recovery controls passed in all baseline and fixed runs.
>
> The demonstrated impact is local cross-principal WPAN identity and policy
> modification after privileged device setup. Memory corruption, disclosure,
> RCE and LPE were not demonstrated.
>
> Fixes: 9ec767160357 ("net: add IEEE 802.15.4 socket family
> implementation")

Probably a good stable candidate,

Cc: stable@vger.kernel.org

> Assisted-by: OpenAI Codex
>

Nit: extra line

> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
> ---
>  net/ieee802154/socket.c |    4 ++++
>  1 file changed, 4 insertions(+)
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index be8ca1f053a2b..362457de8424c 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -128,6 +128,10 @@ static int ieee802154_dev_ioctl(struct sock *sk, str=
uct ifreq __user *arg,
>  	int ret =3D -ENOIOCTLCMD;
>  	struct net_device *dev;
>=20=20
> +	if (cmd =3D=3D SIOCSIFADDR &&
> +	    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
> +		return -EPERM;
> +
>  	if (get_user_ifreq(&ifr, NULL, arg))
>  		return -EFAULT;

The fix is correct, but since you are aligning those checks with other
path (like IPv4) maybe for the sake of coherency, those checks should be
done in the same order. An unpriviledged user providing an incorrect
device would get EPERM instead of EFAULT in devinet_ioctl(). Not sure if
that's worth a respin though. In any case,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
