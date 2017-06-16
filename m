Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37420 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbdFPNYZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Jun 2017 09:24:25 -0400
Received: by mail-wm0-f53.google.com with SMTP id d73so23860478wma.0
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2017 06:24:24 -0700 (PDT)
Date: Fri, 16 Jun 2017 15:24:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ieee802154: bad frame received (type = 0)
Message-ID: <20170616132416.zx2akoo2othdflke@omega>
References: <CAAK7Ti--Z6rpE8rfUcCRADc8YJ8pWcw65dsOZnm3bx+rofWirw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAK7Ti--Z6rpE8rfUcCRADc8YJ8pWcw65dsOZnm3bx+rofWirw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jun 16, 2017 at 05:30:14PM +0530, JANARDHANACHARI KELLA wrote:
> Hi,
> 
> I am trying to use the at86rf233 radio with raspberry pi3 and kernel
> 4.4.50. that kernel has cloned from git/raspberrypi.
> 

this is a known bug of raspberrypi kernel which seems they don't fix it
either and fixed in newer raspberrypi kernels.

Please do the steps [0].

Also I recommend it to use _mainline_ linux kernel from kernel.org - I
will give no support at all for non mainline kernels, because I don't
know what rpi people do there and I don't care about it what they do there.

"NOTE: for the latest Raspbian and its Linux-Kernel v4.4.x these steps
are mandatory, as the 802.15.4 transceivers are not working correctly.
Hopefully, this issue will be fixed in the next release." as you see on
[0].

Finally: I never had such issues with mainline linux kernel, so please
folks don't use raspberry pi kernel images and report issues about that
here - we do mainline linux only!

- Alex

[0] https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbian-image-with-6LoWPAN-support
