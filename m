Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619336;
	b=hXGnubMudy2MyxctW5ccNPDhwjpvI9lD1/PQLCadgsa5LbLy66DPdVJCPfTLyVSH6vFz
	 PIwh2AtqrNlo4utFB9isYpCW9C5zqX/atxE2ozQFlqxRQNR37pfOUVSH5nZ0oEFbiiz4m
	 yqTAim9fTPc1NtuizJ+bpZ6A8ejxnxQGLEm3PFH6CHEMUnwJfLILzcHYSSb8XiZHu/+YO
	 xkDqHYseF8RlCgazeoTpSSZKoDOk0xpQYygIN/XEp8G7xFT56AeQidsRnAnr6YTDFDhoZ
	 R8ISVnTvOPnOCxkMPfseXBVR+RMC4TsbAxrQQFMWj+jFrnDh2VVOAbYszMQe3UsajZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619336;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ylUBh491hf4LFInZUCVQvpnRSa5T9z/gjbnH1xTjgQ8=;
	b=TBwn7+ZA92neXbOqAAskCol9jvKjfhSlrLNJvL9cwl9AcwCEDblNO0ri/WgOb7l9Fwi0
	 NnmhAA2PaVO3TSZfPk4Fg+KGCKIXa5QZz/qO0xAYHywODG+uyQrls86inTpKGU3AkOJxf
	 2A1l7WSfCz1qazmQ/6r4ptjfe9PZCP3I1VinAhb+9HY4v1jKVUNB+ngW4eO7hE0DpiYia
	 4HCQDii8yzf1QUEum0PSsoeAlfmwTKdA4oJMwJe/hyZk+Hsh/IeyObfIh3Dut3Ji91yak
	 CrlUrWKEYHuGjJjQGnIOm2BgI+tS2Op+XMDZQnP6OrmpkGPF+Sh5Fb4HRDpqtLJshwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AVhsMJl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9838606A337;
	Wed, 25 Nov 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVhsMJl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373141F000CA;
	Wed, 25 Nov 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619336;
	bh=ylUBh491hf4LFInZUCVQvpnRSa5T9z/gjbnH1xTjgQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AVhsMJl/10WhWu3CinPAwSY2CdIyzYMJ1MYVhnoMSMRo9UtTWejf9x0eZbtNd04mY
	 KEv8811SFtU1D1V9GpP42EdouN7nnSubHDLnAE4UNplwAORBmvj8ljW9TTtMdSzSVI
	 /h8e4Vz3QcTECo1eMEq3ljyHhFEzGZ2u5UOLOQlhdSKugz4puYBx32ySoUk5DeSI0H
	 uQYrxRKj1f3iqTm/+tfwVxfyLRrxvifumFI6w7CKS3Sx0LnLShK9et4LkrGmc0gX1v
	 vjcva2ME7YMNrp0uO3bC/15u4285ga8opyaVxkLtWFH2ET+bDOrh0H2bpU930EMM2q
	 7MGvccumum6oQ==
Subject: Re: [PATCH net] mac802154: take RTNL around ASSOC RESP transmission
From: netdev-bot+sashiko@kernel.org
To: leegun25@proton.me
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Date: Wed, 25 Nov 2026 15:08:55 +0000
Message-ID: <179561933580.3135.16839129837492499512@kernel.org>
In-Reply-To: <20261121150835.256812-1-leegun25@proton.me>
References: <20261121150835.256812-1-leegun25@proton.me>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new rtnl_lock() in mac802154_process_association_req()
  (net/mac802154/scan.c:833) makes the rx_mac_cmd worker wait on the…
- [High] A remote ASSOC REQ can still reach
  WARN_ON_ONCE(!netif_running(sdata->dev)) in…
- [High] mac802154: RTNL self-deadlock on same-host association in
  mac802154_process_association_req()

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  mac802154_process_association_req() (net/mac802154/scan.c:891-899) the…
- [Low] This problem wasn't introduced by this patch, but
  mac802154_process_association_req() checks wpan_dev->pan_id,…

--

mac802154: take RTNL around ASSOC RESP transmission

This commit makes mac802154_process_association_req() take the RTNL
before association_lock. The goal is to stop the ASSOC RESP sent from the
rx_mac_cmd worker through ieee802154_mlme_tx_locked() from tripping
ASSERT_RTNL(). The RTNL is released after association_lock on every exit.

> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index d393b1f4e74e4..49bc5d29b4ee0 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -826,6 +826,11 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
>  		return -ENODEV;
>  	}
>  
> +	/* mac802154_send_association_resp_locked() uses the MLME TX helpers,
> +	 * which require the RTNL.  Take it before association_lock to keep the
> +	 * same lock order as the netlink paths (RTNL then association_lock).
> +	 */
> +	rtnl_lock();
>  	mutex_lock(&wpan_dev->association_lock);

[Severity: High]
Does this turn every same-host association into a 10 second stall
of the global RTNL?

NL802154_CMD_ASSOCIATE is registered with NL802154_FLAG_NEED_RTNL, so
nl802154_pre_doit() takes rtnl_lock() and holds it until
nl802154_post_doit(). In between, the call chain is:

nl802154_associate()
  rdev_associate()
    mac802154_associate()
      mac802154_perform_association()
        ieee802154_mlme_tx_one_locked()    /* sends ASSOC REQ */
        wait_for_completion_killable_timeout(&local->assoc_done,
                                             10 * HZ);

The coordinator may be another interface on the same kernel, such as
a second mac802154_hwsim radio or a second local transceiver. In that
case its rx_mac_cmd worker now enters
mac802154_process_association_req() and blocks in rtnl_lock().
rtnl_mutex is global, so putting the two interfaces in different
network namespaces does not help. The ASSOC RESP cannot be sent until
the associating thread gives up:

1. The node thread holds the RTNL and sleeps on assoc_done.
2. The coordinator worker sleeps in rtnl_lock() for the full
   10 * HZ.
3. mac802154_perform_association() returns -ETIMEDOUT and clears
   IEEE802154_IS_ASSOCIATING. nl802154_post_doit() then drops the
   RTNL.
4. The worker gets the RTNL, sends the late ASSOC RESP and adds the
   node to wpan_dev->children. The node has already reported failure
   and will drop the response.

So the association fails every time. For those 10 seconds every other
RTNL user on the system waits behind it, including link and address
changes and other rtnetlink requests. Before this patch the same
setup worked. ASSERT_RTNL() in ieee802154_mlme_tx_locked() only
checks rtnl_is_locked(), and the node thread was holding the RTNL.

The hwsim runs in the commit message use a monitor and a coordinator
and never issue the associate command. Lockdep does not track
completions either, so none of those runs would have shown this.

Is the RTNL really what the response TX needs here? Could the TX path
used from the rx_mac_cmd worker be protected by a narrower lock
instead? Or could mac802154_perform_association() avoid holding the
RTNL while it waits on assoc_done?

[Severity: High]
Can this rtnl_lock() stall a local associate request until it times out?

The netlink associate path holds the RTNL for the whole time it waits for
the ASSOC RESP. NL802154_CMD_ASSOCIATE has NL802154_FLAG_NEED_RTNL, so
pre_doit takes the RTNL, and then:

nl802154_associate()
  mutex_lock(&wpan_dev->association_lock);
  rdev_associate()
    mac802154_associate()                /* ASSERT_RTNL() */
      mac802154_perform_association()
        wait_for_completion_killable_timeout(&local->assoc_done, 10 * HZ);

Take two PHYs on the same host, for example the usual two-radio
mac802154_hwsim setup. There is a coordinator interface on phy0 and a
node on phy1 running associate:

1. The node's netlink thread holds the RTNL and waits on assoc_done.
2. phy0 receives the ASSOC REQ, and its rx_mac_cmd worker enters
   mac802154_process_association_req().
3. With this patch the worker blocks in rtnl_lock() until the node's
   10 second timeout expires.
4. The node returns -ETIMEDOUT and clears IEEE802154_IS_ASSOCIATING.
   The ASSOC RESP that phy0 sends after that is dropped by the node's
   rx path because mac802154_is_associating() is false.
5. If that TX was ACKed, the coordinator still adds the node to
   wpan_dev->children, so the two sides disagree about the association.

Before this patch the cross-PHY case worked. ASSERT_RTNL() only checks
the global rtnl_is_locked(), and the node's netlink thread was holding the
RTNL. Each wpan_dev also has its own association_lock.

There is also a same-PHY variant that already existed. Each PHY has a
single-threaded mac_wq. If a coordinator with parent == NULL is itself
associating, an ASSOC REQ queued ahead of the parent's ASSOC RESP blocks
the worker that has to deliver that RESP. Before this patch it blocked on
association_lock. Now it blocks on the RTNL first.

This change also invalidates an assumption stated in commit 2f37fba846c9
("mac802154: fix use-after-free of sdata via queued RX frames"): "A worker
blocked in an association TX ... does not hold rtnl". The commit message
does not mention this.

