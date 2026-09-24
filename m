Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52433263F;
	Thu, 24 Sep 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213566; cv=none; b=vCwT9R0OobmGeFW96aAldIIS0k6L9CYXZJ5JQE+NcQfLnSA0ZwjkPDIDLK0buK/i9BIXpcrDdRubj7wf7Eg41ICp5a4vWk7U9GteCxYVevf9/s9/DfNQpeVjowlJu8+VYQoT6wNjea3N+g3LOiK+RbUyYMoXdK1TrE8o/or8h9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213566; c=relaxed/simple;
	bh=MAT8iFdafPU0Irc7euRwQojGzKyMgWAAaN7mYSnOja4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Okq3VnZ8gDDocVMIJv0RRqU1uC5dEqkD+ivDwxtWsrdAQZSFbTdeSEraCp/CIJt2vay+kzQ/b4tZbd8A23+It3YxiNp266NYGN0wCGHFHh/wuTt/2BKY7WZ9UFJnINYfg0wUAXJadCfLvK4acQZjz+QfQ125Jbcwp+S1dj+L3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSqfjhDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSqfjhDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8FE1F000FF;
	Thu, 24 Sep 2026 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213563;
	bh=LGKl+hZ70U+oKqNHKuDiyRBsAwAJk2zQyLpbxnFcNPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GSqfjhDFeefaoyNbe1PECTbLwtzn4hgZ4AIOf2/JazwJP3dHPp0Y/jjofGasL3RZm
	 fevxLywP5orFsBncNb9T34tr8mQ3sW8Iu1f5283iKakEyP4mVe9tyeoMbJx78NhzvE
	 2Agq/7OIh0drsHxIFG0U4s9VawffSCseaJprpdwJKzwp22Ia6UMcnPg5Qmx2Ac/1li
	 umI+bCw43swOGMnkfAjNNNl6HrAziaeqYFvkhC7sJHlFVCHx8HHiqK7Q7dm0I/Zu4U
	 K7yyc98mGOQJNH/O8h0EARJs/pkf4FTLus/tuY6E9IxR/fo5hAj69RVTI4A4pOcn74
	 xbfCpotLT6QqA==
Date: Wed, 23 Sep 2026 18:32:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "i.n.a" <quiet-daffodil@proton.me>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-wpan@vger.kernel.org"
 <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet
 radio support
Message-ID: <20260923183242.1ea56c5d@kernel.org>
In-Reply-To: <4vyyH7e6jQ1f1QSNRo16qvvSXxieE4qNs02suWZW-hC6P5pzxq8wmywfogCLRsj-_oucoBZRFxccllsuEPFGqkqTz9TF1h52zWaViQqzDkE=@proton.me>
References: <4vyyH7e6jQ1f1QSNRo16qvvSXxieE4qNs02suWZW-hC6P5pzxq8wmywfogCLRsj-_oucoBZRFxccllsuEPFGqkqTz9TF1h52zWaViQqzDkE=@proton.me>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 23:06:39 +0000 i.n.a wrote:
> >Is stacking protocols on top of the MAC that different to IEEE  
> 802.15.4?
> 
> Had a look through `mac802154` and `ieee802154_ops`, the hardware boundary does look quite similar, particularly packet TX/RX, start/stop, TX power and energy detection.
> 
> The main differences seem to be the 802.15.4-specific parts such as channel/page addressing, CSMA parameters and address filtering, versus PHY-specific configuration for LoRa/GFSK.
> 
> Would it make sense to investigate factoring out a small generic packet-radio layer beneath the MAC-specific interfaces?

Not an expert, but IMO, you'll need to take it up with ieee802154
maintainers. If they are not interested in broadening the support
I'd say keeping the code in user space seems perfectly fine.
