Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD754669
	for <linux-wpan@vger.kernel.org>; Mon,  8 Jan 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mk16.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mk16.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mk16.de header.i=@mk16.de header.b="cR2G0SlZ"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T80sq19SHz3tWC
	for <linux-wpan@vger.kernel.org>; Mon,  8 Jan 2024 18:09:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mk16.de; s=key2;
	t=1704733775; bh=dGlG9sRiMC6yNvzj/1xbr3f00OAcpIsaanITHY1M6gg=;
	h=Date:From:To:Subject:From;
	b=cR2G0SlZpY0OtF7r39Xuh1ocz2akeeWpR1oWpoIOCU4/1LLTzhmwU/D4I22KEjKsm
	 sJLWVtypVnf03gmjft9sqQLmtIBpDP9zR/OdNiL48z5UTnkCqloGpDjah/zpsZDKPo
	 V+SQfaz89Vp2UCdSUPNU4FSxeWrWdUtofe91doFCvQ0YgkOksK9Mx+IZ/jvGtEMEM6
	 FphbySKnSUJ7ZAl918x+0AYCuzkvdZl2EmifQZU7KsRO5iNNNAKpEqjjum5FUkwnNo
	 +a7iO01EwQOBIlSevQgDHadMIFQLra1lQ7OZcjvFbi0H5cbCQRHtV3DugCzpeQlYwg
	 VaTwGKxcK/Ikw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4T80sq0R0xz3tV3
	for <linux-wpan@vger.kernel.org>; Mon,  8 Jan 2024 18:09:35 +0100 (CET)
Received: from mxe87b.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4T80sp5smXz8sb7
	for <linux-wpan@vger.kernel.org>; Mon,  8 Jan 2024 18:09:34 +0100 (CET)
Received: from ciel (unknown [IPv6:2605:6400:c5ac:3cc6::14])
	by mxe87b.netcup.net (Postfix) with ESMTPSA id 6954A1C002A;
	Mon,  8 Jan 2024 18:09:30 +0100 (CET)
Authentication-Results: mxe87b;
        spf=pass (sender IP is 2605:6400:c5ac:3cc6::14) smtp.mailfrom=m-k-mailling-list@mk16.de smtp.helo=ciel
Received-SPF: pass (mxe87b: connection is authenticated)
Date: Mon, 8 Jan 2024 17:09:28 +0000
From: Marek =?UTF-8?B?S8O8dGhl?= <m-k-mailling-list@mk16.de>
To: linux-wpan@vger.kernel.org
Subject: Linux WPAN and Contiki NG
Message-ID: <20240108170928.2b1d0fd9@ciel>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HCcb4PYtXxa9ifPkZbPqRbA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-PPP-Message-ID: <170473377065.978488.191273826818566973@mxe87b.netcup.net>
X-Rspamd-Queue-Id: 6954A1C002A
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: awfcE0u+InBDvPxTvaJ4ybItqhcIUhBCObb+mGXqRas7Th5HETGkEyQ=

--Sig_/HCcb4PYtXxa9ifPkZbPqRbA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello dear Mailling list,

I would like to try Linux WPAN with Contriki NG and have some questions
(I am new to the topic, so the questions may be quite stupid): Contiki
NG, as I understand it, implements various 6lowpan standards -
including 6TiSCH, TSCH and 6TOP. Which of these are also implemented in
Linux WPAN and how can they be used? As I understand it, TSCH is
implemented. Is that correct? The use of it is explained on
https://linux-wpan.org/documentation.html.
Is there anything special I need to consider when connecting Linux and
Contiki NG?

I hope it's okay if I post my questions here on the Mailling list.

Greetings
Marek K=C3=BCthe

--Sig_/HCcb4PYtXxa9ifPkZbPqRbA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmqKBWfzrPNg7whIBfoaRRmmRCMcFAmWcLEgACgkQfoaRRmmR
CMcKmw/+PlaNa11G0IwsL6Q5QlXdiNI4jJs7MVzVxBaNFJ7rrjXgoe2S3g97yM4E
LCrWxYK5TCAyl8yGPWhQxTKuHj4T/U+lIQltwq8SmxFaX3z3Ljr3TGZ++FQegjRg
UJQ9EGs4yqJbrd3ekIGTB76HfCDZqZX5DxlmmO2ER09a+ifUVqLAW7LUE9b4sWl4
qhDtwb2nkxZEPb9H8bsIaC+fa5FSjACsp8xY86wTVnGW8GDyRbgw3i6fEpgO1aAF
CE8yXO6+J9J8ELnlbpvFBFBalcdIvk3Z1wesiDNqaZFqOkpUjVYPDnB/zUK4eQOI
+fGkyr4+60zraUklDGihroWHzHNFV/lRGgL+lksg2yr7VWzgzT3odYuFr0UBSuT5
ughT81B9Jh1h/4yo3ULS8akcf3rCwFw6/MFgPWwlUiIllWAHqJbq9rDqU9W96SfM
E9wQ+5nmsjV8ErhULvWCh11VBgJ7/NJMoyBi+5xnUV+ZqLcfUrrrOBKO6nQm9mP0
h713YYpykc2RvFlzi89rrf3g6DASigXCwF2fIXE7Mlpsj4//frau70deeihybVIc
hWZVgpPTyPedj+bcfs9f+TRziRWRrt07f3E6Q6guHjJs19V0JJjqUS3LdQ0FlAVM
sJ/x79sjQIRi4hue+wb30IUMc8xidHjFiT8vsBKo7bRxSCeGxR8=
=LuIj
-----END PGP SIGNATURE-----

--Sig_/HCcb4PYtXxa9ifPkZbPqRbA--
