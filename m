Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:48657 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKFRIh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 12:08:37 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so1699589wgh.25
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 09:08:36 -0800 (PST)
Date: Thu, 6 Nov 2014 18:08:33 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan with external radio
Message-ID: <20141106170830.GB32499@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
 <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega>
 <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Henning Rogge <hrogge@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

Hi,

On Thu, Nov 06, 2014 at 06:00:49PM +0100, Henning Rogge wrote:
> On Thu, Nov 6, 2014 at 5:54 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> > Hi,
> >
> > On Thu, Nov 06, 2014 at 05:33:51PM +0100, Henning Rogge wrote:
> >> I had a look at the fakelb driver,
> >>
> >> if I understand it right it just "connect" the raw-frame side of
> >> multiple 6lowpan interfaces with each other, right? So it might be
> >> part of the solution...
> >>
> >> the other part should be similar to the tun.c driver... unfortunately
> >> the tun driver got quite complex from what I can see.
> >>
> >
> > do you use a 802.15.4 radio? Then maybe the serial driver is something
> > like that what you searching for.
> 
> No, its not a 802.15.4 radio... its mostly layer 1 and some "listen
> before talk/ALOHA" media access. I can send it raw frames (with a few
> header fields) and get everything the radio receives via serial port.
> 
> A friend of mine suggested looking into 6lowpan instead of writing my
> own fragmentation/IP-compression/... scheme. The radio is very slow,
> so I need something efficient.
> 

don't know how you can run 6LoWPAN on it. There exist 802.15.4 6LoWPAN
[0] and BTLE 6LoWPAN [1]. You need many L2 informations at 6LoWPAN level
for exmaple running IPv6 compression mechanism.

- Alex

[0] https://tools.ietf.org/html/rfc4944 - also see 6282 and 6775
[1] http://tools.ietf.org/html/draft-ietf-6lo-btle-03 (hope this is the newest one)
