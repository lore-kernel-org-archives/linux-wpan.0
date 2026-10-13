Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F14F93AD;
	Tue, 13 Oct 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895951; cv=none; b=DK9ivxRDHTAbb9X0zEvDL3M2qfk+Yk0p+SwCz2lLnRjtNxDk6FrkTYENyREQ/WG2oQ09YzYgUTuGJgjszMlJESSrgDK2speoy4k+NitEhyEBXs5fidpDOk6lcrUZz/rzMp8+zeId/Wxxi0sLBwNpJfjybA5fjwNRmlAXIF4nyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895951; c=relaxed/simple;
	bh=WPXDokGAVT8xHyG7V2eyKKm0EVqC2AqXpUSIFVoSpPc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLfrNrEsf2+WjeEFEXRVVWhyckJ04oH7rpjBsPNtNCnYZzsSo0+KNGriPkZ2NBaky1LU0M46i8l+fuS1g85lzETvB7ulnLkI4Kqw7DoVHF5fZgRidvYCnIeGZvF31CNgcBi95YEHrbxsfjsJyAwucgl6qaHCC1CCXNRiaIiu3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWBy2xqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWBy2xqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E171F00898;
	Tue, 13 Oct 2026 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895950;
	bh=6AphuRwwkTTX1UE/Xr94mon/cOPvdUL05cql2xK2qX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DWBy2xqYtmHFRAyIXF5jPPjGyPp4pdMsMthXlxlQgObwwVYtwnxm4QkudyDJGNlnC
	 AIAbVyhU9TnMNos1sODU3/XKnq3ZfvgLz2kHtvNhipIqg/nHpwd+SvtcjVmnz+CuEQ
	 318looYnwL0JWHS3zCGEMQeIKTl2RtLZS76KUjFM/3aIVd/tpS/FRR3UrYilPnKpwa
	 40ekRrJ1JxQR4qcE4QBXTpWKRl/BEDFwHbe6NtIj/1oX01ICHmG/psTLDJTIq0OGFq
	 1iPE2UBm4YS//v0P6JqdMd4bsxJAXW9Iafgfl+H37yQfH2K54rirqPaXOpMc4H8gOW
	 QC4kVYrpbcK2A==
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during hardware
 teardown
From: netdev-bot+sashiko@kernel.org
To: aryanarora.w1@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, david.girault@qorvo.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Date: Tue, 13 Oct 2026 12:52:29 +0000
Message-ID: <179189594936.434549.3505861884741105866@kernel.org>
In-Reply-To: <20261012120934.64632-1-aryanarora.w1@gmail.com>
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because it handles scan_work only.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ieee802154_unregister_hw() drops RTNL after…
- [Medium] This problem wasn't introduced by this patch, but
  mac802154_scan_worker() checks scan_req and ieee802154_sdata_running()…
- [Low] This problem wasn't introduced by this patch, but the block
  comment above mac802154_scan_cleanup_locked()…

--

mac802154: Cancel scan work synchronously during hardware teardown

This commit adds a cancel_delayed_work_sync() call on local->scan_work in
ieee802154_unregister_hw(). The call runs after the interfaces are removed
and before local->mac_wq is destroyed. It is meant to stop a scan worker
that requeues itself from leaving a delayed-work timer armed when the PHY
allocation is freed.

Closes: https://syzkaller.appspot.com/bug?extid=19cbce4cc656ecd4febc

> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 8ed6de111f5af..ba6311e98c8b8 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -285,6 +285,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
>  
>  	rtnl_unlock();
>  
> +	cancel_delayed_work_sync(&local->scan_work);
> +

[Severity: High]
Does beacon_work need the same treatment? It is also a delayed work on
local->mac_wq that re-arms itself. mac802154_stop_beacons_locked() in
net/mac802154/scan.c uses the same non-sync cancel:

	clear_bit(IEEE802154_IS_BEACONING, &local->ongoing);
	cancel_delayed_work(&local->beacon_work);
	request = rcu_replace_pointer(local->beacon_req, NULL, 1);

After the transmit, mac802154_beacon_worker() re-arms without checking
beacon_req again:

	ret = mac802154_transmit_beacon(local, wpan_dev);
	...
	if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
		queue_delayed_work(local->mac_wq, &local->beacon_work,
				   local->beacon_interval);

The transmit goes through ieee802154_mlme_tx(), which takes rtnl_lock().
Can this sequence leave the beacon_work timer armed?

CPU1 (beacon worker)
mac802154_beacon_worker()
  beacon_req != NULL, sdata running, netdev_hold()
  mac802154_transmit_beacon()
    ieee802154_mlme_tx()
      rtnl_lock()   <- blocks

CPU0
ieee802154_unregister_hw()
  rtnl_lock()
  ieee802154_remove_interfaces()
    ... mac802154_slave_close()
      mac802154_stop_beacons_locked()
        cancel_delayed_work(&local->beacon_work)   <- worker is running
        local->beacon_req = NULL
  rtnl_unlock()
    netdev_run_todo()   <- drops rtnl, waits for CPU1's netdev ref

CPU1
      ieee802154_mlme_tx_locked() returns -ENETDOWN
  queue_delayed_work(local->mac_wq, &local->beacon_work, ...)
  netdev_put()

CPU0
  cancel_delayed_work_sync(&local->scan_work)   <- beacon_work untouched
  destroy_workqueue(local->mac_wq)
  wpan_phy_unregister(local->phy)
