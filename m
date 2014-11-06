Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33928 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKFTeu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 14:34:50 -0500
Received: by mail-wg0-f51.google.com with SMTP id l18so2030344wgh.10
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 11:34:48 -0800 (PST)
Date: Thu, 6 Nov 2014 20:34:46 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan with external radio
Message-ID: <20141106193445.GD2321@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
 <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega>
 <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
 <20141106170830.GB32499@omega>
 <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
 <20141106182403.GA2321@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141106182403.GA2321@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Carlo Vallati <carlo.vallati@iet.unipi.it>
Cc: Henning Rogge <hrogge@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

Hi Carlo,

On Thu, Nov 06, 2014 at 07:24:03PM +0100, Alexander Aring wrote:
> On Thu, Nov 06, 2014 at 06:55:11PM +0100, Carlo Vallati wrote:
> > Hi,
> > you can also take a look at this work in progress of mine [0] in which I'm
> > implementing a driver for the Xbee s1 cards.
> > The implementation is still a work in progress, so it has only the basic TX
> > and RX operations and it includes the latest subsystem changes (at least
> > the version included in the 3.16 kernel).
> > The driver communicates with the Xbee s1 card using a serial protocol to
> > receive/send raw data, while most of the 802.15.4 are implemented in
> > hardware (for this reason its structure follows the fakehard.c driver).
> > 
> 
> well, I removed now any HardMAC functionality because it never had any
> functionality. For example [0].
> 
> This was used by the fakehard driver but there was no real netlink
> interface which used these calls. HardMAC driver is another topic for
> the future.
> 

this will not mean that I don't accept HardMAC drivers. I do now a
rework of this branch which looks very similar like wireless/mac80211
afterwards.

The HardMAC functionality should be look like wireless. This
means a cfg802154 implementation inside driver layer. Also netdev
allocation/registration etc.. is inside driver layer. cfg802154 is just
a callback structure for the netlink 802.15.4 calls.

Really the current mainline HardMAC functionality was in some broken
state which never had any functionality.


I hope you are not too frustrated now. :-)

- Alex
