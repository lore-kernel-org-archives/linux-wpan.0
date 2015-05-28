Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53733 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbE1K3Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 06:29:16 -0400
Date: Thu, 28 May 2015 13:29:14 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150528102914.GB11340@wantstofly.org>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
 <20150525074133.GH11340@wantstofly.org>
 <20150526085615.GA2747@omega>
 <20150527124550.GZ11340@wantstofly.org>
 <20150527134609.GF712@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150527134609.GF712@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

On Wed, May 27, 2015 at 03:46:13PM +0200, Alexander Aring wrote:

> > > > > Since firmware version 0.2 we use AACK handling directly in the firmware.
> > > > > Inform the stack that the hardware supports and uses it.
> > > > > 
> > > > > Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> > > > > ---
> > > > >  drivers/net/ieee802154/atusb.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> > > > > index 9d07dd7..eef1d8a 100644
> > > > > --- a/drivers/net/ieee802154/atusb.c
> > > > > +++ b/drivers/net/ieee802154/atusb.c
> > > > > @@ -568,7 +568,8 @@ static int atusb_probe(struct usb_interface *interface,
> > > > >  		goto fail;
> > > > >  
> > > > >  	hw->parent = &usb_dev->dev;
> > > > > -	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> > > > > +	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> > > > > +		    IEEE802154_HW_AACK;
> > > > >  
> > > > >  	hw->phy->current_page = 0;
> > > > >  	hw->phy->current_channel = 11;	/* reset default */
> > > > 
> > > > I'm wondering about this patch...
> > > > 
> > > > The IEEE802154_HW_AACK flag is defined in the core:
> > > > 
> > > > include/net/mac802154.h:
> > > > 	/* Indicates that receiver will autorespond with ACK frames. */
> > > > 	#define IEEE802154_HW_AACK              0x00000002
> > > > 
> > > > And is set by various drivers:
> > > > 
> > > > drivers/net/ieee802154/at86rf230.c:     lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
> > > > drivers/net/ieee802154/atusb.c:             IEEE802154_HW_AACK;
> > > > drivers/net/ieee802154/cc2520.c:        priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> > > > drivers/net/ieee802154/mrf24j40.c:      devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> > > > 
> > > > But there's no code anywhere in the tree that tests for this flag, and
> > > > if I think about it for a bit, I'm not sure what the core code could do
> > > > with this information, as I don't think it's feasible to generate ACKs
> > > > in software if the hardware doesn't support auto-ACKing?  (Is hardware
> > > > that doesn't support this useful or usable at all?  Maybe just remove
> > > > the flag altogether?)
> > > 
> > > yes this is true, this flag isn't evaluated and we can't never
> > > supporting ack handling in software. I never saw a transceiver which
> > > doesn't support auto-ACK handling also.
> > > 
> > > One use case would be that we check on this flag when we receive an ack
> > > frame in mac802154 frame parsing. Then we could drop a WARN_ONCE which
> > > means "hey care that you support aack handling in your driver".
> > > 
> > > But our logic is for _all_ drivers now is that they should _always_
> > > support AACK handling by default, there is no feature disable or enable.
> > 
> > Yep, and so I think the flag should just go.
> > 
> > 
> > > So maybe removing this flag and then making always WARN_ONCE if we get an
> > > ACK frame in mac802154 (except monitor interface).
> > 
> > How do you mean, get an ACK frame in mac802154?  The AACK flag is
> > documented to be about automatically responding to received packets
> > addressed to us by transmitting an ACK frame in hardware, but I
> > think you are saying here that non-AACK hardware would also pass
> > received ACK packets through to software?  (Is that how e.g. atusb
> > behaves if you don't enable AACK mode in hardware?)
> 
> Yes, I think I was wrong here. We need to talk about how the ack
> handling is really used. (I got confused because AACK handling in
> at86rf2xx means that ack frames are never delivered to the next layer).
> 
> AACK = automatically ack frame transmitting, when we receive a frame we
>        create an ack frame. _IF_ the ack request bit in 802.15.4 mac is
>        set.
> 
> ARET = this is enabled when max_frame_retries is 0 or above, e.g. 3
>        means we try to transmit and if no ack is received then this will
>        be retransmit at maximum value of 3 times.
> 
> This means if you using ARET handling (max_frame_retries >= 0) in a
> network with nodes that doesn't support AACK handling you have a bigger
> issue and need to turn off ARET handling (that's currently the reason
> why we have as default value for max_frame_retries = -1). The normal
> 802.15.4 default is max_frame_retries = 3.

The 802.15.4 spec requires auto ACK handling, so why is this behaviour
in there?  Is there a lot of non-spec-compliant hardware out there that
never ACKs frames?  (If so, do we care about such hardware?)


> I got confused now, because if the at86rf2xx are in RX_AACK mode (which
> is the AACK handling mode), then the transceiver doesn't send the ACK
> frames to the next upper layer. In normal RX mode (without AACK) then
> the transceiver would send ack frames to the next layer which is
> mac802154, but the mac802154 can't handle them.
> 
> What I suggest is that we always drop a WARN_ONCE when we receive an ACK
> frame, because the network is a possible ARET enabled network and we
> can't handle the ack frames, so when a node speaks with a ARET handling
> and max_frame_retries = 3 we get the same frame 3 times and the sending
> node think that the receiving node has never got the frame, because the
> receiving node never send an ack frame.

Even if the sending node doesn't retry the transmission it can be
important to the sending node to know whether or not the packet
was ACKed (this would be max_frame_retries == 0), as some MLME state
machine actions depend on your packet having been ACKed by the other end.


> I recently send also a patch that the ack request bit is only set when
> the transceiver operates in ARET mode, do you think that's a good idea
> for the default behaviour of 802.15.4 6LoWPAN frames?

I think it's a good idea for all frames, not just 6LoWPAN ones, and
it should probably be the default behavior -- but then the question
of what the default value of max_frame_retries should be is the
harder question, IMHO.


> In monitor mode (promiscuous mode) then the phy doesn't filter anything
> and delivers to userspace directly. This is not 100% that what's it is
> on air because the ack handling is sometimes too fast and the
> transceiver doesn't get all of them, but this is okay for a monitor interface.
> When I can put another question to this mail is "it's a good idea that a
> monitor interface can transmit frames", they don't can handle never ack
> frames, it should only a passiv listen mode, except somebody wants to
> make some mess into the network.

I'm undecided about this right now -- I can find arguments for why
it should be possible to do this and for why it shouldn't and I'm
not sure which are more convincing.
