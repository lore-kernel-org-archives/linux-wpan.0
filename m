Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35881 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdHCL1I (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Aug 2017 07:27:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id t201so12545343wmt.1
        for <linux-wpan@vger.kernel.org>; Thu, 03 Aug 2017 04:27:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOHTApjS9h+RXtdJzCbhA+8ixYL9LvRAKa=3uLa+qHJrf277MA@mail.gmail.com>
References: <20170707110011.pwz272ppmwwu2wzh@omega> <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega> <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega> <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega> <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega> <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
 <20170710120303.5v3wikb3lkpvoao2@omega> <1a7c2fd3-fda8-765a-f055-c32302a23879@freenet.de>
 <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com>
 <5146468f-566c-40e4-e428-9cac2b90d470@hm.edu> <CAOHTApi5ZPNRMc0Sy0BBacXWbPnaG-NMedwdb8D9DqzPYM5u4g@mail.gmail.com>
 <CAB_54W5+pnKoL2LzfwfqsOOXVj0BG6dNRstJMFkrX1fG9mm=kA@mail.gmail.com> <CAOHTApjS9h+RXtdJzCbhA+8ixYL9LvRAKa=3uLa+qHJrf277MA@mail.gmail.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 3 Aug 2017 07:27:06 -0400
Message-ID: <CAOHTAphROv01OiuMKsAJ8Oes6DRYUD6qcR8Gx97+uxX2xTAouA@mail.gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Wed, Aug 2, 2017 at 6:16 PM, Alexander Aring <aring@mojatatu.com> wrote:
> Hi,
>
...
>>
>> It's "... to another state."... Maybe when a RX irq occurs during the
>> spi async handling there could be some "xmit" callbacks... This will
>> change the transceiver into another state... (not directly, but so far
>> I know it queues for state change). So when it will automatically go
>> into RX_AACK_ON then it will change the state to something else and
>> allows framebuffer overwrite.
>
> it could be that there exists a race when stop queue is running and
> currently a xmit is going on...
> I currently have no idea how to solve it and need to have more details
> what happens when the transceiver is in BUSY_RX and we do another
> state change? Will it be queued or not (so after BUSY_RX it will
> change to RX_ON and then another state)?
>

Sorry, I remember... you told you don't send anything? Then this can't
be the issue. :-(
... but maybe we should stop transmit queue while receiving.

- Alex
