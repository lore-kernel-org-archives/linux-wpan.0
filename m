Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DB6528.2040704@pengutronix.de>
Date: Fri, 01 Aug 2014 12:00:08 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
References: <53DB5A53.5000004@xsilon.com> <20140801094144.GA11159@omega>
In-Reply-To: <20140801094144.GA11159@omega>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1022618548262970729=="
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH bluetooth-next] 6lowpan: Remove
 ununsed dev parameter from skb_delivery_cb callback.
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1022618548262970729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2014 11:41 AM, Alexander Aring wrote:
> Hi Martin,
>=20
> On Fri, Aug 01, 2014 at 10:13:55AM +0100, Martin Townsend wrote:
>> This parameter is never used by any function implementing this callbac=
k.
>> ---
>>  include/net/6lowpan.h         | 2 +-
>>  net/6lowpan/iphc.c            | 2 +-
>>  net/bluetooth/6lowpan.c       | 4 ++--
>>  net/ieee802154/6lowpan_rtnl.c | 5 ++---
>>  4 files changed, 6 insertions(+), 7 deletions(-)
>>
>=20
> I don't test it yet, but you need to add a Signed-off-by: ...
>=20
> You can create this with -s parameter while git format-patch.

Usually the Sob is added during the commit with the -s parameter, i.e:

    git commit -s

You can modify your commit and add the Sob with:

    git commit --amend -s

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPbZSgACgkQjTAFq1RaXHNFngCfQgc/NATlNwqQbMR7zqhJL9/F
qVQAn04ZRIiF1ySpgi7OhRe51GqFBZ+E
=7BWt
-----END PGP SIGNATURE-----

--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0--


--===============1022618548262970729==
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
--===============1022618548262970729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel

--===============1022618548262970729==--
