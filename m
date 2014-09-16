Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54209 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbaIPUai (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 16:30:38 -0400
Date: Tue, 16 Sep 2014 22:30:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916203032.GG6104@omega>
References: <20140916133206.GA6104@omega>
 <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com>
 <20140916140459.GB6104@omega>
 <54184CDB.9050200@xsilon.com>
 <20140916173806.GC6104@omega>
 <54188817.80707@xsilon.com>
 <20140916193723.GD6104@omega>
 <54189522.9090405@xsilon.com>
 <20140916200754.GE6104@omega>
 <54189B6E.5080905@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54189B6E.5080905@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 16, 2014 at 09:19:58PM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> On 16/09/14 21:07, Alexander Aring wrote:
> >On Tue, Sep 16, 2014 at 08:53:06PM +0100, Martin Townsend wrote:
> >...
> >>>I make another c example, hopeful more correct than the last one:
> >>>
> >>>char *foo(char *skb)
> >>>{
> >>>         char *new;
> >>>
> >>>         if (some_error_before_consume)
> >>>                 return ERR_PTR(-EINVAL); /* here we need to do a free(skb) */
> >>>
> >>>         /* UDP expand */
> >>>         new = expand(skb, 16);
> >s/16/8 , argl, doesn't matter was only an example. :-)
> >
> >>>         if (!new)
> >>>                 return ERR_PTR(-ENOMEM);
> >>>         consume(skb); /* parameter skb becomes dangling pointer */
> >>>         skb = new; /* doesn't rescue it, it is different than skb from caller function
> >>>                       at this point, the skb_inout had rescue it, because it was a pointer
> >>>                       of pointer */
> >>>
> >>>         /* IPv6 expand */
> >>>         new = expand(skb, 40);
> >>>         if (!new) /* some error after a consume(skb), will crash at drop_skb label */
> >>>                 return ERR_PTR(-ENOMEM);
> >>>         consume(skb);
> >>>         skb = new;
> >>>
> >>>         return skb;
> >>>}
> >>I see the problem now, once the skb has been copied and then an error occurs
> >>you have to return the error and the skb has been lost.  Would using the
> >>skb->cb to store decompress status get around this problem?
> >mhhh, complicated... on 802.15.4 6LoWPAN we use the control block
> >information for fragmentation information. I don't know right now if we
> >get trouble when we add the "uncompression on the fly when FRAG1 was
> >received".
> >
> >What exactly do you mean with "decompress status"?
> An integer that either contains an error code or 0 that process_data would
> set as process_data is now IPHC decompression.

sounds for me that this basically could work, but not easy to maintain.
The control block is "normally" for store information across callbacks
which used the same sk buff.

Maybe simple do that what Jukka said, to handle the kfree_skb inside of
lowpan_process_data. What's wrong now with that?

- Alex
