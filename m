Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63191 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaISKj4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 06:39:56 -0400
Received: by mail-wi0-f171.google.com with SMTP id bs8so601319wib.16
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 03:39:54 -0700 (PDT)
Date: Fri, 19 Sep 2014 12:39:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919103951.GB19542@omega>
References: <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <541B004D.1020609@xsilon.com>
 <20140918163008.GC9262@omega>
 <541B1068.4060707@xsilon.com>
 <20140918170938.GB11661@omega>
 <541BE8D9.2000700@xsilon.com>
 <20140919093335.GB17051@omega>
 <541BFE0C.1050707@xsilon.com>
 <20140919101534.GA19542@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140919101534.GA19542@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, mkl@pengutronix.de

Hi Simon,

On Fri, Sep 19, 2014 at 12:15:34PM +0200, Alexander Aring wrote:
...
> > 
> > It does not look like it is safe to do it at xmit callback either. I have
> > added debug printing out skb_shinfo(skb)->dataref in the compress function
> > as well as the lowpan_xmit function and there are 3 refs to the data at both
> > points. This makes sense as the packet would be sent to the
> > 802.15.4/ethernet/rawsocket as it is a multicast packet.
> > I think the only solution is to do a full copy of the packet in the 6lowpan
> > layer. Then we can modify the headers as much as we like. I know there is an
> > overhead doing this but I can't see another way of avoiding this issue.
> > 
> 

I found now the "dev_hard_header" call inside the IPv6 implementation [0]. It's
a wrapper to call the create callback of header ops. So what I understand about
the issue that, somebody assume that there is still an IPv6 header and
not 6LoWPAN header. But we replacing data there so some implementation
will parse garbage.

[0] shows three function which call dev_hard_header:

 - neigh_compat_output
 - neigh_resolve_output
 - neigh_connected_output

So these three we need to look at it and see if there is some code which
parse an IPv6 header afterwards. Right?

I will try to do some grep magic and find a case when this happens.

- Alex

[0] http://lxr.free-electrons.com/source/net/core/neighbour.c#L1294
