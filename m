Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB33D75A1
	for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710775; cv=none; b=BTTzoBFMmmBy5dHBITlCqamWnHUJvOJgvpYz14a1spxZz3T1Tq5Dg+b6P8/uV2enwRGIwNuGyFpHMRQBJ2QH177KXEvUT7x7uwnyuW3kuDfuKtWQGgXfTpWLFgLYr2QzXQz+vWO081RJ+puokwzc0CElSu2l6fec0gGRCMpITsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710775; c=relaxed/simple;
	bh=V99jLj2gEYsH462fTqhUwsqP0GqMQkk41b67V5dynz0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JCL5NiezHYDu6hSKPbSqEaY+hRQfKm+lYEhTdEBAMCeqMdib1/IdKXMNZwbb1ntJoZw8FwJK97WAOeiofHajtMTC6GpxB2SCdnm/yuoNofkR7rpcJ9CbYfaP6IomU1DC7HdqsP2RapBm2uLD25CbBTlM8D7dphVD8vNa1Po+r58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH1/Yndx; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH1/Yndx"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so185250a12.0
        for <linux-wpan@vger.kernel.org>; Thu, 17 Sep 2026 22:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789710773; x=1790315573; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RoqQBX0V764x0A/v/amZwGuN9suY1fEbdmSCiYW1k5w=;
        b=LH1/YndxdKdTqJTRoOSlt0kiCmgEVtwTVWQ2dNzfDSEY9XCp7y4XkQQsRQsO5sGLdv
         u4MsRZUs9PrK9+cdV4t88JtvJCAHyKi7lNtx55zWSiC5jvb5+vGABqO1ZZumgYbJtFfJ
         hY4c6wdKEssCOyGYKh06SJaa/wuFCT8ZXM07tBmeEZ8bfCdXgVdRoxZk4hnY9hIbiwDQ
         KzveBiurcVwDtjShw5SNupSOCA/2HmuyCAD/Gc8sxGi23g7IZ1kBi4MTd8At3tM73xaK
         AAeJV9jgE6XlxjBVIofS387c2mof0UM1QiHLKWeCk3NUhc00RRKMxAcZyHpxohn3BaN7
         XU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789710773; x=1790315573;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoqQBX0V764x0A/v/amZwGuN9suY1fEbdmSCiYW1k5w=;
        b=LtsmPY7vQPyc11bBVsXQIuZHkwkkFHYMutNBbcE3slKwqzw381/JXo9c86pMuu9FWR
         G/2rseIrqaZIzUG2im/AvUFeDjBHx2QgRQc9kNRpBV0JH9ywmt5RIHKtkITHGogMddJ9
         doJk3e94CDSJMknFrIf1RgT/TtLCJhiRgIUgvM5pJ0cgEwQDUNyiJrY+JSlimPorTH0R
         Phe5lhtqMSgzxJsEbakflQeN0rd1s6ooqPgJFiR0hTZnTVWQDC+LKd/M49hKhM2EIClC
         OR6nGxi8H9bMJvh/gAagq+RykpKFXYAGWRtakfbCzXRu1Ovms87Aje2+Ow/XeBepiFVH
         LoUg==
X-Forwarded-Encrypted: i=1; AKwUvBxCrGB31qmNEFhumP20OcP83UGlJS+d1A76rNMGlRlNiSB7JVotuVkGaVWguvdRQnBwOI3hWeKUbwzz@vger.kernel.org
X-Gm-Message-State: AFuF++nZinpLsj1EPKhgSsio9jUjbUqgd/mdTF13BpwB6ugP95C4hAEy
	yS8Ar0SmbB4Hw9DEGY10oGAC6gBDPp9SmObiui/R1t7P6YbLyXikYBNp
X-Gm-Gg: AYBFou1mNpcD9m1I57bGyZQg5RoV7oB5zolr9GOQ9oXAYMMbN7crCwDD8p5wGIFaUS8
	Xw4BpwOb5q+N/1DcSGqx+3lyNtgvDrmVucBISEokXxznwspvqS41iXC6x/Buj6heesfzGoeXHtf
	HVxe7SJgdCdAVlDHoiMJR5gv752OBk+qXDOkQf1omlnhBkXD3jrtZAoWZYpYu01eAlnXLe+Fwlj
	LaLNEctXZgZbtNeOEj0tNEhExJh5uLuY1eg2KxYM4UIjN96q84muw7FsgcD9HFHNzMPeKZpRft3
	GqyzbYvFH7l21OUhPaA2SCdEmMMdwz/zWq7O4+MU9MYAcTpVjVpXKLUkJ62eUXLo6LvhgjsUsU5
	lAitf9nXMwOMpyLetzns7PD5BqZx5WlNVc8JHqGHjyd7v9vWM6nkRAZl5tC+YXjJv0CMiZZbnn2
	NJ1qH7TM859IiMoEfSW5j/T6DoWRa+LaXXogVNq8ajA8fdpETgE/SlM2acgJHalHHbFn6Qbp/CW
	qRcjMuvGuS9kWCLJrzFyWybVg==
