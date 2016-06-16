Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44775 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752605AbcFPKoT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 16 Jun 2016 06:44:19 -0400
Subject: Re: [PATCHv4 net-next 04/12] ndisc: add __ndisc_opt_addr_space
 function
References: <20160615192027.4064-1-aar@pengutronix.de>
 <20160615192027.4064-5-aar@pengutronix.de>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <797c4085-3bc2-1f62-ba9a-4582de01cec9@stressinduktion.org>
Date: Thu, 16 Jun 2016 12:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160615192027.4064-5-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

On 15.06.2016 21:20, Alexander Aring wrote:
> This patch adds __ndisc_opt_addr_space as low-level function for
> ndisc_opt_addr_space which doesn't depend on net_device parameter.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>

[note, patchworks picks up the acks automatically, you don't need to repost]

Thanks,
Hannes


