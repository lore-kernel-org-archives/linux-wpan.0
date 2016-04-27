Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33591 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbcD0BPD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Apr 2016 21:15:03 -0400
Subject: Re: [PATCH net-next 9/9] taskstats: use the libnl API to align nlattr
 on 64-bit
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
 <1461339084-3849-10-git-send-email-nicolas.dichtel@6wind.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57201287.80002@gmail.com>
Date: Wed, 27 Apr 2016 11:14:47 +1000
MIME-Version: 1.0
In-Reply-To: <1461339084-3849-10-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au



On 23/04/16 01:31, Nicolas Dichtel wrote:
> Goal of this patch is to use the new libnl API to align netlink attribute
> when needed.
> The layout of the netlink message will be a bit different after the patch,
> because the padattr (TASKSTATS_TYPE_STATS) will be inside the nested
> attribute instead of before it.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

The layout will change/break user space -- I've not tested the patch though..

Balbir Singh.
 
