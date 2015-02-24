Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41048 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbBXKeY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 05:34:24 -0500
Message-ID: <54EC53A9.8070004@pengutronix.de>
Date: Tue, 24 Feb 2015 11:34:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bluetooth-next 2/2] at86rf230: add support for external
 xtal trim
References: <1424772665-25857-1-git-send-email-alex.aring@gmail.com> <1424772665-25857-3-git-send-email-alex.aring@gmail.com> <54EC50B7.4040105@pengutronix.de> <20150224102832.GA748@omega>
In-Reply-To: <20150224102832.GA748@omega>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oWt2x6QNNrB4LgnN9iS56vkw0egQoOvon"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oWt2x6QNNrB4LgnN9iS56vkw0egQoOvon
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2015 11:28 AM, Alexander Aring wrote:
> Hi Marc,
>=20
> On Tue, Feb 24, 2015 at 11:21:43AM +0100, Marc Kleine-Budde wrote:
>> On 02/24/2015 11:11 AM, Alexander Aring wrote:
>>> This patch adds support for setting the xtal trim register. Some at86=
rf2xx
>>> transceiver boards needs fine tuning the xtal capacitor.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>  .../devicetree/bindings/net/ieee802154/at86rf230.txt         |  3 ++=
+
>>>  drivers/net/ieee802154/at86rf230.c                           | 12 ++=
++++++++++
>>>  include/linux/spi/at86rf230.h                                |  1 +
>>>  3 files changed, 16 insertions(+)
>>>
> ...
>>> @@ -1390,6 +1397,10 @@ static int at86rf230_get_pdata(struct spi_devi=
ce *spi,
>>> =20
>>>  	cfg->rstn =3D of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);=

>>>  	cfg->slp_tr =3D of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0=
);
>>> +	ret =3D of_property_read_u8(spi->dev.of_node, "xtal-trim",
>>> +				  &cfg->xtal_trim);
>>> +	if (ret < 0 && ret !=3D -EINVAL)
>>> +		return ret;
>>> =20
>>>  	return 0;
>>>  }
>>> @@ -1545,6 +1556,7 @@ static int at86rf230_probe(struct spi_device *s=
pi)
>>>  	lp =3D hw->priv;
>>>  	lp->hw =3D hw;
>>>  	lp->spi =3D spi;
>>> +	lp->cfg =3D cfg;
>>
>> This doesn't look correct.
>=20
> You mean the line:
>=20
> "lp->cfg =3D cfg;" or everything?

Just that line, it's in the wrong patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oWt2x6QNNrB4LgnN9iS56vkw0egQoOvon
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU7FOtAAoJECte4hHFiupUVO0P/jLVgVOrN2qVZ6Xk1sTdX0U+
/2r505lQtzi5zaafMbQvF8gnjIO4yhj2pGsm7I0S2UpQ0FK/RpmZenfgUGa+6GX+
9vWkpVTzvdTG6w3NwDu5Dq915ec0taXhNQ+R/1WQXRR/Wx9sOSeqPFTt7eIxgM/Y
3xHdgTl1payrVqO7qKdkdch+wV/nr9njwRbbrbV+AQ9nPLtedgvLwzr/qdFzpqDE
trQTU6+gLjJNoHannIP8Y9DemQNUYbvBr+rLIwqx/I+aaSM7kqQW757f0M+ERaJj
yetvLSmVqXAFES7wt2YtqKwPCtaJdSk4Y1Xb0jb9tgpEDGIPzPqOJGcddIrJRpBG
oJU6lACq6uLN2okBZ9ta7GlviL0EJCmwMhY1M8TD8PbBPsKzZsrs+0QByReTYT1f
zRLEdtm6FS6qClvrRTnHOS1FddeerqanalsuNCQ6zjznTmlygHU1HqCT8/Id0YlY
5Ho6evDb6ymjqQOwUzJ6isiBmsdYRjUpnyvjwG33gAOZKKOLEYqCxRwmyQnhyjbV
Dam1ksj5agNbdbfJGrwv0GH6cjLRc9B2NKKV6AHadD8qICaZia3Sqj2v1Mb0cPuf
EsTf8Ml306q8fsDWiqsDi5f98f/eOUhBuCHEnwOgKH1MHNHYw032BJR+vNl0A+9L
UblL6TnVxkAAp+Bzz5Un
=uNqq
-----END PGP SIGNATURE-----

--oWt2x6QNNrB4LgnN9iS56vkw0egQoOvon--
