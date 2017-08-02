Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37467 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdHBS7k (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Aug 2017 14:59:40 -0400
Received: by mail-wm0-f54.google.com with SMTP id t201so277868wmt.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Aug 2017 11:59:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5146468f-566c-40e4-e428-9cac2b90d470@hm.edu>
References: <20170707110011.pwz272ppmwwu2wzh@omega> <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega> <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega> <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega> <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega> <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
 <20170710120303.5v3wikb3lkpvoao2@omega> <1a7c2fd3-fda8-765a-f055-c32302a23879@freenet.de>
 <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com> <5146468f-566c-40e4-e428-9cac2b90d470@hm.edu>
From: Alexander Aring <aring@mojatatu.com>
Date: Wed, 2 Aug 2017 14:59:38 -0400
Message-ID: <CAOHTApi5ZPNRMc0Sy0BBacXWbPnaG-NMedwdb8D9DqzPYM5u4g@mail.gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Aug 2, 2017 at 1:03 PM, Balz <s.balz@hm.edu> wrote:
> Hi Alex,
>
> I've changed the Kernel module so that i read the Framebuffer as SRAM and
> not as FrameBuffer.
> I've write a 0x00n followed by 0x00 to determine a SRAM read from the add=
r
> 0.
>
> But the Kernel Module can not identity the frame length any more.
>
> The Sniffed packages (all Packages have 143 byte length) do not show the
> behaviour any more.
>
> Maybe the SRAM read access is protected and the Frame-buffer Read not...?
>

I think frame buffer read access only.

"Dynamic Frame Buffer Protection is released on the rising edge of pin 23 (=
/SEL)
 during a Frame Buffer read access, or on the radio transceiver=E2=80=99s
state change from
 RX_ON or RX_AACK_ON to another state.", see [0].

unless there is no errata which said is broken for frame buffer I am
not willing to change it to e.g. SRAM which would work.
As the datasheet says "Frame Buffer read access" only and not SRAM, foo.

- Alex

[0] http://www.atmel.com/images/Atmel-8351-MCU_Wireless-AT86RF233_Datasheet=
.pdf
