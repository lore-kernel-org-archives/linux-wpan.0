Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33539 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbbE1LZf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 07:25:35 -0400
Received: by wgez8 with SMTP id z8so33538701wge.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 04:25:34 -0700 (PDT)
Date: Thu, 28 May 2015 13:25:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150528112527.GB716@omega>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
 <20150525074133.GH11340@wantstofly.org>
 <20150526085615.GA2747@omega>
 <20150527124550.GZ11340@wantstofly.org>
 <20150527134609.GF712@omega>
 <20150528102914.GB11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150528102914.GB11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

On Thu, May 28, 2015 at 01:29:14PM +0300, Lennert Buytenhek wrote:
...
> > 
> > Yes, I think I was wrong here. We need to talk about how the ack
> > handling is really used. (I got confused because AACK handling in
> > at86rf2xx means that ack frames are never delivered to the next layer).
> > 
> > AACK = automatically ack frame transmitting, when we receive a frame we
> >        create an ack frame. _IF_ the ack request bit in 802.15.4 mac is
> >        set.
> > 
> > ARET = this is enabled when max_frame_retries is 0 or above, e.g. 3
> >        means we try to transmit and if no ack is received then this will
> >        be retransmit at maximum value of 3 times.
> > 
> > This means if you using ARET handling (max_frame_retries >= 0) in a
> > network with nodes that doesn't support AACK handling you have a bigger
> > issue and need to turn off ARET handling (that's currently the reason
> > why we have as default value for max_frame_retries = -1). The normal
> > 802.15.4 default is max_frame_retries = 3.
> 
> The 802.15.4 spec requires auto ACK handling, so why is this behaviour
> in there?  Is there a lot of non-spec-compliant hardware out there that
> never ACKs frames?  (If so, do we care about such hardware?)
> 

Yes, that's why max_frame_retries = -1 is introduced, if we do a
max_frame_retries = 0 and receive no ACK frames then the transmission
logic of transceiver thinks the transmission was failed.

The point is here, there exists _a_ _lot_ of contiki etc... sensor nodes which
doesn't support AACK handling and then you need to be sure that all
(which can reach the non AACK node) don't use ARET handling. With ARET I
also means max_frame_retries = 0, in this case.

Since there still exists hardware which don't use AACK handling then we
need a option to disable ARET handling and this is currently our default (-1).
I tried to change it at [0], with a BIG note that it could be that other
nodes receives then the same frame three times (this indicates mostly
that the sensor node doesn't support AACK handling) I have myself also
some nodes which _could_ support AACK handling but contiki doesn't use
it.

The patch at [0] never reached mainline. 

> 
> > I got confused now, because if the at86rf2xx are in RX_AACK mode (which
> > is the AACK handling mode), then the transceiver doesn't send the ACK
> > frames to the next upper layer. In normal RX mode (without AACK) then
> > the transceiver would send ack frames to the next layer which is
> > mac802154, but the mac802154 can't handle them.
> > 
> > What I suggest is that we always drop a WARN_ONCE when we receive an ACK
> > frame, because the network is a possible ARET enabled network and we
> > can't handle the ack frames, so when a node speaks with a ARET handling
> > and max_frame_retries = 3 we get the same frame 3 times and the sending
> > node think that the receiving node has never got the frame, because the
> > receiving node never send an ack frame.
> 
> Even if the sending node doesn't retry the transmission it can be
> important to the sending node to know whether or not the packet
> was ACKed (this would be max_frame_retries == 0), as some MLME state
> machine actions depend on your packet having been ACKed by the other end.
> 

yes, some MLME options required acks. In case of at86rf2xx we need to
take care then about the trac status which indicates if ACK was received
or not. Currently we doesn't care about this information. There is also
no way to get this information, I thought about to creating some stats
about that (which represents some 802.15.4 generic stats information).

I am not 100% how to deal with this currently, but I am sure this will
be a lot of fun.


In case of at86rf2xx if we are in RX_AACK mode then we doesn't get any
ack frames anymore to the next layer. The transceiver simple doesn't
react on ack frames anymore while receiving. Maybe because when it's in
RX_AACK and react on acks, then the RX_AACK mode would also send then
ack frames for acks, but this should not happen then.

I think that other transceivers (I currently has the atmel ones only)
react the same, so if we get ack frames inside of mac802154 then this
indicates some nodes operates _possible_ in ARET mode and the used
transceiver doesn't support AACK (because ack frames are delivered to
mac802154) and we should never deliver ack frames to this layer.

> 
> > I recently send also a patch that the ack request bit is only set when
> > the transceiver operates in ARET mode, do you think that's a good idea
> > for the default behaviour of 802.15.4 6LoWPAN frames?
> 
> I think it's a good idea for all frames, not just 6LoWPAN ones, and
> it should probably be the default behavior -- but then the question
> of what the default value of max_frame_retries should be is the
> harder question, IMHO.
> 

Yea, I would say we should use 802.15.4 default. If somebody expierence
that some node receives the same frame type 3 times, then it should turn
-1 on _all_ nodes in the network.

> 
> > In monitor mode (promiscuous mode) then the phy doesn't filter anything
> > and delivers to userspace directly. This is not 100% that what's it is
> > on air because the ack handling is sometimes too fast and the
> > transceiver doesn't get all of them, but this is okay for a monitor interface.
> > When I can put another question to this mail is "it's a good idea that a
> > monitor interface can transmit frames", they don't can handle never ack
> > frames, it should only a passiv listen mode, except somebody wants to
> > make some mess into the network.
> 
> I'm undecided about this right now -- I can find arguments for why
> it should be possible to do this and for why it shouldn't and I'm
> not sure which are more convincing.

okay. Maybe we talk this in another thread.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01604.html
