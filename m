Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:32977 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbdGJMDQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Jul 2017 08:03:16 -0400
Received: by mail-wr0-f173.google.com with SMTP id r103so135943819wrb.0
        for <linux-wpan@vger.kernel.org>; Mon, 10 Jul 2017 05:03:16 -0700 (PDT)
Date: Mon, 10 Jul 2017 14:03:04 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170710120303.5v3wikb3lkpvoao2@omega>
References: <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
 <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega>
 <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega>
 <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega>
 <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Jul 10, 2017 at 01:50:30PM +0200, Balz wrote:
> Hi,
> 
> thank you as far.
> 
> i do have next Thursday the possibility to get a rpi.
> 
> I'am sorry.
> yes i'am using it as monitor.
> the configuration is :
>     sudo iwpan "$wpan" del
>     sudo iwpan "$phy" interface add "$wpan" type monitor
>     sudo iwpan "$phy" set channel 0 "$channel"
>     sudo ifconfig "$wpan" up
> 
> with $wpan == wpan0, $phy == phy0 and $channel = 26
>

ok. But do you transmit over monitor interface or not? It could be that
the transceiver overwrites framebuffer with tx frames. (only after some
xxx times when going to TX_ON isn't possible, it will do some force
change).

> So i try to get in touch with Atmel/Micochip and report the result.
> 

ok.

- Alex