X-Received: by 2002:a05:6a21:9e0f:b0:3dd:85a8:caca with SMTP id adf61e73a8af0-3dd8c47d1c6mr2792351637.33.1789710773192;
        Thu, 17 Sep 2026 22:52:53 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c28721895sm1518873eec.13.2026.09.17.22.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 22:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 05:52:50 +0000
Message-Id: <DLI7IPF4DIYX.3BAFFWR52DHUY@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: test untracked NA
 recovery of FAILED neighbors
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
Cc: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
 <aajith@arista.com>, <roopa@nvidia.com>, <jhpark1013@gmail.com>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alex.aring@gmail.com>,
 <linux-wpan@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <3f33052571409614b953a3dc7778114c51c43669.1789448374.git.lfqlee314@gmail.com> <178966456270.22033.8952247046783062389@kernel.org>
In-Reply-To: <178966456270.22033.8952247046783062389@kernel.org>

> [Severity: Low]
> Should verify_ndisc() also check the link-layer address that the
> advertisement carried?
>
> The seed in test_unsolicited_na_common() deliberately creates the entry
> without one:
>
> 	${IP_ROUTER} neigh replace "${HOST_ADDR}" dev "${ROUTER_INTF}" \
> 		nud failed extern_learn
>
> while the recovery path in net/ipv6/ndisc.c:ndisc_recv_na() pulls the tar=
get
> link-layer address out of the options and passes it down:
>
> 	lladdr =3D ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
> 	...
> 	__ndisc_update(dev, neigh, lladdr,
> 		       new_state, update_flags, neigh_failed,
> 		       NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);
>
> Since the only assertions here are the state substring and extern_learn,
> would a change that moves FAILED -> STALE but installs no lladdr, or an
> incorrect one, still report OK?  Comparing the resulting lladdr against t=
he
> host veth MAC would close that gap.
>
I will update the tests to verify the lladdr


> [Severity: Low]
> Can this switch actually isolate the mode 2 in-prefix gate?
>
> Moving HOST_ADDR from 2000:20::2 to 2000:21::2 changes the source address=
 of
> the advertisement, its target address, and the key of the seeded neighbou=
r
> entry all at once, while the router keeps 2000:20::1/64.
>
> The advertisement under test comes from addrconf_dad_completed(), and
> ndisc_send_na() uses the same address for both fields when it is local:
>
> net/ipv6/ndisc.c:ndisc_send_na() {
> 	ifp =3D ipv6_get_ifaddr(dev_net(dev), solicited_addr, dev, 1);
> 	if (ifp) {
> 		src_addr =3D solicited_addr;
> 	...
> 		.target =3D *solicited_addr,
> }
>
> so saddr =3D=3D target for every packet this test generates.  The kernel =
gate is
> source based:
>
> net/ipv6/ndisc.c:accept_untracked_na() {
> 	case 2:
> 		return !!ipv6_chk_prefix(saddr, idev->dev);
> }
>
> and Documentation/networking/ip-sysctl.rst describes mode 2 in terms of "=
the
> source IP address".  Would a change that tested msg->target instead of sa=
ddr
> leave both new mode 2 rows green?  Keeping HOST_ADDR fixed and instead
> varying the prefix configured on the router side would exercise the gate
> without also moving the target and the entry key.
>
Will update the tests to cover one source address outside the prefix and=20
one inside.

> [Severity: Medium]
> The comment says "add a delay to ensure neighbour processing is done", bu=
t
> link_up, start_tcpdump and verify_ndisc run back to back with no sleep an=
d no
> retry.  Where is the delay?
>
> start_tcpdump() blocks on:
>
> 	${IP_ROUTER_EXEC} timeout 15s \
> 		tcpdump --immediate-mode -tpni ${ROUTER_INTF} -c 1 \
> 		"icmp6 && icmp6[0] =3D=3D 136 && src ${HOST_ADDR}"
>
> but the AF_PACKET tap that satisfies -c 1 is fed from ptype_all delivery =
in
> __netif_receive_skb_core(), which runs ahead of the state change the test
> looks at:
>
> ipv6_rcv() -> icmpv6_rcv() -> ndisc_recv_na() -> __ndisc_update() ->
> neigh_update()
>
> Does tcpdump exiting really order against that update, given verify_ndisc=
()
> takes a single un-retried snapshot of ip neigh show?
>
> There is a second effect for the new rows.  In the four expect-FAILED=20
> cases:
>
> 	test_unsolicited_na_combination 0 0 1 failed
> 	test_unsolicited_na_combination 0 1 0 failed
> 	test_unsolicited_na_combination 1 1 1 failed
> 	test_unsolicited_na_combination 0 2 1 failed 0
>
> the expected value FAILED is exactly the state the entry was seeded with,=
 so
> "still FAILED" and "the advertisement was never processed" look identical=
.
> Would a bounded poll for the expected state, or an explicit settle, make
> these rows able to distinguish the two?
>
> Related question on ordering of the capture: tcpdump is started after
> link_up, so can the single unsolicited advertisement emitted at DAD
> completion be missed if the fork and exec are slow?  In that case timeout
> exits 124 while set -e is in effect inside start_tcpdump, which aborts th=
e
> whole script rather than failing one row.  Would arming the capture befor=
e
> link_up avoid that?
>
Will change the tests to start the capture prior to bringing up the host=20
side

