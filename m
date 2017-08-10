Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:37610 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdHJMBP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 10 Aug 2017 08:01:15 -0400
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
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
 <20170710120303.5v3wikb3lkpvoao2@omega>
 <1a7c2fd3-fda8-765a-f055-c32302a23879@freenet.de>
 <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com>
From: Balz <Sebastian.balz@freenet.de>
Message-ID: <e2e32fd2-4f23-bcaa-db64-b425e9518068@freenet.de>
Date: Thu, 10 Aug 2017 13:59:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: Balz <s.balz@hm.edu>, linux-wpan@vger.kernel.org

Hi,

as mention the packages seems to be valid expected the package size of 143.
I tried to manipulate the kernel module so that is read the SRAM but 
I've trouble with reading the correct frame length. For me that is to 
deep into kernel programming (I have no knowledge with the Linux kernel).

Temporally we switch to a RIOT based SLIP sniffer.

Thank you very much fro your help.

Best Regards
Sebastian Balz


Am 31.07.2017 um 15:48 schrieb Alexander Aring:
> Hi,
>
> On Sat, Jul 29, 2017 at 8:05 AM, Balz <Sebastian.balz@freenet.de> wrote:
>> Hi Alex,
>>
>> The Atmel/Microchip Team ask me to do not a Frame-Buffer Reader but a SRAM read(addr 0x00-0x7F)
>> I locked through the Code but could not find the Frame-Buffer reading part.
>>
> We start the read frame buffer command at [0].
>
>> I would like to recompile the corresponding part and check if that changes something
>>
> For me it sounds weird. You definitely lost the frame buffer
> protection with that.
> Is there some errata released where it stands you should use SRAM access?
>
> If I would be atmel, then maybe try to use manual locks, see register
> bits "RX_PDT_DIS". If they don't trust that automatic way doesn't
> work.
> You can change the code as well to use the manual way.
>
> - Alex
>
> [0] http://elixir.free-electrons.com/linux/latest/source/drivers/net/ieee802154/at86rf230.c#L758

