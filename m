Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52250 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbaHGTFN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Aug 2014 15:05:13 -0400
Date: Thu, 07 Aug 2014 12:05:12 -0700 (PDT)
Message-Id: <20140807.120512.1190683458101132981.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
References: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH] 6lowpan: Allow 6LoWPAN to be modular
To: geert@linux-m68k.org
Cc: alex.aring@gmail.com, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu,  7 Aug 2014 17:06:43 +0200

> Change config symbol 6LOWPAN from type bool to type tristate, so
> 6LoWPAN can be built modular, just like IPV6
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks.
