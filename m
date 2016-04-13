Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:55850 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965180AbcDMABB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Apr 2016 20:01:01 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: UDP stress-testing
In-Reply-To: <57075C35.5070206@haw-hamburg.de>
References: <5706C0D7.1040000@haw-hamburg.de> <20160407204125.GA4736@omega> <57075C35.5070206@haw-hamburg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 12 Apr 2016 20:00:58 -0400
Message-ID: <11304.1460505658@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Peter Kietzmann <peter.kietzmann@haw-hamburg.de>

--=-=-=
Content-Type: text/plain


Peter Kietzmann <peter.kietzmann@haw-hamburg.de> wrote:
    >> Change tx queue setting:
    >>
    >> ip link set txqueuelen 1000 dev $WPAN_DEV

    > That was the parameter I was looking for. Increasing this queue it is
    > :-) !

assuming that you aren't sending packets faster than your essential bit rate,
increasing the txqueuelen just increases the latency.

A queue length of 3 or 4 ought to be enough to keep the transmitter busy.
Setting it to 1000 just causes bufferbloat.


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVw2MOICLcPvd0N1lAQIa2wf/ShQa4krLfTl9WQ6MfCzYsv2ruribSX1E
0uZK+wgzSwSF067lboZYDPlRCX1r/ItW3aFFbXLDQfGtavXq4l047p4MiWDVvlTu
ZJGaTSYpSuyNDcHOvcj2njthwuAIpE1Ugc0ODbaxHdxoZD3o6EGXYCood8gmtDSY
il25VAIHXUoIPa8osJDkWlpTxECNJ/vfjGRSh8ayy7cuSn9NJF+a9ZHc7SfGvB25
NDmJpCQCopW6NDsByPEnzbiHUCtuTfNjzps+QdcVggEHBzYXeXeOZhGWQdRVMnW2
U2Fz76Juqb2gkqNr4wEw/iMLXQACqSmRBM1+pGsmZnbbOqRhR8Ge8A==
=Rx2H
-----END PGP SIGNATURE-----
--=-=-=--
