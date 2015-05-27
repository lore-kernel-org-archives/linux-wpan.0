Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53413 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbE0Mpz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 08:45:55 -0400
Date: Wed, 27 May 2015 15:45:50 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150527124550.GZ11340@wantstofly.org>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
 <20150525074133.GH11340@wantstofly.org>
 <20150526085615.GA2747@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150526085615.GA2747@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

On Tue, May 26, 2015 at 10:56:18AM +0200, Alexander Aring wrote:

> Hi Lennert,

Hi!


> > > Since firmware version 0.2 we use AACK handling directly in the firmware.
> > > Inform the stack that the hardware supports and uses it.
> > > 
> > > Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> > > ---
> > >  drivers/net/ieee802154/atusb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> > > index 9d07dd7..eef1d8a 100644
> > > --- a/drivers/net/ieee802154/atusb.c
> > > +++ b/drivers/net/ieee802154/atusb.c
> > > @@ -568,7 +568,8 @@ static int atusb_probe(struct usb_interface *interface,
> > >  		goto fail;
> > >  
> > >  	hw->parent = &usb_dev->dev;
> > > -	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> > > +	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> > > +		    IEEE802154_HW_AACK;
> > >  
> > >  	hw->phy->current_page = 0;
> > >  	hw->phy->current_channel = 11;	/* reset default */
> > 
> > I'm wondering about this patch...
> > 
> > The IEEE802154_HW_AACK flag is defined in the core:
> > 
> > include/net/mac802154.h:
> > 	/* Indicates that receiver will autorespond with ACK frames. */
> > 	#define IEEE802154_HW_AACK              0x00000002
> > 
> > And is set by various drivers:
> > 
> > drivers/net/ieee802154/at86rf230.c:     lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
> > drivers/net/ieee802154/atusb.c:             IEEE802154_HW_AACK;
> > drivers/net/ieee802154/cc2520.c:        priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> > drivers/net/ieee802154/mrf24j40.c:      devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> > 
> > But there's no code anywhere in the tree that tests for this flag, and
> > if I think about it for a bit, I'm not sure what the core code could do
> > with this information, as I don't think it's feasible to generate ACKs
> > in software if the hardware doesn't support auto-ACKing?  (Is hardware
> > that doesn't support this useful or usable at all?  Maybe just remove
> > the flag altogether?)
> 
> yes this is true, this flag isn't evaluated and we can't never
> supporting ack handling in software. I never saw a transceiver which
> doesn't support auto-ACK handling also.
> 
> One use case would be that we check on this flag when we receive an ack
> frame in mac802154 frame parsing. Then we could drop a WARN_ONCE which
> means "hey care that you support aack handling in your driver".
> 
> But our logic is for _all_ drivers now is that they should _always_
> support AACK handling by default, there is no feature disable or enable.

Yep, and so I think the flag should just go.


> So maybe removing this flag and then making always WARN_ONCE if we get an
> ACK frame in mac802154 (except monitor interface).

How do you mean, get an ACK frame in mac802154?  The AACK flag is
documented to be about automatically responding to received packets
addressed to us by transmitting an ACK frame in hardware, but I
think you are saying here that non-AACK hardware would also pass
received ACK packets through to software?  (Is that how e.g. atusb
behaves if you don't enable AACK mode in hardware?)


> btw: I having some plans to rework the frame parsing/creation. The
> parsing is based on mac802154 frame parsing [0]. There I have implement
> the WARN_ONCE [1]. The frame parsing isn't mainline yet, because I can't
> test the crypto layer. For doing this draft I simple removed the crypto
> layer which makes the parts easier. The current frame parsing is much
> oriented to support data frames only to deal with 6LoWPAN. It's a mess
> currently to support new things into the frame parsing and we should
> really look how mac802154 dealing with frame parsing and doing the same
> in mac802154 and ieee802154 6lowpan, just other hex values and static
> inline functions. Then we also don't need to parse always the whole
> frame when we just want the addresses for example. Also the wireless
> community (if they want) getting easier familar with the code.

I'll look into this.
