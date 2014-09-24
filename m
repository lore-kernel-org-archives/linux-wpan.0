Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56931 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaIXGgE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 02:36:04 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so6520307wiv.11
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 23:36:02 -0700 (PDT)
Date: Wed, 24 Sep 2014 08:35:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
Message-ID: <20140924063554.GA5858@omega>
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
 <20140916070156.GB1244@omega>
 <541899D8.4020101@componentsw.com>
 <20140916202000.GF6104@omega>
 <5420EE4F.5000007@signal11.us>
 <54226075.8050105@componentsw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54226075.8050105@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: Alan Ott <alan@signal11.us>, linux-wpan@vger.kernel.org, simon.vincent@xsilon.com

On Tue, Sep 23, 2014 at 11:11:01PM -0700, Walter Mack wrote:
> 
> On 09/22/2014 08:51 PM, Alan Ott wrote:
> >On 09/16/2014 04:20 PM, Alexander Aring wrote:
> >>Hi Walter,
> >>
> >>On Tue, Sep 16, 2014 at 01:13:12PM -0700, Walter Mack wrote:
> >>>Alex,
> >>>
> >>>this is not a question of chip revisions. Chips with the same revision
> >>>can
> >>>be used in designs with or without the external transmitter/receiver.
> >>>Its
> >>>just that the chip has to be set up to be compatible with the design.
> >>>
> >>ah, ok. Dunno, I will wait on alan's opinion. If I don't heard anything
> >>in one
> >>week I will apply it.
> >
> >Did Simon's patch get applied? I couldn't see it in any of the obvious
> >places when I looked the other day.
> >
> >>
> >>Maybe alan wants also add a device tree support for this driver and then
> >>we could
> >>make a dt property/platform data for that. But for now, I am also fine
> >>with module
> >>parameter solution... because we don't have a dt support right now.
> >>
> >
> >I don't like this as a module parameter. That's not what module params are
> >really designed for. It's better as DT so that it can be turned on and off
> >for the individual devices, not system-wide.
> This is a valid point.

ack.

> >mrf24j40 loads up fine under DT. There just isn't anything to configure
> >(so far) other than the SPI.
> >
> >Are there any other known boards which use the external amplifier besides
> >the MB and MC (and MD and ME, which are the same as the MB and MC)?
> Mine does. It is a custom design that hooks up to the extension port of the
> Raspberry PI. It doesn't have a product name..
> >
> >Alex, I'm not sure how this fits with Simon's patch, as I haven't
> >investigated it fully. I'd expect both implementations to be the same, but
> >they're not.
> Is Simon's patch available for me to have a look at?
> 

I upload it now to pastie.org... [0].

I want to try to add this patch in a seperate branch but this patch doesn't
apply on linux-wpan. There must be changes in the middle of them which
are not mainline. Diff reports about line 813, but the end of the file
is line 802.

Simon can you confirm this? I never tried to apply it since there was
other review notes.

The same what your patch does and Simon's is the setting of
REG_TESTMODE.

- Alex

[0] http://pastie.org/9589875
