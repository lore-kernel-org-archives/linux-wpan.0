Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34767 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbdGHSLU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Jul 2017 14:11:20 -0400
Received: by mail-wr0-f181.google.com with SMTP id 77so86768107wrb.1
        for <linux-wpan@vger.kernel.org>; Sat, 08 Jul 2017 11:11:20 -0700 (PDT)
Date: Sat, 8 Jul 2017 20:11:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170708181113.htxnpxrzxgsrqyva@omega>
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170708180631.l7lddi475pmua33o@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Sat, Jul 08, 2017 at 08:06:48PM +0200, Alexander Aring wrote:
...
> 
> > The Registers a configured as:
> > 
> > cat /sys/kernel/debug/regmap/spi1.0/registers
> > 
> > 01: 16
> > 02: 16
> > 03: 00
> > 04: 20
> > 05: 00
> > 06: 20
> > 07: ff
> > 08: 1a
> > 09: 00
> > 0a: 00
> > 0b: 00
> > 0c: a0
> 
> RX_SAFE_MODE is 1 here, good.
> 

It could be that I misunderstood the datasheet, and the RX_SAFE_MODE is
"released" on loosing CS. Which means we need to reenable the bit after
each received frame.

maybe you could check that? :-/

- Alex
