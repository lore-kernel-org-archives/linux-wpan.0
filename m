Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65075372F0;
	Thu, 17 Sep 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664564; cv=none; b=UP8+sO3LY0wXaapC0GVhGY0H3CCzMTmH9ew18MIulv3L++0HNv45elSUKI8SE3eircHlDfXRqUVW6WzbiNUE9yyaq6sQCO5ZPwyPe3Dw0b1Xa8IzXolZAq4T/2PJS07exi6E5+IXbZOgVLLCA0k7ajxD9kJeAbwXrSbf7JuHUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664564; c=relaxed/simple;
	bh=r5wQ7Q71ZnW7DtUnZFVpltScTLGufe8Rx4r69gWOfdU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MH2wrgX1tB1pc/RsjFwzHucexemsd6e+T9bWXRCW+jRDc4E2gtXkYgBRGTMQM/D9gJeGs1yhhsPB4+fg3ugNijrhxXNgULY9sDMzCRlAjXmaAlGzHoj/idVFcW/gOL6kmTYtKD59dYYGE/szWoI5EDk3U/NwqWdZLjlAo/X/CZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6Hia2gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6Hia2gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0041F0089A;
	Thu, 17 Sep 2026 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664562;
	bh=9gkUpcacySlNXR9m3jO0DJtl7wJBJZ8H/KILpliZ6mE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F6Hia2gyk69p45JstMH6cQVPw3K78esP4NFUgZ/LMMw8NbZRT1xXgPuJjnfzL2+se
	 Rc8HyLPCuPAXDUjAaKNsZ1tPyPJq/uGN2ZHbszYYVg9TYKIENl5Ps0WUd59Vzh/EEA
	 GNJ+QLu9bpGGaS7Po28tmbTfu4ChX2IQhkcamfqs28nHAhuzjHm7fzQAc/yp8NRn8f
	 UdUxNYpJErjyZ64/1kvWpcE+93vmi7pXJC3HN3SRe0Yvv6WVqDFuFdeXE7RoCEUy4f
	 KMYaoBJ4bcEWXq5zhsUyfKCZOP4ZflRy5GEtr2DEFnkAcYfZBrNUlUVLyKnlnokOOo
	 KuuXHheQmch6Q==
Subject: Re: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from NA
 messages
From: netdev-bot+sashiko@kernel.org
To: lfqlee314@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rdunlap@infradead.org, netdev@vger.kernel.org, aajith@arista.com,
 roopa@nvidia.com, jhpark1013@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex.aring@gmail.com, linux-wpan@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
Date: Thu, 17 Sep 2026 17:02:40 +0000
Message-ID: <178966456087.22033.11671220306303617581@kernel.org>
In-Reply-To:
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
References:
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] net/ipv6/ndisc.c:ndisc_recv_na() now passes two different
  gateway keys to rt6_clean_tohost() for the very same "router -> host"…
- [Low] Reported for completeness only; assessed as resolved within this
  series.
- [Low] The comment block added at net/ipv6/ndisc.c:985-988, at the top
  of accept_untracked_na(), is indented with four spaces instead of…

--

ipv6: update NUD_FAILED neighbors from NA messages

This teaches ndisc_recv_na() to treat a neighbour entry in NUD_FAILED the
same way as a missing entry, so an NA with a target link-layer address
option moves it to STALE on routers when accept_untracked_na is enabled.
The ndisc_ops update callback gains a failed_recovery argument and the
sysctl documentation is reworded accordingly.

Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com

A few questions below.

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 90cd5d8525698..84d70c09205a2 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c

[ ... ]

> @@ -972,14 +982,18 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
>  
>  static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
>  {
> +    /* For any given neighbor IP address, consider it an untracked neighbor if
> +     * it is absent from the neighbor cache or if it has a NUD_FAILED entry in
> +     * the neighbor cache
> +     */
        ^^^^

[Severity: Low]
This isn't a bug, but this comment block in accept_untracked_na() is
indented with spaces while the switch statement right below it uses tabs,
so checkpatch reports "ERROR: code indent should use tabs where possible".

The comment also describes what the caller considers "untracked", based on
the neighbour cache, but accept_untracked_na() only reads the sysctl value
and never sees the neighbour entry. Would it fit better next to

	neigh_untracked = !neigh || neigh_failed;

in ndisc_recv_na(), where the RFC 9131 decision table already documents the
same concept?

>  	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
> -	case 0: /* Don't accept untracked na (absent in neighbor cache) */
> +	case 0: /* Reject NAs for untracked neighbours */
>  		return 0;
> -	case 1: /* Create new entries from na if currently untracked */
> +	case 1: /* Accept NAs for untracked neighbours */
>  		return 1;

[ ... ]

> @@ -1067,32 +1084,41 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)

