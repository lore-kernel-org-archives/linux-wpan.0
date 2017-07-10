Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:32861 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdGJJke (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Jul 2017 05:40:34 -0400
Received: by mail-wr0-f172.google.com with SMTP id r103so130892473wrb.0
        for <linux-wpan@vger.kernel.org>; Mon, 10 Jul 2017 02:40:33 -0700 (PDT)
Date: Mon, 10 Jul 2017 11:40:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170710094026.4urdv5bovwiztku7@omega>
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
 <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega>
 <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega>
 <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Jul 10, 2017 at 10:39:34AM +0200, Balz wrote:
> hi,
> 
> I figured out that you can disable the shadow registers (in the regmap dir)
> by writing "y" to "cache_bypass" by the command "echo y > cache_bypass", ore
> by setting the third char to y (in the corresponding line ) in the file
> access but this you cannot do in user space.
> 
> I've checked it out that if you write a "y" to "cache_bypass" that the drive
> reads all defined registers (seen in "range") from the device.
> The value of ref 0x0C stays unchanged.
> 
> I would be very grateful if you could use you connections to Atmel.
> Of cause you can refer to my proved logic-dump and pcap file in my dropbox
> 

tried it, gave up... seems to be everything has changed because
microchip & atmel stuff. You could try it...

You didn't answered my other question:

Do you transmit over monitor interface?

Also I don't have such issues with RPi, do you have some RPi around and
use _mainline_ Linux kernel. Very important _mainline_.

- Alex
