Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbbCDUYt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 15:24:49 -0500
Message-ID: <54F76A0B.1000903@pengutronix.de>
Date: Wed, 04 Mar 2015 21:24:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bluetooth-next] ieee802154: correct sifs
 handling and new defines
References: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kam9XG9QcN1Gi0mv815BPPMEnd2W8qSsh"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kam9XG9QcN1Gi0mv815BPPMEnd2W8qSsh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2015 09:19 PM, Alexander Aring wrote:
> Hi,
>=20
> this series corrects the interframe spacing time when
> IEEE802154_HW_TX_OMIT_CKSUM phy flag is set. This flag is set when the
> transceiver sets the crc on his own.
>=20
> Also I add some defines from 802.15.4 standard. There is still some mag=
ic
> values for IEEE802154_FCS_LEN everywhere in mac802154 implementation. W=
e
> should replace these values with IEEE802154_FCS_LEN later.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kam9XG9QcN1Gi0mv815BPPMEnd2W8qSsh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU92oOAAoJECte4hHFiupUHHcP/iGgjvZjzahq4XywpHhH92df
TjcM33Bv45yMHUbQ3cRbPsDWBXO37nx+GZ43P+GWWo1hZxZAAhOkyf28UoevtBjZ
UpgjFgjXODXfmtv16UVTlpf5tyRKHr2c/v6aqB/n7wbuFILvH6gUmln7MEuY/0Y/
GEsDg2SZg/bn9R+ogbaumAWI8m82d0DKxPlWlv/0u8sgFO+iYLp6m8dJGH3gNYQo
1v0tNKD/hY4GwSiiMWDpyMaSXjcVewfH6TiHX6bYxR1zmrcs8S+OzL3lI+n76A1r
g8HFZsN6CLKV5wIkpkE2v5320f55+Fq32Ss8ydI/GnLQfUJnnh50Gn/KawMF4rqn
wFr5GhqLNLATmIh1cLrF4pBoaxQ9buMcoupSY4Ec+41QflPkFhE6lSZMlA1gqp60
hR8+RzFIfTwaM4PJenvxg1uSncjZ/HrMBXpBUex7Keis5Ehbf4DOpq02sj71wiav
guyQ0QOSrAyjJv5GJp6Pg+b2EVd9GZtB4BjyfHddOyM6OJnxI0mjPLvQkG/n9r6k
4PVOLG2EyrAWjNLIiHqEIENm1eIe96W8dM9oQ09rdjDpG0AqZSmxhonNweqo9OVy
ODGKxrnjjKM70mg5LVIJnd0g8cIugKaFaQWnCmlB3fBtz+rJOBCndDs7G/bUlTuo
1JiIfYad+jnWZrDWNI6I
=IhH8
-----END PGP SIGNATURE-----

--kam9XG9QcN1Gi0mv815BPPMEnd2W8qSsh--
