Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62120 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaIXM3d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 08:29:33 -0400
Date: Wed, 24 Sep 2014 14:29:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 4/4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140924122927.GC5246@omega>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
 <1411554093-14976-5-git-send-email-alex.aring@gmail.com>
 <4472A049-A0BA-4E19-B788-5292749AD916@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4472A049-A0BA-4E19-B788-5292749AD916@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Simon Vincent <simon.vincent@xsilon.com>

On Wed, Sep 24, 2014 at 02:18:52PM +0200, Marcel Holtmann wrote:
> Hi Alex,
> 
> > The 6lowpan ipv6 header compression was causing problems for other interfaces
> > that expected a ipv6 header to still be in place, as we were replacing the
> > ipv6 header with a compressed version. This happened if you sent a packet to a
> > multicast address as the packet would be output on 802.15.4, ethernet, and also
> > be sent to the loopback interface. The skb data was shared between these
> > interfaces so all interfaces ended up with a compressed ipv6 header.
> > The solution is to ensure that before we do any header compression we are not
> > sharing the skb or skb data with any other interface. If we are then we must
> > take a copy of the skb and skb data before modifying the ipv6 header.
> > The only place we can copy the skb is inside the xmit function so we don't
> > leave dangling references to skb.
> > This patch moves all the header compression to inside the xmit function. Very
> > little code has been changed it has mostly been moved from lowpan_header_create
> > to lowpan_xmit. At the top of the xmit function we now check if the skb is
> > shared and if so copy it. In lowpan_header_create all we do now is store the
> > source and destination addresses for use later when we compress the header.
> 
> so I added a two empty lines here to make this text a bit more easier on the eyes when reading it. Also in the future I would propose to keep it a 72 chars and not try to max out the 80 chars width. The reason is so that git log displays properly in a 80 chars terminal.
> 

ok. thanks. Yes, I know the 80 chars width... need to check this when I
see/apply others patches.

> > 
> > Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> > net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++++++++------------
> > 1 file changed, 89 insertions(+), 36 deletions(-)
> > 
> > diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> > index 5e788cd..78cb206 100644
> > --- a/net/ieee802154/6lowpan_rtnl.c
> > +++ b/net/ieee802154/6lowpan_rtnl.c
> > @@ -71,20 +71,42 @@ struct lowpan_dev_record {
> > 	struct list_head list;
> > };
> > 
> > +/* don't save pan id, it's intra pan */
> > +struct lowpan_addr {
> > +	u8 mode;
> > +	union lowpan_addr_u {
> 
> I changed this into union { since there is no reason to name the union here.
> 

oops, yes you already said that at your first review note. Seems that
this wasn't changed.

Thanks Marcel.

- Alex
