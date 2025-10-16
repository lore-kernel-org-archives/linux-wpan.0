Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0B334380;
	Thu, 16 Oct 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619237; cv=none; b=Zf1BZoJPo59oxEougx5Ww9VPc4Ybk/ZJWrYcbrfMpr7TfO3zlPNu3xyAWMQACMzOTckcxhGg7h3lVvytcA0VMOrOXQmGVR86m9IB5kJzlckXwrxc975X06wk7AGbatWrTUZp7k+MTno36zKgzG7Wo9gEHyvWAQh8hPu0iK3ubAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619237; c=relaxed/simple;
	bh=2jg4Av+zM7tjDY5Z5S63NnnEZORlkA02wuvFoD/B2pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh9SRSddqZOdJ2qg7mKiP2+cj0UjIpPHbxmRRypYz5KQQDLStMFk97ktEylo5kMy+0wFguoYPPY6NKzYgYBILodtnCtP+vapRf0+nZ4nJs0cpOQzC0MQ6bC4tcofN1sIFR3YgNggLQyS2TVOeP92BOz1C+4xVky/iBdQU0kU2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6X3R08q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6X3R08q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC13C4CEF1;
	Thu, 16 Oct 2025 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619237;
	bh=2jg4Av+zM7tjDY5Z5S63NnnEZORlkA02wuvFoD/B2pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6X3R08q28qXx/1Nd+oOpcO9AQZ3bc4cBO8iLWxP1QRpWvSHYmdrXXBjim3cMlPAZ
	 0La41EQ5ANylxrlxlZ5RRpzr8gIy6/pQm6XaD0WfE1PnevOnxHHVvyL4C5gt1OYpzZ
	 dgH1Q+H5Wba7DFHNx4vXox8Csq5AZ/ly5EKnqwnzbvw9vQLk8f3Copc28Dgr+4dpMi
	 +aSN6pB3UU6IdwoFqn8HP/AfjkhBtjn3M023hTHD5i2qHW23y5EFd2xQjACLDNijH6
	 lK+Io7R0Y/uur7Unl7VDGGb7jiVzb91EFZ9uS7h2C1GQqSip7M2y1TQk0W6n3herOW
	 Za4/QZ/xQJVww==
Date: Thu, 16 Oct 2025 13:53:52 +0100
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] nl802154: fix some kernel-doc warnings
Message-ID: <aPDq4BJnxji5mTxc@horms.kernel.org>
References: <20251016035917.1148012-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016035917.1148012-1-rdunlap@infradead.org>

Thanks Randy,

On Wed, Oct 15, 2025 at 08:59:17PM -0700, Randy Dunlap wrote:
> Correct multiple kernel-doc warnings in nl802154.h:
> 
> - Fix a typo on one enum name to avoid a kernel-doc warning.
> - Drop 2 enum descriptions that are no longer needed.

According to my brief dig into git history,
it seems those were added but never used.

> - Mark 2 internal enums as "private:" so that kernel-doc is not needed
>   for them.
> 
> Warning: nl802154.h:239 Enum value 'NL802154_CAP_ATTR_MAX_MAXBE' not described in enum 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL' description in 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL' description in 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:369 Enum value '__NL802154_CCA_OPT_ATTR_AFTER_LAST' not described in enum 'nl802154_cca_opts'
> Warning: nl802154.h:369 Enum value 'NL802154_CCA_OPT_ATTR_MAX' not described in enum 'nl802154_cca_opts'

I do still see:
Warning: include/net/nl802154.h:237 Enum value 'NL802154_CAP_ATTR_CCA_ED_LEVELS' not described in enum 'nl802154_wpan_phy_capability_attr'

And that enum does seem to be used. So it would be nice to address this
by documenting it. But I think that can be left as a separate task.

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>

