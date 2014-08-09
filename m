Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62808 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaHIIfu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 04:35:50 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so2029189wiv.1
        for <linux-wpan@vger.kernel.org>; Sat, 09 Aug 2014 01:35:49 -0700 (PDT)
Date: Sat, 9 Aug 2014 10:35:44 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140809083542.GA15408@omega>
References: <CAAkeqgWGgHLeFpaGM-AYFZkfcAMWydcnW__ow+pf5_c0c+C8jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAkeqgWGgHLeFpaGM-AYFZkfcAMWydcnW__ow+pf5_c0c+C8jA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: Atmel at86rf212 and 'b' support in Linux
To: Andrey Yurovsky <yurovsky@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Aug 08, 2014 at 02:58:21PM -0700, Andrey Yurovsky wrote:
> Hi Alex.  I'm working with the at86rf212b and we're using the
> at86rf230.c from mainline.  There's a version check there that
> specifically rejects anything except version 1:
> 
>         case 7:
>                 chip = "at86rf212";
>                 if (version == 1) {
>                         lp->data = &at86rf212_data;
>                         lp->dev->flags |= IEEE802154_HW_LBT;
>                         lp->dev->phy->channels_supported[0] = 0x00007FF;
>                         lp->dev->phy->channels_supported[2] = 0x00007FF;
>                 } else {
>                         rc = -ENOTSUPP;
>                 }
>                 break;
> 
> ...and our hardware returns version 3.  I've removed this check and
> things seem to work and I've also discussed it with two Atmel FAEs and
> they don't see any reason for this check to be performed or for the
> driver to have different behavior for the different revisions (they're
> going to send me a change list for the HW either way).
> 
> Do you know more about this?  Is there a specific issue this check is
> trying to address?  If not, would you mind if I submitted a patch that
> removes it?
> 

This is there because nobody tested the driver with another version than
1. If you tested it, please send patches. There is no other reason why
we check on version 1 there. If nobody tested it, you can never be sure
it's working then.

- Alex
