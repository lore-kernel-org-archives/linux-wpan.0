Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38415 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbLHRMD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Dec 2015 12:12:03 -0500
Date: Tue, 8 Dec 2015 18:11:58 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
Message-ID: <20151208171154.GB766@omega>
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com>
 <56657FCA.9000502@analog.com>
 <20151207135312.GB20826@omega>
 <56669828.3060606@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56669828.3060606@analog.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, marcel@holtmann.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Tue, Dec 08, 2015 at 09:43:20AM +0100, Michael Hennerich wrote:
> On 12/07/2015 02:53 PM, Alexander Aring wrote:
> >Hi,
> >
> >On Mon, Dec 07, 2015 at 01:47:06PM +0100, Michael Hennerich wrote:
> >...
> >>>>+static struct ieee802154_ops adf7242_ops = {
> >>>>+    .owner = THIS_MODULE,
> >>>>+    .xmit_sync = adf7242_xmit,
> >>>>+    .ed = adf7242_ed,
> >>>>+    .set_channel = adf7242_channel,
> >>>>+    .set_hw_addr_filt = adf7242_set_hw_addr_filt,
> >>>>+    .start = adf7242_start,
> >>>>+    .stop = adf7242_stop,
> >>>>+    .set_csma_params = adf7242_set_csma_params,
> >>>>+    .set_frame_retries = adf7242_set_frame_retries,
> >>>>+    .set_txpower = adf7242_set_txpower,
> >>>>+    .set_promiscuous_mode = adf7242_set_promiscuous_mode,
> >>>>+    .set_cca_ed_level = adf7242_set_cca_ed_level,
> >>>
> >>>Nice to see so many callbacks implemented. The only things I see missing
> >>>is xmit_async, set_lbt and set_cca_mode. I would not make it a
> >>>requirements to get these hooked up before merging this patch but we
> >>>should consider it as todo items.
> >>
> >>The part only supports CCA mode Energy above threshold.
> >>Not sure what this LBT mode does on the AT86RFxxx driver.
> >
> >This is for sub 1Ghz regulations in some country (Japan/Europe) area,
> >there CSMA/CA accoridng 802.15.4 isn't allowed at sub 1-Ghz, that's why
> >they introduced LBT.
> >
> >That reminds me to work on a regulator db, again. :-)
> >
> >Nevertheless it should not related to 2.4 Ghz global ISM band, so far I
> >know.
> >
> >>The ADF7242 only supports CSMA-CA and not some other listen before talk
> >>flavour. The only oher option is to turn CSMA-CA completly off.
> >
> >Another thing for ToDo list, add support for turning CSMA-CA handling
> >complete off, many transceiver has such option.
> >
> >There exists ways currently to turn off CSMA handling only by choosing
> >the right backoff exponents, 802.15.4 writes:
> >
> >Note that if macMinBE is set to zero, collision avoidance will be
> >disabled during the first iteration of this algorithm.
> 
> First iteration only? And I think that is for slotted operation.
> I wouldn't overload MinBe with an option to disable CSMA-CA.
> Maybe add a new command?
> 
> 

"CSMA" != "CSMA-CA"

The calculation is for backoff periods (aUnitBackoffPeriod) is:

2^(MINBE + 1) - 1

doesn't matter if slotted/unslotted. See page 23 at [0].

By disable CSMA-CA I usually assume that the CCA status will not
performed. Disable CSMA -> CCA status will be performed.

I agree to add an own command to disable "CSMA-CA", to disable "CSMA" we
have minBe.

> >
> >Okay then another ToDo for wpan-tools would be to make a nice printout
> >that CSMA is disabled if "macMinBE is set to zero".
> >
> >>I'm also not sure if we need to supprot the async mode, while the sync mode
> >>is working. For me the async mode looks like it tries to workaround some HW
> >>access issues.
> >>
> >
> >We came to the conclusion that "sync" callback is a workaround that
> >people can use spi_sync. :-)
> 
> Hmmm - I don't quite understand.
> 
> The difference is that xmit_sync blocks until the packet is transmitted,
> while async returns immediately.

Exact, and "blocking" is not what the netdev api offers by callback
".ndo_start_xmit".

> spi_sync can be only used from context that can sleep. While spi_async
> runs it's own queue and provides a completion callback.
> 
> These radios can only do one thing at the time. And in both cases there are
> queues that are being stopped while the radio driver is busy doing
> something.
> 

Yes, most transceivers has only one framebuffer. Btw: AT86RFxxx has
really only one for rx/tx.

> So the only thing is the IF down/up issue?
> 

I am not sure, I thought about that the whole day and I need to admit: I
think both ways have some races _currently_.

What I am suppose is that we can easier deal which such races when we
use xmit_async without having a workqueue in the middle of
"ndo_start_xmit" and "driver xmit" callback.

Furthermore, with MLME-ops we need to send frames out which are triggered
by a workqueue as well, mac80211 MLME-ops do the same.

But there exist a difference by starting a xmit workqueue from "ndo_start_xmit"
or "netlink command".


----

Btw: while thinking the whole day I detected a "deadlock" (maybe
somebody can confirm it).

At [1], we have ndo_stop callback which is called under RTNL lock. This
will call ieee802154_stop_device, which also flushed the xmit workqueue
(That means it will wait until the workqueue is complete scheduled).
Now the "worker" callback of the xmit workqueue also hold the RTNL lock,
see [2]. If this is called when "stop callback" [1] is waiting for the
workqueue it will wait forever, because the xmit workqueue will wait on
RTNL lock.

That the workqueue held the rtnl lock while transmit was one of my
earlier changes, where somebody had some issues when doing ifdown. Maybe
this change do "something" which fixed it but the real issue was an
another. Now, when stop doing "flush_workqueue" and all netdev queues
(which belongs to a phy) are stopped, then there can't be a 802.15.4
driver "stop" callback.

Also if we wait for the workqueue and the netdev queue was stopped
before, it will be awake again because the driver will finish it.


I have some headache now and I think we need to discuss again about the
correct handling of "transmit" and look if everything works fine then
without races, but it isn't easy. What I currently think is that
"xmit_async" goes to the right direction, that we don't need to deal
with the loosing context of "ndo_start_xmit" when call driver xmit
callback.

> The ADF7242 would actually return an error if the packet wasn’t sent
> or ACKed by the receiver. It's still looks like this information
> isn’t being used anywhere.
> 

Yes, MLME-ops needs this option, we don't have currently any functionality to
tell the "why transmit failed" to upper-layers (mac802154).

Such stats should be available by "iwpan", like "iw station dump" in wireless.
Then you can do some statistic counts. (Maybe the first use case to see
that it works.)

> Not a big deal - but in addition received ACKs (that would potentially
> indicate that the packet was successfully delivered) cause warnings and are
> completely dropped as well.
> 

- Alex

[0] ISBN 978-0-7381-6684-1 STDPD97126 (I hope they handle revisions of
				       802.15.4 standard with this
				       number).
    or simple use this link (found by google):
    http://ecee.colorado.edu/~liue/teaching/comm_standards/2015S_zigbee/802.15.4-2011.pdf
    it's pdf page 43.
[1] http://lxr.free-electrons.com/source/net/mac802154/iface.c#L333
[2] http://lxr.free-electrons.com/source/net/mac802154/tx.c#L41
