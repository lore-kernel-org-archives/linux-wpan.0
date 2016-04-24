Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45954 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcDXAOG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 23 Apr 2016 20:14:06 -0400
Date: Sat, 23 Apr 2016 20:13:59 -0400 (EDT)
Message-Id: <20160423.201359.395973791059696609.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/9] netlink: align attributes when needed
 (patchset #1)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, bsingharora@gmail.com

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 22 Apr 2016 17:31:15 +0200

> This is the continuation of the work done to align netlink attributes
> when these attributes contain some 64-bit fields.
> 
> David, if the third patch is too big (or maybe the series), I can split it.
> Just tell me what you prefer.

This looks excellent, series applied, thanks!
