Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51465 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcD0Q4o (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2016 12:56:44 -0400
Date: Wed, 27 Apr 2016 12:56:41 -0400 (EDT)
Message-Id: <20160427.125641.2051987150702050549.davem@davemloft.net>
Subject: Re: [PATCH net-next v2] taskstats: fix nl parsing in
 accounting/getdelays.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <1461772388-3763-1-git-send-email-nicolas.dichtel@6wind.com>
References: <5720DFA1.3080503@6wind.com>
	<1461772388-3763-1-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com
Cc: bsingharora@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 27 Apr 2016 17:53:08 +0200

> The type TASKSTATS_TYPE_NULL should always be ignored.
> 
> When jumping to the next attribute, only the length of the current
> attribute should be added, not the length of all nested attributes.
> This last bug was not visible before commit 80df554275c2, because the
> kernel didn't put more than two nested attributes.
> 
> Fixes: a3baf649ca9c ("[PATCH] per-task-delay-accounting: documentation")
> Fixes: 80df554275c2 ("taskstats: use the libnl API to align nlattr on 64-bit")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Applied, thanks.
