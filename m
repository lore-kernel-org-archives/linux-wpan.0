Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506362;
	b=ibxc3ZpWP5ESEDJoNjNu4XTvbZvsfsKYXS5O/VJX6UAmyc6rw9Pl6JA4OQoLQXAmi7pI
	 /5ssIHPVx9nrG+u+G5J5mIpC48qclLAPXYZmdWCdAPvgBuJUsfqG1G9irVkTNfTl3DW+1
	 zYBoR4shMI43rjFwCOApXVFrVeiDTMCJCJuE3MSihq32fmlyfApZfN6RGw3t2Q8/GM/ad
	 atEyUBKbEWUbS7LPXJ3WDnJfpiR1pwNrgp42mX7wLZEmSk3kadiB5Trh4paloC0CGckrb
	 Lf+A5GzWq0Py87Lerppw1Cha5GJTD1KCA0OK9jEAVzfA9aN4fBka74NG0NEPCXUrcYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506362;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zpRnhO6ETmCWwFUmF0vR5fErBVE1PURDZa67B1CQG1I=;
	b=HLsQFDt2j7zOOxSadn3DMvRopSJxnlEd3I1BG6mt59vssMzOcaWZ2Xgc0C6QN3ZzUUYm
	 zbLDdCqPodyfipuHgp0IBgBCIWokMmerj2nIiW/vpDH14bqR0WjksCecbNkF3fqgFWMhS
	 JNGXjJlONz2pdxgnxAKZKyKOXJwN9YPlXCt6vYMLNEmas401jMZq88qM7Loj5hwgJKlOc
	 WJvCgKNAE1cpy52IG6ys2xr2QQDW3izvSFWgykKdrW/NsihzJlp9YDCoGFk4r2h0qtjnx
	 prF+Ru/EAPrtSAxBafKcmoM6Li7coYAAuhBvIfAclwN+3XopRfKq+inHyo2r7t9+rPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ggBp+EqB;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B10606A31E;
	Tue, 24 Nov 2026 07:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ggBp+EqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795506359; x=1795765559;
	bh=zpRnhO6ETmCWwFUmF0vR5fErBVE1PURDZa67B1CQG1I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ggBp+EqBmkmTKocSuPKhyKg7t38Eq96Qwu9+i8JjZug7LiV1O/M5TlnMW8ETNia6x
	 9KDjySjxH2c0demKBo7AVbDZhiZPWu5nEA5bBNWRQtDV9uxRoWWt5MrFA2AWex5pIW
	 ApQlGzwXX7ffEOAyTIoDEPUsr3sX0MJ5iMWlyTz4dMPd2wLLM8kS31IoyHlwx1QVVe
	 HeSCo3N2dQ9bzGY0gDwiSzArBFTPKyAg8b00l11zcmdXGvWpX57HcLHE1n1OGa+aB/
	 l33NVuesCone/otY1wr9SZsjCzJVeNJHxXCE7dqQryA66/0y0h5zzBsJvwTlhv/ra4
	 9as+mdTAp0n2w==
Date: Tue, 24 Nov 2026 07:45:51 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH net v5] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261124074531.1701179-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: 5db93f1eb541a8ff9e8e77829bba84e724955fbe
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A 6LoWPAN fragment carries the datagram's total size (d_size) and its
own offset within it. lowpan_frag_queue() never checks that the
offset, or offset plus length, fits inside d_size, and never rejects
an empty fragment.

A datagram is considered complete once enough bytes have been counted
(fq->q.meat) toward d_size, regardless of whether those bytes actually
form a contiguous range. So an out-of-range or empty fragment's length
still counts toward completion, even though it doesn't belong anywhere
in the datagram.

IPv6's ip6_frag_queue() already bounds each fragment's end against
IPV6_MAXPLEN and rejects zero-length fragments; 6LoWPAN had no
equivalent checks.

Fixed by rejecting any fragment that is empty, or whose offset (or
offset + length) exceeds d_size.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag=
 api")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
v5:
 - Resent as a new thread instead of in reply to the v1 thread, per
   Jakub Kicinski's request. No content changes from v4.

v4:
 - Added a check for zero-length fragments (!skb->len), which the
   previous check missed. ip6_frag_queue() and nf_ct_frag6_queue()
   already reject these; this patch now does too.
 - Reworded the impact description to stop claiming one specific
   mechanism for how an out-of-range fragment causes harm. A
   separate, pre-existing bug elsewhere in the reassembly code made
   that mechanism unreliable; it's left out of scope here and will
   be addressed on its own.

Reproduced two ways: with a local kernel module calling
lowpan_frag_rcv() directly, and over mac802154_hwsim with three
independent processes standing in for sender, receiver and attacker.
An attacker in radio range who observes one fragment of an
in-progress transmission reads d_tag, d_size and the addressing in the
clear, then sends a single out-of-range fragment of its own before the
legitimate fragment for that span arrives. In this arrival order, the
receiver's reassembly completed with the attacker's bytes included in
the final buffer instead of the out-of-range fragment being rejected.
Both reproducers were re-run against this fix to confirm the
out-of-range fragment is now rejected outright.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix, and
the test results myself and take responsibility for this contribution,
per Documentation/process/coding-assistants.rst.

 net/ieee802154/6lowpan/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/r=
eassembly.c
index ddb6a5817d09..4edd307000c8 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -103,6 +103,9 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *=
fq,
 =09offset =3D lowpan_802154_cb(skb)->d_offset << 3;
 =09end =3D lowpan_802154_cb(skb)->d_size;

+=09if (!skb->len || offset > end || skb->len > end - offset)
+=09=09goto err;
+
 =09/* Is this the final fragment? */
 =09if (offset + skb->len =3D=3D end) {
 =09=09/* If we already have some bits beyond end
--
2.51.2

