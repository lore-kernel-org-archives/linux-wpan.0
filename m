Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42659 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbA2WUm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Jan 2015 17:20:42 -0500
Date: Thu, 29 Jan 2015 14:20:41 -0800 (PST)
Message-Id: <20150129.142041.1936369659257898527.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with
 IFLA_NET_NS_[PID|FD]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org, dmitry.tarnyagin@lockless.no, arvid.brodin@alten.se, alex.aring@gmail.com, linux-wpan@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Mon, 26 Jan 2015 22:28:12 +0100

> When one of these attributes is set, the netdevice is created into the netns
> pointed by IFLA_NET_NS_[PID|FD] (see the call to rtnl_create_link() in
> rtnl_newlink()). Let's call this netns the dest_net. After this creation, if the
> newlink handler exists, it is called with a netns argument that points to the
> netns where the netlink message has been received (called src_net in the code)
> which is the link netns.
> Hence, with one of these attributes, it's possible to create a x-netns
> netdevice.

Series applied, thanks.
