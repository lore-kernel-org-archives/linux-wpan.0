Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474313;
	b=reG+ONmERaKbKJ3EA1+OERZZCx5qXFLTkR5VGZt+OeQ+qpEf5ExSiQEozfozwBgkCFxJ
	 vBmDwKP6V+d5t9H9/jhAJ7qj9UcQdppK7GcbjW48H2np67GeGoEYBpNgNs4i9SCpu86Ud
	 H7xEn1fwIDBx/aveff8jQsi0b+rScoJ3X2a389dF8pGz58BSrT/NGZnsBOY+Zlfuah7qA
	 8bHx2zEzln20dMKceFo78I3bQzgW8EcVrDT45i1B1pIylknKn9fCW/c1IzVhc/lULJ62K
	 qvZt7ODZz+QCQKSPQyTtWzC5SnQGnn6kqI1mT3qXjOTONmMaDUgXFz8sRv4zwagPVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474313;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=T6KbVd0311ptwDs/ZdF97Qisn+PkZ36G5vjlrqBZgxM=;
	b=H99ACAb9/m60hgLGsYzjk/Dh7Jj4+0AVr85w7qyNTJ+MuU711cQ7tbhBnX26/A+goI6a
	 e18+T3P1gGMi0JcxjI/DNTUbFuPqQNmilxRAUwdmC2roJYJyCQZqKOqSlVzs0JE9y+jde
	 7WPjp+BHgQA8Bi1q5usJTau8LSeqPn2MvFvhohRMm8Je05Ywb0XyFDmnIPqZtbRCn9V7f
	 HUdcmtIhCkvAli2/G3Lg3fl3gqtoMWuQJnwNZcggcCQOHn1gjR7JhyxvGWkAQDaKMcC5r
	 ul5XkNv5HrU8R8KCC5Du7nM/QDWWkd7GP6zPz1yIAKKqakQxNjbGyMQAj1GcZN7ZTxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABn4BWQF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25003606A332;
	Thu, 12 Nov 2026 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABn4BWQF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1063C1F00A05;
	Thu, 12 Nov 2026 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474312;
	bh=T6KbVd0311ptwDs/ZdF97Qisn+PkZ36G5vjlrqBZgxM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ABn4BWQFXYKuTtJUDBk+Zly3a0AlZbsm/RtBN8VHj6svE+fQFU7vXsRe/KduTtf93
	 rIcCiDlxV0F8t0erY3ETC3rtkhSRdZnUsEKVtwCKqdZVnxydr+a69qw4b63lC3mAQC
	 wr96Hl2V/0AU6jiYsD77OHXmvXV5qymBmMjA11FOlhk3BLlIZAih4efqU2IGmW7zfl
	 KuklxwuwjkFjf6O37TM9Kn4NrePDSPADEyDWw0F45lPkNShc6buOvx8E9YYm3P6rtM
	 AeyDqjrrMT27eDBiCskVnQFPLu9glY5X9md7DsLjAYJqmU9NnLgjqFzl2qg+qNXGg8
	 0AlNOrZvQH9ug==
Subject: Re: [PATCH net RESEND] ieee802154: 6lowpan: validate fragment offset
 against datagram size
From: netdev-bot+sashiko@kernel.org
To: rc4d5a@protonmail.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 09:05:11 +0000
Message-ID: <179447431152.2199510.14609873818368730049@kernel.org>
In-Reply-To: <20261109090226.799973-1-rc4d5a@protonmail.com>
References: <20261109090226.799973-1-rc4d5a@protonmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message overstates the security impact and
  misstates the check it adds.

--

ieee802154: 6lowpan: validate fragment offset against datagram size

This commit adds a bounds check to lowpan_frag_queue() that rejects a
6LoWPAN fragment when its offset, or its offset plus length, goes past
the declared datagram size (d_size). The commit message says this stops
an attacker from forging another sender's data. It also compares the
bug to CVE-2019-8359 in Contiki-NG.

> fragment claiming to start far past the end of the datagram is
> accepted the same as a legitimate one, allowing an attacker to forge
> data of another sender.

[ ... ]

> The same class of bug was assigned CVE-2019-8359 (CVSS 9.8) in
> Contiki-NG's 6LoWPAN stack before a 2019 fix; RIOT-OS's implementation

[ ... ]

> Fix by rejecting any fragment whose offset, or offset plus length,
> falls outside [0, d_size).

[ ... ]

> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index ddb6a5817d098..905ba5f868442 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -103,6 +103,9 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
>  	offset = lowpan_802154_cb(skb)->d_offset << 3;
>  	end = lowpan_802154_cb(skb)->d_size;
>  
> +	if (offset > end || skb->len > end - offset)
> +		goto err;
> +

[Severity: Medium]
Does the commit message match what this check rejects and what it
protects against?

The check accepts offset + skb->len == end, which it has to for the
final fragment. It also accepts a zero-length FRAGN with offset ==
d_size. So the fragment end has a closed upper bound, not the
"[0, d_size)" range the message gives.

ip6_frag_queue() drops zero-length fragments:

	if (end == offset)
		goto discard_fq;

lowpan_frag_queue() still accepts them. They add nothing to fq->q.meat,
so they can't append any data.

About "allowing an attacker to forge data of another sender": the
message assumes the attacker can read d_tag, d_size and the addressing
in the clear. With that, can't the attacker still send an in-range
fragment at the next expected offset? For example, with d_size = 200:

  FRAG1 [0, 64)       legitimate, queued
  FRAGN [64, 136)     attacker, passes the new check
  FRAGN [64, 136)     legitimate, rejected as an overlap
  FRAGN [136, 200)    legitimate, completes the datagram

The attacker's fragment takes the append path in
inet_frag_queue_insert():

	else if (FRAG_CB(last)->ip_defrag_offset + last->len < end) {
		/* This is the common case: skb goes to the end. */
		/* Detect and discard overlaps. */
		if (offset < FRAG_CB(last)->ip_defrag_offset + last->len)
			return IPFRAG_OVERLAP;
		if (offset == FRAG_CB(last)->ip_defrag_offset + last->len)
			fragrun_append_to_last(q, skb);

The legitimate [64, 136) fragment then gets IPFRAG_OVERLAP and is freed
through goto err in lowpan_frag_queue(). The reassembled datagram ends
up holding the attacker's bytes.

Also, 802.15.4 has no source authentication without llsec, so an
attacker can just spoof a whole datagram. This bug doesn't really enable
forging another sender's data, and the patch doesn't prevent it.

About "The same class of bug was assigned CVE-2019-8359 (CVSS 9.8)": the
Contiki-NG bug was an out-of-bounds write into a fixed reassembly
buffer. Linux never copies payload to a computed offset.
inet_frag_reasm_finish() links the fragment skbs to the head:

				head->data_len += fp->len;
				head->len += fp->len;
				head->truesize += fp->truesize;

				*nextp = fp;

So before this patch, an out-of-range offset only changed the contents
of the reassembled payload. It never touched memory outside it. Could
the comparison and the 9.8 score come out of the message? They may
mislead stable and CVE triage.

The change itself looks like a reasonable integrity and robustness fix:
a reassembled datagram can no longer contain bytes past the declared
d_size. Could the message describe it that way, and give the fragment
end's upper bound as closed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109090226.799973-1-rc4d5a%40protonmail.com
