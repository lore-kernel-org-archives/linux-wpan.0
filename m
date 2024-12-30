Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D1ACECF;
	Mon, 30 Dec 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735580706; cv=none; b=q7GJ/Poa6YMCrpO0b9dy4B/zATkc7RF8IQSaD7mYBvwk3Jn/gd9rZVaZL2l75psMHTEM3XU6zOlBpVsl2MMTlx+zVjiGxuzjfIEBqeSDKJmfzEh64uUSr3ZCTjfA2OV+fNyeZ3yuLHqKpNKnqv6s6rilNM+63q6OLySJ/q0NJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735580706; c=relaxed/simple;
	bh=nZ8yUYKWBFyZrBaTwMEzkA8yOQODSfdrlruxZ10PyeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9q4rURAu0tZQVRkxkbaXLUFx5z9MB6g6G9Iz5xsTTrkMhwavrPcga+5KIUMKFAwrsqpNy7jt/RSg9QTmuD0DTYqNUufpq+ZwnsYhZuiNmWdEJ+J8S7BCIbpltnfuSfRKPn4aateBEKvaa0ghRfl2xhhUKlawwkK234/Kx9GQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qLYhqdaL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qLYhqdaL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=dxNaadebLcYgh8ljzhaVbQ2Fy3vBArbY2oXDgs3g14A=; b=qLYhqdaLWl7kduTN
	HBBv9La91skewY+++9osuGWbXqA2zz0cHHsPK4a2nuwsv3VR60gExM36VWWTZdyiW6kOyUl+0y6jt
	UASBdJmSezpj2XholC9FMef+O1GppYZBKoLW2D4kPNsDPTsfzJIRgcdCp8/MMKTB0kqsc6p7BhOuO
	6TqOizx7IRZ7lVKf5Ohffi1LflhXG+zTvGbX+l+y/B+1H3J1hIDW84s56c5aICIcQYhabvLrzCWe7
	X1WG7ArfN/5GUBB40ckQtlJyMSgfRfBPx16FNXie9FSIw6m5HFJ8g82v8ptA8f1ZOGmqysCqr8o72
	tTcT/bhM8GyDhvi8wQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tSJou-007ebC-0q;
	Mon, 30 Dec 2024 17:44:48 +0000
Date: Mon, 30 Dec 2024 17:44:48 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: mac802154: Remove unused
 ieee802154_mlme_tx_one
Message-ID: <Z3LcEIO8cRAHUUsG@gallifrey>
References: <20241225012423.439229-1-linux@treblig.org>
 <173557391812.3760501.8550596228761441624.b4-ty@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <173557391812.3760501.8550596228761441624.b4-ty@datenfreihafen.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:44:18 up 236 days,  4:58,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Stefan Schmidt (stefan@datenfreihafen.org) wrote:
> Hello linux@treblig.org.
> 
> On Wed, 25 Dec 2024 01:24:23 +0000, linux@treblig.org wrote:
> > ieee802154_mlme_tx_one() was added in 2022 by
> > commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
> > commands") but has remained unused.
> > 
> > Remove it.
> > 
> > Note, there's still a ieee802154_mlme_tx_one_locked()
> > variant that is used.
> > 
> > [...]
> 
> Applied to wpan/wpan-next.git, thanks!

Thanks! I'd been thinking I had to wait for net-next to reopen.

Dave

> [1/1] net: mac802154: Remove unused ieee802154_mlme_tx_one
>       https://git.kernel.org/wpan/wpan-next/c/bddfe23be8f8
> 
> regards,
> Stefan Schmidt
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
