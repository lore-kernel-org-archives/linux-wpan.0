Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:56330 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbaKFQye (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 11:54:34 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so1665042wgh.25
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 08:54:33 -0800 (PST)
Date: Thu, 6 Nov 2014 17:54:27 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan with external radio
Message-ID: <20141106165425.GA32499@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
 <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Henning Rogge <hrogge@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

Hi,

On Thu, Nov 06, 2014 at 05:33:51PM +0100, Henning Rogge wrote:
> I had a look at the fakelb driver,
> 
> if I understand it right it just "connect" the raw-frame side of
> multiple 6lowpan interfaces with each other, right? So it might be
> part of the solution...
> 
> the other part should be similar to the tun.c driver... unfortunately
> the tun driver got quite complex from what I can see.
> 

do you use a 802.15.4 radio? Then maybe the serial driver is something
like that what you searching for.

btw. 6LoWPAN is specified for 802.15.4 and btle, maybe there exists also
some other drafts for different L2 layers.


The serial protocol:

There exist a "special" serial protocol v1 and v2.

The serial v2 is only theory concept. v1 is described at [0].

How does it work?

You have some little mcu with an 802.15.4 radio and a special firmware
on it which speaks this protocol via serial bus [0].

On linux side you have a special serial driver [1] which makes an wpan
interface. You can use this driver with any serial device which speaks
this protocol.



Now the big part, this cames never into mainline and I don't want to
accept the current state of driver implementation at [1]. There was also
some subsystem changes. The driver at [1] needs to port to the new
changes. Porting this driver should not be difficult... but there are
also some other parts at this driver why the driver isn't mainlineable.

The idea about a serial driver isn't forgotten but I don't have
currently time to care about that. Have enough to do to keep the
802.15.4 subsystem alive.

- Alex

[0] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/SerialV1
[1] https://github.com/linux-wpan/linux-wpan-next/commit/546618171de2be30236aab86f3ee323b425e2bf5
