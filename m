Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497489;
	b=02Dmp6a6+QXBF3w0GSsI+WQthptwARbz2uNnasewl5FSJzLGPu817JqwGWRK3xKsfGM7
	 ZrzK72QHVNKMZ+JwwBoU1QIb72zbF5CEc6B9KhraYv7OUaPtYekayMHEFwtNkdCAKx0e/
	 txrSB6eM/oKmpMNFZQQfogqEcDXFGrxRxJpzTFUHdLAg1R5KLxRLmKD75fRWplz7zGydD
	 3mAKsHQDiOZFuQUtbbEnL1bnqAL4x/1EWdEOacdmos0MiWrFYHXZqRETN46PFteVp4hoT
	 czR54aU/rO6QELo5xWwfKqeBaz4/zxIBA9ZkS+mE5s6AdawJe1qGEUHXkUyuojLIzCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497489;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jxWr0UyAgoOCsx3FYUPyc8/DK6vMkOytDJVYo6SpPCA=;
	b=5IUTWAEUfzEeHGeXgeOuwliFv3C8ZS5mxn1eZuUJTm9jA5Np+p3YRWKnfRNDGDJRE+Ib
	 rBFneVmEkhQL5yM3Dmpa6uqfH60yc6xKHUwPSi3IXpF4AafHbZlyjPibGqjucLvQESnnb
	 pikEqAojrVnAEq3oTNRzj+9M+fPZZ+JuOpPIAGdf2g0Hdg1E+1rHQUjqR+yj9Zy4M/PJH
	 QtnaM2c3DghoyBtTuAPQfzlEbYbeZcBydsilOMV8xubhdPVpRzWusF8iSPFwjHr1Sa9Au
	 S84RwHm5Z/7NH2dXRGNinr6AzghukKsrAdmemp1vKxUOj81LSHcSguwJtBonfDLVYTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="enD/F0ei";
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AC606A337
	for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2026 15:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E92AC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=enD/F0ei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794497486; x=1794756686;
	bh=jxWr0UyAgoOCsx3FYUPyc8/DK6vMkOytDJVYo6SpPCA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=enD/F0eiax/lRDiMR2XI+MZjC0DDtunVMztCY5Mr/Gh47+VYgp7XN+0ULKBMlkiGO
	 PsmFlTh+dWfr2vHHB87r59l4r5JGH7bdVMTbhFKRFP9ssqCChyzunBpxXajo/aJj9H
	 6NvrL67qhPxt5KsQQmuj7BiAl5hAe8zq7mfgH9lFT4nabl1bugOitW5w6GkBKQL8dg
	 q/tyjGgykgZNq0g4EAGLgLGvyE/uR4Sc8NtLnLLMikn02wLj226eoccREWhGJbH/7p
	 7d15lXeyUUqbm4/c/ZrVqvkHQzPwMw7U0tolMoRWvv5Y9TB42M1FirUubk+axl4Q/P
	 8l3nnconvG3mg==
Date: Thu, 12 Nov 2026 15:31:19 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH net v2] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261112153034.1015181-1-rc4d5a@protonmail.com>
In-Reply-To: <20261109090226.799973-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com> <20261109090226.799973-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: 3e01bde934cf601315439b4cf74b12f4be303d8f
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

A 6LoWPAN fragment announces the total size of the datagram it belongs
to (d_size) and its own offset within that datagram. The reassembly
code never checks that the offset actually fits inside d_size, so a
fragment claiming to start past the end of the datagram is accepted
the same as a legitimate one.

lowpan_frag_queue() considers a datagram complete by counting bytes
received (fq->q.meat) against the declared size (fq->q.len), not by
verifying the bytes form a contiguous range. A fragment with an
out-of-range offset still has its length counted toward that total.
If an attacker's out-of-range fragment lands in a gap before the
legitimate fragment for that span arrives, inet_frag_queue_insert()
accepts the attacker's bytes into that span; when the legitimate
fragment for the same span then arrives, it collides with the
attacker's skb and is dropped as an overlap (IPFRAG_OVERLAP). The
datagram still completes, but with the attacker's bytes in the
reassembled buffer instead of the legitimate sender's.

IPv6's reassembly (net/ipv6/reassembly.c, ip6_frag_queue()) computes
end =3D offset + payload length for every fragment and checks end
against IPV6_MAXPLEN, which bounds offset by construction. 6LoWPAN's
d_offset and d_size are independent wire fields with no such coupling,
and no separate bounds check was added for it. RIOT-OS's 6LoWPAN
implementation (gnrc_sixlowpan_frag_rb_add) already rejects a fragment
once offset + size exceeds the reassembly buffer's datagram_size;
Linux's 6LoWPAN reassembly had no equivalent check.

Fixed by rejecting any fragment whose offset exceeds d_size, or whose
offset plus length would exceed d_size. A final fragment ending
exactly at d_size, including a zero-length one at offset =3D=3D d_size, is
still accepted, matching the completion check right below it.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag=
 api")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
v2:
 - Reworded the impact description. 802.15.4 has no source
   authentication without llsec, so this bug doesn't let an attacker
   impersonate another sender; the real effect is that an attacker's
   fragment can get spliced into the reassembled datagram in place of
   a legitimate sender's bytes, with the legitimate fragment for that
   span evicted as an overlap.
 - Dropped the CVE-2019-8359/Contiki-NG comparison. That bug was an
   out-of-bounds write into a fixed buffer; this one only corrupts the
   reassembled payload's contents, since inet_frag_reasm_finish()
   links fragment skbs by pointer rather than copying into a computed
   offset. The two aren't the same severity class.
 - Corrected the described accepted range: the check allows
   offset + length =3D=3D d_size, which it must for the final fragment
   (including a zero-length one at offset =3D=3D d_size), so the accepted
   range has a closed upper bound, not the open "[0, d_size)" the v1
   message stated.

No change to the fix itself; the diff in reassembly.c is unchanged
from v1.

Reproduced two ways: with a local kernel module calling
lowpan_frag_rcv() directly, and over mac802154_hwsim with three
independent processes standing in for sender, receiver and attacker.
An attacker in radio range who observes one fragment of an
in-progress transmission reads d_tag, d_size and the addressing in the
clear, then sends a single out-of-range fragment of its own before the
legitimate fragment for that span arrives. The receiver's reassembly
completes with the attacker's bytes in place of the legitimate
sender's for that span, and the legitimate fragment is dropped as an
overlap. Both reproducers were re-run against this fix to confirm the
out-of-range fragment is now rejected outright.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix, and
the test results myself and take responsibility for this contribution,
per Documentation/process/coding-assistants.rst.

 net/ieee802154/6lowpan/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/r=
eassembly.c
index ddb6a5817d09..905ba5f86844 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -103,6 +103,9 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *=
fq,
 =09offset =3D lowpan_802154_cb(skb)->d_offset << 3;
 =09end =3D lowpan_802154_cb(skb)->d_size;

+=09if (offset > end || skb->len > end - offset)
+=09=09goto err;
+
 =09/* Is this the final fragment? */
 =09if (offset + skb->len =3D=3D end) {
 =09=09/* If we already have some bits beyond end
--
2.51.2

