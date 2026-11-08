Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143151;
	b=udGAPNDrOA0QzUvQ9YFUdXc3AtNJXPpEAXYq6rhzmxh9X4tUl4XkUYDohYvoWQieIn/v
	 nfghAlcpPeOtMXHnnX+g9A/2foTToR9saQLfaqDK+rGCMAVMQoeiux6sCYIV/HWOPOUf/
	 0f9XRk2pRqnkP8CpLXcGc0LcYUZgX1CazDAxtwEDUBMzXHx1hgC1s3XXbHHWuB3f9pDGr
	 8O6FhWuXO6GFPUvMCULix2e0Z/uv50wF5lR13LimlOABFY3HDC1G6hR5G9pFLr05KDeq4
	 ynMkqF/VJqlEz8SKKS/9l6+C2dmZBLIIAUXb3ajrJD+hsVFc2VnX3NNuDL+9S8HWKlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143151;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=/ju0UIjdCG6ZiMr1SA/N7Lj70Ti90KDSIS/K4qvyQxQ=;
	b=uejM8/yDrsYZlXUDy89vTOklOrTFGPtX5OQPU/0P0f7cGCE7RyR7TWDVhkzSsOHJR14z
	 JlE3W/f8jK0UqFZ2W7eJgJ8cw+RGJe1LmPl1tmSww1jSBV25hq8302ly8tS/uTmNP+zds
	 9rHxA8q1qOLHaP4BAF+MfUZO97WQXV4vM9NxS8Zi0rvDlxUtGxFtNHHAXMkQwumvFXlDB
	 c0b2INaOooXBHwSxzFj76prnQD0YBHHPL3OF/iWuLsyec1Yi6tobiOFLlD3a9CMdDobZc
	 SgjoKnIGeoWxGQp7tO+kmaorhk9wUERKjyEcrP+Y5GoL6gnzmRdPZfnjDEcQSe6EZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=o3rqLGjq;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE063606A31C;
	Sun,  8 Nov 2026 13:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE063606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=o3rqLGjq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794143147; x=1794402347;
	bh=/ju0UIjdCG6ZiMr1SA/N7Lj70Ti90KDSIS/K4qvyQxQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o3rqLGjqvzp7+G6cz6+cQdskBARZy19bhv3arsNAaM6Mu/7MygMNlfAwf+DNDE7ua
	 3BsuSmuFRODGta6hmfkPAtpNHnzQu8mR/xNqlG2dox3mywQ6xZ0VmRdtm8MWRkYott
	 7RQfvnlaXH8pC9lI/PGHedSDHN4QkIsjxb57/ujWxglp2Pld05WgSoJIKY3UL9vFz/
	 fsetGO2+6SxFXHWFbaVOukQfAYznq/l0+6Ep/PtD5PXNYHW7dc3Q7l4mckg1fwOjAr
	 /EjIxp59cp5lSb+5u+r/dq+q2gZae8buhSk8ZCpCKnCgRVyDpSIWGtSQtwvg+nzk9Q
	 Npc/SuJsDVEpw==
Date: Sun, 08 Nov 2026 13:05:39 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH RESEND] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261108130206.754001-1-rc4d5a@protonmail.com>
In-Reply-To: <20261107223217.718177-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: 3198adb360e38418fb809f75944811b80fa1d874
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------2c03c29bb9b1c09a28d4879c764dda018846c6e22f456204e9f38544bf3c6b32"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2c03c29bb9b1c09a28d4879c764dda018846c6e22f456204e9f38544bf3c6b32
Content-Type: multipart/mixed;
 boundary=1ea5e3d545f9d130cb916a3b988a47f35340a498e3004eb4c98226cb82f1
From: Ryan Prinz <rc4d5a@protonmail.com>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH RESEND] ieee802154: 6lowpan: validate fragment offset against datagram size
Date: Sun,  8 Nov 2026 14:01:17 +0100
Message-ID: <20261108130206.754001-1-rc4d5a@protonmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107223217.718177-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com>
MIME-Version: 1.0

--1ea5e3d545f9d130cb916a3b988a47f35340a498e3004eb4c98226cb82f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A 6LoWPAN fragment announces the total size of the datagram it belongs
to (d_size) and its own offset within that datagram. The reassembly
code never checks that the offset actually fits inside d_size, so a
fragment claiming to start far past the end of the datagram is
accepted the same as a legitimate one, allowing an attacker to forge
data of another sender.

lowpan_frag_queue() considers a datagram complete by counting bytes
received (fq->q.meat) against the declared size (fq->q.len), not by
verifying the bytes form a contiguous range. A fragment with an
out-of-range offset still has its length counted toward that total, so
a legitimate fragment exchange plus an attacker fragment can sum to
d_size, marking the datagram complete while a gap in the data was
never filled, and appending the out-of-range fragment's bytes to the
end of the reassembled buffer as if they were part of the message.

IPv6's reassembly (net/ipv6/reassembly.c, ip6_frag_queue()) computes
end = of
fset + payload length for every fragment and checks end
against IPV6_MAXPLEN, which bounds offset by construction. 6LoWPAN's
d_offset and d_size are independent wire fields with no such coupling,
and no separate bounds check was added for it.

