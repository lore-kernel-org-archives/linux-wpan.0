Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34885 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbFAOmW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 10:42:22 -0400
Received: by wicmx19 with SMTP id mx19so77963046wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 07:42:20 -0700 (PDT)
Date: Mon, 1 Jun 2015 16:42:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC ben-wpan] atusb: fw: add support for rzusbstick
Message-ID: <20150601144213.GF1195@omega>
References: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
 <5565969E.8060000@osg.samsung.com>
 <20150601133815.GB1195@omega>
 <556C6D96.9010007@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <556C6D96.9010007@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Werner Almesberger <werner@almesberger.net>

On Mon, Jun 01, 2015 at 04:35:02PM +0200, Stefan Schmidt wrote:
...
> I looked around to find places to get a rzusb dongle the best offer with
> stock I found is this:
> http://www.digikey.de/product-search/de?vendor=0&keywords=ATAVRRZUSBSTICK
> 
> Is this reasonable? Thinking about getting one to have it for testing.
> 

I found [0]. Maybe cheaper, don't know the shipping costs.

We can collect all "Where to buy" on wpan.cakelab.org. But remember you
need some programmer for first firmware programming (now always because
we don't have DFU). 

You see the damn small pinout on pic [1]? That's the programmer pins,
this maybe look at digikey what other customers also bought, I think
that's maybe some pin header and cable which fits in there. Or you doing
this stuff inside your next hackerspace.

- Alex

[0] http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module
[1] http://media.digikey.com/photos/Atmel%20Photos/ATAVRRZUSBSTICK.JPG
