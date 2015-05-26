Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33002 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbbEZNHf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 09:07:35 -0400
Received: by wicmx19 with SMTP id mx19so64271038wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 06:06:54 -0700 (PDT)
Date: Tue, 26 May 2015 10:56:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150526085615.GA2747@omega>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
 <20150525074133.GH11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150525074133.GH11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

Hi Lennert,

On Mon, May 25, 2015 at 10:41:33AM +0300, Lennert Buytenhek wrote:
> On Thu, May 21, 2015 at 04:51:36PM +0200, Stefan Schmidt wrote:
> 
> > Since firmware version 0.2 we use AACK handling directly in the firmware.
> > Inform the stack that the hardware supports and uses it.
> > 
> > Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> > ---
> >  drivers/net/ieee802154/atusb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> > index 9d07dd7..eef1d8a 100644
> > --- a/drivers/net/ieee802154/atusb.c
> > +++ b/drivers/net/ieee802154/atusb.c
> > @@ -568,7 +568,8 @@ static int atusb_probe(struct usb_interface *interface,
> >  		goto fail;
> >  
> >  	hw->parent = &usb_dev->dev;
> > -	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> > +	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> > +		    IEEE802154_HW_AACK;
> >  
> >  	hw->phy->current_page = 0;
> >  	hw->phy->current_channel = 11;	/* reset default */
> 
> I'm wondering about this patch...
> 
> The IEEE802154_HW_AACK flag is defined in the core:
> 
> include/net/mac802154.h:
> 	/* Indicates that receiver will autorespond with ACK frames. */
> 	#define IEEE802154_HW_AACK              0x00000002
> 
> And is set by various drivers:
> 
> drivers/net/ieee802154/at86rf230.c:     lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
> drivers/net/ieee802154/atusb.c:             IEEE802154_HW_AACK;
> drivers/net/ieee802154/cc2520.c:        priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> drivers/net/ieee802154/mrf24j40.c:      devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> 
> But there's no code anywhere in the tree that tests for this flag, and
> if I think about it for a bit, I'm not sure what the core code could do
> with this information, as I don't think it's feasible to generate ACKs
> in software if the hardware doesn't support auto-ACKing?  (Is hardware
> that doesn't support this useful or usable at all?  Maybe just remove
> the flag altogether?)

yes this is true, this flag isn't evaluated and we can't never
supporting ack handling in software. I never saw a transceiver which
doesn't support auto-ACK handling also.

One use case would be that we check on this flag when we receive an ack
frame in mac802154 frame parsing. Then we could drop a WARN_ONCE which
means "hey care that you support aack handling in your driver".

But our logic is for _all_ drivers now is that they should _always_
support AACK handling by default, there is no feature disable or enable.
So maybe removing this flag and then making always WARN_ONCE if we get an
ACK frame in mac802154 (except monitor interface).

The reason is that a sending node which using max_frame_retries above or
equal zero, needs to get an ACK frame after tranmsitting. Otherwise for
frame_retries e.g. 3 the receiving node will receive the frame three
times contiguoues.

So AACK frame handling is always enabled (in mac header is a bit to
enable ack request, this should be configureable somehow (also for
6LoWPAN, it's currently hard coded always enabled)). And ARET handling
can be configureable by max_frame_retries parameters, (-1) means in this
case don't waiting for a ack frame while tranmsit. (0) Means sending
frame but wait for ack frame without retransmit, but possible further
error counting could check on "why transmit failed" and this there
should some counters "no ack frame". All setting above 0 is the same just
with retransmit support, which is can't be done by software but we have
the option to disable/enable it.


btw: I having some plans to rework the frame parsing/creation. The
parsing is based on mac802154 frame parsing [0]. There I have implement
the WARN_ONCE [1]. The frame parsing isn't mainline yet, because I can't
test the crypto layer. For doing this draft I simple removed the crypto
layer which makes the parts easier. The current frame parsing is much
oriented to support data frames only to deal with 6LoWPAN. It's a mess
currently to support new things into the frame parsing and we should
really look how mac802154 dealing with frame parsing and doing the same
in mac802154 and ieee802154 6lowpan, just other hex values and static
inline functions. Then we also don't need to parse always the whole
frame when we just want the addresses for example. Also the wireless
community (if they want) getting easier familar with the code.

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c
[1] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c#L171