driver calls ieee802154_free_hw()   <- local freed, timer still pending

destroy_workqueue() drains work that is queued or running. It does not
drain a delayed work whose timer has not fired yet. When this timer fires,
it touches the freed local and calls __queue_work() on the destroyed
mac_wq.

The 1000 ms re-arm in the !ieee802154_sdata_running(sdata) branch of
mac802154_beacon_worker() has the same effect.

This is the problem the commit message describes ("The worker can requeue
itself after cancellation, leaving an active delayed-work timer when the
PHY allocation is freed"), reached through beacon_work instead of
scan_work.

Could this call disable_delayed_work_sync() on both scan_work and
beacon_work, after rtnl_unlock() and before
destroy_workqueue(local->mac_wq)? This has to stay outside the rtnl lock,
because both workers take rtnl_lock().

cancel_delayed_work_sync() calls enable_work() again before it returns, so
a later producer could still arm the work.

>  	destroy_workqueue(local->mac_wq);
>  	destroy_workqueue(local->workqueue);
>  	wpan_phy_unregister(local->phy);

[Severity: High]
This isn't a bug introduced by this patch, but the rtnl lock is dropped
and both workqueues are destroyed while the PHY is still on
cfg802154_rdev_list. Netlink can only stop finding the PHY once
wpan_phy_unregister() runs:

net/ieee802154/core.c:wpan_phy_unregister() {
    ...
	list_del_rcu(&rdev->list);
	synchronize_rcu();
    ...
}

Neither nl802154_new_interface() nor ieee802154_if_add() checks whether
the PHY is being torn down. nl802154_new_interface() has a TODO about it:

	/* TODO avoid failing a new interface
	 * creation due to pending removal?
	 */

What happens if a CAP_NET_ADMIN client does the following in this window?
It creates an interface, brings it up and sends NL802154_CMD_TRIGGER_SCAN.

mac802154_trigger_scan_locked() would then do:

	queue_delayed_work(local->mac_wq, &local->scan_work, 0);

If that happens before destroy_workqueue(), the worker can re-arm itself
with scan_duration. A timer is then still pending after mac_wq is
destroyed and local is freed. cancel_delayed_work_sync() re-enables the
work before it returns, so it does not stop later producers.

If it happens after destroy_workqueue(), __queue_work() runs against a
destroyed workqueue.

In both cases the new interface stays on local->interfaces. One of two
things then happens in wpan_phy_unregister():

- it waits forever in wait_event() for opencount to reach zero, or
- it hits WARN_ON(!list_empty(&rdev->wpan_dev_list)).

After that, ieee802154_free_hw() hits:

	BUG_ON(!list_empty(&local->interfaces));

Would it make sense to withdraw the PHY, or to block interface creation
and scan start, before the rtnl lock is dropped here? Using
disable_delayed_work_sync() would at least keep scan_work from being armed
again.

[Severity: Medium]
This isn't a bug introduced by this patch, but the sync cancel cannot undo
hardware changes that a racing scan worker has already made.

mac802154_scan_worker() checks scan_req and ieee802154_sdata_running()
under rcu_read_lock() only. It then takes the rtnl lock twice without
checking again:

	rcu_read_unlock();

	/* Bypass the stack on purpose when changing the channel */
	rtnl_lock();
	ret = drv_set_channel(local, page, channel);
	rtnl_unlock();
	...
	rtnl_lock();
	ret = drv_start(local, IEEE802154_FILTERING_3_SCAN, &local->addr_filt);
	rtnl_unlock();

Suppose the worker is blocked on rtnl_lock() while mac802154_slave_close()
runs mac802154_abort_scan_locked(), plus ieee802154_stop_device() on the
last close. When the worker gets the lock, can it restart the hardware in
scan filtering mode after the stack has already stopped it or restored the
default filtering?

In the user abort case, the worker then re-queues itself with
scan_duration. The next run calls drv_stop() on entry, without the rtnl
lock and before it checks scan_req:

	drv_stop(local);
	synchronize_net();
	mac802154_flush_queued_beacons(local);

	rcu_read_lock();
	scan_req = rcu_dereference(local->scan_req);
	if (unlikely(!scan_req)) {

Does that leave the radio stopped while the interface is still up?

In ieee802154_unregister_hw(), the same race can leave the radio running
after tasklet_kill() and interface removal. Whether that leads to RX or
IRQ activity against a local that is about to be freed depends on the
driver.

Could the worker check test_bit(IEEE802154_IS_SCANNING, &local->ongoing)
or rtnl_dereference(local->scan_req) again under the rtnl lock before it
touches the hardware?

[Severity: Low]
This isn't a bug introduced by this patch, but the block comment above
mac802154_scan_cleanup_locked() in net/mac802154/scan.c says:

 * - The sub-interface and device driver module get both their reference
 *   counters incremented whenever we start a scan, so they cannot disappear
 *   during operation.

Is that still accurate? nl802154_trigger_scan() stores raw wpan_dev and
wpan_phy pointers in the request. It takes no dev_hold(), netdev_hold()
or try_module_get(). mac802154_trigger_scan_locked() only publishes
scan_req and queues scan_work.

The only reference in the scan path is the short-lived netdev_hold()
inside each run of mac802154_scan_worker(). It is dropped before the
worker re-arms.

Should the comment be updated to match the code?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012120934.64632-1-aryanarora.w1%40gmail.com
