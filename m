Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbBXKz2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 05:55:28 -0500
Message-ID: <54EC589A.5060207@pengutronix.de>
Date: Tue, 24 Feb 2015 11:55:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bluetooth-next 2/2] at86rf230: add support for external
 xtal trim
References: <1424772665-25857-1-git-send-email-alex.aring@gmail.com> <1424772665-25857-3-git-send-email-alex.aring@gmail.com> <54EC50B7.4040105@pengutronix.de> <20150224102832.GA748@omega> <54EC53A9.8070004@pengutronix.de> <20150224104236.GB748@omega>
In-Reply-To: <20150224104236.GB748@omega>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HcQUSqPVORL61kbsK0he5AUJ0eIQnp2MC"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HcQUSqPVORL61kbsK0he5AUJ0eIQnp2MC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2015 11:42 AM, Alexander Aring wrote:
> On Tue, Feb 24, 2015 at 11:34:17AM +0100, Marc Kleine-Budde wrote:
>> On 02/24/2015 11:28 AM, Alexander Aring wrote:
>>> Hi Marc,
>>>
>>> On Tue, Feb 24, 2015 at 11:21:43AM +0100, Marc Kleine-Budde wrote:
>>>> On 02/24/2015 11:11 AM, Alexander Aring wrote:
>>>>> This patch adds support for setting the xtal trim register. Some at=
86rf2xx
>>>>> transceiver boards needs fine tuning the xtal capacitor.
>>>>>
>>>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>>>> ---
>>>>>  .../devicetree/bindings/net/ieee802154/at86rf230.txt         |  3 =
+++
>>>>>  drivers/net/ieee802154/at86rf230.c                           | 12 =
++++++++++++
>>>>>  include/linux/spi/at86rf230.h                                |  1 =
+
>>>>>  3 files changed, 16 insertions(+)
>>>>>
>>> ...
>>>>> @@ -1390,6 +1397,10 @@ static int at86rf230_get_pdata(struct spi_de=
vice *spi,
>>>>> =20
>>>>>  	cfg->rstn =3D of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0=
);
>>>>>  	cfg->slp_tr =3D of_get_named_gpio(spi->dev.of_node, "sleep-gpio",=
 0);
>>>>> +	ret =3D of_property_read_u8(spi->dev.of_node, "xtal-trim",
>>>>> +				  &cfg->xtal_trim);
>>>>> +	if (ret < 0 && ret !=3D -EINVAL)
>>>>> +		return ret;
>>>>> =20
>>>>>  	return 0;
>>>>>  }
>>>>> @@ -1545,6 +1556,7 @@ static int at86rf230_probe(struct spi_device =
*spi)
>>>>>  	lp =3D hw->priv;
>>>>>  	lp->hw =3D hw;
>>>>>  	lp->spi =3D spi;
>>>>> +	lp->cfg =3D cfg;
>>>>
>>>> This doesn't look correct.
>>>
>>> You mean the line:
>>>
>>> "lp->cfg =3D cfg;" or everything?
>>
>> Just that line, it's in the wrong patch.
>>
>=20
> yes, but in the other patch it makes no sense. I only use the platform
> data in probe function and can't access the platform data over lp->cfg
> there, because lp isn't allocated. So I can add it in patch 1/2 but the=
n
> I will never access the lp->cfg then.
>=20
> devm_request_gpio thing will remember which gpio was requested. I never=

> read the platform_data again.

This means it makes no sense of copying/embedding the whole platform
data into the private struct. You should initialize your private data
from the devicetree node if available, otherwise from the platform data.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HcQUSqPVORL61kbsK0he5AUJ0eIQnp2MC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU7FidAAoJECte4hHFiupU8HQP/Rwejm91GZnKUs5MdNinjA4i
zV0+vLk1MLGOPz3tbY6I6j9hY7hV97mp+0G4ZV7/mwUzE080rKvKLJtjMzkEbgbj
lREbIx3xvXAtjQyBTmsobgS74oiSbu5zcnWsKMHL/Aco0Ssec8Igi7mmbtUNIoWG
DBGMqXKdpcCPHMtPvtrpzXylA95m04EL4CT0ae29/L1SZ0AXgid7rkleUwXWdOxr
9nOEDWZhYQkV/IreZILUkNGj41eXiYgX7DWyArdy7ePA1LG3OWH3Ou/ILgvMLRcz
x4iz2PSMubAdAKJPhgYdUHHFtFx2GNmkMYgbOBq4r4QVImn9Atl1w2ptUoOwrEfw
9hnfEdnJ2j6j2Cr4eDsKkde7RrTG+LDMjUJlpKKjSuR8gTmn+8LTWwoRc0M0CxXX
iiBSAYPDExtLAWabY0o1VJz6PG+5j2nsJTjwfQAEo+CToNKcHfnY80x/7JKGyV9T
NVFlEZ/4cD9kbIVAYibob3JKQYv9U4QFzdjOOU1wP9wEZ2E9eFfrDuhMtiaiKJhU
jIImc/nT3hp/rmp9P6jtm7OB24E1m81U4yCGrTqgiVyS1HSKI1/Vg4HRMn+j1qV+
4rtTEow0UDM2GI0J+7GUbtd+qGW5c+z1Bqsh80duzjUn2xtKH84JgZBZR7iVtAox
rs5rkZqcUAb4IF5F46Ho
=/6Kx
-----END PGP SIGNATURE-----

--HcQUSqPVORL61kbsK0he5AUJ0eIQnp2MC--