[ ... ]

>  	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
> -	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
> -		if (accept_untracked_na(idev, saddr)) {
> -			neigh = neigh_create(tbl, &msg->target, dev);
> -			new_state = NUD_STALE;
> -		}
> -	}
> +	neigh_failed = neigh &&
> +		       (READ_ONCE(neigh->nud_state) & NUD_FAILED);
> +	neigh_untracked = !neigh || neigh_failed;
> +	if (neigh_untracked) {
> +		accept_untracked = lladdr && idev &&
> +				   READ_ONCE(idev->cnf.forwarding) &&
> +				   accept_untracked_na(idev, saddr);
> +		new_state = NUD_STALE;
> +	}
> +	if (!neigh && accept_untracked)
> +		neigh = neigh_create(tbl, &msg->target, dev);

[Severity: Low]
Is the new FAILED handling covered by an in-tree test at this point in the
series? As of this commit, ndisc_unsolicited_na_test.sh and
arp_ndisc_untracked_subnets.sh only seed absent entries, so the whole
FAILED to STALE half of the knob, including the mode 2 same-subnet
qualification, would still pass if it were broken.

For the record, this looks resolved later in the same series: the follow-up
patch "selftests: net: test untracked NA recovery of FAILED neighbors"
(7be3b5fcfd3f9adb7489aff8013c6d4beacbf20c) seeds entries with

	ip neigh replace ... nud failed extern_learn

and adds the failed combinations covering every row of the new table,
including the in-prefix and out-of-prefix mode 2 cases. Mentioning it here
only for completeness.

>  
>  	if (neigh && !IS_ERR(neigh)) {
> +		u32 update_flags;
>  		u8 old_flags = neigh->flags;
>  
> -		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
> +		if (neigh_untracked && !accept_untracked)
>  			goto out;
>  
>  		/*
> @@ -1108,19 +1134,23 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)

[ ... ]

>  		if ((old_flags & ~neigh->flags) & NTF_ROUTER) {
>  			/*
>  			 * Change: router to host
>  			 */
> -			rt6_clean_tohost(dev_net(dev),  saddr);
> +			rt6_clean_tohost(net,
> +					 neigh_failed ? &msg->target : saddr);
>  		}

[Severity: Medium]
Why does the gateway address handed to rt6_clean_tohost() now depend on the
previous NUD state of the entry? Before this patch the same "router to
host" event always flushed routes keyed by saddr.

fib6_clean_tohost() in net/ipv6/route.c matches the argument against the
gateway of RA-installed routes and against cached exceptions:

	if (((rt->fib6_flags & RTF_RA_ROUTER) == RTF_RA_ROUTER) &&
	    nh->fib_nh_gw_family && ipv6_addr_equal(gateway, &nh->fib_nh_gw6))
		return -1;

so it expects the address of the node that stopped being a router, which is
unrelated to whether the cache entry happened to be in NUD_FAILED.

When saddr differs from msg->target, and that is allowed since RFC 4861 4.4
only requires the NA source to be an address of the sending interface (a
router advertising a global target from its link-local source, or the proxy
NA case handled a few lines above via pneigh_lookup()), the FAILED recovery
path flushes routes keyed by msg->target while every other path flushes
routes keyed by saddr. Can both be right for the identical event?

If saddr was the wrong key all along, would it make sense to fix that
separately for all cases, with a Fixes: tag, rather than changing it only
for the FAILED path? The changelog describes only the FAILED to STALE
transition and does not mention this change of key.

>  		reason = SKB_CONSUMED;
>  out:

Thanks for looking at these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789448374.git.lfqlee314%40gmail.com
