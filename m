Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34275 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbFPSbO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 14:31:14 -0400
Received: by wgv5 with SMTP id 5so18637767wgv.1
        for <linux-wpan@vger.kernel.org>; Tue, 16 Jun 2015 11:31:12 -0700 (PDT)
Date: Tue, 16 Jun 2015 20:31:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/3] at86rf230: fix phy settings while
 sleeping
Message-ID: <20150616183104.GA9659@omega>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
 <1434446394.3559.21.camel@pengutronix.de>
 <20150616100806.GB17255@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150616100806.GB17255@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Jun 16, 2015 at 12:08:06PM +0200, Alexander Aring wrote:
...
> 
> I agree this is the common kernel soltution. I think is what we need is
> to put this logic then into 802.15.4 subsystem.
> 
> In the wpan_phy we put a refcounter and let them increment when the phy
> is "used by susbsytem" -> if was 0 then awake and decrement
> "when it's not used" -> if reach 0 then subsystem.
> 
> Currently all ops (except the xmit op, but this should not called when
> sleeping) are protected by rtnl mutex so the refcount can't be greater
> than one.
> 
> I will put it to my ToDo List, then we have some driver_ops
> resume/suspsend when the susbsystem will use the wpan_phy when it's
> sleeping and the driver needs to do something.
> 
> Nevertheless this patch looks for _now_ valid and introducing a refcount
> in 802.15.4 for the wpan_phy is better. At the moment I broke the
> behaviour when introduced the sleep state some days ago.
> 
> At Wednesday Marcel will send the last push request to net-next and I
> need to decide now if we do this fix OR reverting the introducing of
> sleep state.
> 
> I would leave this patch and when the times comes we introduce a better
> 802.15.4 wpan behaviour with refcounts later. The logic is just
> completely in driver layer right now.

I tried to implement such feature but I gave up.

What we have is currently a very transceiver specific issue which is
that we can't access the register when the transceiver is in sleep mode.

I find out that e.g. the mrf24j40 [0] can access the registers while in
sleep mode. See "3.15 Sleep": "... registers and the MRF24J40 is accessible
via the SPI port".

So there are transceivers which have the possibility to access the
register inside sleep state and there are transceivers which have no the
possibility.

Well, our at86rf2xx has it not and need to be wake-up before access the
spi registers.


Now inside the 802.15.4 subsystem the transceiver _should_ in sleep mode
in the following states:

1. In probing after hardware init. -> transceiver hasn't been started is
   like starting stop callback, because the transceiver hasn't been started.
2. After calling stop driver callback. -> should be called by suspend
   callback of pm_ops and last interface down only.

On a start driver callback the transceiver isn't in sleep mode anymore,
which means xmit callback don't need to check on "if we are in sleep
state" we can be sure, that we are not in a sleep state.


Now if the transceiver isn't started (this could be the case when we
have no interfaces up) then we can't access the registers, BUT there are
netlink commands to change e.g. channel, tx_power etc. which can also be
accessible while interfaces are down (means transceiver is in sleep state).

In this case we need to awake the transceiver (in case of at86rf2xx
transceivers, there are some transceivers which offers the register
accessible while sleep).


What I said before was that all driver_ops callbacks are protected by a
mutex, so we can't run twice a driver_ops operation (except xmit
callback but this is a special case, it's only called between start <->
stop state and then the transceiver should _not_ sleeping).

What I did now in this patch was to check if we sleeping, if yes then
make the register access possible, otherwise do nothing. If we do
nothing then we are in the start <-> stop state when the transceiver
should always be not in the sleeping state.

I think this is a very specific transceiver issue and should be handled
by the driver now. The only thing which I could do is to introduce a new
hardware flag "IEEE802154_HW_NO_SLEEP_ACCESS" and the layer above checks
on each driver_ops on this and awakes the transceiver before and set the
transceiver sleeping after driver_op. On more than one driver_ops in the
above layer we could save some time. But I think we should not do that and
this time is so small - it doesn't matter.

To introduce some refcnt would also not give any benefits, when all
driver_ops are protected by a mutex and can't run twice. So I would
simple say that we leave the state of handling the "register accessible
when transceiver is in sleep state" as it is.

- Alex

[0] http://ww1.microchip.com/downloads/en/DeviceDoc/39776C.pdf
