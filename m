Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:50909 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeGBRxh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 13:53:37 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so13306285itg.0
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jul 2018 10:53:36 -0700 (PDT)
Date: Mon, 2 Jul 2018 13:53:29 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
Message-ID: <20180702175329.lobhttvi6z6nkdzq@x220t>
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Romuald Cari <romuald.cari@devialet.com>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Cl=C3=A9ment?= Peron <clement.peron@devialet.com>

Hi,

On Mon, Jul 02, 2018 at 03:28:04PM +0200, Clément Péron wrote:
> Could you review it please ?
>

sorry... I was thinking a lot what I can contribute to this patch, I
want to make it short.

I see your use case and your use case has of course a valid point.


What I can say about the code? This socket layer was contributed a lot
in a time where the subsystem was unmaintained. Stefan has some
experience with this socket layer by doing some examples [0].

In my opinion I am confused that a lot of netlink handling is needed to
do "something" with this socket layer. I already thought that we need
some af802154ng for next generation.

Known bug is also RAW sockets on af802154 are totally messed up... but
we don't need them, this can be done by AF_PACKET (just need to think
about similar handling there).

---

Now to your patch, you use skb->cb there. The tc ingress part can
_maybe_? use this control block information. I think this issue is out
of scope because we have also other parts in the code how we pass data
between driver and packet layer with skb->cb -> we simply do it wrong.

I have no problems to have this patch inside but for future we should
tackle a af802154ng with a better UAPI handling.

If we fix skb->cb we just need to think about how to pass such data up
to socket layer.

- Alex

[0] https://github.com/linux-wpan/wpan-tools/tree/master/examples
