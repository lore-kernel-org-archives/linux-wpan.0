Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:56342 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbaIVRCG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 13:02:06 -0400
Received: by mail-wg0-f43.google.com with SMTP id y10so3287387wgg.26
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 10:02:04 -0700 (PDT)
Date: Mon, 22 Sep 2014 19:02:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140922170201.GB7282@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140922162148.GA7282@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

On Mon, Sep 22, 2014 at 06:21:48PM +0200, Alexander Aring wrote:
> Hi Simon,
> 
> grml, I overlooked something the last version. But I will fix it while
> applying if all seems to be okay for all other guys/girls.
> 
> On Mon, Sep 22, 2014 at 04:52:03PM +0100, Simon Vincent wrote:
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
> > 
> > Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> > ---
> > 
> > v4 - fixed patch style checks
> > 
> > 
> >  net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 89 insertions(+), 36 deletions(-)
> > 
> > diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> > index 6591d27..ca7ef0e 100644
> > --- a/net/ieee802154/6lowpan_rtnl.c
> > +++ b/net/ieee802154/6lowpan_rtnl.c
> > @@ -71,6 +71,21 @@ struct lowpan_dev_record {
> >  	struct list_head list;
> >  };
> >  
> > +/* don't save pan id, it's intra pan */
> > +struct lowpan_addr {
> > +	__le16 mode;
> 
> In the rework I made this __le16 because this value comes directly from
> mac header and contain the masked frame control fields for the

sorry, this is sending part. So correct would no parsing, just set the
value at begin of generation of mac header to the frame control field.
So we never need to convert this value again.

This is also for parsing at receiving side, then we just copy this value.

- Alex
