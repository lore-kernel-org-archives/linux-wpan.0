Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423720;
	b=QNW8lB4iHf34risI+6SaTjAciuvQPgL9Hw670jvVVW5WotKu73wIwwgLhI3ODSpi1Cck
	 afttHYknlDasfJ7M+j5fYoNVnHxtolm68bgLoMjn9dLVfN9WqawBKEk9dakcxPZdmOESy
	 DIRXvyMZrMlyOhEFb3HczY1AN0KH7Ya9SL+Vy+nuTtNe07gCaMHEERDx1PjMN3mDMVkZA
	 cwkPq113NT7WG9GmJTtStV5D5DuZ3D43FvnFmCIfJhDPRGHlhyks69DscS1/gVabCEv3D
	 1vDZ+k6qBzapMU+2NcxyPG74XdyMcbKvntDGkbSHCnzo55V5la+8nzmB313pTk5gnpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423720;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=gxoYopGv36PrxSuDkesKkqjNJ9M5btJr5MGzOubEhE0=;
	b=PEdTuMZxKlEUH3D+HoYPLuBAEhDNEkyMa+foB55cwsPjzDuWfq189QajZAIjMb1+9Z5H
	 tqUtBeDJlVsW4g/q49ilY8XZc8ogxYQ/6m01JmnmoJmuj/IxbPXj/BMxXvkDIyEvkoI6v
	 8cMK0mKV3qf/8sktpQwN4xuuiVHwwbAXPAwkRGtSSCa6fW+m8+xJ06wOqFkmAIwZJWwQq
	 +0XTsG0WwmTLjJi+VEYQazK/t5J9J3fqX7Mf/46Sg1ckbJB+lBnYOxjOc14xZxcTYL3yG
	 BQTdX7cySPjnkZYn7gK+SofSjfGGvC1bpvvTdhjf2l7Uaa4wOCZz9Dwhe4DHE99dmrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=d6RB14i4;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11941606A31F;
	Mon, 23 Nov 2026 08:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11941606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=d6RB14i4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 47A781A17B1;
	Mon, 23 Nov 2026 08:48:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 137125FAEB;
	Mon, 23 Nov 2026 08:48:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E3FC11E68739;
	Mon, 23 Nov 2026 09:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795423716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gxoYopGv36PrxSuDkesKkqjNJ9M5btJr5MGzOubEhE0=;
	b=d6RB14i4DdcicrUpKqHgnXA999geC/VvzPSth5X6vIzaCmnhxdWmUa4rsmGCGoYBr8XR0l
	b3WwuSXEfKjir3yszUaeYqNhq3JadTsVzS6xgt4UcL6H3CU3kqlPASi+ypo5FBovcLvJJT
	60/Z/PUFjGldNrJxWrgkmBBsc5DJNXENylCH1iO421hUdUt+Kkt+TvxhX67vhVITpkCmcG
	erGGzo7swHPvFyQ02Y13hJervV/5w6LcrIUfNX5S4UVEDe3akGzUO2r00TcFZzoZ0NUg+P
	1jNcCZZbTIWRryuLusDj6gOJFik3xKDrnGhoYalMAZfmDawnQKszLMS4MpL6Xg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Keon-Hyeong <leegun25@proton.me>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: fix duplicate association handling
In-Reply-To: <20261121133101.240921-1-leegun25@proton.me> (Lee Keon-Hyeong's
	message of "Sat, 21 Nov 2026 13:31:08 +0000")
References: <20261121133101.240921-1-leegun25@proton.me>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 23 Nov 2026 09:48:34 +0100
Message-ID: <87se0sue59.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

Hi Lee,

On 21/11/2026 at 13:31:08 GMT, Lee Keon-Hyeong <leegun25@proton.me> wrote:

> A retransmitted ASSOC REQ from an already known child is supposed to
> replace the old entry, but the lookup uses the new child's address mode.
> With alloc_addr=1 the new child has short-address mode and
> cfg802154_pan_device_is_matching() rejects short-mode queries, so the
> lookup never matches and every retransmission is appended as a new child,
> consuming an association slot and a short address.  With alloc_addr=0 the
> lookup matches, but the old entry is only list_del()'d without kfree(),
> leaking a kmalloc-32 object per retransmission, and nchildren is
> incremented again for the replacement.
>
> The ASSOC REQ source is always an extended address.  Look the existing
> child up by its extended address regardless of the short-address mode
> chosen for the new entry, free the replaced child, and count only
> genuinely new children.
>
> With max_associations=2, two association requests from the same peer
> exhaust all available slots and prevent another peer from associating.
> With alloc_addr=0, 300 repeated requests leak 300 kmalloc-32 objects and
> inflate nchildren; a subsequent disassociation leaves the counter
> inflated, and an interface down/up does not reset it.  Both behaviours
> were reproduced with a monitor/coordinator pair on mac802154_hwsim and
> are gone after this patch.
>
> Fixes: 601f160b61b2 ("mac802154: Handle association requests from peers")
> Signed-off-by: Lee Keon-Hyeong <leegun25@proton.me>
> ---
>  net/mac802154/scan.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index d393b1f4e..ebef22e7e 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -879,19 +879,23 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
>  		"Successful association with new child %8phC\n", &ceaddr);
>  
>  	/* Ensure this child is not already associated (might happen due to
> -	 * retransmissions), in this case drop the ex structure.
> +	 * retransmissions), in this case replace the ex structure.  The ASSOC
> +	 * REQ source is always an extended address, so look the child up by it
> +	 * regardless of the short address mode chosen for the new
>  	entry.

Did you read back this comment and thought it was in any way useful?
Please drop.

>  	 */
> -	tmp.mode = child->mode;
> +	tmp.mode = IEEE802154_EXTENDED_ADDRESSING;

This is probably fine but an orthogonal change, so a separate patch, no?

>  	tmp.extended_addr = child->extended_addr;
>  	exchild = cfg802154_device_is_child(wpan_dev, &tmp);
>  	if (exchild) {
>  		dev_dbg(&sdata->dev->dev,
>  			"Child %8phC was already known\n", &ceaddr);
>  		list_del(&exchild->node);
> +		kfree(exchild);
> +	} else {
> +		wpan_dev->nchildren++;
>  	}
>  
>  	list_add(&child->node, &wpan_dev->children);
> -	wpan_dev->nchildren++;
>  
>  unlock:
>  	mutex_unlock(&wpan_dev->association_lock);
