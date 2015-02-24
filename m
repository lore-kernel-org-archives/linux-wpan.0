Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60472 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbBXKVp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 05:21:45 -0500
Message-ID: <54EC50B7.4040105@pengutronix.de>
Date: Tue, 24 Feb 2015 11:21:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bluetooth-next 2/2] at86rf230: add support for external
 xtal trim
References: <1424772665-25857-1-git-send-email-alex.aring@gmail.com> <1424772665-25857-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1424772665-25857-3-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oj2dbe9klI1ILlIWO0Hs6hLUGl32Jd4Ab"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oj2dbe9klI1ILlIWO0Hs6hLUGl32Jd4Ab
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2015 11:11 AM, Alexander Aring wrote:
> This patch adds support for setting the xtal trim register. Some at86rf=
2xx
> transceiver boards needs fine tuning the xtal capacitor.
>=20
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  .../devicetree/bindings/net/ieee802154/at86rf230.txt         |  3 +++
>  drivers/net/ieee802154/at86rf230.c                           | 12 ++++=
++++++++
>  include/linux/spi/at86rf230.h                                |  1 +
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230=
=2Etxt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> index d3bbdded..1ae5100 100644
> --- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> +++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> @@ -11,6 +11,8 @@ Required properties:
>  Optional properties:
>    - reset-gpio:		GPIO spec for the rstn pin
>    - sleep-gpio:		GPIO spec for the slp_tr pin
> +  - xtal-trim:		u8 value for fine tuning the internal capacitance
> +			arrays of xtal pins: 0 =3D +0 pF, 0xf =3D +4.5 pF
> =20
>  Example:
> =20
> @@ -20,4 +22,5 @@ Example:
>  		reg =3D <0>;
>  		interrupts =3D <19 1>;
>  		interrupt-parent =3D <&gpio3>;
> +		xtal-trim =3D /bits/ 8 <0x06>;
>  	};
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee80215=
4/at86rf230.c
> index c495f23..e74b3cc 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -72,6 +72,7 @@ struct at86rf230_state_change {
> =20
>  struct at86rf230_local {
>  	struct spi_device *spi;
> +	struct at86rf230_platform_data cfg;
> =20
>  	struct ieee802154_hw *hw;
>  	struct at86rf2xx_chip_data *data;
> @@ -1362,6 +1363,10 @@ static int at86rf230_hw_init(struct at86rf230_lo=
cal *lp)
>  	usleep_range(lp->data->t_sleep_cycle,
>  		     lp->data->t_sleep_cycle + 100);
> =20
> +	rc =3D at86rf230_write_subreg(lp, SR_XTAL_TRIM, lp->cfg.xtal_trim);
> +	if (rc)
> +		return rc;
> +
>  	rc =3D at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
>  	if (rc)
>  		return rc;
> @@ -1380,6 +1385,8 @@ static int at86rf230_hw_init(struct at86rf230_loc=
al *lp)
>  static int at86rf230_get_pdata(struct spi_device *spi,
>  			       struct at86rf230_platform_data *cfg)
>  {
> +	int ret;
> +
>  	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node) {
>  		if (!spi->dev.platform_data)
>  			return -ENOENT;
> @@ -1390,6 +1397,10 @@ static int at86rf230_get_pdata(struct spi_device=
 *spi,
> =20
>  	cfg->rstn =3D of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
>  	cfg->slp_tr =3D of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);=

> +	ret =3D of_property_read_u8(spi->dev.of_node, "xtal-trim",
> +				  &cfg->xtal_trim);
> +	if (ret < 0 && ret !=3D -EINVAL)
> +		return ret;
> =20
>  	return 0;
>  }
> @@ -1545,6 +1556,7 @@ static int at86rf230_probe(struct spi_device *spi=
)
>  	lp =3D hw->priv;
>  	lp->hw =3D hw;
>  	lp->spi =3D spi;
> +	lp->cfg =3D cfg;

This doesn't look correct.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oj2dbe9klI1ILlIWO0Hs6hLUGl32Jd4Ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU7FC3AAoJECte4hHFiupUWFcP/3nvD5LbrZUntVzUAdGzm1yb
ZBp7iI/sMmMzHjY1PbLdw0vKXg16VcIzUh2U9dWTK+fqszY+6vbDHxZRmbwEWqqe
/6evtmcpbtHmDxHQJy3SRhJtfw/3bSyWLvjs/hK6uManPIXKamM1TSMq9caWOf2w
m6r2IEXfOiXjfH9kBqtYX+FNJE58LDTnSzWiZi/pMF5Nn7falGq/YBZVEgnPcG1W
q+nRwzaBQLg/tZVbn09NS5zDtaBFwE2umYxI+1M5YiNB5gFJ16Ob89P5seNwnaGh
kBQYpsNvMHHUYv8L0CueYyHGdNlJMqtrZxNX/FLcSYmoSG6vGdccT0GSIZsK10kv
/ECtr2q83WJp0doBzvWC6qPB9UVS3zCC1yw8BUsDxlNwO7XbQ47zLDWzIU9KZn7h
5F901M3Ka77PIUEEfEqLWz0gbGyoYU3cBstLr4r4Z6HQv9L77fAJs9DMoG/whnnu
ePVu7CspNVZzzU8jEp2CQZR03OZni9yjAIZc6JtmdUMX7GG4GuW1Rtf4zPDQS1oV
WRJPauUUgfAn4TSqyrnm34Iw7yN4/AZNqvLs24n6FszQ4L6rB+TUZzK9LxDqRKDm
iFkg3WCBCChshVftUy1Na6F4YB37XUDLnCPqJV7qIRFfq6wSefnJXQFaMcHISaCF
0KfgJ2WTCBMCgirbwtHJ
=ECOJ
-----END PGP SIGNATURE-----

--oj2dbe9klI1ILlIWO0Hs6hLUGl32Jd4Ab--
