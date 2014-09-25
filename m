Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51745 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaIYHZg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Sep 2014 03:25:36 -0400
Message-ID: <5423C36D.20606@xsilon.com>
Date: Thu, 25 Sep 2014 08:25:33 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com> <20140916140459.GB6104@omega> <54184CDB.9050200@xsilon.com> <20140916173806.GC6104@omega> <54188817.80707@xsilon.com> <20140916193723.GD6104@omega> <54189522.9090405@xsilon.com> <20140916200754.GE6104@omega> <54189B6E.5080905@xsilon.com> <20140916203032.GG6104@omega> <20140925055504.GA24765@omega>
In-Reply-To: <20140925055504.GA24765@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

I'm not keen on handling kfree_skb inside of lowpan_process_data for reasons already stated in a previous email.  I'll have a rethink to see if there's another way of handling this.  One idea I'm investigating is pskb_expand_head, this doesn't create a new sk_buff but adds room to the head and/or tail which seems perfect for decompression.  There must only be a reference count of 1, so we would need to make a copy if this is the case before passing to decompression, I can't think why there would be more than 1 reference as the packet will only have passed through the 802.15.4 layer and only 6LoWPAN can decompress it.   If it's cloned for monitoring then this would be a problem.
Any thoughts on this?

- Martin.

On 25/09/14 06:55, Alexander Aring wrote:
> On Tue, Sep 16, 2014 at 10:30:32PM +0200, Alexander Aring wrote:
> ...
>> Maybe simple do that what Jukka said, to handle the kfree_skb inside of
>> lowpan_process_data. What's wrong now with that?
>>
> ping. Really bad issue, what's about the state to fix it?
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

