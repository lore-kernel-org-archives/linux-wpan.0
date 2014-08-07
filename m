Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38720 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaHGStq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Aug 2014 14:49:46 -0400
Date: Thu, 7 Aug 2014 20:49:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140807184938.GC17452@omega>
References: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH] 6lowpan: Allow 6LoWPAN to be modular
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 07, 2014 at 05:06:43PM +0200, Geert Uytterhoeven wrote:
> Change config symbol 6LOWPAN from type bool to type tristate, so
> 6LoWPAN can be built modular, just like IPV6
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>
