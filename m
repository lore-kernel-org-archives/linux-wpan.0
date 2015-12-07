Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34232 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbbLGNxW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Dec 2015 08:53:22 -0500
Date: Mon, 7 Dec 2015 14:53:17 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
Message-ID: <20151207135312.GB20826@omega>
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com>
 <56657FCA.9000502@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56657FCA.9000502@analog.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, marcel@holtmann.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Mon, Dec 07, 2015 at 01:47:06PM +0100, Michael Hennerich wrote:
...
> >>+static struct ieee802154_ops adf7242_ops = {
> >>+    .owner = THIS_MODULE,
> >>+    .xmit_sync = adf7242_xmit,
> >>+    .ed = adf7242_ed,
> >>+    .set_channel = adf7242_channel,
> >>+    .set_hw_addr_filt = adf7242_set_hw_addr_filt,
> >>+    .start = adf7242_start,
> >>+    .stop = adf7242_stop,
> >>+    .set_csma_params = adf7242_set_csma_params,
> >>+    .set_frame_retries = adf7242_set_frame_retries,
> >>+    .set_txpower = adf7242_set_txpower,
> >>+    .set_promiscuous_mode = adf7242_set_promiscuous_mode,
> >>+    .set_cca_ed_level = adf7242_set_cca_ed_level,
> >
> >Nice to see so many callbacks implemented. The only things I see missing
> >is xmit_async, set_lbt and set_cca_mode. I would not make it a
> >requirements to get these hooked up before merging this patch but we
> >should consider it as todo items.
> 
> The part only supports CCA mode Energy above threshold.
> Not sure what this LBT mode does on the AT86RFxxx driver.

This is for sub 1Ghz regulations in some country (Japan/Europe) area,
there CSMA/CA accoridng 802.15.4 isn't allowed at sub 1-Ghz, that's why
they introduced LBT.

That reminds me to work on a regulator db, again. :-)

Nevertheless it should not related to 2.4 Ghz global ISM band, so far I
know.

> The ADF7242 only supports CSMA-CA and not some other listen before talk
> flavour. The only oher option is to turn CSMA-CA completly off.

Another thing for ToDo list, add support for turning CSMA-CA handling
complete off, many transceiver has such option.

There exists ways currently to turn off CSMA handling only by choosing
the right backoff exponents, 802.15.4 writes:

Note that if macMinBE is set to zero, collision avoidance will be
disabled during the first iteration of this algorithm.

Okay then another ToDo for wpan-tools would be to make a nice printout
that CSMA is disabled if "macMinBE is set to zero".

> I'm also not sure if we need to supprot the async mode, while the sync mode
> is working. For me the async mode looks like it tries to workaround some HW
> access issues.
> 

We came to the conclusion that "sync" callback is a workaround that
people can use spi_sync. :-)

Ununfortunately the nfc subsystem works also which such sync callback.

Currently working of sync xmit:

 - ieee802154_tx (softirq context, might_sleep() will fail).
    - set parameters schedule workqueue /* queue_work(...) */
      /* sleeping phase */ <-- we lost the context of ieee802154_tx, the
                               locks are not held anymore. Others
                               netdev_ops are possible.
 - ieee802154_xmit_worker will be scheduled <--- Does this still
 						 working if a stop
						 callback was running
						 inside the
						 "sleeping phase"?
    - /* sleeping: wait for completion */ when tx complete is triggered
                                          irq triggered.

With async:

The context of ieee802154_tx will be held until the driver "xmit_async"
callback is done. This callback should call spi_async which cannot be
interrupted until the "last" complete callback is done.

Then a stop callback can occur at the time where the hardware "actually"
transmit the frame. This is a complete async process, there is no "wait
for completion" anymore. The complete replacement would be
"ieee802154_xmit_complete".

Drivers should also disable/enable the tx/rx irq's when doing stop/start,
if possible.

- Alex
