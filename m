Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34300 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbbHDSrR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Aug 2015 14:47:17 -0400
Received: by wibud3 with SMTP id ud3so189265351wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 04 Aug 2015 11:47:16 -0700 (PDT)
Date: Tue, 4 Aug 2015 20:47:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 2/6] ieee802154: add helpers for frame
 control checks
Message-ID: <20150804184734.GB22802@omega>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
 <55C0E859.2010503@osg.samsung.com>
 <20150804174412.GA22216@omega>
 <55C105F5.80801@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55C105F5.80801@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Aug 04, 2015 at 08:35:33PM +0200, Stefan Schmidt wrote:
...
> >right it doesn't manipulate the skb. For the "problems like we did with
> >the 6lowpan" you need to decide which problems, I see several:
> >
> >  - running skb_pull (which removes) buffer and we don't have the room to
> >    pull out the bytes of skb, example: skb->len = 3, skb_pull size is 4
> >    which ends in a BUG(), we need to check it with skb_may_pull before.
> 
> Sorry, I should have been a bit more verbose here to make it clearer. I
> meant the above.
> 

This doesn't happend here. It's just dereferencing frame control field
which should be always at beginning of skb_mac_header. We need the
unaligned access, because we cannot assume that the address is at an
aligned address.

And the frame control field is in little endian byte order, we simple
use the byte order which we also transmit (everywhere).

- Alex
