Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbeKQOrV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Nov 2018 09:47:21 -0500
Date: Fri, 16 Nov 2018 20:32:00 -0800 (PST)
Message-Id: <20181116.203200.1638720313402188457.davem@davemloft.net>
Subject: Re: [PATCH V3 2/7] net: lorawan: Add LoRaWAN socket module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181114160126.4445-3-starnight@g.ncu.edu.tw>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
        <20181114160126.4445-3-starnight@g.ncu.edu.tw>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: starnight@g.ncu.edu.tw
Cc: afaerber@suse.de, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, marcel@holtmann.org, dollar.chen@wtmec.com, ken.yu@rakwireless.com, linux-wpan@vger.kernel.org, stefan@datenfreihafen.org

From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Thu, 15 Nov 2018 00:01:23 +0800

> +#define	lrw_get_mac_cb(skb)	((struct lrw_mac_cb *)skb->cb)

Please make this a static inline function.  If the identifier is all lowercase
programmers expect it to be real code not a CPP macro.

> +#define	LORAWAN_MODULE_NAME	"lorawan"
> +
> +#define	LRW_DBG_STR(fmt)	LORAWAN_MODULE_NAME": "fmt
> +#define	lrw_info(fmt, ...)	(pr_info(LRW_DBG_STR(fmt), ##__VA_ARGS__))
> +#define	lrw_dbg(fmt, ...)	(pr_debug(LRW_DBG_STR(fmt), ##__VA_ARGS__))

Just define "pr_fmt()" appropriately and you don't need to play these kinds
of games.

Set pr_fmt() and call pr_info() and pr_debug() directly.
