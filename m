Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843860;
	b=boKMJTblZCd4dGbNpf5RjKFDI18yqHWjobUIEpSRYef5mCYIX7uj25NOOwm8cXePky9o
	 9diaRUngOV7K2icPWeLaVn+OjzlOt7sqBb82Ctgsu8r4LmwpDvM68ouZL/gOVFCsrKPxe
	 le5vKifLpb34OYgfYipqk4yoBoIKkUfrn+AH+q7zrIVM7L7U0mmEwggROVFeRujgmqvWS
	 NFBLRX+dkhbG6gZE0UIWA4qUV8peQINMGbAKuBaBzMawzHBuKFUR9Z8k5nzSilc7sWZMi
	 kc5/PfRGYtfgo/fdco+yFfs/5e4GqJGjGDmr6Rr9GR6zw7bSkir237BTZktH879qpwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=C9+XjET5RSQdlM7ZfuD3xAhjrNGw9Kacup8gENsd8So=;
	b=3PT1IkBTd81cJx3645zL/UbWYfo5ZKs6EwqhedqxFnbq9+7uwhBGvWYByhuodkZkANte
	 2SF0uh7qJ3WWp1VPYK7SMGDrpoQ2igt3mM27YcNhP7dbDTDX/GZ7Ckj1aXhPWlMAUT+ok
	 0zCRd7JUzpnby1Ur3nFrc3E/7e82l0lyTh05a4s4N5KFuC7NnwO2WkolVKjLyJ65Om9dn
	 xX7DyFi2fWl+1DwBAhHT6I961QX5b6w91b5kuTY7eJrh/ZApm5cYfNz2Z/jIwjLEtM0FU
	 q7RsM1vdXiTCPbbdF80FnnaE09bNtkhVVSJOnDtG6Quq7kPMtqUQoutKHzTuxF/i0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWJT8Xpk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557C606A323;
	Mon, 16 Nov 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWJT8Xpk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FC1F000C9;
	Mon, 16 Nov 2026 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843859;
	bh=C9+XjET5RSQdlM7ZfuD3xAhjrNGw9Kacup8gENsd8So=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UWJT8XpkK/yddz+mkY7X5hnChMl5ZLi6pXmEs/tQcHYLURFwYuj0T/JR1CBdbZzX3
	 BFF1H4HXOhzcIIqEzTPkZZrpf0EgSIsms53gJaWy3m/SDwUKmCKQhYLWNQpYPxn07v
	 BYNHsbzk3hALhnw6jsAu52bUCjy3EGaw1AyCTKhZudhwJsC9hiHboITQDoQILB1gr/
	 BQx+ehQZxG0mNh8KaV022+SV2Nx8PNKDK2+IDH+5YON8F8zc1YcdLcbyg2zIOsA4MT
	 a+DsEVTQzwYl+9jLCUgSUv93mybbo/C1o01Xj2uhLwpwjQnTtz8nyQJtHB6yavDNnZ
	 BH8VHImzrUu/A==
Subject: Re: [PATCH net v2] ieee802154: 6lowpan: validate fragment offset
 against datagram size
From: netdev-bot+sashiko@kernel.org
To: rc4d5a@protonmail.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 15:44:18 +0000
Message-ID: <179484385868.3136.2031122352295651681@kernel.org>
In-Reply-To: <20261112153034.1015181-1-rc4d5a@protonmail.com>
References: <20261112153034.1015181-1-rc4d5a@protonmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ieee802154: 6lowpan: zero-length fragments accepted in
  lowpan_frag_queue()
- [Medium] The commit message gets both the impact and the mechanism
  wrong, and overstates what the patch protects against.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  code path the patch's scenario depends on.

--

ieee802154: 6lowpan: validate fragment offset against datagram size

This patch adds a bounds check to lowpan_frag_queue(). The check rejects
any 6LoWPAN fragment whose offset is greater than d_size, or whose offset
plus length is greater than d_size. The commit message says this stops an
attacker's out-of-range fragment from being spliced into a reassembled
datagram in place of the legitimate sender's bytes.

> If an attacker's out-of-range fragment lands in a gap before the
> legitimate fragment for that span arrives, inet_frag_queue_insert()
> accepts the attacker's bytes into that span; when the legitimate
> fragment for the same span then arrives, it collides with the
> attacker's skb and is dropped as an overlap (IPFRAG_OVERLAP). The
> datagram still completes, but with the attacker's bytes in the
> reassembled buffer instead of the legitimate sender's.

[Severity: Medium]

Does this describe what happens to a fragment that starts past d_size?

lowpan_frag_queue() passes end = d_size to inet_frag_queue_insert(). If
the attacker's node sits at an offset greater than d_size, a later
legitimate fragment always takes the left branch in the binary search:

net/ipv4/inet_fragment.c:inet_frag_queue_insert() {
    ...
			if (end <= FRAG_CB(curr)->ip_defrag_offset)
				rbn = &parent->rb_left;
    ...
}

So nothing is dropped as an overlap. The out-of-range fragment only adds
to fq->q.meat. In most cases meat == len is then never reached, and the
queue waits for the timeout.

A DUP/OVERLAP collision can only happen for the other half of the check
(offset < d_size, offset + len > d_size). Even then, one such fragment
pushes meat past d_size. Doesn't "the datagram still completes" need
more conditions than the message gives?

Also, the new check still accepts an in-range forged fragment that gives
the same splice. Take d_size = 96, with a legitimate FRAG1 covering
[0, 48) already queued. An attacker sends a FRAGN with the same d_tag,
d_size and addresses, d_offset = 6 and 48 bytes of payload:

    offset = 48, skb->len = 48, end = 96
    48 > 96 is false, 48 > 96 - 48 is false  -> check passes
    48 + 48 == 96                            -> final, LAST_IN set

