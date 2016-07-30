Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50055 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcG3WCd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 30 Jul 2016 18:02:33 -0400
Subject: Re: Looking for boards with an 802.15.4 chip
References: <20160728174051.GB75405@redhat.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e65bd287-bfba-c92b-ac64-0e1c758a3e03@datenfreihafen.org>
Date: Sun, 31 Jul 2016 00:02:29 +0200
MIME-Version: 1.0
In-Reply-To: <20160728174051.GB75405@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>, "aar@pengutronix.de" <aar@pengutronix.de>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linville@redhat.com" <linville@redhat.com>

Hello.

On 28.07.2016 19:40, Don Zickus wrote:
> Hi Alexander,
> 
> I was wondering what boards/chips folks like yourself use to develop/test
> the 802.15.4 work?  I noticed the website  http://wpan.cakelab.org/ mentions
> a bunch of boards.  Some of those pointers don't work and the ones that do,
> show standalone boards that need to be wired up to a SPI bus.
> 
> I assume the SPI bus is easily found on a rPI-like board.  Is it difficult to
> hook one of them up to an x86 desktop?

You might be able to do this with some USB dongle exposing some GPIOs to
to the kernel but I never used anything like that. Most of my
transceivers are connected to Pi's. So it goes down to embedded.

I'm in the lucky position though to have two ATUSB dongles which are
simple USB dongles and get connected to your x86 systems with ease.
They work out of the box in mainline since 4.1 and the firmware is open
source as well. The problem right now is that it is now longer being sold.

We are working on changing this though. See my mail from a few minutes
ago to this list about interest for a new ATUSB production batch.
Right now we would estimate them being on sale again sometime in October
(the smaller fabs we are using for SMT is on holiday and we also need to
prepare things in our spare time).

If this is to far away, fair enough. If it does not really matter to you
and you would have an interest to use them please let me know so I can
better estimate the needed number of devices for the batch.

regards
Stefan Schmidt
