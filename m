Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613985;
	b=1+0a0F1/xOywg4joU46hfOZ2iI+/QreuhUpHHhDueTmDp4TA9/cYf6xM8mFXOtn0u8br
	 srFjT/VPUGYNF+pd6X33LUcVaaVgFlV5R8TbYM9pIXFng32mbhGwQrDpdTgWrDuVBL1s4
	 U2gDphfiXTKX7pmYmXMoBHv4StzI0AWUSJ7KsZriwC7DMa6GZH9QwGAs5deooalHAAm6j
	 yKcR2UGNOzhvKsBfOL8Bc9jv0oCUWys14ixvNnAY+z8JocIBsfU/XJhJyAKY6ef6KWP81
	 V9hix+uTvWeIOOQ41SeGD4l3kE1A64Qa42umV8/XqhBlOgFtYwAMxNwHT2ZaiUJmbQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613985;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CeTkfVzE6KwXB8K1xX0sANf/8jffszjaX1cpX1GXslI=;
	b=RjMAjpO6Qsjrr/rT86W19bw/157IUnwqaIYp+xnjJKsIr0LdHK5V5OYK/Z19UlbaWFgN
	 cY7dP1O62o14W5ZdNwHAGk476R7zdnjWvYFBPNmE4PAyvx0yiZxlinAbJVGZpYg0Yad3K
	 1o3JDD4P5cPGH4GKxCJT6R103HvQo9v3oP81NqQcPEEIv0rrC3DgSJo5AAzVpLcNZxSYR
	 B7Il5UY6Ywg/dT7XZv8Y8q6tYF2yOTV1HekMzpIxLhnwyQ+I3wqwHf1BXMGQCRajCvlKO
	 a/dHsih96iEOoS8pXRxAOcbyCeqUYYMH50Qcsf7Wgsi+jeCOLbBpz/lLK1TaQnpgpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Atf85tef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2012606A335;
	Wed, 25 Nov 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Atf85tef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A8D1F000D4;
	Wed, 25 Nov 2026 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613984;
	bh=CeTkfVzE6KwXB8K1xX0sANf/8jffszjaX1cpX1GXslI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Atf85tefh9bkXVmipDJVe/yKXCpOUVZfmgPBw+SiGnlS5ODWT3Qi1Ctw68pKnE4B2
	 /JG0l3QkMnCQZq9bPO9JM8LvXEx2ZEfAgdQFuyNmw6z7ADsKe8W3pweA0e3m9728Lb
	 W1MtQHFgO43gToB8j2AauPifWHtDfx08gD6WVUqh5bTAvS9DjVEHhjX7qbmbrNgXT3
	 tkKZURCrOgF2oAhHq6C9THh6oLUDpn7yusmqyRJLh/zkJYNmBmtrlSZ8AJ0YWrhsqy
	 HDlwyuLCUb/zJaL1Z694gIqhQEVVbaVIQ9hR9Qw+BjrIoe44TsXG2/rrNsL4rTZd5B
	 mK8rzdgrF6V9Q==
Subject: Re: [PATCH net] mac802154: fix duplicate association handling
From: netdev-bot+sashiko@kernel.org
To: leegun25@proton.me
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Date: Wed, 25 Nov 2026 13:39:43 +0000
Message-ID: <179561398358.3135.3017322314045036906@kernel.org>
In-Reply-To: <20261121133101.240921-1-leegun25@proton.me>
References: <20261121133101.240921-1-leegun25@proton.me>
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

- [High] In mac802154_process_association_req() (net/mac802154/scan.c),
  the duplicate lookup only runs after the capacity gate at line 848.
- [Medium] mac802154_process_association_req() (net/mac802154/scan.c)
  draws a fresh random short address for every accepted REQ…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  cfg802154_get_free_short_addr() (net/ieee802154/pan.c:86-88) does not…

--

mac802154: fix duplicate association handling

This commit changes mac802154_process_association_req() to look up an
already known child by its extended address, whatever short address mode
was chosen for the new entry. It also frees the replaced child entry.
nchildren is now incremented only for children that were not already in
the list.

> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index d393b1f4e74e4..ebef22e7e8857 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -879,19 +879,23 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
>  		"Successful association with new child %8phC\n", &ceaddr);
>  
>  	/* Ensure this child is not already associated (might happen due to
> -	 * retransmissions), in this case drop the ex structure.
> +	 * retransmissions), in this case replace the ex structure.  The ASSOC
> +	 * REQ source is always an extended address, so look the child up by it
> +	 * regardless of the short address mode chosen for the new entry.
>  	 */
> -	tmp.mode = child->mode;
> +	tmp.mode = IEEE802154_EXTENDED_ADDRESSING;
>  	tmp.extended_addr = child->extended_addr;
>  	exchild = cfg802154_device_is_child(wpan_dev, &tmp);
>  	if (exchild) {
>  		dev_dbg(&sdata->dev->dev,
>  			"Child %8phC was already known\n", &ceaddr);
>  		list_del(&exchild->node);
> +		kfree(exchild);

[Severity: Medium]

With alloc_addr=1, a new short address is picked and sent in the
association response before this lookup runs:

		if (assoc_req_pl.alloc_addr) {
			assoc_resp_pl.short_addr = cfg802154_get_free_short_addr(wpan_dev);
			child->mode = IEEE802154_SHORT_ADDRESSING;

In the retransmission case named in the comment, the requester keeps
address A from the first response.
mac802154_process_association_resp() clears IEEE802154_IS_ASSOCIATING on
the first matching response and returns -ENODEV for any later ones.

Here the old entry holding A is freed and only the new entry, with address
B, is kept. Won't the coordinator then reach this child at a short address
it doesn't use? For example, mac802154_send_disassociation_notif() does:

	frame.mhr.dest.short_addr = target->short_addr;

Address A is then also treated as free for the next allocation.

Before this patch, the newest entry B was already at the head of the list
and lookups returned it first, so the mismatch is not entirely new.
Now that the patch replaces the entry on retransmissions, should it reuse
exchild->short_addr (or do the lookup before allocating)? That would avoid
handing out a new address the peer will ignore. The commit message doesn't
mention this behaviour.

> +	} else {
> +		wpan_dev->nchildren++;
>  	}

[Severity: High]

Does this count only genuinely new children while there is still room in
the table? The duplicate lookup runs only after the capacity check earlier
in mac802154_process_association_req():

	if (wpan_dev->nchildren >= wpan_dev->max_associations) {
		...
			assoc_resp_pl.status = IEEE802154_PAN_AT_CAPACITY;
		...
	}
	...
	ret = mac802154_send_association_resp_locked(sdata, child, &assoc_resp_pl);
	if (ret || assoc_resp_pl.status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
		kfree(child);
		goto unlock;
	}

Suppose nchildren == max_associations and a request arrives from a child
that is already in wpan_dev->children. The request gets
IEEE802154_PAN_AT_CAPACITY, and the replace logic is never reached. The
stale entry keeps its slot, but the peer is told it is not associated.

This can happen with max_associations=2, the setup used in the commit
message, if the peer lost its state. It can also happen after
mac802154_disassociate_from_parent() runs on the peer: the peer frees its
parent even when the disassociation notification was not acked, so the
coordinator still holds the child.

For a plain MAC retransmission the refusal does no harm, because
mac802154_process_association_resp() drops later responses once
IEEE802154_IS_ASSOCIATING is cleared.

Would it make sense to do the extended address lookup before the capacity
check, and skip the check for a known child? Then these statements from
the commit message would also hold when the table is full:

  "A retransmitted ASSOC REQ from an already known child is supposed to
  replace the old entry"

  "count only genuinely new children"

>  
>  	list_add(&child->node, &wpan_dev->children);
> -	wpan_dev->nchildren++;

[Severity: High]

This isn't a bug introduced by this patch, but the replace logic relies on
cfg802154_get_free_short_addr() returning unused addresses. It does not
appear to reject addresses already used by children. In
net/ieee802154/pan.c:

	do {
		get_random_bytes(&addr, 2);
		...
		list_for_each_entry(child, &wpan_dev->children, node)
			if (child->short_addr == addr)
				continue;

		break;
	} while (1);

Since list_for_each_entry() is a for loop, the continue only advances the
list walk and does not restart the do/while loop. When the walk finishes,
the break runs and the colliding address is returned.

The kernel-doc in include/net/cfg802154.h promises "a random short address
expectedly unused on our PAN". mac802154_process_association_req() gives
this address to any remote peer that sets alloc_addr, so two children can
end up with the same short address.

max_associations defaults to SZ_16K and there are only 65534 usable
values, so collisions become likely after a few hundred associations.
Flooding the coordinator with unauthenticated association requests makes
them almost certain.

Should the child check use a flag or a goto, so that a collision restarts
the outer loop?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121133101.240921-1-leegun25%40proton.me
