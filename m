Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:56783 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbaIHSzY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 14:55:24 -0400
Date: Mon, 8 Sep 2014 20:55:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140908185519.GB633@omega>
References: <53DCE75C.2030305@xsilon.com>
 <20140821083945.GA29484@omega>
 <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
 <53FE446D.6040805@xsilon.com>
 <20140908104008.GB6981@omega>
 <540DF1AE.2070709@xsilon.com>
 <20140908183652.GA633@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140908183652.GA633@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Martin,

On Mon, Sep 08, 2014 at 08:36:52PM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Mon, Sep 08, 2014 at 07:13:02PM +0100, Martin Townsend wrote:
> ...
> > >>Hi,
> > >>
> > >>I'll respin and include the memory leak fix and this patch and a couple of
> > >>others I have and send as a series to bluetooth.  What bluetooth git
> > >>repository should I base the series on?
> > >>
> > >What's the state about to fix this bad issue? :-)
> > >
> > >I didn't saw any new patches because of this.
> > >
> > >- Alex
> > >--
> > >To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> > >the body of a message to majordomo@vger.kernel.org
> > >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > Sorry for the delay, been on hols for a few days, I will create the patches
> > tomorrow if I get time.
> > 
> > I have also implemented Generic Header Compression[0] which is still in
> > draft at the moment but I can't imagine it will change much before being
> > released.  I'm going to integrate it into our linux repository this week.
> > Would you be interested in putting it in linux-wpan or linux-wpan-next or
> > would you prefer to wait until it gets it RFC status?
> > 
> 
> no, for me it's okay to have this mainline. I heard that a draft becomes
> no RFC when nobody implements it.
> 

I thought more about that, you mean the receiving part only? So the
uncompression. The point is that we don't have no interface for an user
that can decide if he like to use UDP compression like RFC 6282 or UDP
compression like GHC. This is only relevant for the transmit part. So
compression is optionally. (We should have some interface to make this
configurable by user -> adding this to the nhc layer, later).

On the uncompression part, means the receiving part we can support both.
UDP RFC 6282 or UDP like GHC, the next header id value should be
different there. That means currently we can receive every packets but
transmit only RFC6282 compression formats.

So for receiving this, it's okay. But for compression, since we don't
have some interface to make this configurable we should use RFC 6282.


Same opinion here? We can talk about that point.

- Alex
