Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36345 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbbE1La0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 07:30:26 -0400
Received: by wizk4 with SMTP id k4so143226004wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 04:30:25 -0700 (PDT)
Date: Thu, 28 May 2015 13:30:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150528113017.GC716@omega>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
 <20150525074133.GH11340@wantstofly.org>
 <20150526085615.GA2747@omega>
 <20150527124550.GZ11340@wantstofly.org>
 <20150527134609.GF712@omega>
 <20150527161147.GA18033@omega>
 <20150528103613.GC11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150528103613.GC11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

On Thu, May 28, 2015 at 01:36:14PM +0300, Lennert Buytenhek wrote:
...
> > 
> > But one of these modes (max_frame_retries = -1 OR max_frame_retries >=
> > 0) should be supported and AACK handling should also always supported.
> 
> Hardware that only supports max_frame_retries = -1 is clearly not
> 802.15.4 compliant -- how much of such hardware is there out there?
> 

This is correct, because 802.15.4 default is max_frame_retries = 3. I
never saw a transceiver which doesn't support ARET handling in hardware
by transceiver.

What we do currently is:

If a transceiver doesn't support handling of setting max_frame_retries
parameters then we assume the 802.15.4 defaults. We can't say if it's
really supported or not, depends on driver implementation.

And currently for max_frame_retries we assume "-1" which is not correct,
because 802.15.4 describes "3" as default. But again, this is only to
hold backwardscompability with nodes which doesn't support AACK.

> 
> > Maybe I should draw some graphics to display what the meaning of
> > max_frame_retries really is. At the end each driver should follow all
> > the same meaning of this value.
> 
> I think it's clear to me.

ok.

- Alex
