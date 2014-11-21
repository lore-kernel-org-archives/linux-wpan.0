Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36725 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbaKUQxr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Nov 2014 11:53:47 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so7170813wgh.4
        for <linux-wpan@vger.kernel.org>; Fri, 21 Nov 2014 08:53:46 -0800 (PST)
Date: Fri, 21 Nov 2014 17:53:40 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Power Management support for IEEE-802.15.4 drivers
Message-ID: <20141121165337.GD20364@omega>
References: <CAEUmHyayKKHF0RfjZvMDM0WjNj=vP7hL5B8h69ZaVv=Y59t0iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEUmHyayKKHF0RfjZvMDM0WjNj=vP7hL5B8h69ZaVv=Y59t0iQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On Mon, Nov 17, 2014 at 02:56:09PM +0530, Varka Bhadram wrote:
> Hi,
> 
> None of IEEE-802.15.4 drivers implement power management. But devices
> (AT86RF230, CC2520) will operate in different power modes.
> 
> Why cant we add these functionalities to the driver, so that we can
> save the overall system power.
> 

For power management we only support currently "interface down all wpan
interfaces?". For at86rf230 this will go into the TRX_OFF state which
has less power usage. There exist also some SLEEP mode, but then I would
need the slp_tr pin to awake maybe the transceiver. Yea we _could_ do
that, but for now I doesn't care about that.

So you could do into some sleep modes on (*stop) and out in (*start).


For REAL power management, this is much complicated. The buzzword for
802.15.4 networks is here "beacon enabled networks" just google it. This
has a lot of todo with GTS (Guaranteed Time Slots).

For now I am NOT an expert into this and we are far away to support such
functionality! We can't parse beacon frames at all and the current
parsing functions are optimize to parse data frames only. This need to
be a lot of work inside mac802154 and we need to create a complete
infrastructure for this.

Currently it's important to save what we have right now. Beacon enabled
networks is a new topic for the future. But I don't want to stop you. If
you like to implement such functionality go ahead and send patches.

I don't know much currently about "beacon enabled networks" I just know
that something like this exists and nothing more. In my opinion a lot of
other things need to be done to implement such functionality.

- Alex
