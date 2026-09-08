Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823D59D61F;
	Tue,  8 Sep 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891639; cv=none; b=Uvt4LQsh4p0lAZz7MkmoipyWoTdOTH/YmX8vplS+yHKNoyEwoyUv24Ws3PdTIVMfJfmaegv6/syWBSZUyq03xgJ7s+1Ik8YgiHCZR2hwpsQ93j3GT1y95HxQldRn7zpHQ+Zcnf3BSSGyftLt2UWkpINKUD1EREeuVr7+1Ud0Zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891639; c=relaxed/simple;
	bh=BFI5caB6ERVBcSiLhlW766huNtLaUxnIRkAkZWxkjFk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fB9bUKjVAiyMHfT4TqJsyFio9LJLHdRIzCWrYU+OS7QK2jQ3T1DgDvy68n5jv6Xe7zFTdCOIw6p9OacO3rIj1i0GMRWp1gNHPI9cxmy6b+tpaE4rQnA/Uzg7qwHXwPIQYD/xD2hAgCVILGX2giGHJsQSI8RXqQ+ntC6zmt1klu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSiMqoZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSiMqoZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4B11F00A3A;
	Tue,  8 Sep 2026 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891638;
	bh=QOwwJhACw69omnvZR/W13CeKCMFQ80Z4kKgnTmOEJKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SSiMqoZNK7Z+un7EEgGWUk/oV9nbX35iUVpuHGrZiHe7OUxOUeOzDA1zic82znT31
	 NFPuZFcaWAYKxPfYWwrUUyiBn+qiHYP2DIFwQMRh0zLELb2zTlmomjRCvUABiNUOrq
	 pfy3wJSOVQA2y+raUYL3QUFoL9QNlkZCc7GAGk5HzBmV04uy/lBobIaqqFSYsSVJ1M
	 GgnFJrgdCpPx4migrcFeHidF9glrUURKhlP4R9ClyIR4FBmdX9UXdNd2QwJHScXiqJ
	 pBpyLhJ6bn/XGsCVvSE4QG8Pq5g/DKJi7nNmHJZPh2ZXU78nRx8tfwwSNucfFUHvdH
	 LjtxLf6MAa3EA==
Subject:
 Re: [PATCH 1/2] ieee802154: register a device type for the wpan netdev
From: netdev-bot+sashiko@kernel.org
To: adrianox@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 18:20:37 +0000
Message-ID: <178889163770.219967.16467487407776248344@kernel.org>
In-Reply-To: <20260905212007.304875-1-adrianox@gmail.com>
References: <20260905212007.304875-1-adrianox@gmail.com>
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

- [Medium] Commit message mischaracterizes both the pre-patch state and
  the effect of the change in net/ieee802154/core.c.

--

ieee802154: register a device type for the wpan netdev

This adds a wpan_dev_type with only a .name field and assigns it from a
new NETDEV_POST_INIT case in cfg802154_netdev_notifier_call(), replacing
the "TODO NETDEV_DEVTYPE" comment.  It mirrors what cfg80211 does with
wiphy_type in cfg80211_netdev_notifier_call().

> ieee802154: register a device type for the wpan netdev
>
>     The cfg802154 netdev notifier never sets a device type, so wpan
>     interfaces lack a sysfs "type". Mirror cfg80211 by calling
>     SET_NETDEV_DEVTYPE() in a NETDEV_POST_INIT case with a new
>     wpan_dev_type.

[Severity: Medium]
Is the statement "wpan interfaces lack a sysfs 'type'" accurate?  Every
netdev already gets a type file unconditionally from net/core/net-sysfs.c:

    NETDEVICE_SHOW_RO(type, fmt_dec);
    ...
    static struct attribute *net_class_attrs[] __ro_after_init = {
            ...
            &dev_attr_type.attr,

That attribute shows struct net_device::type, which for wpan interfaces is
already 804 (ARPHRD_IEEE802154), so /sys/class/net/<if>/type exists before
this patch.

The macro used here touches a different field:

    #define SET_NETDEV_DEVTYPE(net, devtype)        ((net)->dev.type = (devtype))

and a struct device_type carrying only .name creates no sysfs attribute
file at all.  The one observable effect is in dev_uevent() in
drivers/base/core.c:

    if (dev->type && dev->type->name)
            add_uevent_var(env, "DEVTYPE=%s", dev->type->name);

So the change adds a DEVTYPE=wpan key to the netdev uevent environment
(also visible in /sys/class/net/<if>/uevent), which is what the cfg80211
precedent does with .name = "wlan".

Could the changelog be reworded to describe that effect instead, and also
mention that this is a new userspace-visible uevent key?  udev and
systemd-networkd rules that match on Type= will now see wpan for
interfaces that previously exported no DEVTYPE.

The code change itself looks fine and consistent with
cfg80211_netdev_notifier_call().

> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index c0b8712018a16..c6213412d2914 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -272,6 +272,10 @@ void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
>  	kfree(rdev);
>  }
>  
> +static const struct device_type wpan_dev_type = {
> +	.name	= "wpan",
> +};
> +
>  static void
>  cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
>  			   int iftype, int num)
> @@ -296,7 +300,9 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
>  	/* TODO WARN_ON unspec type */
>  
>  	switch (state) {
> -		/* TODO NETDEV_DEVTYPE */
> +	case NETDEV_POST_INIT:
> +		SET_NETDEV_DEVTYPE(dev, &wpan_dev_type);
> +		break;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905212007.304875-1-adrianox%40gmail.com
