Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46643 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaKFSBz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 13:01:55 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so2296376wid.10
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 10:01:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org> <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega> <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
 <20141106170830.GB32499@omega> <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
From: Henning Rogge <hrogge@gmail.com>
Date: Thu, 6 Nov 2014 19:01:32 +0100
Message-ID: <CAGnRvupUvS5ibUiqSz=2JCyYJN1ePgskfW85qyPRGeiKwW2apw@mail.gmail.com>
Subject: Re: 6lowpan with external radio
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Carlo Vallati <carlo.vallati@iet.unipi.it>
Cc: Alexander Aring <alex.aring@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

On Thu, Nov 6, 2014 at 6:55 PM, Carlo Vallati
<carlo.vallati@iet.unipi.it> wrote:
> Hi,
> you can also take a look at this work in progress of mine [0] in which I'm
> implementing a driver for the Xbee s1 cards.
> The implementation is still a work in progress, so it has only the basic TX
> and RX operations and it includes the latest subsystem changes (at least the
> version included in the 3.16 kernel).
> The driver communicates with the Xbee s1 card using a serial protocol to
> receive/send raw data, while most of the 802.15.4 are implemented in
> hardware (for this reason its structure follows the fakehard.c driver).

I will have a look at it... thank you.

> Even if your radio it's not 802.15.4, maybe you can emulate/simulate some of
> the operations and information needed by the upper layers.

If I understand the difference between the "soft" and the "hard" style
drivers right, the soft ones can work with a more stupid hardware,
correct?

Henning
