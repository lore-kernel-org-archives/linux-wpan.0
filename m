Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CC6D6FC
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mk16.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mk16.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mk16.de header.i=@mk16.de header.b="Rfcjmvqq"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T8fky2x2Cz3s7h
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mk16.de; s=key2;
	t=1704825354; bh=lTT3pdTdCV7VDcLnAfTOsu55eGQaPFgMdOltDEIs+Fc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=RfcjmvqqP2lLwpAOU2a1aW6olJqoGkx7evzsvOCHWu4BJG+vnByM33S6eKJOfPzu+
	 +zQQncgkD+nMHGuEP9SDWy40VCam1oDgFTIKam1g9nNiuUCXKW1klxA62MrHM4MY9i
	 TP5XNIwppnY63Oong2hZYwdcTd6IJ4TQFYzEh5i9cTOa64i464kPGqhd4OueCIO6G9
	 r+vINWuXLg2gs/U+DbP/yjIPdpI3onlOXJO63Rnr7XpBj4gvHLuHwJNBraH/Gd86Ps
	 VBEoeGD2O79xCJxhs1PViijgBIW20bIsBXV62HWsM1Q+JXIgD79sd6o3iFtatZGdqD
	 3LyI5rH/xawkw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T8fky2Dqjz3s7V
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:54 +0100 (CET)
Received: from mxe87b.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4T8fky0gSRz8sZV
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:54 +0100 (CET)
Received: from ciel (unknown [IPv6:2605:6400:c5ac:3cc6::14])
	by mxe87b.netcup.net (Postfix) with ESMTPSA id B7DA01C0041;
	Tue,  9 Jan 2024 19:35:49 +0100 (CET)
Authentication-Results: mxe87b;
        spf=pass (sender IP is 2605:6400:c5ac:3cc6::14) smtp.mailfrom=m-k-mailling-list@mk16.de smtp.helo=ciel
Received-SPF: pass (mxe87b: connection is authenticated)
Date: Tue, 9 Jan 2024 18:35:49 +0000
From: Marek =?UTF-8?B?S8O8dGhl?= <m-k-mailling-list@mk16.de>
To: linux-wpan@vger.kernel.org
Subject: Re: Linux WPAN and Contiki NG
Message-ID: <20240109183549.13908ccf@ciel>
In-Reply-To: <26711.1704808629@obiwan.sandelman.ca>
References: <20240108170928.2b1d0fd9@ciel>
 <26711.1704808629@obiwan.sandelman.ca>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JrLjvaNcxX1Dt7b/t.2hN_i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-PPP-Message-ID: 
 <170482534997.3763488.11002345717794644098@mxe87b.netcup.net>
X-Rspamd-Queue-Id: B7DA01C0041
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 7/SxYwUWgFpkXlTVB0kePXvDHU/hx8MIISXIfLBgeABiSMlHEhFFN7M=

--Sig_/JrLjvaNcxX1Dt7b/t.2hN_i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jan 2024 08:57:09 -0500
Michael Richardson <mcr@sandelman.ca> wrote:

> As Stefan said, you can not yet run TSCH on Linux.
> Many of us would like to make it happen, and a few (Alex!) are writing co=
de,
> but there hasn't been a resources to allow anyone to spend real time on i=
t.
> Typically, people combine a Linux host (like a openwrt router) with a USB
> connection to a Contiki or RIOTOS (or maybe Zephyr now) device that acts =
as
> the 6TISCH device.
>=20

Thanks for the answer! However, when I create a new wpan0 interface,
`coordinator` also appears for choice. Is this not TSCH related?

```
$iwpan phy7 interface add test type
Usage:	iwpan [options] phy <phyname> interface add <name> type
<type> [extended address <hex as 00:11:..>]

Add a new virtual interface with the given configuration.
Valid interface types are: node, monitor, coordinator.



Options:
	--debug		enable netlink debugging
```

--=20
Marek K=C3=BCthe
m.k@mk16.de
er/ihm he/him

--Sig_/JrLjvaNcxX1Dt7b/t.2hN_i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmqKBWfzrPNg7whIBfoaRRmmRCMcFAmWdkgUACgkQfoaRRmmR
CMcHKhAApplVdFn82fxIE223lrGObqY03a+Ea2SkK1BtIXCk58YB5S1cOjnkQURk
9a77w6/jGQOjB8cqKXxpXCS0Y/sdfY7rd6NiavbdJmeWInNnwIdzE5E8ZytEMuFb
248J/8PwH3UXfu2RMk6iQqJ/OOsQhh6JAomVK2BNqnJVoj0RFGJrz/2Y5Gx30eD5
hKpj4i2Y86gScD7hiC5Qx6FV26tusuv7MEHSCNKc8XzNIbt1fp7gfgqQOfuW64vy
MPx85rsZTb89bWqC3yhgYgPSALhIHO2Jql5OjRceqVAYxbDdYc3zmKo8MoW8QPr7
YZfn8l+K8n2mNzdzsZoym3okkxzgtm2YgzHr2ySrzT1eiyX39aqGjXftdQkRWa07
1o/Rdk4A+npS30FMhp/Oe30qbJHvVKaXNTMSS5s6QuEkH6zWcuIpV+ilm7ku5WVb
Cgmy21Zzf9tkK7fnknke0HPkZbHhi1jTknA0lTxzXoohXXB+TONbSoIveeNjqRzL
0upCkVW1igKNJQ0Dw1UoFE5ZWh4OiNB9wcWBmz7hiRdxTuJH8/VJMiC8Fpuq0s9c
R7+nFCfO4lH+J9G9APSLRiKNfAlW4rMLAlIsXfhX8Uqt0E3i7EAgdYD//gLugxiX
dS4D6lNOeuRui+XZxrmrHXrSt10tNYPcDSShcCLwAFPWPfZ6aGQ=
=ukiA
-----END PGP SIGNATURE-----

--Sig_/JrLjvaNcxX1Dt7b/t.2hN_i--
