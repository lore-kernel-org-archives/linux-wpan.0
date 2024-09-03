Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FE1CC8BA;
	Tue,  3 Sep 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390039; cv=none; b=I+esr+w4YkYj6GilvzXLrGazKQf1QvxkaaghVCXHQ4F//fThSRJ48JqGD+3Rr3mGTrca2Vr3ulnWw+asxs+4odzrJradd+pXh4j2vQUMNsGI+feWtkdoQSEnH7qawNQTIN7mfwyk1pzHGYYroMf5+copBmgfomFakqkXzvuXZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390039; c=relaxed/simple;
	bh=+Lt56Uk6FYMW9PVWHGuZjqRvAMZmTAgKqQWZA3zUEik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uibikVyr+SN16IiZfQJc0iZGl5dP2fwr5eP/iDDoJv9cuVHSUWOMfl6KD6Mo4Ekuxu4yTRHLIdHVf7OQ0Pe65Gsg0CONIdSw+Ti9nlBz9J7gE+4HGfUy7aareMjjv4leDQAE6stmKNhQsem5yWunVdZBYWqcXwOXEUBhJIFGJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip1p4Gdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip1p4Gdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A455EC4CECA;
	Tue,  3 Sep 2024 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390039;
	bh=+Lt56Uk6FYMW9PVWHGuZjqRvAMZmTAgKqQWZA3zUEik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip1p4Gdp5U9+ip/8Wb7+sno+pxsOCIW/6prvbAZZkr/le9gsb8g/WkqrX+b9GnHYW
	 obeh+Cp4LHvl665TdJ3u6vHznuwL8Xwd6usXYgOTQgFnsKeaTPQvf1ENPAHQf6inDp
	 4nfQq3534FHcq+03J1IB6OO2Eaf7S/UV7CuebNCR1quyiA/kMdwzG5ruNTGfwGolt3
	 +1WNgE1DKc4BD3QBB69KUeM+tu1nHNLThfoZCvvE9k5DFzTtn9U+sr51lyjzQrYI5S
	 F1TTHAeATDUf9acRS9u/SFmwezcoXGOuptJyZJYwscwdPKODExmzHwsBkVWynltmSU
	 TV1dx/Zhpsy9Q==
Date: Tue, 3 Sep 2024 12:00:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2024-09-01
Message-ID: <20240903120037.66998934@kernel.org>
In-Reply-To: <750caf49-c4e0-43f7-a89f-5b9af96fc0f9@datenfreihafen.org>
References: <20240901184213.2303047-1-stefan@datenfreihafen.org>
	<20240903114257.7b906da2@kernel.org>
	<750caf49-c4e0-43f7-a89f-5b9af96fc0f9@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 20:52:03 +0200 Stefan Schmidt wrote:
> On 9/3/24 8:42 PM, Jakub Kicinski wrote:
> > On Sun,  1 Sep 2024 20:42:13 +0200 Stefan Schmidt wrote:  
> >> Simon Horman catched two typos in our headers. No functional change.  
> > 
> > Is it okay if we merge these into net-next ?
> > On one hand they are unlikely^w guaranteed not to introduce
> > regressions, but on the other such trivial spelling fixes are
> > not at all urgent.  
> 
> Sure, no problem. They just landed in my fixes queue and thus wpan. They 
> can easily go through net-next. Can you merge the pull directly or do 
> need a new one against net-next?

I'll pull this one, thanks!
