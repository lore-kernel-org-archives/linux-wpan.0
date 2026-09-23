Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1F4A4848;
	Wed, 23 Sep 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188614; cv=none; b=Qen1z7+pOS2UFB+wNddmL0xRSlalr03peijU6KIUw+5pSjSuM0pUbBdgkzzOVi1MeUHKabGVOchD8hP7CIRIxFBwxi+WJW9x0fXbXdp7V7NGjPsFjkqpTjdqau8hsKQPbCTMzrGLnguv+0PtFBH68B6q9hGMM4I88i9CqNIpEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188614; c=relaxed/simple;
	bh=+Jtt1cU4U8k1cpZJK1LQTkB7oIUEVS9l74OTKqgep2E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOjrMfz0WKR0Wdrr4plv07eCTZrB+PwFtObNK1UogoNvoOCUh1lF5nOgcDDK3SdlrWRhlyAMViFmMUSq43woKiit1VQ7ifAkpQtq1E/A+X547iF9oBbrwS6FIYvPlP+hD1b0c1j2gcoIPLGi8+/8+Ay97XUJTbCqo+q3nYpk9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpe9kFrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpe9kFrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D4D1F000FF;
	Wed, 23 Sep 2026 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188612;
	bh=gLvEq6x6vlfP6bUwxmnguwF0raKfMv/VOUto/aw7tWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tpe9kFrOgveGVJYDE0SHuHzT6I5ZN1n9g5G7YDq8mgM4QKUhxb+wDFCJUNeOSEfAT
	 AfL7mKSJqc0vtgwEVb/58GZWoE3i2rhEvmXA3qpPJs+S6FUDD/nepgUfd2yLyJc7Sp
	 i/nOCfKIBHdPkt6bQSCLYvkRVNYXuk5Tm+OUV6YDTOMhOa5tzq7HGnyGdXHZLj7yUJ
	 aAXg3bjwslRnWHKWJngT4UEPNOXYBcaOuDO3HZQDemVC80TMsRKE2TnoOyU+kFQGN3
	 8voAyqEC6uyQiCAU2NCIoMTKY3pp0JHLq1T+mwGQXtlKIDIMPXV6900jQEMDQQ4UTG
	 7ObqAosAeASUQ==
Subject: Re: [PATCH] 6lowpan: add missing pskb_may_pull() checks in IPHC and
 NHC compression
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: alex.aring@gmail.com, marcel@holtmann.org, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 18:36:50 +0000
Message-ID: <179018861097.2160803.13520936526945055504@kernel.org>
In-Reply-To: <20260919213638.3314763-1-benquike@gmail.com>
References: <20260919213638.3314763-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the same unvalidated IPv6-header dereference on
  the 6LoWPAN transmit path survives in both link-layer callers, which…
- [High] Both new guards are anchored at skb->data, but the reads they
  must protect are anchored at header offsets, so the checks can pass…
- [Medium] The two new pskb_may_pull() failures only produce -EINVAL, and
  neither in-tree caller honours it, so the malformed frame this patch…
- [Low] Commit message states the wrong failure mode, but the concern's
  own mechanism is also disproven.

--

6lowpan: add missing pskb_may_pull() checks in IPHC and NHC compression

This adds a pskb_may_pull() check for sizeof(struct ipv6hdr) in
lowpan_header_compress() and for sizeof(struct ipv6hdr) +
nhc->nexthdrlen in lowpan_nhc_do_compression(), returning -EINVAL when
the headers are not in the linear area.

A few questions on the changelog and on the placement of the checks.

> 6lowpan: add missing pskb_may_pull() checks in IPHC and NHC compression
>
>     When a short or non-linear `ETH_P_IPV6` frame is transmitted over a
>     6LoWPAN interface (for example, via `AF_PACKET`),
>     `lowpan_header_compress()` and `lowpan_nhc_do_compression()` read past
>     `skb_tail_pointer(skb)` and trigger `BUG_ON(skb->len < skb->data_len)`
>     in `skb_pull()`.

