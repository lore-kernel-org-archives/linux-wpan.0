Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2A45C6EA;
	Sun, 20 Sep 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942508; cv=none; b=GGxpuN8MSNm50obz/tgBUcsOE7xAM19eVCIIA2rVdjdWfr2OlkybyvThLayZkQkb/VbLBekgUj3n51/Bi8PBcTsmI/hoOnYYuDCc4MQ7UQ0sDeo//tYQcBK4ylS1MEhdwZMoH3wZs3OMUWakRWJ3y7OgLGNYQhfp2pHjtiIo4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942508; c=relaxed/simple;
	bh=vzjbQ1Teo1NkTs6feYbq8RmQ9rTfel6wGQSP0V4fstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/T7cwVD6MDh6rgGx3BKXsU8lOVA2jbobpX5SDimOuOGhijwAtv3Np5zKfVgQzFXMHPmbb5EyAp8xYkfhvU0whF8Aiq98RvJLZVWnkwAP7QHCOoTquyNDeKZEIHwivYFFMsDqHo6UMQ7gHzoVhX0O330iW+7Nb1T/W2PrzDkUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u7brwQfz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u7brwQfz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VzcGzhVxXelUxZV/8Eai14q6xaZB4zeYzYGVKrfKLCg=; b=u7brwQfzzy6m/bd4YnsnfwNVkt
	fxMH/E+uv+8VulWPeyO0RKYI3s47d8cGn52ioLRdASLSHzF9kVSI1Rg/SpgYYkqy9NidurxCEFhWs
	Ngnvmpl4IWDfNtBnYoBysLSGWw4/kmeT6jazUn9AxOKl9B91aRezSsE/RlbvrqDbZC+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8PoP-006DN2-03; Mon, 21 Sep 2026 00:15:05 +0200
Date: Mon, 21 Sep 2026 00:15:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "i.n.a" <quiet-daffodil@proton.me>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet radio
 support
Message-ID: <a809e324-c282-4524-bf3e-95a7583c607b@lunn.ch>
References: <blQUbzijkKTlQdGuLj0o-ZJ_Their5EXvu2RW5b0q-tuU0SBmwqMjpk6HprXKRq0Yn_RHathROFMQ3T8nnPaW3nrq9lQdwIG-cF6YaFIte4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blQUbzijkKTlQdGuLj0o-ZJ_Their5EXvu2RW5b0q-tuU0SBmwqMjpk6HprXKRq0Yn_RHathROFMQ3T8nnPaW3nrq9lQdwIG-cF6YaFIte4=@proton.me>

On Sun, Sep 20, 2026 at 09:50:17PM +0000, i.n.a wrote:
> > You want to make whatever API you design vendor independent.
> 

> Thanks, that's a good point. I'll keep the API
> vendor-independent. Is there an existing kernel abstraction you'd
> suggest as a starting point?

This is not really my area, but i would look at the ieee802154 code in
the kernel. They are different technologies, but is the MAC interface
that different? Both need to pass packets to send, both need to
receive packets. There needs to be some why to select frequency, etc.

Is stacking protocols on top of the MAC that different to IEEE
802.15.4?

	Andrew
