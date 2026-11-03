Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734717;
	b=yVtFMXyfkbeSibFoYtNljs1BzBiiS42SU2PApfW5CcDUiZw5NuLr9tJZhO8vlCVh0sOj
	 Uw8INLiXm0cv1urj0nBLC1n4q3dK2hP/LZgw21r1c/LRAXjfFJEQaq4Rq462RUFjawlxg
	 H9g8CNMe2Ygg1DJy8XBwQ3H8wT4S2n+OGRQYEAoSlKADjXUL32gBr6UAE7GfSNjGREFix
	 1Q5elWeSjTlZ4mSXZMgl6Lrv5uNjcS/gOiP8kmHUkgMyopFgty4jDwjPO9k6cAx2ZDU8S
	 kE/po/dDhfCCc/0AhAIZ/FQQ/YcH0Yw0C0e3jRbvMiKwRoFpm8SbGaD1P2B6xQYUM4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734717;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gjbIoKggA3ZB4AoecBWT6FbzxdHr7kpCEu66Kpd7ryc=;
	b=CsxQX3kEfHhE3mVWoxf0d8sl8Skfv9dQN3LakENySfBrZlPRSGdYH98sPbNszsOg8nDV
	 +CjKz84+viGSNZ+6uYMD9nNbSn5oiGWMv0IkMJ7BvxHObNq8TMjZsjMwkDQpKBLprER1W
	 xlf0y+KLtIdd2WqUfqikNDrYaI+x8vqjPlPJVqJk2GRbv6vj6sFLh2zpxrNW1AM4pgioY
	 KXmIHt3nNFOjfL/FfkkSz+bscOUIZnj8bqp2+f+ea63RykB/u8bixwo74SSF6IvTWsWei
	 TBeaSOUljPobY1nKRY6mIUMKFSqaxP8OJZejtoxRAWegsybtkmZfNVxxyXHI/Quspkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9Pa4ssf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3297606A324;
	Tue,  3 Nov 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9Pa4ssf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1951F000C1;
	Tue,  3 Nov 2026 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734716;
	bh=gjbIoKggA3ZB4AoecBWT6FbzxdHr7kpCEu66Kpd7ryc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J9Pa4ssffdth4yMj2y8l9OYDobyqKq7UDkJVQNhlBmmneHHTuEGA7Dql4t9zawMN2
	 ZOsz226ckgvlfCq0/Z+IIMQHWOmuAEREm9tkWhwceL1CxgEePRvI7dh50rTgqtq2JP
	 lAU87zp1Nx/7Aq9CoNFwYbZkFqp9a5bF2yDEKMAxfDPsgFdrRyjah6euWIN1Liz1PL
	 V78vkkpxsaB33WUmXAv/HcNTvsU4WYR2PhQUvW9xbb2oU8B1a/Z8YqB1emQbIXSKci
	 AU4EBhDh6Glx3VagNeXNABaPcWa2PrJQKexTH/5TvxgeHek1DQmjrNGKpawTEOMdXt
	 BZhASPo+c/bXg==
Subject: Re: [PATCH net] ieee802154: reject ARPHRD_IEEE802154 devices without
 ieee802154_ptr
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 19:38:35 +0000
Message-ID: <179373471506.488856.5288914841220832792@kernel.org>
In-Reply-To: <179338834213.72059.10411262981778676981@gmail.com>
References: <179338834213.72059.10411262981778676981@gmail.com>
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

- [High] The fix misses one place.
- [Medium] The patch rejects a non-WPAN device after a first-match lookup
  has returned it, instead of skipping it during the lookup.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ieee802154_dump_iface() and ieee802154_llsec_dump_table()…

--

ieee802154: reject ARPHRD_IEEE802154 devices without ieee802154_ptr

This patch adds !dev->ieee802154_ptr checks to the legacy 802.15.4 netlink
code and to the AF_IEEE802154 socket code, wherever a device is picked by
dev->type == ARPHRD_IEEE802154. It fixes NULL pointer dereferences caused
by TUN devices that TUNSETLINK switched to ARPHRD_IEEE802154 and that
have no wpan_dev.

Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90

> diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
> index 74ef0a310afbb..5bf6725eb55dd 100644
> --- a/net/ieee802154/nl-mac.c
> +++ b/net/ieee802154/nl-mac.c

[ ... ]

> @@ -437,7 +437,8 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  	idx = 0;
>  	for_each_netdev(net, dev) {
> -		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
> +		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
> +		    !dev->ieee802154_ptr)
>  			goto cont;
>  
>  		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,

[Severity: High]
This is a pre-existing issue and not something this patch introduced, but
is this for_each_netdev() walk safe if a device is unregistered at the
same time?

ieee802154_dump_iface() and ieee802154_llsec_dump_table() walk
net->dev_base_head without RTNL or rcu_read_lock(). They also take no
dev_hold() on the current device. The legacy family has no parallel_ops,
so genl_dumpit() only holds genl_mutex around the callback:

net/netlink/genetlink.c:genl_dumpit() {
    ...
	genl_op_lock(info->family);
	rc = ops->dumpit(skb, cb);
	genl_op_unlock(info->family);
    ...
}

The loop body also sleeps while holding the raw dev pointer.
ieee802154_nl_fill_iface() does:

	rtnl_lock();
	short_addr = dev->ieee802154_ptr->short_addr;
	pan_id = dev->ieee802154_ptr->pan_id;
	rtnl_unlock();

