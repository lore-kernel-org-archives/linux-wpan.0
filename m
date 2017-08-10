Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36730 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdHJQjE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Aug 2017 12:39:04 -0400
Received: by mail-wm0-f42.google.com with SMTP id t201so24105875wmt.1
        for <linux-wpan@vger.kernel.org>; Thu, 10 Aug 2017 09:39:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2e32fd2-4f23-bcaa-db64-b425e9518068@freenet.de>
References: <20170707110011.pwz272ppmwwu2wzh@omega> <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega> <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega> <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega> <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega> <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
 <20170710120303.5v3wikb3lkpvoao2@omega> <1a7c2fd3-fda8-765a-f055-c32302a23879@freenet.de>
 <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com> <e2e32fd2-4f23-bcaa-db64-b425e9518068@freenet.de>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 10 Aug 2017 12:39:02 -0400
Message-ID: <CAOHTApjGxwLp2YEsyHyx2gE7L9DYEA8VsobgZUcQiC4nqiUm1g@mail.gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <Sebastian.balz@freenet.de>
Cc: Balz <s.balz@hm.edu>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Thu, Aug 10, 2017 at 7:59 AM, Balz <Sebastian.balz@freenet.de> wrote:
> Hi,
>
> as mention the packages seems to be valid expected the package size of 143.
> I tried to manipulate the kernel module so that is read the SRAM but I've
> trouble with reading the correct frame length. For me that is to deep into
> kernel programming (I have no knowledge with the Linux kernel).
>

so you mention that you got a frame length which is not valid. It
can't be large than 127.
This is an on the air field (PHR), so it could be that somebody while
transmitting is wrong.
_IMPORTANT_ this (PHR) field is not part of CRC (FCS).
Also we filter on such frame length and read the whole framebuffer
then and trim it to 127 bytes (for monitoring could be interesting)...

I would check with an e.g. ATUSB if you receive the same frames... I
would only trust other sniffer devices if you know how they filter or
simple drop such frames or do whatever their policy is.

btw:

I bet many other drivers doesn't check on valid PHR field and so far
they run into bufferoverflows...

- Alex
