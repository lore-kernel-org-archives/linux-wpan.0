Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:38863 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeCLP1m (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 12 Mar 2018 11:27:42 -0400
Received: by mail-io0-f170.google.com with SMTP id d21so4521513ioc.5
        for <linux-wpan@vger.kernel.org>; Mon, 12 Mar 2018 08:27:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180311173039.GA18490@picapica.im>
References: <20180307133525.GA30047@picapica.im> <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
 <20180310172932.GA17439@picapica.im> <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
 <CAOHTApgcEvkckSgCQ_cen-4Q2CTMwuQy8WReeZs-M4Zj6PfPiQ@mail.gmail.com>
 <20180311123745.GA11826@picapica.im> <CAB_54W7MUCeYj1Nvh0nuvf=MVNrM3HNZ=s3VvAz1imRd-RZm1w@mail.gmail.com>
 <20180311173039.GA18490@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 12 Mar 2018 11:27:41 -0400
Message-ID: <CAB_54W7oBCws2C--1aGSOF65XoBTWpdHKx3p1eJnKe8BX0FoKQ@mail.gmail.com>
Subject: Re: "encryption failed" warnings in dmesg
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: Alexander Aring <aring@mojatatu.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-03-11 13:30 GMT-04:00  <anton@picapica.im>:
> On Sun, Mar 11, 2018 at 09:34:39AM -0400, Alexander Aring wrote:
>>
>> > Seems working so far, at least instances are able to see each
>> > other, pair up and even occasionally ping each other from CLI.
>>
>> be prepared that the kernel will filter some stuff, you should change
>> it that it will not do it. I think we would accept a patch to make
>> that possible. The kernel is filtering -> you don't running a user
>> space stack.
>
> I tried to remove llsec_encrypt/llsec_decrypt from kernel, recompiled/rebooted,
> pings started passing only after that, but still not all IPv6 addresses are pingable.
> Seems that half of the packets are still filtered out somewhere.
> What could be the other possible places in kernel where raw packets can be dropped?
>

You do it too hacky, look how monitor tx and rx works... they have
different callbacks and are not changable during runtime *yet*.

> Now I am trying to compare tcpdump dumps from both devices, with "node" type interfaces.

The tip above is the only thing what I can give you... you need to
disable all software side filtering up to AF_PACKET raw layer (I hope
you don't use af802154 raw - it's terrible broken).

---

I will not respond anymore to this mail, I gave you all my
knowledge... it would for me very simple for me to implement it, but
the last years I discovered more and more: "freelancer ask questions,
I implement - because fun" and their make profit about it. So I _only_
want to implement stuff which makes this subsystem as a benefit.
Running user space stacks is not a benefit to this subsystem, so I am
not interested.

Sorry :-(

- Alex
