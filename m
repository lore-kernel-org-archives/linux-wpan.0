Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B5383CE;
	Thu, 17 Sep 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664566; cv=none; b=QmFcs1ELqht6AWMV2ZRXyFDCqXSl6oStN5189vJdmu/sBypLa37aZfk0BxhsjQbEMR3uXSyrGHrA2tBgFmiOFka6jMqqp9EisKS+g/CJU1smkheZLmElOznAyOkzl9sqN2WwQhRDJuadfWZ7rYVs4nDFK3DX5aU+qBa9Jhn/ApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664566; c=relaxed/simple;
	bh=Q2FCzzqX3BpbpN3yzX73NxL81MIs+UH8FlTwH6dFWqM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vc7/bNIKg/TTw8CYwkdzcW8NMf0Iy84iFb68tpOgSmPJQZHRbDU2VHNVY1NZK1Ip+0LL1qvQ7fU6u1DefDeLWBKuen2dfFM6/aAo4sRFCH0wWQ+cgHGltNKNTvWnkPbGKQAIfDoZJ5mOQcu0SkK0IQJJQAmHLbIiu0xSWg6yCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZUNLTiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZUNLTiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331E1F000FF;
	Thu, 17 Sep 2026 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664564;
	bh=sTcKsJpMS3E8tOO3CWvFNL24eVk4OaBicDP6GSIgVCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BZUNLTiJkWghq7bfMpHC1U7mbfGcUz05jpRBZThgB5yG9crc8nTlpyN6qf6J7vt1U
	 bPZx2ai1mmKAmwQsDlMHStuLWm53cZBZM4b0abWPUXdLMZiOTjsCRnxmZwkUFNQ8kJ
	 xuVr/ahbo9VpJu6tJiltLkOyUb81iuc+rfsvEF72S7e8Ie7C8nsVO6BURjrO54Vhc+
	 a29K49xMgyiO1owCV0nmrVlovBMI3Nge1SfoKA1+LsTsi/05/nDKR4XcjTJIIa7O5I
	 tpZqPyJ2uHvmw/Xhob1LZ3uE9GszW6sM5Ixe9rEUs6rCOs6wpWSDfK7HjS8EXN7E2W
	 qwE7CFsoU5dmQ==
Subject: Re: [PATCH net-next v2 2/2] selftests: net: test untracked NA
 recovery of FAILED neighbors
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
Date: Thu, 17 Sep 2026 17:02:42 +0000
Message-ID: <178966456270.22033.8952247046783062389@kernel.org>
In-Reply-To:
 <3f33052571409614b953a3dc7778114c51c43669.1789448374.git.lfqlee314@gmail.com>
References:
 <3f33052571409614b953a3dc7778114c51c43669.1789448374.git.lfqlee314@gmail.com>
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

- [Medium] The new FAILED-seed cases assert an in-place neighbour state
  transition but the script has no synchronization guaranteeing that the…
