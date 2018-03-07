Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34766 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbeCGPnK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Mar 2018 10:43:10 -0500
Received: by mail-vk0-f49.google.com with SMTP id z190so1576220vkg.1
        for <linux-wpan@vger.kernel.org>; Wed, 07 Mar 2018 07:43:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307133525.GA30047@picapica.im>
References: <20180307133525.GA30047@picapica.im>
From: Alexander Aring <aring@mojatatu.com>
Date: Wed, 7 Mar 2018 10:43:09 -0500
Message-ID: <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
Subject: Re: "encryption failed" warnings in dmesg
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anton Sviridenko <anton@picapica.im>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Wed, Mar 7, 2018 at 8:35 AM, Anton Sviridenko <anton@picapica.im> wrote:
> I send packets through raw socket on ieee802154 network interface using at86rf212b transceiver
> and sometimes get lot of these messages in dmesg:
>
> ieee802154 phy0 wpan0: encryption failed: -22
>
> I've traced place in source that generates them:
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/tx.c
>
> Can someone explain what happens?
> Isn't it supposed for raw packets to be passed as is? I think if packet is encrypted,

it should be, but what you see... yea no. This is a very long
discussion what's is wrong in encryption/decryption handling... it's
made in the wrong places and move it away from it need to solve other
issues - sorry nobody really works on llsec at the moment.

> it should be already encrypted by userspace software that prepared this raw packet.
> Btw, software that sends raw packets is OpenThread, I'm trying to run it on Linux,
> if that matters
>

Yes I did already the same several years ago... See [0].

You need to use monitor interfaces to make it somehow working but be prepared:

1. no hardware address filtering
2. no hardware ack handling

Have fun!

We really like to support Thread stuff on socket layer... and _NOT_ as
user space stack.

> How encryption keys are expected to be set up when encryption is used?
> It seems wpan-tools do not contain such commands.
>

There is a hacky experimental branch. Please prepared:

1. frame counter sync is not defined by peer to peer networks

IEEE doesn't solve this practical issue:

I have a very strong opinion about it:

IETF solved it with MLE, MLE was shutting down, MLE lives still (as a
fork in Thread) which is _closed_ spec.
It was myself a surprise that the MLE is a fork and they made it
forced incompatible with IETF MLE.
Welcome to the world of politics in open standards, where people use
all open standards _except_ the bootstrapping protocol which is
necessary to make something working.

In my opinion Thread should be look more on what they doing on top of
transport layer and rest should be open, but this isn't the case...

2. Framecounter overflow -> you need to distribute new keys

---
Now what I want to see:

I am not part of Thread group and I don't want to be, because I am
sure it doesn't allow me to do open source stuff anymore in some parts
and then I don't know what I can do and what I can't.
I also don't have the money for that.

IDEA, (because we need to deal with that SOMEHOW):

Use open implementation OpenThread and make a library wrapper around
it to use MLE stuff in Linux as daemon and _important_ use Linux stack
and please don't use user space stacks!
I did this [0] for development.

This is my opinion on what way we need to go to provide Thread in Linux.

(btw: my talk at netdev2.1 in Montreal exactly was about MLE and the
mess that we need to support it to talk with "commercial" products
outside) [1]

I am close to release my stuff from [2] which makes the development a
lot of easier.

- Alex

[0] https://groups.google.com/forum/#!msg/openthread-users/BXOk9JfDsqY/r4E6T5RmBwAJ
[1] https://www.youtube.com/watch?v=rseB3PsPWHg
[2] https://www.youtube.com/watch?v=iMYCaqHVmS0
