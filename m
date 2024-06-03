Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91513D27C;
	Mon,  3 Jun 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458945; cv=none; b=ZK+we3iWSOlswZQeBWEzHyg3SWi0B7d3gXkUygEAkoUdMeZ3AecqXWLON+z9iLHqmPgpWMPIJq6Yv/H9kxpXII8O/uPcRgEJPm7ByWNccg7s3CGEWQEsk5DpmPUWeKQvaZ0WL0a568C4ay7IhObprFZjcm+OOiyhoQDeRyKRzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458945; c=relaxed/simple;
	bh=49k/N76rSkVbMyCGLrPhdc2JjNR5PlQ62XZdNfocVbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9mr/AZVYiIh9uDc1tc+LvRFKTuouiEIASQGq/N+7HLEor/CJ0HGv21AgD+L11b2F+KVSCPdUVUxiGfgCfVVvi6MHX47kl++v1yNhnROM6BLhRi3CqnvHqa90lx3DNTGo8wnSGi3dWld5OCj6WpkjIobGiaOF/NssH3PFNujN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlRi+oWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlRi+oWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81023C4AF08;
	Mon,  3 Jun 2024 23:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717458944;
	bh=49k/N76rSkVbMyCGLrPhdc2JjNR5PlQ62XZdNfocVbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WlRi+oWmLYzBZTR6yAynA1gYroOpWQjYROAm3XdTW6F7sdZE+3zLn0NXGq+dP3tqg
	 jhADpCe+kTJgFJVxKpk8qQqlVLcxqYFhrNYn0PjaefenZtiggA9AFqW3Lp3Q3UYM/y
	 dQ8ao6cnwSympOJ2LS5FctYKLXPGlUNLcFeunQgB3ysZ2w5j4PhjPny3jHo/0x4NLW
	 ZphXB3cIEfn/6vYUc9BM1c6NR093v4Xuq0dvs2oqhku2u9RMhpojrqO9tSqAu8KXzy
	 KxmjHx1nhpFglnFenNc3jSQCp2MtBOUWG6dFd902ktdrnhCLg6v/m2tFjiu6yUXDgp
	 WSPxjnBLZVPew==
Date: Mon, 3 Jun 2024 16:55:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Yunshui Jiang <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
Message-ID: <20240603165543.46c7d3b4@kernel.org>
In-Reply-To: <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org>
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
	<41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 11:33:28 +0200 Stefan Schmidt wrote:
> Hello.
> 
> On 31.05.24 10:07, Yunshui Jiang wrote:
> > mac802154 devices update their dev->stats fields locklessly. Therefore
> > these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC()
> > and DEV_STATS_ADD() to achieve this.
> > 
> > Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> > ---
> >   net/mac802154/tx.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > index 2a6f1ed763c9..6fbed5bb5c3e 100644
> > --- a/net/mac802154/tx.c
> > +++ b/net/mac802154/tx.c
> > @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
> >   	if (res)
> >   		goto err_tx;
> >   
> > -	dev->stats.tx_packets++;
> > -	dev->stats.tx_bytes += skb->len;
> > +	DEV_STATS_INC(dev, tx_packets);
> > +	DEV_STATS_ADD(dev, tx_bytes, skb->len);
> >   
> >   	ieee802154_xmit_complete(&local->hw, skb, false);
> >   
> > @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
> >   		if (ret)
> >   			goto err_wake_netif_queue;
> >   
> > -		dev->stats.tx_packets++;
> > -		dev->stats.tx_bytes += len;
> > +		DEV_STATS_INC(dev, tx_packets);
> > +		DEV_STATS_ADD(dev, tx_bytes, len);
> >   	} else {
> >   		local->tx_skb = skb;
> >   		queue_work(local->workqueue, &local->sync_tx_work);  
> 
> This patch has been applied to the wpan tree and will be
> part of the next pull request to net. Thanks!

Hi! I haven't looked in detail, but FWIW

$ git grep LLTX net/mac802154/
$

and similar patch from this author has been rejected:

https://lore.kernel.org/all/CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWUUYFYjM1Uw@mail.gmail.com/
