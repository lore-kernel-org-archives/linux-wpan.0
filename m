Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56222 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaJER7A (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Oct 2014 13:59:00 -0400
Date: Sun, 5 Oct 2014 19:58:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20141005175855.GB15923@omega>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
 <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
 <20141005175049.GA15923@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141005175049.GA15923@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>, werner@almesberger.net

Martin,

On Sun, Oct 05, 2014 at 07:50:49PM +0200, Alexander Aring wrote:
...

> if (skb_headroom(skb) < len)
> 	do_expand_stuff(skb....);
> 

Maybe also put the skb_push stuff here, please look yourself what we do also
at udphdr and hdr here. It's should have some similar calling steps.

But please not the skb_reset_stuff here. This is different for network
header and transport header.

> return 0;
> 
> 

- Alex
