Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:48521 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964826AbeAXRYg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 24 Jan 2018 12:24:36 -0500
Date: Wed, 24 Jan 2018 18:24:34 +0100
From: anton@picapica.im
Subject: Re: reading RSSI value
Message-ID: <20180124172434.GA5251@picapica.im>
References: <20180121122454.GA24136@picapica.im>
 <CAB_54W6mxa4f3Sy97psaYqYGf9Xp+7SY_imv91U=YK9y_-iMiQ@mail.gmail.com>
 <CAB_54W5qcYR4oyqAUv0Bc2nCjEbKHSgzpRF4i2xtLsTHaNw=2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB_54W5qcYR4oyqAUv0Bc2nCjEbKHSgzpRF4i2xtLsTHaNw=2Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Jan 22, 2018 at 02:02:09PM -0500, Alexander Aring wrote:
> Hi,
> 
> 2018-01-21 12:59 GMT-05:00 Alexander Aring <alex.aring@gmail.com>:
> > Hi,
> >
> > 2018-01-21 7:24 GMT-05:00  <anton@picapica.im>:
> >> Hello
> >>
> >> Is it possible to somehow read RSSI (Received Signal Strength indicator) value for each ieee802154 frame
> >> received using raw socket? Quick grepping in kernel and wpan-tools sources says no, but just wanted to
> >
> > One note about raw sockets: you should use AF_PACKET RAW as socket type.
> >
> > The answer is no. A single RSSI value of a frame says nothing about
> > something... We want to collect them in kernelspace e.g. wireless
> > station dump and make some mapping from $NODE_ADDR (complicated
> > because short/extended mapping).
> > There exists some thesis branch on github which I did for my "thesis"
> > but not ready to bring upstream at all...
> >
> >> confirm. Could energy detection level value used instead? Also, is it possible to set transmitter power
> >
> > Also no energy detection and no LQI...
> >
> > Transmit power is possible (depends on driver support), but not per frame...
> >
> 
> got a new idea about to handle this per frame. Talked with one of the
> TC maintainers today... I think it would be nice to have a TC action
> where you can set a transmit power per classifier... not sure there
> exists many way how to handle it. Also there was an idea according to
> 6lowpan to handle it per ndisc entry. :-/
> 
> If you really want to set it per frame. 802.11 people might be
> interessted in the "wireless tx power TC action" as well...
> 
> - Alex


But changing transmit power is possible in runtime, isn't it?
I mean, without bringing interface down/up. Or not?
Is it supported by at86rf230 driver for at86rf212 chip? It seems that yes

Anton

