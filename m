Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60414 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbBWPyY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 10:54:24 -0500
Message-ID: <54EB4D27.9000800@pengutronix.de>
Date: Mon, 23 Feb 2015 16:54:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] at86rf230: add support for setting external
 xtal
References: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>	<54EB4302.9090006@pengutronix.de> <20150223151329.GC704@omega> <20150223154104.GA15550@omega>
In-Reply-To: <20150223154104.GA15550@omega>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AxNJxMfl61hMiLfeOJSoMPD0pVGvjHev1"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxNJxMfl61hMiLfeOJSoMPD0pVGvjHev1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2015 04:41 PM, Alexander Aring wrote:
> Marc,
>=20
> On Mon, Feb 23, 2015 at 04:13:29PM +0100, Alexander Aring wrote:
>> On Mon, Feb 23, 2015 at 04:10:58PM +0100, Marc Kleine-Budde wrote:
>>> On 02/23/2015 04:05 PM, Alexander Aring wrote:
>>>> This patch adds support for setting external xtal. This is recommend=
ed
> ...
>>>>  	rc =3D at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
>>>>  	if (rc)
>>>>  		return rc;
>>>> @@ -1392,6 +1403,16 @@ at86rf230_get_pdata(struct spi_device *spi)
>>>>  	pdata->rstn =3D of_get_named_gpio(spi->dev.of_node, "reset-gpio", =
0);
>>>>  	pdata->slp_tr =3D of_get_named_gpio(spi->dev.of_node, "sleep-gpio"=
, 0);
>>>> =20
>>>> +	pdata->xtal =3D of_property_read_bool(spi->dev.of_node, "external-=
xtal");
>>>
>>> The platform data should be considered read only by the driver. Bette=
r
>>> put the information into your per-driver private data struct.
>>>
>>
>> ah, yes you are completely right here. Sorry :)
>>
>=20
> I am not sure if this is okay here in that case. For non devicetree thi=
s
> code will never touched and I grab this code from some i2c driver like
> [0].
>=20
> They also use the platform-data for setting the devicetree properties.

That doesn't make it better.

> The only thing which I can see now is the check if (xtal > 0xF) which i=
s
> not available on non devicetree settings... but I can also remove this
> check, somebody should make something complete wrong if this value is
> above 0xF and regmap should mask this value.

IMHO this driver has been poorly converted to DT. The usual way would be
to add data to at86rf230_local.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AxNJxMfl61hMiLfeOJSoMPD0pVGvjHev1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU600tAAoJECte4hHFiupUDQcQAIisXKx7b00Yhjp6g7pFh+0b
ZEPoJ2spoEvcp/6BnaCH/VwmjM3j36JGv3VI5LGw5qDTT7jArg045X+IwSgvb/tJ
9OYS44zrN6RCbdZN0zMWo0gPWIDDDq9JkEMfGfpVVm60WcKj7rJikMa6LIfM1TQF
GJ2IIdsubDi8BugF1ZtrQMRpjiTrzBAw+lh37cVwCIVNM6LZ3J5uq/8oK50W8N+u
VkW1hPHEzsISJQGA1jIzN36MhvgR7SByGvAWvYkF3WRly/jq//lDG36l6tacWAFB
kxZtm8CqR2cil7iNIe8E6V7yU7bdJkrckoxRp5kVBEaoDnbwXukO4W3rNdw9EE4K
Bgije7JyEf8Mjs8UpMWAteJvJkIUHn5vLedx6G00Mf0cCBAhx7MNJqqFocPZGGUi
I7DTobpvMKpj/21p590iEKTPiMmvuEdjD/YxULXuqsx81rtDmSWf7oHstZxTxuRV
4SWdb4b6xAo+bOhVKM5WkIpjGyIXvBWv15VqyHOqZD+0X+p+LU44/bK2Bh7ra3sV
bJPcCk4ZIZbvcZ/St26NYBo0wDaS6k/Xc8Yd2A8/mAIrGUdaIrB2KBX3h2nhOphb
oImLcQ+SntKQf2hKAS7Doinl9w6pjTKsiXiN4dfI40MCrU9Zf+OkYEz5e3vTSRfY
jltiafcNSbadyNr8tid9
=h2jE
-----END PGP SIGNATURE-----

--AxNJxMfl61hMiLfeOJSoMPD0pVGvjHev1--
