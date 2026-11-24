Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504238;
	b=17abZIQ3W0YY5mCKvrn9t3XIa73DJ9vTPq4ejsTHyVvCJzoBroqB/q0wKfvr7w+RsG4y
	 4+Ko0XE2aUPtbahc59tRR468WH4J4JuYx+Vd5iA+XhSECI5QAvggBNn4mFjRzHUZO3OIh
	 dQTfPpxKQ699g0ADgfeZipKFkVrf6xC7nQF0ZiyijoUHSPDPZuJci9g+n62ofi+KJrwHv
	 CLNo+58ZtursjUiD80SFxV+ot2td2VkXKVNbWTqbTRx7FIRnbEXM6zvDqeEgm8l6bE/zH
	 OtUQiNPqSULMEyVojAbnTu5kEo8OAirHe2GnIdVmvuzSGOzRj/gLBgwp0riBwc8XuCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504238;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BNp2+flLXC2RdQ1rApA9xXKiDl4PT/UNh19vKSxfWMU=;
	b=PLyI3yH+jNP+zUt0xesesbBSFNAJPZJPKPIq2ePbA3ItiBjgwzO4RE0PoOgNEVEVtair
	 vsaqz8RRR/6O63nn/FkN97PAubhcQycIp+u7Rs6Dc+YSFtMA2RlS2eBZLfhPZ/QKdV/DW
	 HNZ7HO6qtvfcqD3vi54ntUBh+jVsSI7LbwfIT8wBOcBtSbOxA4+GL861MzhaD9XNSUkxF
	 ajH8kuujdNsXXJLg1phXMonxM20x71RMHdpfLki3lolOco+VAQRAm8lvMlt1qcO0xOVYe
	 m4ohn/+7yUv+2wp0RsCw41KHvICYPzDrOcCprVViTrykRssHUtOAmdBUfQcxrDFZzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j70JAOnu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30117606A321;
	Tue, 24 Nov 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j70JAOnu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA371F000C0;
	Tue, 24 Nov 2026 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795504237;
	bh=BNp2+flLXC2RdQ1rApA9xXKiDl4PT/UNh19vKSxfWMU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j70JAOnuyYK9UOwZMa91GfTqAcR0r7JdoD4zUd6SjLrsgnADQvyV/MOUEg6hp/ukk
	 +WtkeUzdQjHEY5AzF2KZxolLd/rIiwyKplQzfaAUN5PR3DFB0MsgOdXVJBjAechDPm
	 MwpCJyVNWB0s1r/jzGQdjfjsEhE6W8hyPRlIYy0iOuQ4avk3HaMI9F8c4xbFgk8VD3
	 7Yr7gxLX4FKTPjUSRGiIm823cpYSKxPjfXGWIB7YhXPLsuoR3DzvOKIfU+c22I65Dv
	 xuHYopOionS/tKGzOLO3YJi2gcHg1KbnjvsJVuTMOxDxwZNJPo8HZqHh8J+d8dHOE+
	 sK6+4SDZ5dmqg==
Subject:
 Re: [PATCH net v2] ieee802154: keep the original error after a netns rollback
From: netdev-bot+sashiko@kernel.org
To: amisiurov@cloudlinux.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 07:10:36 +0000
Message-ID: <179550423672.3135.14967631079444652354@kernel.org>
In-Reply-To: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
References: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The rollback loop in cfg802154_switch_netns()
  (net/ieee802154/core.c, lines 255-267) walks rdev->wpan_dev_list…
- [Low] The commit message suggests that any failed move in
  cfg802154_switch_netns() ends with 'err' overwritten to 0.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  exact path the commit message describes (-EEXIST on the forward move).
- [High] This problem wasn't introduced by this patch, but
  cfg802154_pernet_exit() (net/ieee802154/core.c, around line 361) calls…

--

ieee802154: keep the original error after a netns rollback

This patch shadows 'err' inside the rollback loop of
cfg802154_switch_netns(). A failed netns switch then returns the original
error instead of the result of the last move-back. Without it, a failed
switch can be reported to userspace as a success through
nl802154_wpan_phy_netns().

> That rollback loop overwrites the same 'err' variable with the result of
> each move-back. The move-backs succeed, so 'err' ends up 0 and the function
> returns 0 -- success -- even though nothing moved and the phy stayed in the
> old netns.

[Severity: Low]
This isn't a bug, but could the commit message say more precisely when the
overwrite happens?

Suppose the first entry in rdev->wpan_dev_list that has a netdev is the one
that fails. list_for_each_entry_continue_reverse() starts at
list_prev_entry(pos), which is the list head. The rollback body never runs,
so the unpatched code already returns the original error in that case.

The overwrite only happens in two cases:

  - at least one earlier netdev moved before a later one failed, or
  - every netdev moved and then device_rename() failed.

The message doesn't mention the device_rename() path, which this patch
also fixes.

The reproduction note below the --- line ("phy0 and its wpan0 interface",
-EEXIST internally, 0 returned) only fits if phy0 had another interface
that moved before wpan0 failed.

Would stating these conditions help backporters decide whether they are
affected?

> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index c0b8712018a16..f471744175182 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -255,6 +255,8 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
>  	list_for_each_entry_continue_reverse(wpan_dev,
>  					     &rdev->wpan_dev_list,
>  					     list) {

[Severity: High]
Does this rollback really move all of the already-moved netdevs back?

Each dev_change_net_namespace() call runs the NETDEV_UNREGISTER and then
the NETDEV_REGISTER notifier. cfg802154_netdev_notifier_call() changes
rdev->wpan_dev_list while that happens:

net/ieee802154/core.c:cfg802154_netdev_notifier_call() {
    ...
	case NETDEV_REGISTER:
		...
		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
    ...
	case NETDEV_UNREGISTER:
		...
		if (!list_empty(&wpan_dev->list)) {
			list_del_rcu(&wpan_dev->list);
		...
		INIT_LIST_HEAD(&wpan_dev->list);
    ...
}

So every successful move puts the moved wpan_dev at the head of the list.
Take a list of [A, B, C] where C fails:

  forward loop:  move A        -> [A, B, C]
                 move B        -> [B, A, C]
                 A again, net_eq() no-op
                 C fails, break with pos = C

  rollback:      pos = prev(C) = A
                 move A back   -> [A, B, C]
                 prev(A) is the list head, loop ends

B is never moved back. On the device_rename() failure path pos is the list
head, so only prev(head) is moved back.

With this patch the function returns the original error (for example
-EEXIST from an altname clash in the target netns). Userspace is told the
switch failed, but B stays in the new netns while the phy stays in the old
one.

The commit message says the error path "moves the already-moved netdevs
back to the old netns" and that "nothing moved". That doesn't seem to hold
when two or more netdevs had already moved.

The stranded netdev also keeps netns_immutable = true. When its netns is
torn down, default_device_exit_net() skips it. default_device_exit_batch()
then unregisters it with unregister_netdevice_queue(), because mac802154
netdevs have no rtnl_link_ops.

That path bypasses ieee802154_if_remove(), so sdata->list stays on
local->interfaces after the netdev and its sdata are freed. Can that then
be dereferenced in __ieee802154_rx_handle_packet():

	list_for_each_entry_rcu(sdata, &local->interfaces, list) {

or by the list_del_rcu() in ieee802154_remove_interfaces()?

> +		int err;
> +
>  		if (!wpan_dev->netdev)
>  			continue;
>  		wpan_dev->netdev->netns_immutable = false;

[Severity: High]
This isn't a bug introduced by this patch, but it is on the same -EEXIST
forward-move path the commit message describes. Is the netns_immutable
flag of the failing netdev ever restored?

In the forward loop of cfg802154_switch_netns():

		wpan_dev->netdev->netns_immutable = false;
		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
		if (err) {
			WARN_ON(err && err != -ENOMEM);
			break;
		}
		wpan_dev->netdev->netns_immutable = true;

The break skips the restore. The rollback starts at list_prev_entry() of
the failing entry, so it never visits that netdev either. That leaves the
only guard in __dev_change_net_namespace() disabled:

	if (dev->netns_immutable) {
		NL_SET_ERR_MSG(extack, "The interface netns is immutable");
		goto out;
	}

A later "ip link set wpanX netns Y" can then move the netdev away from its
phy. NETDEV_REGISTER sets the flag back to true in Y. When Y is destroyed,
the same default_device_exit_batch() path described above unregisters the
netdev without ieee802154_if_remove(). That leaves a freed sdata on
local->interfaces.

cfg80211_switch_wdev_netns() in net/wireless/core.c always restores the
flag, whatever the result:

	wdev->netdev->netns_immutable = false;
	err = dev_change_net_namespace(wdev->netdev, net, "wlan%d");
	wdev->netdev->netns_immutable = true;

Should the 802.15.4 version also set the flag back before the break?

[Severity: High]
This is a pre-existing issue, but what happens if cfg802154_switch_netns()
fails when it is called from cfg802154_pernet_exit()?

net/ieee802154/core.c:cfg802154_pernet_exit() {
    ...
		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net))
			cfg802154_switch_netns(rdev, &init_net);
    ...
}

The return value is ignored. Altname clashes don't apply during teardown,
because __dev_change_net_namespace() destroys conflicting altnames when
!check_net(net_old). The trigger here is an allocation failure in
dev_change_net_namespace() or device_rename().

On such a failure the errout path does:

	net = wpan_phy_net(&rdev->wpan_phy);

That is the dying netns. The rolled-back netdevs are moved back into a
namespace that is about to be freed, possibly only some of them given the
list reordering above. wpan_phy_net_set() is never called, so the phy
keeps pointing at the freed struct net.

The immutable netdevs left in the dying netns are then unregistered by
default_device_exit_batch() without ieee802154_if_remove(). That leaves
dangling sdata entries on local->interfaces, which ieee802154_rx() and
ieee802154_remove_interfaces() later use.

cfg80211_pernet_exit() handles this with force mode and a WARN_ON():

			WARN_ON(__cfg80211_switch_netns(rdev, &init_net, true));

Force mode unregisters the interfaces that cannot be moved. Is a similar
fallback needed for 802.15.4?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120065750.3274661-1-amisiurov%40cloudlinux.com
