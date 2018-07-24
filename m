Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:37277 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXQ1l (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 12:27:41 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCH 1/2 v2] ieee802154: assembly of 6LoWPAN fragments improvement
In-Reply-To: <78e7773b-c2b8-5070-d940-df0d8e35ae32@datenfreihafen.org>
References: <20180717152546.GA22664@Rafael-Mac.intra.sownet.nl> <78e7773b-c2b8-5070-d940-df0d8e35ae32@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 24 Jul 2018 11:20:41 -0400
Message-ID: <8714.1532445641@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Rafael Vuijk <r.vuijk@sownet.nl>, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Schmidt <stefan@datenfreihafen.org> wrote:
    > "We have tested the 6LoWPAN modules in the Linux kernel and came to s=
ome
    > issue regarding fragmentation. We have seen aborted SCP transfers
    > ("message authentication code incorrect") and tested TCP transfers as
    > well and saw corruption on fragment-sized intervals. The current
    > fragment assembling functions do not check enough for corrupted L2
    > packets that might slip through L2 CRC check. (in our case IEEE802.15=
.4
    > which has only 16-bit CRC).
    > As a result, overlapping fragments due to offset corruption are not
    > detected and assembled incorrectly. Part of packets may have old data.
    > At TCP-level, there is only a simple TCP-checksum which is not enough=
 in
    > this case as the corruption occurs frequently (once every few minutes=
).

This is a common problem with checksums, fragments and "high" bandwidths.
It can occur with some frequency, and has been a reason for much of the PMTU
work (including PLMTUD) to get rid of IP-level fragmentation.
A solution is better checksums: or rather integrity hashes.

I'm curious if the problem would have been if the 802.15.4 network was
encrypted, and thus had an cryptographic integrity check.

    > After quickly analysing the code we saw some potential issues and
    > created a patch that adds additional overlap checks and simplifies so=
me
    > conditional statements. After running tests again, TCP corruption was
    > not seen again. The test was performed with SCP and keeps transferring
    > large files now without error."

    > It would be great if some of this finds it way into the commit log of
    > these two patches. At a minimum I would require them to not have the
    > same commit summary line.

Agreed.

    >> Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
    >> --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000=
000 +0100
    >> +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000=
000 +0100
    >> @@ -140,23 +140,14 @@ static int lowpan_frag_queue(struct lowp
    >> offset =3D lowpan_802154_cb(skb)->d_offset << 3;
    >> end =3D lowpan_802154_cb(skb)->d_size;
    >>=20
    >> +	if (fq->q.len =3D=3D 0)
    >> +		fq->q.len =3D end;
    >> +	if (fq->q.len !=3D end)
    >> +		goto err;
    >> +
    >> /* Is this the final fragment? */
    >> if (offset + skb->len =3D=3D end) {
    >> -		/* If we already have some bits beyond end
    >> -		 * or have different end, the segment is corrupted.
    >> -		 */
    >> -		if (end < fq->q.len ||
    >> -		    ((fq->q.flags & INET_FRAG_LAST_IN) && end !=3D fq->q.len))
    >> -			goto err;
    fq-> q.flags |=3D INET_FRAG_LAST_IN;
    >> -		fq->q.len =3D end;
    >> -	} else {
    >> -		if (end > fq->q.len) {
    >> -			/* Some bits beyond end -> corruption. */
    >> -			if (fq->q.flags & INET_FRAG_LAST_IN)
    >> -				goto err;
    >> -			fq->q.len =3D end;
    >> -		}

    > Some basic testing on my side has not revealed any issues on this. I
    > will give it some longer testing with SCP now.

    > regards
    > Stefan Schmidt
    > --
    > To unsubscribe from this list: send the line "unsubscribe linux-wpan"=
 in
    > the body of a message to majordomo@vger.kernel.org
    > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBW1dDyICLcPvd0N1lAQLX2wgAm4N3HooRA2lANZQrsAThMhCar0dN+GwH
JTXKpsXzViRcS6a317Txse8AYRulGRKBJw9d0GuVODD4hiAprG1DxtNMvgz3JqxE
e7vwNexH+mLgUZUDvf7U6qa4CvjuKLoG92H91g1+Z1qCEuZtiy0MqKJoKDLZnp0W
IQ9aQHMoecjtj9EzX8uR4bAgsTUaSa9699CpKHE5tAwlx8a+NQhIYl/bb+HJsuUz
Ao4lajB+gft7vDJkT9n58qHR24r7b4XR+/cXc7mr3yTHYeJ2INe1XSojBlcxhc4X
rwJnLJWBuSBJy0MkdNUpNQM7lltd7ZHhXOeXSie9qS4o46Jc81NJiQ==
=Xn7A
-----END PGP SIGNATURE-----
--=-=-=--
