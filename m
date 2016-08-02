Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36864 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966150AbcHBPAr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Aug 2016 11:00:47 -0400
Subject: Re: [PATCH linux-wpan/radvd for-upstream 2/2] device-linux: get
 address length via sysfs
References: <20160802143752.12831-1-aar@pengutronix.de>
 <20160802143752.12831-3-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <daec056f-fcd7-228f-6097-eff7d7137af7@pengutronix.de>
Date: Tue, 2 Aug 2016 16:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <20160802143752.12831-3-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org


Hi,

On 08/02/2016 04:37 PM, Alexander Aring wrote:
> This patch will change the behaviour for 6LoWPAN interface to detect the
> linklayer address length via sysfs. The usually way to get the address
> length is via a mapping from ARPHRD device type. This doesn't work for
> 6LoWPAN interfaces, we need at least some other mechanism. This patch
> adds the mechanism to read out the sysfs UAPI to get the addr_len
> attribute of net_device. This will not work if there are two 6LoWPAN
> link-layer types with the same address length but need different
> handling in userspace. For that reason I think a linklayer type would be
> better, this requires a 6lowpan netlink API which doesn't exist right
> now. So we use this simple way now.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

I need to remove this signed off. That's not radvd commit style. :-)

---

After talking shortly with Marcel, RTNL netlink has already the same
stuff what we can get from sysfs entry here. See [0] kernel and [1]
userspace.

Over RTA_PAYLOAD(tb[IFLA_ADDRESS]) [1], we should be able to get the
dev->addr_len which is given by [0]... I make now a new version with
netlink as UAPI mechanism.

- Alex

[0] http://lxr.free-electrons.com/source/net/core/rtnetlink.c#L1247
[1] https://github.com/shemminger/iproute2/blob/master/lib/ll_map.c#L84