[Severity: Low]
Is the described failure mode accurate?  skb_pull() is skb_pull_inline():

include/linux/skbuff.h:
	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);

For the reachable case, a short but linear ETH_P_IPV6 frame (skb->len = 6,
data_len = 0), the skb_pull(skb, sizeof(struct ipv6hdr)) in
lowpan_header_compress() just returns NULL without touching skb->len, so
the BUG() inside __skb_pull() cannot be reached.

The non-linear variant also looks unreachable for these two netdevs:
neither lowpan_setup() (net/ieee802154/6lowpan/core.c) nor netdev_setup()
(net/bluetooth/6lowpan.c) advertises NETIF_F_SG or NETIF_F_FRAGLIST, so
skb_needs_linearize() is true and validate_xmit_skb() linearizes or drops
any paged/fraglist skb before ndo_start_xmit.

Would it be more precise to describe this as an out-of-bounds read of the
IPv6 header whose bytes are then emitted in the compressed header, rather
than as a BUG()?

> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 37eaff3f7b69..b2be70036ee7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -1140,6 +1140,9 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
>  	if (skb->protocol != htons(ETH_P_IPV6))
>  		return -EINVAL;
>  
> +	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> +		return -EINVAL;
> +

[Severity: High]
Does this cover the whole transmit path?  Both link-layer callers
dereference the IPv6 header before lowpan_header_compress() is reached.

net/bluetooth/6lowpan.c:setup_header() {
	...
	hdr = ipv6_hdr(skb);
	...
	memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
	...
	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
}

The memcpy() reads 16 bytes at IPv6 header offsets 24..39 and the result
feeds ipv6_addr_is_multicast(), BT_DBG("dest IP %pI6c") and
peer_lookup_dst(), all before the new check runs.  netdev_setup() sets
hard_header_len = 0 and bt_xmit() only calls skb_unshare(), which
validates no length, so an AF_PACKET send of 6 bytes with sll_protocol =
htons(ETH_P_IPV6) makes those bytes land past skb_tail_pointer(skb).

net/ieee802154/6lowpan/tx.c:lowpan_header_create() {
	const struct ipv6hdr *hdr = ipv6_hdr(skb);
	...
	n = neigh_lookup(&nd_tbl, &hdr->daddr, ldev);
}

This is header_ops->create, called from dev_hard_header() in
packet_snd() on the SOCK_DGRAM path before skb_copy_datagram_from_iter()
has copied any payload, with no pskb_may_pull() anywhere.

Should the length and linearity validation happen at the xmit/hard-header
entry points (bt_xmit()/setup_header() before the daddr read, and
lowpan_header_create()) instead of only inside the compressor?

[Severity: Medium]
Who consumes this new -EINVAL?  Neither in-tree caller looks at it.

net/ieee802154/6lowpan/tx.c:lowpan_header() {
	...
	lowpan_header_compress(skb, ldev, &info.daddr, &info.saddr);

	*dgram_offset = (*dgram_size - skb->len) + skb_network_header_len(skb);
}

lowpan_header() returns only wpan_dev_hard_header()'s value, so the
"if (ret < 0) drop" in lowpan_xmit() is never taken.
net/bluetooth/6lowpan.c:setup_header() also calls it as a void statement
and then reports its own unicast/multicast status, so bt_xmit() goes on to
dev_hard_header()/send_pkt().

Does that mean the frame this patch rejects is still put on the link,
uncompressed?  Its first byte 0x6x aliases LOWPAN_DISPATCH_IPHC (0x60,
mask 0xE0), so a receiver would parse it as an IPHC header.

There is a second effect on the ieee802154 path: the aborted compression
never reaches the skb_pull()/skb_reset_transport_header() at the end of
lowpan_header_compress(), so skb_network_header_len() is called on an skb
whose transport header may still be the ~0U sentinel:

