Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46741 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754830AbcEBTGc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 May 2016 15:06:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6BDBE20C2B
	for <linux-wpan@vger.kernel.org>; Mon,  2 May 2016 15:06:31 -0400 (EDT)
Subject: Re: [PATCHv2 bluetooth-next 02/10] 6lowpan: add 802.15.4 short addr
 slaac
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-3-git-send-email-aar@pengutronix.de>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <0924d341-f27b-227a-a07d-19b272fad6fa@stressinduktion.org>
Date: Mon, 2 May 2016 21:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <1461140382-4784-3-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

On 20.04.2016 10:19, Alexander Aring wrote:
> This patch adds the autoconfiguration if a valid 802.15.4 short address
> is available for 802.15.4 6LoWPAN interfaces.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>

Thanks,
Hannes

