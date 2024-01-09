Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AF6D6FC
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mk16.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mk16.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mk16.de header.i=@mk16.de header.b="WWPw9uMU"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T8fkh5nZVz3s7h
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mk16.de; s=key2;
	t=1704825340; bh=ln0QqPnctUgmBG7jEJqhkvD4Nw/8TB6tyJW9Wcnd818=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=WWPw9uMUG6tO+L6fkZXKzDwjAzI0XNnlHYYWRkmj4KGuFvEcEEVMEDhFutJUR0iMu
	 rx2caHY+No1V7eNS3K9cG6nvDrpDZgN3d9t5dro3Rj/tkp0WAvngi0TQ1TJ+5H79fW
	 Y6vqea7Q83i8pI83Is7Ub3CuAulAAPvgoDCjErpXWo4rl2P2xC9vhsC1nQrEEosEe0
	 dlQzlg2FCTWIPfEYRvK03wwWk3v3SVo+qRtbJr3IWR6WHCFTiz00aAlhCIwB9gfdoD
	 BZJlseElxqw/kYkpJFXUlJ7+CjQn/BO408aVIPcAxpbQaeom2Qkw640Rqg+X8dKlk2
	 YSOozpOwDwwwQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T8fkh53JHz3s7V
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:40 +0100 (CET)
Received: from mxe87b.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4T8fkh3QSRz8sZf
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:35:40 +0100 (CET)
Received: from ciel (unknown [IPv6:2605:6400:c5ac:3cc6::14])
	by mxe87b.netcup.net (Postfix) with ESMTPSA id 172D81C002A;
	Tue,  9 Jan 2024 19:35:36 +0100 (CET)
Authentication-Results: mxe87b;
        spf=pass (sender IP is 2605:6400:c5ac:3cc6::14) smtp.mailfrom=m-k-mailling-list@mk16.de smtp.helo=ciel
Received-SPF: pass (mxe87b: connection is authenticated)
Date: Tue, 9 Jan 2024 18:35:35 +0000
From: Marek =?UTF-8?B?S8O8dGhl?= <m-k-mailling-list@mk16.de>
To: linux-wpan@vger.kernel.org
Subject: Re: Linux WPAN and Contiki NG
Message-ID: <20240109183535.63067687@ciel>
In-Reply-To: <4f4ae371-9993-4964-a61e-a88d885e1161@datenfreihafen.org>
References: <20240108170928.2b1d0fd9@ciel>
 <4f4ae371-9993-4964-a61e-a88d885e1161@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GGQxSoZ91IwBAYHe1+f=IFT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-PPP-Message-ID: 
 <170482533631.3758721.12027410372191619097@mxe87b.netcup.net>
X-Rspamd-Queue-Id: 172D81C002A
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: kJqVEztMRSOQ6NA5Vafk0MHjEpl0eYz9jfmY8FAE/AXj5RYuQbwphws=

--Sig_/GGQxSoZ91IwBAYHe1+f=IFT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jan 2024 08:34:47 +0100
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

Thanks for the answer!

> Would be happy to hear findings when you tried it. :-)

I have written a small blog entry about my configuration. It may not be
particularly beautiful (written) - but I think you can understand it.

TLDR: Linux and Contriki NG only work together when Contriki NG is in
CSMA mode.

English: https://mk16.de/blog/contiki-ng-linux-wpan-6lowpan-en/
German: https://mk16.de/blog/contiki-ng-linux-wpan-6lowpan-de/

--=20
Marek K=C3=BCthe
m.k@mk16.de
er/ihm he/him

--Sig_/GGQxSoZ91IwBAYHe1+f=IFT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmqKBWfzrPNg7whIBfoaRRmmRCMcFAmWdkfcACgkQfoaRRmmR
CMeCIA//aXGeLpO8cLokUTp/72VCIclo9FRlBYnEpYF4Jl3PyjhTT8w5AWwJ0Ode
aFEXCOGQ0FTXp0kpf1jGpzp2d+XxjI4i5qtLPDCt8VzQaKKMYOI8xABSxmPintFB
n+RH0ZM0864l9seWmo267a7wO/ElrF/szraq/88R36VBD+M7WmKWs0hz6YGQufBH
MbtplkPq7XQs5JDgYgJ0dDRqlPzL65G5enph+NXEn3nWMdtFtBxon2TDSlT5rUpe
80S+hHjrOS7C4ieoB/ZedfzIZQqKFJUjEJd0DdovqQq3i7lpVmAT3uyqsTzzHn34
Gw3fBiWHIAQ4pZPgWlwL0FK9Sv+Ed+LYsuqvPBWvg0XEHBMfWqr5MUECAkxsJHNZ
eLPneSkxvYYL9o0CFZQkf75Y4sDw8Hq/c6BqXG5SQz4cDIFgL9eb9Qa5xhiVjxw0
JHFRcoFQRhDXWhUrDtlYbAmfIB5uekiDc1N+AwHQ5nM2dx3s3TeBf1PQhEJPsA7G
GJW8wBeTM0H9ZGpF2sulsO640RTzzGVCS8CfCefYGINHJD5jwEapF5RGCZeC3GDa
Ftiw2qf/ZkURivX6GCobkmUDq72jYUySGx3UIFKfiJ4hs4Itermol0ZSva5l3Mal
37mQUClgseVC+YOF984F1VmA5JOZZN/Skfd6z5SgX6SF6TJEX/s=
=XCHF
-----END PGP SIGNATURE-----

--Sig_/GGQxSoZ91IwBAYHe1+f=IFT--