The PROVE_LOCKING runs in the commit message would not catch this
problem. Lockdep does not model completions, and the tests described
never run the associate command.

[Severity: High]
Can a remote ASSOC REQ still reach the WARN_ON_ONCE() in
ieee802154_mlme_tx_locked() with this change?

The only running-state check is done without any lock held, in
mac802154_rx_mac_cmd_worker():

	if (ieee802154_sdata_running(mac_pkt->sdata))
		mac802154_rx_mac_cmd(local, mac_pkt);

Nothing checks it again after the RTNL is taken here. Here is a race with
"ip link set <coord> down":

1. dev_close() holds the RTNL and calls mac802154_slave_close().
2. mac802154_slave_close() decrements local->open_count and clears
   SDATA_STATE_RUNNING.
3. A monitor interface may be up on the same PHY, which
   ieee802154_check_concurrent_iface() allows. If so, open_count stays
   non-zero.
4. The worker passed the check before ndo_stop ran. It sleeps in
   rtnl_lock() until the close completes.
5. The worker then continues:

mac802154_send_association_resp_locked()
  ieee802154_mlme_tx_locked()
	if (!local->open_count)        /* false, monitor still open */
		return -ENETDOWN;
	...
	if (WARN_ON_ONCE(!netif_running(sdata->dev)))   /* fires */
		return -ENETDOWN;

With panic_on_warn=1 this is the same panic the commit message says it
removes.

Before this patch the window was a short lockless race. Now any worker
that is waiting for the RTNL while ndo_stop runs will see the closed
state. The rx_mac_cmd_list is also not flushed on close.

Would it make sense to check ieee802154_sdata_running(sdata) and
netif_running(sdata->dev) again after rtnl_lock(), and return -ENETDOWN
if either is false?

[Severity: Low]
This isn't a bug introduced by this patch, but the checks at the top of
mac802154_process_association_req() run before rtnl_lock() and
association_lock are taken. They read wpan_dev->pan_id, extended_addr,
short_addr and parent, for example:

	if (wpan_dev->parent) {
		dev_dbg(&sdata->dev->dev,
			"Ignoring ASSOC REQ, not the PAN coordinator\n");
		return -ENODEV;
	}

The writers hold those locks:

mac802154_associate() {
	...
	wpan_dev->pan_id = coord->pan_id;
	wpan_dev->short_addr = short_addr;
	wpan_dev->parent = parent;
	...
}

On the same PHY, this sequence is possible:

1. The worker handles the parent's ASSOC RESP and completes assoc_done.
2. The worker picks up a later ASSOC REQ, reads parent == NULL and
   blocks on rtnl_lock().
3. mac802154_associate() sets wpan_dev->parent and drops the locks.
4. The worker accepts and records a child as if it were still the PAN
   coordinator. It may also answer a request addressed to the old
   pan_id.

The same window existed before through association_lock. Should these
checks be done after the locks are taken?

>  
>  	memcpy(&assoc_req_pl, skb->data, sizeof(assoc_req_pl));

[ ... ]

> @@ -895,6 +900,7 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
>  
>  unlock:
>  	mutex_unlock(&wpan_dev->association_lock);
> +	rtnl_unlock();
>  	return ret;
>  }

[Severity: Medium]
This is a pre-existing issue, but does the duplicate-child handling just
above the unlock label leak exchild?

	exchild = cfg802154_device_is_child(wpan_dev, &tmp);
	if (exchild) {
		dev_dbg(&sdata->dev->dev,
			"Child %8phC was already known\n", &ceaddr);
		list_del(&exchild->node);
	}

	list_add(&child->node, &wpan_dev->children);
	wpan_dev->nchildren++;

With alloc_addr == 0, the lookup finds the old entry. It is unlinked but
never freed, and nchildren is still incremented. The count then overstates
the list by one per re-association.

With alloc_addr == 1, which Linux nodes always set, tmp.mode is
IEEE802154_SHORT_ADDRESSING. cfg802154_pan_device_is_matching() always
rejects that mode:

	if (ext_dev->mode == IEEE802154_ADDR_SHORT)
		return false;

So duplicates pile up on wpan_dev->children and nchildren keeps growing.

The other removal paths pair list_del() with kfree() and adjust
nchildren:

  mac802154_process_disassociation_notif()
  mac802154_disassociate_child()
  cfg802154_free_peer_structures()

Repeated re-associations from one peer can push nchildren toward
max_associations. That leads to spurious IEEE802154_PAN_AT_CAPACITY
refusals.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121150835.256812-1-leegun25%40proton.me
