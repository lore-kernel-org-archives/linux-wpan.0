Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37996 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752605AbcFPKo7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 16 Jun 2016 06:44:59 -0400
Subject: Re: [PATCHv4 net-next 06/12] ndisc: add __ndisc_fill_addr_option
 function
References: <20160615192027.4064-1-aar@pengutronix.de>
 <20160615192027.4064-7-aar@pengutronix.de>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <acceee9f-b1bf-8ac4-425f-b53f67651c75@stressinduktion.org>
Date: Thu, 16 Jun 2016 12:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20160615192027.4064-7-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

On 15.06.2016 21:20, Alexander Aring wrote:
> This patch adds __ndisc_fill_addr_option as low-level function for
> ndisc_fill_addr_option which doesn't depend on net_device parameter.
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


