Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbeKFDhE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Nov 2018 22:37:04 -0500
Date: Mon, 05 Nov 2018 10:16:10 -0800 (PST)
Message-Id: <20181105.101610.1437737564548154497.davem@davemloft.net>
Subject: Re: [PATCH V2 2/7] net: lorawan: Add LoRaWAN socket module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181105165544.5215-3-starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
        <20181105165544.5215-3-starnight@g.ncu.edu.tw>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: starnight@g.ncu.edu.tw
Cc: afaerber@suse.de, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, marcel@holtmann.org, dollar.chen@wtmec.com, ken.yu@rakwireless.com, linux-wpan@vger.kernel.org, stefan@datenfreihafen.org

From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue,  6 Nov 2018 00:55:40 +0800

> +static inline struct lrw_mac_cb * mac_cb(struct sk_buff *skb)

"mac_cb()" is pretty generic for a name, and leads to namespace pollution,
please use lrw_mac_cb() or similar.

> +static inline struct dgram_sock *
> +dgram_sk(const struct sock *sk)
> +{
> +	return container_of(sk, struct dgram_sock, sk);
> +}
> +
> +static inline struct net_device *
> +lrw_get_dev_by_addr(struct net *net, u32 devaddr)

Never use inline for functions in a foo.c file, let the compiler decide.

> +{
> +	struct net_device *ndev = NULL;
> +	__be32 be_addr = cpu_to_be32(devaddr);

Always order local variables from longest to shortest line.

> +static int
> +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> +	      int noblock, int flags, int *addr_len)
> +{
> +	struct sk_buff *skb;
> +	size_t copied = 0;
> +	DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name);
> +	int err;

Likewise.

I'm not going to point out every single place where you have made these
two errors.

Please audit your entire submission and fix the problems wherever they
occur.

Thank you.
