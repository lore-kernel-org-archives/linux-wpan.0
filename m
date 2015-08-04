Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33083 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbbHDSm1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Aug 2015 14:42:27 -0400
Received: by wijp15 with SMTP id p15so17937334wij.0
        for <linux-wpan@vger.kernel.org>; Tue, 04 Aug 2015 11:42:26 -0700 (PDT)
Date: Tue, 4 Aug 2015 20:42:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 0/6] ieee802154: aret handling changes
Message-ID: <20150804184248.GA22802@omega>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <55C0E848.3090501@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55C0E848.3090501@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Aug 04, 2015 at 06:28:56PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 30/07/15 10:55, Alexander Aring wrote:
> >Hi,
> >
> >this patch series contains a RFC for changing the max_frame_retries behaviour.
> >The current behaviour is that we allow a range from -1 until 7 (802.15.4
> >standard describes a range from 0 until 7 only). Nevertheless for historical
> >reason we have the "-1" value, which describes no aret handling.
> >
> >The point is when the ack request bit is set inside the mac header the
> >transceiver need to handle the ack somehow, this is mostly the aret mode
> >which is done by hardware. Instead to having this as mac setting which doesn't
> >allow a change during interface up, we simple do this handling per frame
> >indicated by the ack request bit.
> 
> I think it is sound to handle it per frame to give us the opportunity to
> change this setting without taking the interface down. I wonder about the
> frame retry counter which needs to be written in some transceiver register
> to be used by the hardware directly. That one can only be done when the
> interface is down. Whcih means we can decide if we want ARET handling per
> frame but not how often the retry happens. Do I miss something?
> 

yes, turning into ARET mode (which use the max_frame_retries setting) or
NOT ARET mode (I always call this normal TX mode, which don't use the
max_frame_retries value) is now per frame. It depends on ackreq bit is
set or not, because this bit occurs - when the frame is transmitted the
receiving node will send a ack frame back then.

The number "how often the retry is inside ARET mode, if no ack was received"
can be set by interface down only. I already thought about to remove the
check "netif_running" (we probably can do that later). The point where I
am feeling bad is, this is some mac operation which is done by hardware.

We have with mac802154 normally the SoftMAC implementation for doing MAC
layer on linux side, but for ARET handling we can't because these timing
restrictions. In linux when a phy have a running interface means that
the mac802154 is operational and the phy do receive/transmit handling.

Now I can say what happens when e.g. at86rf2xx transceiver is in
TX_ARET_BUSY mode (means something is currently transmitted in ARET mode).
While in this state the transceiver changes his mac value
"max_frame_retries" to some other value. What happens then? I don't
know, the datasheet doesn't say anything how this is protected while
transmit handling. Maybe it isn't protected.

So we have the two arguments for allow/deny transceiver mac settings
while interface up:

Argument to allow:
 - The transceiver will handle the change while transmit "somehow".

Argument to deny:
 - We simple don't allow change mac settings which are handled by
   transceiver while mac is "operational" -> interface is up.

Currently we have the option where we deny to change these mib values
while mac is operational. I also don't think that there exists much use
case for doing a "complex" locking mechanism to allow the change while
interface is up. And this will huge complex with multiple interface
support and such things. Easiest way -> setup mib values which are
handled by transceiver on interface up and don't allow changes during
mac operational.

That's why I do different handling for mib values and pib values.

For phy settings (pib) CCA/channel/page we allow to change these values
during interface up. These values should not having much todo with the
mac layer. Probably we can argument with the same argument what happens
while TX_ARET_BUSY and different channel setting? I also don't know what
happens then. :-) But the point is that the linux side doesn't do any
phy layer things, for MAC we have mac802154 and the transceiver mac
operations (ARET/CSMA/etc...).

> >Instead of max_frame_retries "-1" value which could be useful for making a
> >default ack request bit handling if no information is given if it should be
> >set or not, we have now the ack request default entry inside the mib.
> >
> >This could be useful for the 6LoWPAN stack which have this as default
> >behaviour for data frames.
> 
> You have the wpan-tools bits for the new netlink command pushed somewhere to
> test out with this patchset?
> 

Yes, I have it. Will send them later. Also I want to include for "next
nl802154 feature" the CONFIG_NL802154_EXPERIMENTAL, but I don't think we
should introduce it for this patch series. Because we change the
behaviour of max_frame_retries -1 to the ackreq bit. We will introduce
them later then (maybe for llsec).

Should we name it ackreq_default or ackreq_fallback? I don't think
either that this value need to handled by cfg802154_ops, because setting
this configuration is just a variable in wpan_dev. It's bad that I don't
have a HardMAC driver so I don't know right now to dealing with this value.
I think it's fine to set this value in nl802154, it doesn't need to
reach the mac802154 layer. For "real mib" values this looks different
the underlaying layer need to know the mib values then. Anyway we can
also remove it later again if we don't see a use case for that.

- Alex
