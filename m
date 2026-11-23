Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441449;
	b=0oCL8dl51a7l6dAHBhB4TU8zlKWM5MlUgI4o1lMAd88wBKEMZl4qJneUBVO+dogNGQRA
	 KVmXv8bkzhSHTo2xroT5+OfFqeuda7mLpQZRL9jGqAMMT0sjxw4q+/GyA7mfzkyPGefq9
	 FeEj0jkcQhxtiS4n3go2DPhqisyIrIIOV0u4CiGyMAxlv9dvdQFDL5F2dHu8duEKx16sM
	 rfAT5lPg7R9ou2gRcJIJc+OTCaOYd9TJOvlrdNM6RqESlLqrb96i4fJCGqthSZYcI1HCd
	 WcbUf33v8RIcV6a1TkQzdLsb/hJKTj3aEHL+1z1K0y8XzvvgaF5W0BgzmEa2t0/6dyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441449;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oS4crIHkXag3wnnPASJ03R2UVkt5O45hrU3WSbggrF8=;
	b=ZdpLPo8UCtypPENinx3gwKkdL+/aNHE/jyCaAL0Tq4HcaGNV2llnLtJjBX91/sTZ6O24
	 B89vxEqrcEzfDYzN+EozMHqwrmzt+7LMvn7tTN666BC643mthj9B7anB9Znb7cZIwi1OP
	 hG08vJ5NVLbV90bFNup+H4d471zN/Pt0Q1qJPpjS2W1YuZO2ls+uMOZDV95qkLqmhmOtE
	 M23MSv7yXV0pwNQOjwt/cPu6ABM28C8tbCx73XaMX6r6kk4ZzbfCTI4anDcGj6cLcsVE0
	 My72woJeu3AgqpmLl5Qt+014hbtEr/cNlX53NLJBdHnOcqlhYKkSMx4Eeh5MPGoAxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=TBKrmsCl;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBF606A31F
	for <linux-wpan@vger.kernel.org>; Mon, 23 Nov 2026 13:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABBF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=TBKrmsCl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795441446; x=1795700646;
	bh=oS4crIHkXag3wnnPASJ03R2UVkt5O45hrU3WSbggrF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TBKrmsClmY+jE4pey9hma2lPeNp2tG5fXgNGLYa3X5Ub1tqZDBMm9HD34UIICceWY
	 XA12sAlz/S3WfiI7iU9l0D92Cxk6MmpBIzMUGR1qXPyQSG5VQWvTlHu1zOZJwPAL17
	 z/q0BkyXIJbvNnzebzuPzti2m/l6c/d5jhl2KiUbhftBIBNDtEIJx7yEozuDOTzuB2
	 5aDHEJo4OstuMlPudYQc0zYNOG5Mxg5A6VOgH76+kILWPRx+zqTi8BlYhPtVaZEgH2
	 obr/m+MySWwdKGkgC6Wvykv3NIxG8ChWnfYqVQFtVCoExc5aXRMccF+7nL8vxX5TpH
	 bl5JzzotcNIVQ==
Date: Mon, 23 Nov 2026 13:43:58 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH net v4] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261123134343.1638026-1-rc4d5a@protonmail.com>
In-Reply-To: <20261112153034.1015181-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com> <20261109090226.799973-1-rc4d5a@protonmail.com> <20261112153034.1015181-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: 673f9152a276bae12744019e9e648d26e2b1484e
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

