Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw01.it.ntnu.no ([129.241.56.174]:48342 "EHLO
        mailgw01.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbeGFHzG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 03:55:06 -0400
Subject: Re: [PATCH wpan 1/2] net: 6lowpan: fix reserved space for single
 frames
References: <20180702203203.21316-1-aring@mojatatu.com>
 <a2cb217f-7e22-e603-bd46-13d8764fee64@datenfreihafen.org>
From: David Palma <david.palma@ntnu.no>
Message-ID: <781a24ed-3783-abbf-7726-f377fd5eabca@ntnu.no>
Date: Fri, 6 Jul 2018 09:54:51 +0200
MIME-Version: 1.0
In-Reply-To: <a2cb217f-7e22-e603-bd46-13d8764fee64@datenfreihafen.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BM19Vj1JC6pCwU3DnOhP3cVOdjppiPns5"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com, Rabi Narayan Sahoo <rabinarayans0828@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BM19Vj1JC6pCwU3DnOhP3cVOdjppiPns5
Content-Type: multipart/mixed; boundary="dUnq5RQPKNKv2JZ1MM4VHGa8gF9oofsLY";
 protected-headers="v1"
From: David Palma <david.palma@ntnu.no>
To: Stefan Schmidt <stefan@datenfreihafen.org>,
 Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com,
 Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Message-ID: <781a24ed-3783-abbf-7726-f377fd5eabca@ntnu.no>
Subject: Re: [PATCH wpan 1/2] net: 6lowpan: fix reserved space for single
 frames
References: <20180702203203.21316-1-aring@mojatatu.com>
 <a2cb217f-7e22-e603-bd46-13d8764fee64@datenfreihafen.org>
In-Reply-To: <a2cb217f-7e22-e603-bd46-13d8764fee64@datenfreihafen.org>

--dUnq5RQPKNKv2JZ1MM4VHGa8gF9oofsLY
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On 05/07/18 13:16, Stefan Schmidt wrote:
> Hello.
>=20
> [CC David Palma and Rabi Narayan Sahoo]
>=20
> On 02.07.2018 22:32, Alexander Aring wrote:
>> This patch fixes patch add handling to take care tail and headroom for=

>> single 6lowpan frames. We need to be sure we have a skb with the right=

>> head and tailroom for single frames. This patch do it by using
>> skb_copy_expand() if head and tailroom is not enough allocated by uppe=
r
>> layer.
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D195059
>> Reported-by: David Palma <david.palma@ntnu.no>
>> Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
>> Signed-off-by: Alexander Aring <aring@mojatatu.com>
>=20
> David, Rabi and you please test these two patches and verify that it
> fixes the problems you have?
>=20
> regards
> Stefan Schmidt
>=20

The patches fix the problems!

I've tested them against different packet sizes and no kernel panic.

The patches were applied in Debian's 4.9.88-1+deb9u1 x86_64 kernel,
which before the patches showed the reported issue.

Thanks again to Alex for looking into it.

Cheers,
--=20
David

>> ---
>>  net/ieee802154/6lowpan/tx.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c=

>> index e6ff5128e61a..d0c4d220de08 100644
>> --- a/net/ieee802154/6lowpan/tx.c
>> +++ b/net/ieee802154/6lowpan/tx.c
>> @@ -265,9 +265,24 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, stru=
ct net_device *ldev)
>>  	/* We must take a copy of the skb before we modify/replace the ipv6
>>  	 * header as the header could be used elsewhere
>>  	 */
>> -	skb =3D skb_unshare(skb, GFP_ATOMIC);
>> -	if (!skb)
>> -		return NET_XMIT_DROP;
>> +	if (unlikely(skb_headroom(skb) < ldev->needed_headroom ||
>> +		     skb_tailroom(skb) < ldev->needed_tailroom)) {
>> +		struct sk_buff *nskb;
>> +
>> +		nskb =3D skb_copy_expand(skb, ldev->needed_headroom,
>> +				       ldev->needed_tailroom, GFP_ATOMIC);
>> +		if (likely(skb)) {
>> +			consume_skb(skb);
>> +			skb =3D nskb;
>> +		} else {
>> +			kfree_skb(skb);
>> +			return NET_XMIT_DROP;
>> +		}
>> +	} else {
>> +		skb =3D skb_unshare(skb, GFP_ATOMIC);
>> +		if (!skb)
>> +			return NET_XMIT_DROP;
>> +	}
>> =20
>>  	ret =3D lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
>>  	if (ret < 0) {
>>



--dUnq5RQPKNKv2JZ1MM4VHGa8gF9oofsLY--

--BM19Vj1JC6pCwU3DnOhP3cVOdjppiPns5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEl+q6ZBx359wpOo2MJseEIZzXsVoFAls/IEsACgkQJseEIZzX
sVrPRBAAg6pVpMf786U7TrShLuirsO90P7HudX4DkRmsQobY27CZOVhlm1Y/ZnOE
HmlwfECLv+dyBr63N7/ySYKkPwVsGbBSEHKuqguBuz/PIe/41XnVl2B0UFkh+w/6
5qkERylcmBIgcHyDPZzyTkGYnZ2uhtG2w1Pf1q++ZaI8jDJ7Wh9XGfwpE0+8Wefg
gI2CIM1EtjR8HsGkwCXZ3IQxtnp27xRYCZVdARFEfg7r7lilcBeoJDv6ja5cE2Yf
dYmETo83ORhyaCjQiaFKwO3eYQfsMuv2mNjI6wiSpkTOmk+zIzhsqdO7tVsR/vEo
rx2WZFjDfgbe4X6pkEm+JR7YFwaA4KtrhneGYNrAQwFi/p/LMR3yqr4mUc7nMuoB
c1OG8CGhH/nPbKUjUpzo/j487sQYL4CSVOVMTJzmIxt4eMgAOYMTkAD64ILrZv71
swLEeHvwSmkrj/ezBmciO6080zWEljkZ3qH41ywD4e8uWW4aJq+6YG57OEIouytq
aRW2Q0koK2msn0v86FtrKCbjEht//xnKXsYQUwA9cpzYUjXRaAjXFYbVpWEhb2At
VhYyr/2gO5tIyzMDs3FDrM4DRdJd8gNhUbKyKPoH+sGnKDUtGN3CM5Gzmtts5JHm
EAiMzWZejyYGr5TpJE/Jh6plrLvgthWPI+4rsMJckwQ6NHPZTL8=
=Thxe
-----END PGP SIGNATURE-----

--BM19Vj1JC6pCwU3DnOhP3cVOdjppiPns5--
