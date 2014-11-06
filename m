Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43372 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaKFS2k (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 13:28:40 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1881385wgg.8
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 10:28:38 -0800 (PST)
Date: Thu, 6 Nov 2014 19:28:36 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan with external radio
Message-ID: <20141106182833.GB2321@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
 <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega>
 <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
 <20141106170830.GB32499@omega>
 <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
 <CAGnRvupUvS5ibUiqSz=2JCyYJN1ePgskfW85qyPRGeiKwW2apw@mail.gmail.com>
 <545BBA58.8040703@iet.unipi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545BBA58.8040703@iet.unipi.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Carlo Vallati <carlo.vallati@iet.unipi.it>
Cc: Henning Rogge <hrogge@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Thu, Nov 06, 2014 at 07:13:44PM +0100, Carlo Vallati wrote:
> On 11/06/2014 07:01 PM, Henning Rogge wrote:
> > On Thu, Nov 6, 2014 at 6:55 PM, Carlo Vallati
> > <carlo.vallati@iet.unipi.it> wrote:
> >> Hi,
> >> you can also take a look at this work in progress of mine [0] in which I'm
> >> implementing a driver for the Xbee s1 cards.
> >> The implementation is still a work in progress, so it has only the basic TX
> >> and RX operations and it includes the latest subsystem changes (at least the
> >> version included in the 3.16 kernel).
> >> The driver communicates with the Xbee s1 card using a serial protocol to
> >> receive/send raw data, while most of the 802.15.4 are implemented in
> >> hardware (for this reason its structure follows the fakehard.c driver).
> > 
> > I will have a look at it... thank you.
> > 
> >> Even if your radio it's not 802.15.4, maybe you can emulate/simulate some of
> >> the operations and information needed by the upper layers.
> > 
> > If I understand the difference between the "soft" and the "hard" style
> > drivers right, the soft ones can work with a more stupid hardware,
> > correct?
> 
> Take a look here [0], in HardMAC devices the MAC layer is implemented in
> the device itself, in SoftMAC the MAC layer is mainly implemented in
> software, as the hardware is merely a radio transceiver.
> 
> [0] https://www.kernel.org/doc/Documentation/networking/ieee802154.txt
> 

This Documentation is mostly outdated will be updated after finished the
rework.

HardMAC drivers have some special protocol. For example MLME operations
the driver only know's the interface. Doing the algorithmn is done by
transceiver. The transceiver offers these interface to start such MLME
operation.

- Alex
