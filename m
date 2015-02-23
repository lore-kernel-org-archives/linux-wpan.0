Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34429 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbBWPLF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 10:11:05 -0500
Message-ID: <54EB4302.9090006@pengutronix.de>
Date: Mon, 23 Feb 2015 16:10:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] at86rf230: add support for setting external
 xtal
References: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cK8mxMaUQKchoBUSaCfl1GhKwBjHuEgXU"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cK8mxMaUQKchoBUSaCfl1GhKwBjHuEgXU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2015 04:05 PM, Alexander Aring wrote:
> This patch adds support for setting external xtal. This is recommended
> by the at86rf230 transceivers to reduce power consuming and for a bette=
r
> clock source.
>=20
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  .../bindings/net/ieee802154/at86rf230.txt          |  6 ++++++
>  drivers/net/ieee802154/at86rf230.c                 | 25 ++++++++++++++=
++++++--
>  include/linux/spi/at86rf230.h                      |  2 ++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230=
=2Etxt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> index d3bbdded..4d47c2e 100644
> --- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> +++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> @@ -11,6 +11,10 @@ Required properties:
>  Optional properties:
>    - reset-gpio:		GPIO spec for the rstn pin
>    - sleep-gpio:		GPIO spec for the slp_tr pin
> +  - external-xtal:	boolean to use external xtal if present
> +  - xtal-trim:		u8 value to fine tuning the internal capacitance
> +			arrays of xtal pins. This value should not above 0x0F
> +			and only present when external-xtal is enabled
> =20
>  Example:
> =20
> @@ -20,4 +24,6 @@ Example:
>  		reg =3D <0>;
>  		interrupts =3D <19 1>;
>  		interrupt-parent =3D <&gpio3>;
> +		external-xtal;
> +		xtal-trim =3D /bits/ 8 <0x06>;
>  	};
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee80215=
4/at86rf230.c
> index cbfc8c5..1a95520 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1315,7 +1315,8 @@ static struct at86rf2xx_chip_data at86rf212_data =
=3D {
>  	.get_desense_steps =3D at86rf212_get_desens_steps
>  };
> =20
> -static int at86rf230_hw_init(struct at86rf230_local *lp)
> +static int at86rf230_hw_init(struct at86rf230_local *lp,
> +			     const struct at86rf230_platform_data *pdata)
>  {
>  	int rc, irq_type, irq_pol =3D IRQ_ACTIVE_HIGH;
>  	unsigned int dvdd;
> @@ -1362,6 +1363,16 @@ static int at86rf230_hw_init(struct at86rf230_lo=
cal *lp)
>  	usleep_range(lp->data->t_sleep_cycle,
>  		     lp->data->t_sleep_cycle + 100);
> =20
> +	if (pdata->xtal) {
> +		rc =3D at86rf230_write_subreg(lp, SR_XTAL_TRIM, pdata->xtal_trim);
> +		if (rc)
> +			return rc;
> +
> +		rc =3D at86rf230_write_subreg(lp, SR_XTAL_MODE, 0x5);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc =3D at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
>  	if (rc)
>  		return rc;
> @@ -1392,6 +1403,16 @@ at86rf230_get_pdata(struct spi_device *spi)
>  	pdata->rstn =3D of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);=

>  	pdata->slp_tr =3D of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0=
);
> =20
> +	pdata->xtal =3D of_property_read_bool(spi->dev.of_node, "external-xta=
l");

The platform data should be considered read only by the driver. Better
put the information into your per-driver private data struct.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cK8mxMaUQKchoBUSaCfl1GhKwBjHuEgXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU60MFAAoJECte4hHFiupU9hMP/iD0pT3NCRpcdzvhYkmgue6M
H+EmtnUTn/ZJEYguLtUer5EAgXUwf7BpLlKmBLucYtNPe8juyVTSQqbds+wMRPJw
WlrXNC819lDX4suXoaASEkWUroIA7+nJqUjFxLZ7QmzrtY5tPS5w2vdJ3iqQOfZW
HMbhnzyqIHd9AHH1rDauUi6mi+Ug6wntW6giFMiNYy1s2qJubWqF1x6yyyolfziO
ojGqc32+bWXuR6Gqw2BVGJVn7wh8JhtRoucbE1ynH1hglIXXsCkkBgOPrNEcFPvh
1ziEtKu/GuFWZzAOyDc4switkuqkvnKzrq7GqvhXQqmALxhUJXiy76pm/ZqIPFla
bh4xZn9tOLvHma/SffWgojEiH4Mn80ssFaSJaA1tRbtF8aAlGvWmrAHMYPD8YwY/
BlA4M97/2aWBByJSoiPemNLsr8cndPs7U8zLhhrd/ofBQU6OC9r4dvSwOFoixpEz
Cjx26Hr9eDR2VV/wGewFcBLc4NDiLxCap80xl92o9/rufrVPcT6u+8jTMeKxLa22
8/J8wzz8ssrTR4fLEkQkOH4Y7EEcQbiYBCsvKPAUMmgO6nGuFXmrOQ3NbX11iS1M
D9zLLij7y2r6IsACzEI1XU+Z/vKXOfjJyw+pd/jxvgCMs555HU96fDGc2k4446HF
UlbERjXWgngGAE2wS6jy
=Upri
-----END PGP SIGNATURE-----

--cK8mxMaUQKchoBUSaCfl1GhKwBjHuEgXU--