include/linux/skbuff.h:skb_network_header_len() {
	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
	return skb->transport_header - skb->network_header;
}

Can this trip the debug warning and produce a garbage *dgram_offset?

For completeness: the stronger claim that lowpan_xmit_fragment() then
copies past the tail did not hold up — a frame short enough to fail
pskb_may_pull() always satisfies
skb_tail_pointer(skb) - skb_network_header(skb) <= max_single and takes
the single-frame path.

Would it work to have both callers propagate the error and drop the skb,
or to move the check into lowpan_xmit()/bt_xmit()?

>  	hdr = ipv6_hdr(skb);
>  	hc_ptr = head + 2;
>  
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index a4dde85664f2..a9bf340c090a 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -79,6 +79,11 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
>  		goto out;
>  	}
>  
> +	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

[Severity: High]
Are these guards anchored at the right pointer?  pskb_may_pull() measures
from skb->data:

include/linux/skbuff.h:pskb_may_pull_reason() {
	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;
}

but the reads they protect are anchored at header offsets:
lowpan_header_compress() uses hdr = ipv6_hdr(skb), i.e.
skb->head + skb->network_header, and the only in-tree nhc->compress,
udp_compress() (net/6lowpan/nhc_udp.c), reads
udp_hdr(skb) == skb->head + skb->transport_header.  When
skb_network_offset(skb) != 0 the checks validate a different range than
the one dereferenced.

A fully linear case on an ieee802154 6LoWPAN device (lowpan_setup() sets
hard_header_len = sizeof(struct ipv6hdr), min_header_len = 0): send exactly
80 bytes over AF_PACKET SOCK_RAW with sll_protocol = htons(ETH_P_IPV6),
bytes 40..79 being an IPv6 header with nexthdr = 17.

In packet_snd() reserve = 40, the skb is fully linear,
skb_reset_network_header() followed by skb_reserve(skb, -40) leaves
skb_network_offset(skb) == 40, and the
"len < reserve + sizeof(struct ipv6hdr)" re-reset is skipped since 80 is
not < 80.  Then:

net/core/flow_dissector.c:__skb_flow_dissect() {
	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
}

gives thoff = min(80, 80) = 80, so the transport header points exactly at
skb_tail_pointer(skb).  pskb_may_pull(skb, 40) passes (headlen 80),
nexthdr 17 selects the UDP NHC, pskb_may_pull(skb, 48) also passes, and
udp_compress() reads uh->source, uh->dest and uh->check at skb->data +
80..88.  Does lowpan_push_hc_data() then copy those eight uninitialised
bytes into the header that is transmitted on the link?

The IPHC guard looks affected the same way by any non-zero network offset,
e.g. a tc mirred ingress-to-egress redirect that does
skb_push_rcsum(skb, skb->mac_len) before dev_queue_xmit(), giving
network_offset 14 and a 14-byte past-tail read of hdr for skb->len in
40..53.

Would pskb_may_pull(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr))
and skb_transport_offset(skb) + nhc->nexthdrlen be the right forms here,
or should a non-zero skb_network_offset(skb) simply be rejected?

>  	/* In the case of RAW sockets the transport header is not set by
>  	 * the ip6 stack so we must set it ourselves
>  	 */

On the adjacent pre-existing fixup:

	if (skb->transport_header == skb->network_header)
		skb_set_transport_header(skb, sizeof(struct ipv6hdr));

This isn't a bug introduced by this patch, but the canonical test for an
unset transport header is !skb_transport_header_was_set(skb):

include/linux/skbuff.h:skb_transport_header_was_set() {
	return skb->transport_header != (typeof(skb->transport_header))~0U;
}

With the equality test above, an skb whose transport header was never set
escapes the fixup and udp_hdr(skb) resolves to skb->head + 0xFFFF.  Is it
worth switching to skb_transport_header_was_set() while touching this
function?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919213638.3314763-1-benquike%40gmail.com
