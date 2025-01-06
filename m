Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F0158DD8;
	Mon,  6 Jan 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736167175; cv=none; b=Cj721qcBqQuq1c0VevDtGNerNFHa+HeNaUgQcCjksRmyAIaYI90H5rMfv+FPXpDTRRVSvPOfm8AygsmPvetZpw4jD08l7SHxCInDhUHP+fGQehXP95l27wHcFScIptHgdrrOXairPCv6UNz28wxUFQfQubXNi/CzRmDhIwXmZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736167175; c=relaxed/simple;
	bh=tzGD0pqACbmGcYthf+ZPKDGjYEgWIHP3/sZnHCbYKkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZt0QRwXK65noHbva2PSkHb2oqgXvbCEJbDHoyRX3I3+2eN8zGLCGG8yXBsWZVwvUPGT5JC/3/dJJ5JDCrsfJrDiWvwBPweW/sl/HVzDzKjeGQxGUfVk7U5B+ywNWIdWefyrxeiH/dDfWZ/PESchsM3cKA61KJ9wa37sX8O1+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DH/DdVsC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DH/DdVsC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=MZSs4WxxKTQVijRga2eJlG9YqFLSRLxeN1q+dZjSaN0=; b=DH/DdVsCsol27MP1
	pB62e4bXMTBzeNsnkpJyAhzMf3mN/PcvdrO4IeBsg40zbLqV6vssWZRqnj0wAE/zztJNHr4+V4PFG
	+eUG3OUc2LirmeKP/0be5N1cpN8LPbt7TqUQ4TOArY/m0KWmCvWwAU6BdxKlMLAYAUkoqT8SOyiSc
	a+vCLt4MxWuvH/l7vpn0JZVmJFtnAtiqQGwyBdxWjk3ehBH1lYOhWDTmk1Uu0UHTcNDWbCcKippiO
	Aj9usVd2SUJGgnjVR1NzKEO3hLEJ8I2oE9pZwz8Cyt/ox62UXKPYSA3dEQkvV3eyXMRaHe9H38xB0
	PgSyfaKGq/vShPmI1g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tUmO4-008L9D-2P;
	Mon, 06 Jan 2025 12:39:16 +0000
Date: Mon, 6 Jan 2025 12:39:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: mac802154: Remove unused
 ieee802154_mlme_tx_one
Message-ID: <Z3vO9NAThqOM1kdM@gallifrey>
References: <20241225012423.439229-1-linux@treblig.org>
 <173557391812.3760501.8550596228761441624.b4-ty@datenfreihafen.org>
 <Z3LcEIO8cRAHUUsG@gallifrey>
 <409c1c7c-dbee-4c10-acbe-4aca98ac720c@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <409c1c7c-dbee-4c10-acbe-4aca98ac720c@datenfreihafen.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:38:59 up 242 days, 23:53,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Stefan Schmidt (stefan@datenfreihafen.org) wrote:
> Hello Dave,
> 
> On 30.12.24 18:44, Dr. David Alan Gilbert wrote:
> > * Stefan Schmidt (stefan@datenfreihafen.org) wrote:
> > > Hello linux@treblig.org.
> > > 
> > > On Wed, 25 Dec 2024 01:24:23 +0000, linux@treblig.org wrote:
> > > > ieee802154_mlme_tx_one() was added in 2022 by
> > > > commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
> > > > commands") but has remained unused.
> > > > 
> > > > Remove it.
> > > > 
> > > > Note, there's still a ieee802154_mlme_tx_one_locked()
> > > > variant that is used.
> > > > 
> > > > [...]
> > > 
> > > Applied to wpan/wpan-next.git, thanks!
> > 
> > Thanks! I'd been thinking I had to wait for net-next to reopen.
> 
> It's in my wpan-next tree and I will send a pull request to net-next when it
> opens up again.

Thanks, I see it in linux-next.

Dave

> regards
> Stefan Schmidt
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