- [Low] The two new `accept_untracked_na=2` cases
  (`test_unsolicited_na_combination 0 2 1 failed 1` at line 275 and `...…
- [Low] The new FAILED-neighbor recovery cases verify only the resulting
  NUD state and the `extern_learn` marker, not that the link-layer…

--

selftests: net: test untracked NA recovery of FAILED neighbors

This extends ndisc_unsolicited_na_test.sh with a seeded NUD_FAILED
neighbour entry and six new matrix rows covering accept_untracked_na modes
1 and 2 plus the drop_unsolicited_na and forwarding gates. The seed is
marked extern_learn and ndisc_evict_nocarrier is disabled so the entry
survives until the advertisement arrives.

Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com

A few questions below about the synchronization and the coverage of the new
rows.

> diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
> index 5db69dad0cfc0..5f4f29f0ac4ab 100755
> --- a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
> +++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh

[ ... ]

> @@ -20,7 +26,9 @@ HOST_INTF="veth-host"
>  ROUTER_INTF="veth-router"
>  
>  ROUTER_ADDR="2000:20::1"
> -HOST_ADDR="2000:20::2"
> +HOST_ADDR_IN_NETWORK="2000:20::2"
> +HOST_ADDR_OUT_OF_NETWORK="2000:21::2"
> +HOST_ADDR="${HOST_ADDR_IN_NETWORK}"
>  SUBNET_WIDTH=64
>  ROUTER_ADDR_WITH_MASK="${ROUTER_ADDR}/${SUBNET_WIDTH}"
>  HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"

[ ... ]

> @@ -140,24 +150,77 @@ verify_ndisc() {

[ ... ]

> +	if [ -n "${expected_state}" ]; then
> +		neigh_show_output=$(${IP_ROUTER} neigh show \
> +			to "${HOST_ADDR}" dev "${ROUTER_INTF}")
> +		if [[ " ${neigh_show_output} " != \
> +				*" ${expected_state} "* ]]; then
> +			return 1
> +		fi
> +		if [ "${initial_state}" = "failed" ]; then
> +			[[ "${neigh_show_output}" == *"extern_learn"* ]]
> +		fi

[Severity: Low]
Should verify_ndisc() also check the link-layer address that the
advertisement carried?

The seed in test_unsolicited_na_common() deliberately creates the entry
without one:

	${IP_ROUTER} neigh replace "${HOST_ADDR}" dev "${ROUTER_INTF}" \
		nud failed extern_learn

while the recovery path in net/ipv6/ndisc.c:ndisc_recv_na() pulls the target
link-layer address out of the options and passes it down:

	lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
	...
	__ndisc_update(dev, neigh, lladdr,
		       new_state, update_flags, neigh_failed,
		       NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);

Since the only assertions here are the state substring and extern_learn,
would a change that moves FAILED -> STALE but installs no lladdr, or an
incorrect one, still report OK?  Comparing the resulting lladdr against the
host veth MAC would close that gap.

>  	else
> -		# Neighbour entry expected to be absent for all other cases
> +		neigh_show_output=$(${IP_ROUTER} neigh show \
> +			to "${HOST_ADDR}" dev "${ROUTER_INTF}")
>  		[[ -z ${neigh_show_output} ]]
>  	fi
>  }
>  
>  test_unsolicited_na_common()
>  {
> +	local same_subnet=${5:-1}
> +	local neigh_show_output
> +
> +	if [ "${same_subnet}" -eq 1 ]; then
> +		HOST_ADDR="${HOST_ADDR_IN_NETWORK}"
> +	else
> +		HOST_ADDR="${HOST_ADDR_OUT_OF_NETWORK}"
> +	fi
> +	HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"

[Severity: Low]
Can this switch actually isolate the mode 2 in-prefix gate?

Moving HOST_ADDR from 2000:20::2 to 2000:21::2 changes the source address of
the advertisement, its target address, and the key of the seeded neighbour
entry all at once, while the router keeps 2000:20::1/64.

The advertisement under test comes from addrconf_dad_completed(), and
ndisc_send_na() uses the same address for both fields when it is local:

net/ipv6/ndisc.c:ndisc_send_na() {
	ifp = ipv6_get_ifaddr(dev_net(dev), solicited_addr, dev, 1);
	if (ifp) {
		src_addr = solicited_addr;
	...
		.target = *solicited_addr,
}

so saddr == target for every packet this test generates.  The kernel gate is
source based:

net/ipv6/ndisc.c:accept_untracked_na() {
	case 2:
		return !!ipv6_chk_prefix(saddr, idev->dev);
}

and Documentation/networking/ip-sysctl.rst describes mode 2 in terms of "the
source IP address".  Would a change that tested msg->target instead of saddr
leave both new mode 2 rows green?  Keeping HOST_ADDR fixed and instead
varying the prefix configured on the router side would exercise the gate
without also moving the target and the entry key.

>  
>  	# Setup the test bed, but keep links down
> -	setup $1 $2 $3
> +	setup "$1" "$2" "$3"
> +
> +	if [ "${4:-absent}" = "failed" ]; then
> +		if ! ${IP_ROUTER} neigh replace "${HOST_ADDR}" \
> +				dev "${ROUTER_INTF}" \
> +				nud failed extern_learn; then
> +			echo "Unable to create NUD_FAILED neighbor entry"
> +			return 1
> +		fi

[ ... ]

> @@ -165,22 +228,35 @@ test_unsolicited_na_common()
>  	# Bring the link up, wait for the NA,
>  	# and add a delay to ensure neighbour processing is done.
>  	link_up
>  	start_tcpdump
>  
>  	# Verify the neighbour table
> -	verify_ndisc $1 $2 $3
> +	verify_ndisc "$1" "$2" "$3" "$4" "${same_subnet}"

[Severity: Medium]
The comment says "add a delay to ensure neighbour processing is done", but
link_up, start_tcpdump and verify_ndisc run back to back with no sleep and no
retry.  Where is the delay?

start_tcpdump() blocks on:

	${IP_ROUTER_EXEC} timeout 15s \
		tcpdump --immediate-mode -tpni ${ROUTER_INTF} -c 1 \
		"icmp6 && icmp6[0] == 136 && src ${HOST_ADDR}"

but the AF_PACKET tap that satisfies -c 1 is fed from ptype_all delivery in
__netif_receive_skb_core(), which runs ahead of the state change the test
looks at:

ipv6_rcv() -> icmpv6_rcv() -> ndisc_recv_na() -> __ndisc_update() ->
neigh_update()

Does tcpdump exiting really order against that update, given verify_ndisc()
takes a single un-retried snapshot of ip neigh show?

There is a second effect for the new rows.  In the four expect-FAILED cases:

	test_unsolicited_na_combination 0 0 1 failed
	test_unsolicited_na_combination 0 1 0 failed
	test_unsolicited_na_combination 1 1 1 failed
	test_unsolicited_na_combination 0 2 1 failed 0

the expected value FAILED is exactly the state the entry was seeded with, so
"still FAILED" and "the advertisement was never processed" look identical.
Would a bounded poll for the expected state, or an explicit settle, make
these rows able to distinguish the two?

Related question on ordering of the capture: tcpdump is started after
link_up, so can the single unsolicited advertisement emitted at DAD
completion be missed if the fork and exec are slow?  In that case timeout
exits 124 while set -e is in effect inside start_tcpdump, which aborts the
whole script rather than failing one row.  Would arming the capture before
link_up avoid that?

>  
>  }

[ ... ]

> @@ -193,6 +269,16 @@ test_unsolicited_na_combinations() {
>  	test_unsolicited_na_combination 1 0 1
>  	test_unsolicited_na_combination 1 1 0
>  	test_unsolicited_na_combination 1 1 1
> +
> +	# Expect FAILED entry to become STALE
> +	test_unsolicited_na_combination 0 1 1 failed
> +	test_unsolicited_na_combination 0 2 1 failed 1
> +
> +	# Expect FAILED entry to remain FAILED
> +	test_unsolicited_na_combination 0 0 1 failed
> +	test_unsolicited_na_combination 0 1 0 failed
> +	test_unsolicited_na_combination 1 1 1 failed
> +	test_unsolicited_na_combination 0 2 1 failed 0
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789448374.git.lfqlee314%40gmail.com
