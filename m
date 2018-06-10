Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35248 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbeFJPkP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 10 Jun 2018 11:40:15 -0400
Received: by mail-it0-f68.google.com with SMTP id a3-v6so8141814itd.0
        for <linux-wpan@vger.kernel.org>; Sun, 10 Jun 2018 08:40:14 -0700 (PDT)
Date: Sun, 10 Jun 2018 11:39:56 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: netdevice notifier and device private data
Message-ID: <20180610153956.mgzigzfne6shjb4s@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
 <32763.1528486664@localhost>
 <20180609152921.hqfmprmd4ryttaie@x220t>
 <29706.1528570878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29706.1528570878@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Sat, Jun 09, 2018 at 03:01:18PM -0400, Michael Richardson wrote:
> 
> Alexander Aring <aring@mojatatu.com> wrote:
>     > Futhermore user space programs e.g. radvd will do 6lowpan specific
>     > handling on 6lowpan dev->type, it will not work either on tun
>     > devices.
> 
>     > I know that wpantund from NestLabs do this switch, I am very
>     > curious about the reason but I think they do it because the name
>     > is 6LoWPAN. But wpantund is just a SLIP like protocol with
>     > additional radio/foo commands.
> 
> How do they change it then, and what does it do?

They change it with the ioctl() of tun characte device, see [0].

What it does, it just changing the interface type to something else,
also there is no check at all that Linux has this interface type.

User space software e.g. radvd [1] will evaluate this type and doing
specific handling. Obviously changing it to 6LoWPAN and using this code
will confuse everything, because the handling makes only sense for a
6LoWPAN Linux interface which actually also use the 6LoWPAN subsystem.

They just using tun as all other to feed a IPv6 stack on a remote
microcontroller e.g. openthread, contiki, riot. via slip. (wpantund also
allow some radio, foo configuration).

> It totally seems like broken behaviour.  Maybe it's not even intentional.
> Maybe they are just foobar.
> 

They simple don't know what they doing... somebody thought 6LoWPAN need
to be 6LoWPAN, but they actually don't use the 6LoWPAN handling inside
the kernel. _Except_ they doing out of tree stuff which I don't believe.

According to [0] it also works with tun default (I suppsoe raw IPv6),
because ifdef. And they should not change it because they don't use
in-kernel 6LoWPAN functionality.

I really think that this tun/tap feature makes a lot of trouble for some
type changes. I probably introduce lowpan_dev pointer to netdevice and
then check if it's really a 6LoPWAN interface, a dev->type will not
garantuee anymore you have a 6LoWPAN interface. At least in user space
it's not possible to have a check if you really have a 6LoWPAN interface.

- Alex

[0] https://github.com/openthread/wpantund/blob/master/src/util/tunnel.c#L180
[1] https://github.com/reubenhwk/radvd/blob/master/device-linux.c#L75
