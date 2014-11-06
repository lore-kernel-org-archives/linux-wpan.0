Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:48966 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaKFSYM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 13:24:12 -0500
Received: by mail-wg0-f48.google.com with SMTP id m15so1898921wgh.21
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 10:24:11 -0800 (PST)
Date: Thu, 6 Nov 2014 19:24:05 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan with external radio
Message-ID: <20141106182403.GA2321@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
 <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega>
 <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
 <20141106170830.GB32499@omega>
 <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Carlo Vallati <carlo.vallati@iet.unipi.it>
Cc: Henning Rogge <hrogge@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

On Thu, Nov 06, 2014 at 06:55:11PM +0100, Carlo Vallati wrote:
> Hi,
> you can also take a look at this work in progress of mine [0] in which I'm
> implementing a driver for the Xbee s1 cards.
> The implementation is still a work in progress, so it has only the basic TX
> and RX operations and it includes the latest subsystem changes (at least
> the version included in the 3.16 kernel).
> The driver communicates with the Xbee s1 card using a serial protocol to
> receive/send raw data, while most of the 802.15.4 are implemented in
> hardware (for this reason its structure follows the fakehard.c driver).
> 

well, I removed now any HardMAC functionality because it never had any
functionality. For example [0].

This was used by the fakehard driver but there was no real netlink
interface which used these calls. HardMAC driver is another topic for
the future.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=9f3295b9ea8e54a6c65231d267f069edf420b64f
