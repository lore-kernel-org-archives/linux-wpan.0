Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FE16EB7C;
	Sat,  7 Jun 2025 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749324176; cv=none; b=ZXbdRP0BAJQGgw6IcoUkGKUVu4BC3NHahszI0FhyU4w70l0T+oi8wjnqu3//7OEWyz9/N1F1asXdf0oF6+1MwUW8cGMHO4lxvuAaTUY7GA7ITE1eiynYw3izYuZEjZ8wdIiTGXUi5YzXFJXDAabm26Jhzf6SqVqo2VjjjnCqkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749324176; c=relaxed/simple;
	bh=jAHX8JlYY9wEKzKY1/TIRq/xdUTNzUyMgkRwaThqIao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsLNkHWPNc9nHljgxZK1t8u7T720iK55NQBsdiYzqxR0QdBovLa8HNzbD/t4RMSdNKSvsixGj0l/8goicoIIIayzGiafcGgrbcbsWYLFgooomeW/E882Nf5yKqeJzqp6MwnwMp+dTIsMh2ub7lRBPp3uLGpCZgpjAbdpSlhlMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zd8oTB+W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zd8oTB+W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ExGLk8TuqU9NHPrRY4aFfUExSdhG9RfeulxPf7eReo0=; b=Zd8oTB+W5GK6sJeZ6ZTd3DBJfT
	iXaPevCogHmeNJPmQR97WybE21w/S4C/lymzUtAXaBAzFa6Gd0Xq0j5R2jMIlEHD8wKW5Lr+Bl5Gh
	cDxmxgbJImnJKti3FaEuT3DDsnq8iWZayo16xLx6xnq4VujYarwlI8vMbdarom15XjJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNz7r-00F2sj-Ir; Sat, 07 Jun 2025 21:22:43 +0200
Date: Sat, 7 Jun 2025 21:22:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: Alexander Aring <aahringo@redhat.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
	alex.aring@gmail.com, miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
Message-ID: <54980160-6e46-4ac4-b87f-41b7dccba1d3@lunn.ch>
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
 <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
 <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com>

On Sat, Jun 07, 2025 at 02:54:57PM -0300, Ramon Fontes wrote:
> > handle as unsigned then this check would not be necessary?
> 
> Yeah, it does make sense. However, I have a bit of an embarrassing
> question. How do I submit an updated patch in this same thread?

You don't. You should submit a new patchset, as a new thread.

The CI tooling works on one patchset per thread, and if you deviate
from that, the CI won't test it. And if it is not tested, it is pretty
much an automatic reject.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

It is also the merge windows right now, so anything you post will get
rejected anyway, so please post as RFC.

	Andrew
