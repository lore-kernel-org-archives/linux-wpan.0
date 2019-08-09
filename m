Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13330 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfHIMe6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Aug 2019 08:34:58 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2 17/17] ieee802154: no need to check return value of
 debugfs_create functions
Date: Fri, 9 Aug 2019 12:34:46 +0000
Message-ID: <BY5PR03MB49656ECC2BAA0CB2B63E01F28ED60@BY5PR03MB4965.namprd03.prod.outlook.com>
References: <20190809123108.27065-1-gregkh@linuxfoundation.org>
 <20190809123108.27065-18-gregkh@linuxfoundation.org>
In-Reply-To: <20190809123108.27065-18-gregkh@linuxfoundation.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, Harry Morris <h.morris@cascoda.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Freitag, 9. August 2019 14:31
> To: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Alexander Aring <alex.aring@gmail.com>;
> David S. Miller <davem@davemloft.net>; Harry Morris
> <h.morris@cascoda.com>; linux-wpan@vger.kernel.org; Stefan Schmidt
> <stefan@datenfreihafen.org>
> Subject: [PATCH v2 17/17] ieee802154: no need to check return value of
> debugfs_create functions
>=20
> When calling debugfs functions, there is no need to ever check the return=
 value.
> The function can work or not, but the code logic should never do somethin=
g
> different based on this.
>=20
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Harry Morris <h.morris@cascoda.com>
> Cc: linux-wpan@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/net/ieee802154/adf7242.c   | 13 +++----------
>  drivers/net/ieee802154/at86rf230.c | 20 +++++---------------
>  drivers/net/ieee802154/ca8210.c    |  9 +--------
>  3 files changed, 9 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/net/ieee802154/adf7242.c
> b/drivers/net/ieee802154/adf7242.c
> index c9392d70e639..5a37514e4234 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1158,23 +1158,16 @@ static int adf7242_stats_show(struct seq_file
> *file, void *offset)
>  	return 0;
>  }
>=20
> -static int adf7242_debugfs_init(struct adf7242_local *lp)
> +static void adf7242_debugfs_init(struct adf7242_local *lp)
>  {
>  	char debugfs_dir_name[DNAME_INLINE_LEN + 1] =3D "adf7242-";
> -	struct dentry *stats;
>=20
>  	strncat(debugfs_dir_name, dev_name(&lp->spi->dev),
> DNAME_INLINE_LEN);
>=20
>  	lp->debugfs_root =3D debugfs_create_dir(debugfs_dir_name, NULL);
> -	if (IS_ERR_OR_NULL(lp->debugfs_root))
> -		return PTR_ERR_OR_ZERO(lp->debugfs_root);
>=20
> -	stats =3D debugfs_create_devm_seqfile(&lp->spi->dev, "status",
> -					    lp->debugfs_root,
> -					    adf7242_stats_show);
> -	return PTR_ERR_OR_ZERO(stats);
> -
> -	return 0;
> +	debugfs_create_devm_seqfile(&lp->spi->dev, "status", lp-
> >debugfs_root,
> +				    adf7242_stats_show);
>  }
>=20
>  static const s32 adf7242_powers[] =3D {
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 595cf7e2a651..7d67f41387f5 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1626,24 +1626,16 @@ static int at86rf230_stats_show(struct seq_file
> *file, void *offset)  }  DEFINE_SHOW_ATTRIBUTE(at86rf230_stats);
>=20
> -static int at86rf230_debugfs_init(struct at86rf230_local *lp)
> +static void at86rf230_debugfs_init(struct at86rf230_local *lp)
>  {
>  	char debugfs_dir_name[DNAME_INLINE_LEN + 1] =3D "at86rf230-";
> -	struct dentry *stats;
>=20
>  	strncat(debugfs_dir_name, dev_name(&lp->spi->dev),
> DNAME_INLINE_LEN);
>=20
>  	at86rf230_debugfs_root =3D debugfs_create_dir(debugfs_dir_name,
> NULL);
> -	if (!at86rf230_debugfs_root)
> -		return -ENOMEM;
> -
> -	stats =3D debugfs_create_file("trac_stats", 0444,
> -				    at86rf230_debugfs_root, lp,
> -				    &at86rf230_stats_fops);
> -	if (!stats)
> -		return -ENOMEM;
>=20
> -	return 0;
> +	debugfs_create_file("trac_stats", 0444, at86rf230_debugfs_root, lp,
> +			    &at86rf230_stats_fops);
>  }
>=20
>  static void at86rf230_debugfs_remove(void) @@ -1651,7 +1643,7 @@ static
> void at86rf230_debugfs_remove(void)
>  	debugfs_remove_recursive(at86rf230_debugfs_root);
>  }
>  #else
> -static int at86rf230_debugfs_init(struct at86rf230_local *lp) { return 0=
; }
> +static void at86rf230_debugfs_init(struct at86rf230_local *lp) { }
>  static void at86rf230_debugfs_remove(void) { }  #endif
>=20
> @@ -1751,9 +1743,7 @@ static int at86rf230_probe(struct spi_device *spi)
>  	/* going into sleep by default */
>  	at86rf230_sleep(lp);
>=20
> -	rc =3D at86rf230_debugfs_init(lp);
> -	if (rc)
> -		goto free_dev;
> +	at86rf230_debugfs_init(lp);
>=20
>  	rc =3D ieee802154_register_hw(lp->hw);
>  	if (rc)
> diff --git a/drivers/net/ieee802154/ca8210.c
> b/drivers/net/ieee802154/ca8210.c index b188fce3f641..11402dc347db
> 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -3019,14 +3019,7 @@ static int ca8210_test_interface_init(struct
> ca8210_priv *priv)
>  		priv,
>  		&test_int_fops
>  	);
> -	if (IS_ERR(test->ca8210_dfs_spi_int)) {
> -		dev_err(
> -			&priv->spi->dev,
> -			"Error %ld when creating debugfs node\n",
> -			PTR_ERR(test->ca8210_dfs_spi_int)
> -		);
> -		return PTR_ERR(test->ca8210_dfs_spi_int);
> -	}
> +
>  	debugfs_create_symlink("ca8210", NULL, node_name);
>  	init_waitqueue_head(&test->readq);
>  	return kfifo_alloc(
> --
> 2.22.0