inet_frag_queue_insert() appends it on the common path. meat reaches 96,
and lowpan_frag_reasm() completes the datagram with the attacker's bytes.

802.15.4 has no source authentication without llsec, so no reassembly
bounds check can prevent that.

The check still works as hardening against malformed fragments. Could the
commit message be reworded so readers and stable backporters don't take
it as a fix for third-party fragment splicing?

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

[Severity: High]
Should this also reject skb->len == 0?

The new check lets a zero-length fragment through at any offset up to
d_size. The commit message also says a zero-length final fragment at
offset == d_size is meant to be accepted. ip_frag_queue(),
ip6_frag_queue() and nf_ct_frag6_queue() all treat end == offset as
invalid, and drop the fragment before it reaches
inet_frag_queue_insert().

Empty fragments are easy to produce here:

  - lowpan_get_cb() only checks !skb->len on the FRAG1 branch. A FRAGN
    frame carrying nothing but its 5-byte header therefore reaches
    lowpan_frag_queue() with skb->len == 0.

  - A FRAG1 whose only payload is the LOWPAN_DISPATCH_IPV6 byte passes
    lowpan_get_cb() with skb->len == 1. lowpan_rx_h_ipv6() then pulls
    that byte, so this fragment also arrives here empty.

Take an empty FRAGN with d_offset = 0 that arrives before FRAG1. It
becomes the first node in fq->q.rb_fragments, with ip_defrag_offset 0
and len 0. When the real FRAG1 arrives at offset 0, the common path in
inet_frag_queue_insert() sees

    offset == FRAG_CB(last)->ip_defrag_offset + last->len   (0 == 0)

It calls fragrun_append_to_last(), so FRAG1 is chained behind the
empty skb.

Once meat reaches len, inet_frag_reasm_prepare() uses the first
rb_fragments node as the head, which is the empty FRAGN.
inet_frag_reasm_finish() then does

    skb_push(head, head->data - skb_network_header(head));

That pushes the pulled FRAGN header back in front of the packet. The
decompressed IPv6 header from FRAG1 sits behind it in frag_list. The
dispatch-only FRAG1 case does the same with the 0x41 byte. In both
cases the reassembled packet passed up the stack no longer starts with
its IPv6 header.

Empty fragments at offset == d_size cause a different problem. The
first one sets INET_FRAG_LAST_IN before the real final fragment has
arrived. Repeats go down the binary search in inet_frag_queue_insert(),
where "end <= ip_defrag_offset" holds (d_size <= d_size) before the
IPFRAG_DUP test is reached. Each copy is linked into rb_fragments and
charged through add_frag_mem_limit(). fq->q.meat never moves, so the
memory stays held until the reassembly timer fires.

At an intermediate offset, an empty fragment can do one of two things.
It can be chained onto the tail run without advancing frag_run_len.
Or it can start a zero-length run, so that a later legitimate fragment
below it fails with IPFRAG_OVERLAP.

Would it make sense to add !skb->len to this check, and drop the
zero-length wording from the commit message? Putting it here rather
than in lowpan_get_cb() also covers the FRAG1 case, because that skb
only becomes empty after the rx handlers run.

This matters even more if the insert end is changed to
offset + skb->len, because inet_frag_queue_insert() assumes
offset < end.

[Severity: High]

This is a pre-existing issue and was not introduced by this patch, but
the scenario in the commit message depends on it. Further down,
lowpan_frag_queue() does:

	err = inet_frag_queue_insert(&fq->q, skb, offset, end);

Here end is d_size, the size of the whole datagram, rather than the
fragment's own end (offset + skb->len). ip_frag_queue() and
ip6_frag_queue() both pass the fragment's own end:

net/ipv6/reassembly.c:ip6_frag_queue() {
    ...
	end = offset + (ntohs(ipv6_hdr(skb)->payload_len) -
			((u8 *)(fhdr + 1) - (u8 *)(ipv6_hdr(skb) + 1)));
    ...
}

Doesn't this make inet_frag_queue_insert() treat every 6LoWPAN fragment
as covering [offset, d_size)?

On the common path, the "last_end < end" test turns into
"last_end < d_size". Any fragment with offset < last_end then returns
IPFRAG_OVERLAP.

On the binary search path, "end <= curr offset" is never true for an
in-range node. The walk can never go left, so it ends in IPFRAG_DUP or
IPFRAG_OVERLAP.

Trace 1, d_size = 96, fragments arrive out of order:

    FRAGN d_offset=6, len 48  -> final, run [48, 96)
    FRAG1 offset 0, len 48    -> last_end 96 is not < 96, binary search
                                 96 <= 48 false, 0 >= 96 false,
                                 0 >= 48 false -> IPFRAG_OVERLAP

FRAG1 is freed through goto err and INET_FRAG_FIRST_IN is never set, so
the datagram can never complete.

Trace 2, four 24-byte fragments at offsets 0/24/48/72, arriving in the
order 0, 48, 24:

    fragment 24 -> last_end 72 < 96, offset 24 < 72 -> IPFRAG_OVERLAP

So it looks like any datagram whose fragments arrive out of ascending
order, or with a gap, can never be reassembled. The partial queue keeps
its frag memory until the reassembly timer expires. This seems to date
back to 254c5dbe15d4 ("6lowpan: use rbtree for IP frag queue").

The "dropped as an overlap" behaviour in the commit message looks like a
side effect of this wrong interval, not real overlap detection.

Would it make sense to also pass offset + skb->len as the insert end,
and use d_size only for q.len and the completion check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112153034.1015181-1-rc4d5a%40protonmail.com
