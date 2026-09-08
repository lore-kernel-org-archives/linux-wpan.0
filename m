Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBA59D62A;
	Tue,  8 Sep 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891641; cv=none; b=hMhtoxbioIdn4LF8WURZQ4RqG4aUTeTAjv2LezagNA7Ri4NqNz/lPxU4tP4HOsIvHwHWpy//wZ4lRdB/zjddBWRv4+STO/U4i0bTRd4YSr9Di/Bm5cL+d9P/hRFE2yjQecz4jJhVx9qkqsslULnLCiiY71/87i2TD3ENdiXRWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891641; c=relaxed/simple;
	bh=ZWiWggbLEYBm7FYdXhcnWhd9JR15c10PPQIg4x0OcBc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhQvNKFg8wn/6XSIGlYLVaf5i1XB8HMK72sbtPnCzqtrFVPkvcYeAU+w4Kd4m4aaPkZVDxWlI9q6zz8XWdlLnf6M54vxG4gB6DaRSCGRLDVdJ9qNaQ7E+7cYCmVGOagtM3sI9nd2Rc1svK8NtIb9lBfy+/p9Tu4R5krEh4j7K30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIIW0hle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIIW0hle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A51F00A3D;
	Tue,  8 Sep 2026 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891639;
	bh=vAyrEe0SvPGBNwulJ3WT3DJEUQWS7nX8/HwvNsUh5X8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SIIW0hle6+hFmLt84RXW5jKghIXIYtwUXZuY/ElVpFgm+pwSmj/znWdbmJtJVTxc9
	 J1JYwSMc986M5/b9tgL9nPOUOwHS0RU01V0On2grpBjou0ZT1fKyie0Wgi9LMMSJR+
	 WlW3KwCYuApuGAXej1SPLSBEWvBtnaKFdeAHgANLXawRZPtSnFFO+1ZwRWVRd8L7+9
	 Eg1J6uxzU2qGV2dkE7m4SdM+o8UTqyP2Gyl35deCofBusbMp+klBxH459lyqzF2m6T
	 z+GrkT7tfB+Li48XpdyjmhwQ/TFTiCT/ALYGoyYSi8ZTPB5GFBdyK4Lj3owcFAEu5r
	 ycKIXQuniLFfg==
Subject: Re: [PATCH 2/2] ieee802154: warn on unspecific wpan interface type
From: netdev-bot+sashiko@kernel.org
To: adrianox@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 18:20:38 +0000
Message-ID: <178889163868.219967.6937684996365515536@kernel.org>
In-Reply-To: <20260905212007.304875-2-adrianox@gmail.com>
References: <20260905212007.304875-2-adrianox@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The added WARN_ON fails to detect uninitialized iftypes
  because wpan_dev->iftype zero-initializes to NL802154_IFTYPE_NODE (0),…

--

> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -297,7 +297,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
>  
>  	rdev = wpan_phy_to_rdev(wpan_dev->wpan_phy);
>  
> -	/* TODO WARN_ON unspec type */
> +	WARN_ON(wpan_dev->iftype == NL802154_IFTYPE_UNSPEC);
>  
>  	switch (state) {
>  	case NETDEV_POST_INIT:

[Severity: Medium]
This check cannot fire for the case the commit message says it is
meant to catch. In enum nl802154_iftype (include/uapi/linux/nl802154.h)
NL802154_IFTYPE_UNSPEC is ~(__u32)0 while NL802154_IFTYPE_NODE is 0, so
a wpan_dev whose iftype was never assigned - the struct lives in the
zeroed netdev private area handed out by alloc_netdev(), and
ieee802154_setup_sdata() is the only place that writes it - reads back
as NL802154_IFTYPE_NODE, not UNSPEC. The WARN_ON in
cfg802154_netdev_notifier_call() therefore only triggers if some caller
explicitly stores UNSPEC (or -1, given wpan_dev->iftype is a plain int
and the comparison promotes it to unsigned), which no in-tree code does.
As written this is dead code rather than the assertion described.

Note this is unlike cfg80211, where NL80211_IFTYPE_UNSPECIFIED is 0 and
the same test does catch a zeroed field, so the pattern does not carry
over directly.

How do you want to handle this? Either the sanity check needs to be
expressed in terms of a value that an uninitialized wpan_dev actually
holds, or ieee802154_setup_sdata() and the other wpan_dev producers
need to start out at NL802154_IFTYPE_UNSPEC so the warning has
something to detect. Please also say whether you actually observed the
condition, or whether this is intended purely as a future-proofing
assertion.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905212007.304875-1-adrianox%40gmail.com
