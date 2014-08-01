Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DBB610.6020503@pengutronix.de>
Date: Fri, 01 Aug 2014 17:45:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
References: <53DBB278.7090106@xsilon.com>
In-Reply-To: <53DBB278.7090106@xsilon.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6752836062775891928=="
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH bluetooth-next] Simplify lowpan
 receive path so skb is freed in lowpan_rcv when dropped.
To: Martin Townsend <martin.townsend@xsilon.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-wpan.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6752836062775891928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NhwVD1it9AWFSgsR06N3qXprFuVot9BLK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NhwVD1it9AWFSgsR06N3qXprFuVot9BLK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2014 05:30 PM, Martin Townsend wrote:
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  include/net/6lowpan.h         |  2 +-
>  net/6lowpan/iphc.c            | 22 +++++++++++++---------
>  net/bluetooth/6lowpan.c       | 12 ++++++++----
>  net/ieee802154/6lowpan_rtnl.c | 12 ++++++------
>  4 files changed, 28 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index d7e9169..aa0381e 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -374,7 +374,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u=
16 *dgram_offset)
> =20
>  typedef int (*skb_delivery_cb)(struct sk_buff *skb);
> =20
> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device =
*dev,

Why do you make the first parameter a double pointer?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NhwVD1it9AWFSgsR06N3qXprFuVot9BLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPbthAACgkQjTAFq1RaXHPMcgCfX7B+4RagB4m/BTdMnllfl0rq
iXoAn2jK4meXHjVkdzHnLYvZkTTn2HLJ
=nxJE
-----END PGP SIGNATURE-----

--NhwVD1it9AWFSgsR06N3qXprFuVot9BLK--


--===============6752836062775891928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
--===============6752836062775891928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel

--===============6752836062775891928==--
