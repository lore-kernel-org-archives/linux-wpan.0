Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34321 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbcD0PuI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2016 11:50:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id v200so28912727wmv.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 Apr 2016 08:50:07 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] taskstats: fix nl parsing in
 accounting/getdelays.c
References: <5720DED8.4090706@6wind.com>
 <1461772077-3216-1-git-send-email-nicolas.dichtel@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5720DFA1.3080503@6wind.com>
Date: Wed, 27 Apr 2016 17:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <1461772077-3216-1-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: bsingharora@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au

Le 27/04/2016 17:47, Nicolas Dichtel a écrit :
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
Please, drop this version. I fatfingered my rebase.