The same class of bug was assigned CVE-2019-8359 (CVSS 9.8) in
Contiki-NG's 6LoWPAN stack before a 2019 fix; RIOT-OS's implementation
(gnrc_sixlowpan_frag_rb_add) rejects a fragment once offset + size
exceeds the reassembly buffer's datagram_size. Linux's 6LoWPAN
reassembly is the only one of these implementations without an
equivalent check.

Fix by rejecting any fragment whose offset, or offset plus length,
falls outside [0, d_size).

Reproduced two ways: with a local kernel module calling
lowpan_frag_rcv() directly, and over mac802154_hwsim with three
independent processes standing in for sender, receiver and attacker.
An attacker in radio range who observes one fragment of an
in-progress transmission reads d_tag, d_size and
 the addressing in the
clear, then sends a single out-of-range fragment of its own. The
receiver's reassembly completes with the attacker's bytes appended to
the legitimate data. Both reproducers were re-run against this fix to
confirm the out-of-range fragment is now rejected and the datagram no
longer completes with it included.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix, and
the test results myself and take responsibility for this contribution,
per Documentation/process/coding-assistants.rst.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag api")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
Resending to fix a diff formatting issue in my previous mail.

 net/ieee802154/6lowpan/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ddb6a5817d09..9
05ba5f86844 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -103,6 +103,9 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 	offset = lowpan_802154_cb(skb)->d_offset << 3;
 	end = lowpan_802154_cb(skb)->d_size;
 
+	if (offset > end || skb->len > end - offset)
+		goto err;
+
 	/* Is this the final fragment? */
 	if (offset + skb->len == end) {
 		/* If we already have some bits beyond end
-- 
2.51.2

--1ea5e3d545f9d130cb916a3b988a47f35340a498e3004eb4c98226cb82f1
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - rc4d5a@protonmail.com
 - 0xE775BF83.asc"; name="publickey - rc4d5a@protonmail.com -
 0xE775BF83.asc"
Content-Type: application/pgp-keys; filename="publickey -
 rc4d5a@protonmail.com - 0xE775BF83.asc"; name="publickey -
 rc4d5a@protonmail.com - 0xE775BF83.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFkRFpyUllKS3dZQkJBSGFS
dzhCQVFkQTFpeGV6cng0ZTBFNWJGcjV6UU8xMitlb20vdWZnUVFTS05jQwpHU1ZjUzlqTkxYSmpO
R1ExWVVCd2NtOTBiMjV0WVdsc0xtTnZiU0E4Y21NMFpEVmhRSEJ5YjNSdmJtMWhhV3d1ClkyOXRQ
c0xBRVFRVEZnb0Fnd1dDYWREWnJRTUxDUWNKRUFVYktZOW5tekdRUlJRQUFBQUFBQndBSUhOaGJI
UkEKYm05MFlYUnBiMjV6TG05d1pXNXdaM0JxY3k1dmNtY21EdVNNSm1tcTJWVDN2aFkzY0JzRDFS
YUVsZGE2dDdpTwo1S21uZXZwYXhRTVZDZ2dFRmdBQ0FRSVpBUUtiQXdJZUFSWWhCT2QxdjRPUWRH
ZGFobnFvR0FVYktZOW5tekdRCkFBQmFDUUVBdWxVaElDbmFPSU9DT1d4T3pldUNUZ0dUVGkxM1k4
WjdVL3pYaER1bmFpa0EvaUJRRVBZOEx5NisKU2RZUnZzekQwcHBsS0M0elB2WkhqRDZaMEo4U2Ir
RUh6amdFYWREWnJSSUtLd1lCQkFHWFZRRUZBUUVIUUNwbApBSFVLZXNpb25QaGlBVnBvL3dDUFdt
MnR3SGtpL0tmaUpHQVdlckIxQXdFSUI4SytCQmdXQ2dCd0JZSnAwTm10CkNSQUZHeW1QWjVzeGtF
VVVBQUFBQUFBY0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm4KNlJuS0R5
WjJlV1BjOSs3NEJIR3VPM1E1VGVuWFZ6bWRrRjQ3L1lYQUxFOENtd3dXSVFUbmRiK0RrSFJuV29a
NgpxQmdGR3ltUFo1c3hrQUFBN1RzQS8zRy9hUE9NeGE2MDZxdlh2U3lUOURDNTJCa294ZmlNMk5N
SFpHK0QwSnVGCkFQMFhXbGRlbEVvTFY1bWNRbXFIVThqMVp2ZzRtT1hWL2owYytPWmRheVhUQnc9
PQo9VnZDNAotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
--1ea5e3d545f9d130cb916a3b988a47f35340a498e3004eb4c98226cb82f1--

--------2c03c29bb9b1c09a28d4879c764dda018846c6e22f456204e9f38544bf3c6b32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmrwc6EJEAUbKY9nmzGQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdVS9eo+zjAiYA0l4KVgkLaFiEE53W/g5B0Z1qG
eqgYBRspj2ebMZAAANfIAQCtF6Zd8rhwswy4nrHGfMF/jswh0TUkx7Q0ez0N
CPr3kQD/TdaeisSlJm3LvLvmVkYKWlG9UEYjzyPsg74qGFYZ4wY=
=X2QL
-----END PGP SIGNATURE-----


--------2c03c29bb9b1c09a28d4879c764dda018846c6e22f456204e9f38544bf3c6b32--

