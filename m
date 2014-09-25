Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:48243 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbaIYHjk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Sep 2014 03:39:40 -0400
Date: Thu, 25 Sep 2014 09:39:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140925073936.GB25208@omega>
References: <20140916173806.GC6104@omega>
 <54188817.80707@xsilon.com>
 <20140916193723.GD6104@omega>
 <54189522.9090405@xsilon.com>
 <20140916200754.GE6104@omega>
 <54189B6E.5080905@xsilon.com>
 <20140916203032.GG6104@omega>
 <20140925055504.GA24765@omega>
 <5423C36D.20606@xsilon.com>
 <20140925073143.GA25208@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140925073143.GA25208@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Martin,

On Thu, Sep 25, 2014 at 09:31:43AM +0200, Alexander Aring wrote:
> On Thu, Sep 25, 2014 at 08:25:33AM +0100, Martin Townsend wrote:
> > Hi Alex,
> > 
> > I'm not keen on handling kfree_skb inside of lowpan_process_data for reasons already stated in a previous email.  I'll have a rethink to see if there's another way of handling this.  One idea I'm investigating is pskb_expand_head, this doesn't create a new sk_buff but adds room to the head and/or tail which seems perfect for decompression.  There must only be a reference count of 1, so we would need to make a copy if this is the case before passing to decompression, I can't think why there would be more than 1 reference as the packet will only have passed through the 802.15.4 layer and only 6LoWPAN can decompress it.   If it's cloned for monitoring then this would be a problem.
> > Any thoughts on this?
> > 
> 
> For me it doesn't matter if kfree_skb is inside of lowpan_process_data
> or not. Go ahead and send fixes for this, I will only review if there
> are still issues which are not solved by your patch.
> 
> Don't know what you exactly mean with "monitoring" now.
> 
For me it's only important to know that you still working on this issue.
If you still working on it, all seems to be fine.

Thanks, for your effort.

- Alex
