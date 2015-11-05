Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp2.ugent.be ([157.193.49.126]:38222 "EHLO smtp2.ugent.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbbKERTt (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 5 Nov 2015 12:19:49 -0500
Received: from localhost (mcheck2.ugent.be [157.193.49.249])
	by smtp2.ugent.be (Postfix) with ESMTP id 3E69312C479
	for <linux-wpan@vger.kernel.org>; Thu,  5 Nov 2015 18:11:12 +0100 (CET)
Received: from smtp2.ugent.be ([IPv6:::ffff:157.193.49.126])
	by localhost (mcheck2.UGent.be [::ffff:157.193.43.11]) (amavisd-new, port 10024)
	with ESMTP id ZXkXx9oJEINM for <linux-wpan@vger.kernel.org>;
	Thu,  5 Nov 2015 18:11:11 +0100 (CET)
Received: from mail2.intec.ugent.be (mail2.intec.ugent.be [157.193.214.245])
	by smtp2.ugent.be (Postfix) with ESMTP id BA59112C46B
	for <linux-wpan@vger.kernel.org>; Thu,  5 Nov 2015 18:11:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.intec.ugent.be (Postfix) with ESMTP id A86FA2F
	for <linux-wpan@vger.kernel.org>; Thu,  5 Nov 2015 18:11:11 +0100 (CET)
Received: from mail2.intec.ugent.be ([127.0.0.1])
	by localhost (mail2.intec.ugent.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_EHqQFHYwWb for <linux-wpan@vger.kernel.org>;
	Thu,  5 Nov 2015 18:11:11 +0100 (CET)
Received: from [157.193.135.155] (dhcp-zdpt-155.intec.ugent.be [157.193.135.155])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: fvdabeele)
	by mail2.intec.ugent.be (Postfix) with ESMTPSA id 92E122E
	for <linux-wpan@vger.kernel.org>; Thu,  5 Nov 2015 18:11:11 +0100 (CET)
From: Floris Van den Abeele <floris.vandenabeele@intec.ugent.be>
Subject: 802.15.4 SoftMAC devices in linux-wpan?
Message-ID: <563B8DAA.2050001@intec.ugent.be>
Date: Thu, 5 Nov 2015 18:11:06 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nqnf4NfrssjXam020ENE2ehnspMrF1ux4"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nqnf4NfrssjXam020ENE2ehnspMrF1ux4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I am looking to get a purely PHY radio (so called SoftMAC devices) into
Linux and up and running on an 802.15.4 network.

In linux/Documentation/networking/ieee802154.txt I read that only
monitor mode is supported for SoftMAC devices:
    NOTE: Currently the only monitor device type is supported - it's
IEEE 802.15.4
    stack interface for network sniffers (e.g. WireShark).

When browsing the source files in the linux mainline tree, I also
couldn't find much on a kernel level CSMA/CA implementation.

Are there any other purely PHY devices supported? I saw the cc2520
listed, which in Contiki at least has its MAC protocol running
externally (i.e. inside contiki, not on the cc2520).
How does a cc2520 with linux-wpan perform CSMA/CA (this could help me on
my way significantly)?
If it doesn't, would it be feasible to implement CSMA/CA inside the
kernel? I'm mainly concerned about strict timings and concurrency when
running CSMA/CA in kernel level.

Best regards,
Floris


--nqnf4NfrssjXam020ENE2ehnspMrF1ux4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJWO42vAAoJEB7YeVptYoaUVh8H/0NI9H3swJ4Sb2OJAgY2+Dsk
RLGzA8bwIMSDO6D8AMMvqMMYaIxuGVFbARQ3RoDt12WJdmQbso7hq/M8MiS91ZDb
s53+cw20fO3DMKefBCGzTPLvuTwlt9ACP8g9T6yDaFNn/5FP52kqTAqJdmvdeNR9
YcGx/NrIfaq30r7RE2AZXqiul8z/KNZIBBnt/yo/Xi0jk4+ZFmfKvtvlW8TjRD6q
iv3cKWfI5L5JrOPz7kuT4Y+5FqPWMaQUWLcka5sBzInABGZOxXLgZKqWJgIO3l3B
AL90WwKDeWsP063W053OokOKSNCZVMUFCakT7gAPo4j/fi050xSHdDw1LbU7G7g=
=nb5B
-----END PGP SIGNATURE-----

--nqnf4NfrssjXam020ENE2ehnspMrF1ux4--
