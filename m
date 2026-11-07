Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090780;
	b=41tPzA5nw3InsTJ8MpeiCe/CAwp26xHcU+3uEjGGhs6226K6zKJmijBADvLRW2Zl+9Dm
	 lCt2//VNjXra3G2TzbV5iRTfVVcOdn+F8yhdJ2MGSotpyPCRX4jrGMITXZm2jLSRcdEKB
	 IPByAh3BlB3chiGe54ocuSkK2Bex5bKm5f/ce2Ay+dbx3wTCPMJpYQsMTPu/eNLuhzdm/
	 hL9OXbo6Mqe2PyPZsACkiRBVLXjCzG9xCkS1XeLqOE47zphuyL2cKkATi6NPe/Idz068G
	 eFWNy7HAihh+GCESaUiLtv11c3+i2I3BsY01QiSjtUwI1IJZMJ3RqYl5XDRy1PcNcyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090780;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=Fy1q9DDL6EW09W8M1xaP5lNpvYiNE8bBDgxpWOc4HI4=;
	b=FnHOu4dM5ZMODCh0ehzrA8CbgqFWboRtD5CVVeFQmeQvim3vuKWzXbIWrswQx8wWFpEc
	 6N7mknHa7cOUGe4jpUn1htxYx/9SsZ15xDrsjEMwgmyY1mero+jkWj7vuLqMI7KYlTjSu
	 6KB7Ywc0sUQWEohc/f6x4X7wbaPsDjUWRdbTTZefPxEtnu8teYou2zAQmEEZylu3jdZ/5
	 Ldrf9Z67414VV2V403iuPiN6E8lYimkGJY6JM9wzU5fEesLj1RTe52qaqdPxNmg+q3a2e
	 BgZfiB6LCiMPYrFajDvzBou/gxaa+tZsx6ZM5pEVSd8i8P9doqFr8DzWeKoG84yPyuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uc7dTI9R;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8635606A32C;
	Sat,  7 Nov 2026 22:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8635606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uc7dTI9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794090776; x=1794349976;
	bh=Fy1q9DDL6EW09W8M1xaP5lNpvYiNE8bBDgxpWOc4HI4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uc7dTI9R3L2Hw2ANmfucfPYrfWCA65/PP3HhZK6jt8ou4SiNnux7Q8NMEbjA4vZbi
	 NfuKLPry/mWuivbRoAk6p/rxpojGZFriwrrQS8C7FDPi55m6kiCbTm1ptlEYaU3WT+
	 qX42CxpJNlq3Khe53upLIzbCQ/HHyaHgdppPJeXz1qBgSfvhKZID+TyYXV5uaZaSte
	 GlgZO3h0E8xKNDQtyt7R2TkYcVqgDUVkIBE762xcMgbHVLObPKX9n6Uf8iWoOrWHZs
	 /6P/YDbgwLa7ZdTQfr3l1D74Oy3/mZDUIBseCrBkFn7gS0VMyc5+/yisFPsfnv6cJF
	 3cbW6WNS+sg+g==
Date: Sat, 07 Nov 2026 22:32:51 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261107223217.718177-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: b722c76460f019a123dd4092d1ad458167b9bc77
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------42251045ef49eb2e1d58e9bb17ea4dbe21ddf3576aebf534060aa7cabb773e01"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------42251045ef49eb2e1d58e9bb17ea4dbe21ddf3576aebf534060aa7cabb773e01
Content-Type: multipart/mixed;
 boundary=4bd63114661f58558a324b8e38d0f5b50f21cf001d258bdae6b10dac11c0
From: Ryan Prinz <rc4d5a@protonmail.com>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH] ieee802154: 6lowpan: validate fragment offset against datagram size
Date: Sat,  7 Nov 2026 23:32:17 +0100
Message-ID: <20261107223217.718177-1-rc4d5a@protonmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0

--4bd63114661f58558a324b8e38d0f5b50f21cf001d258bdae6b10dac11c0
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

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag api")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
Reproduced two ways: with a local kernel module calling
lowpan_frag_rcv() directly, and over mac802154_hwsim with three
independent processes standing in for s
ender, receiver and attacker.
An attacker in radio range who observes one fragment of an
in-progress transmission reads d_tag, d_size and the addressing in the
clear, then sends a single out-of-range fragment of its own. The
receiver's reassembly completes with the attacker's bytes appended to
the legitimate data. Both reproducers were re-run against this fix to
confirm the out-of-range fragment is now rejected and the datagram no
longer completes with it included.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix, and
the test results myself and take responsibility for this contribution,
per Documentation/process/coding-assistants.rst.

 net/ieee802154/6lowpan/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ddb6a5817d09..905ba5f86844 100644
--- a/net/ieee802154/6lowpan/reassembly.c
++
+ b/net/ieee802154/6lowpan/reassembly.c
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

--4bd63114661f58558a324b8e38d0f5b50f21cf001d258bdae6b10dac11c0
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
--4bd63114661f58558a324b8e38d0f5b50f21cf001d258bdae6b10dac11c0--

--------42251045ef49eb2e1d58e9bb17ea4dbe21ddf3576aebf534060aa7cabb773e01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmrvpxMJEAUbKY9nmzGQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdxxi8Ehs2A2U1MdsnVee88FiEE53W/g5B0Z1qG
eqgYBRspj2ebMZAAABU9AP0c8mwebEUm16RNwWgRDmlSc70LDNN5ZgURV+cs
UXk4ggD/fidd7LgZyjBfLEnkrVYLrXqdX0eE4eBe2/fAPuwo0AQ=
=g7G9
-----END PGP SIGNATURE-----


--------42251045ef49eb2e1d58e9bb17ea4dbe21ddf3576aebf534060aa7cabb773e01--