ieee802154_llsec_dump_table() calls llsec->lock_table(dev), which takes a
mutex.

At the same time, ieee802154_unregister_hw() can take RTNL without
genl_mutex. It runs on driver unbind, module unload and atusb unplug:

	rtnl_lock();

	ieee802154_remove_interfaces(local);

	rtnl_unlock();

This can unregister the device being dumped and then free it with
free_netdev().

When the dump thread resumes, does it use freed memory? It reads
dev->name, calls ops->get_mac_params(dev) on the freed sdata, and follows
dev->dev_list.next to the next entry.

IEEE802154_LIST_IFACE needs no privileges. The new !dev->ieee802154_ptr
checks read the same unprotected pointer inside these loops.

[ ... ]

> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index be8ca1f053a2b..f87c9ccbc8488 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c

[ ... ]

> @@ -74,6 +75,14 @@ ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
>  		break;
>  	}
>  
> +	/* A TUN device can have its type set to ARPHRD_IEEE802154 without
> +	 * being a WPAN device.
> +	 */
> +	if (dev && !dev->ieee802154_ptr) {
> +		dev_put(dev);
> +		dev = NULL;
> +	}
> +
>  	return dev;
>  }
>  
> @@ -641,6 +650,11 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	else
>  		dev = ieee802154_get_dev(sock_net(sk), &ro->src_addr);
>  
> +	if (dev && !dev->ieee802154_ptr) {
> +		dev_put(dev);
> +		dev = NULL;
> +	}
> +
>  	if (!dev) {
>  		pr_debug("no dev\n");
>  		err = -ENXIO;

[Severity: Medium]
These checks reject the device only after a first-match lookup has
returned it. Can that hide a real WPAN device that comes later in the
list?

For an unbound socket, dev_getfirstbyhwtype() stops at the first
ARPHRD_IEEE802154 device:

net/core/dev.c:dev_getfirstbyhwtype() {
    ...
	for_each_netdev_rcu(net, dev)
		if (dev->type == type) {
			dev_hold(dev);
			ret = dev;
			break;
		}
    ...
}

A TUN device set to ARPHRD_IEEE802154 can sit ahead of the real WPAN
interface in dev_base_head. For example, the WPAN interface or a hwsim
radio may be created after the TUN device. Would every unbound
AF_IEEE802154 datagram send in init_net then fail with -ENXIO?

The IEEE802154_ADDR_LONG branch of ieee802154_get_dev() has the same
pattern. dev_getbyhwaddr_rcu() returns the first type/hwaddr match. The
new post-filter in ieee802154_get_dev() turns an earlier non-WPAN match
into NULL. That match could be a bond that copied its slave's address, or
a TAP device switched with TUNSETLINK whose MAC was then set. In that case
bind() returns -ENODEV even though a real WPAN device has the address.

The short address branch already skips non-WPAN devices inside its loop.
Could the other two lookups work the same way?

The test note says unbound sendto() "keeps working (it picks a hwsim
interface)". That only holds when the hwsim devices come first in the
list.

[ ... ]

> @@ -1097,7 +1111,7 @@ static int ieee802154_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>  	ieee802154_raw_deliver(dev, skb);
>  
> -	if (dev->type != ARPHRD_IEEE802154)
> +	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr)
>  		goto drop;
>  
>  	if (skb->pkt_type != PACKET_OTHERHOST)

[Severity: High]
Does lowpan_rcv() in net/ieee802154/6lowpan/rx.c need the same check? It
handles the same ethertype, and it still checks only the type before it
dereferences ieee802154_ptr:

net/ieee802154/6lowpan/rx.c:lowpan_rcv() {
    ...
	if (wdev->type != ARPHRD_IEEE802154 ||
	    skb->pkt_type == PACKET_OTHERHOST ||
	    !lowpan_rx_h_check(skb))
		goto drop;

	ldev = wdev->ieee802154_ptr->lowpan_dev;
    ...
}

lowpan_packet_type is a global ETH_P_IEEE802154 handler with no device or
netns filter. lowpan_open() registers it through lowpan_rx_init() as soon
as any lowpan interface is up. lowpan_rx_h_check() only looks at frame
bytes that the sender controls.

There seem to be two ways to reach this.

The first is a bond whose first slave is a mac802154 interface.
bond_setup_by_slave() copies slave_dev->type into the bond, and
bond_enslave() rejects only ARPHRD_CAN slaves. Received frames can then
reach lowpan_rcv(skb, bond_dev) with ieee802154_ptr == NULL.

The second is a TUN device switched to ARPHRD_IEEE802154 with TUNSETLINK,
plus a tc mirred egress-to-ingress redirect. __dev_queue_xmit() sets the
mac header, mirred leaves pkt_type unchanged, and a frame starting with FC
0x41 0x88 passes lowpan_rx_h_check(). lowpan_rcv() has no init_net check,
so this also works from a netns owned by an unprivileged user namespace.
Writing to the TUN fd directly does not work: the mac header stays unset,
so ieee802154_get_fc_from_skb() hits its WARN_ON and the frame is dropped.

lowpan_newlink() and lowpan_device_event() in the same module already
check ieee802154_ptr after checking the type. The commit message says
such devices are rejected "wherever a device is picked by its type".
Should lowpan_rcv() also get || !wdev->ieee802154_ptr to complete the fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179338834213.72059.10411262981778676981%40gmail.com
