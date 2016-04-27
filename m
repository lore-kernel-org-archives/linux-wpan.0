Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51116 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbcD0QlT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2016 12:41:19 -0400
Date: Wed, 27 Apr 2016 12:41:15 -0400 (EDT)
Message-Id: <20160427.124115.463605194182852802.davem@davemloft.net>
Subject: Re: [PATCH net-next 9/9] taskstats: use the libnl API to align
 nlattr on 64-bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <5720B0A2.1030405@gmail.com>
References: <57201287.80002@gmail.com>
	<57206A47.2010906@6wind.com>
	<5720B0A2.1030405@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: bsingharora@gmail.com
Cc: nicolas.dichtel@6wind.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au

From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 27 Apr 2016 22:29:22 +1000

> My concern is ABI breakage of user space.

The "ABI" is that unrecognized attributes must be silently ignored by
userspace.
