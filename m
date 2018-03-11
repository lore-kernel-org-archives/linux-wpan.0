Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33398 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKNel (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 11 Mar 2018 09:34:41 -0400
Received: by mail-io0-f195.google.com with SMTP id f1so8437733iob.0
        for <linux-wpan@vger.kernel.org>; Sun, 11 Mar 2018 06:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180311123745.GA11826@picapica.im>
References: <20180307133525.GA30047@picapica.im> <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
 <20180310172932.GA17439@picapica.im> <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
 <CAOHTApgcEvkckSgCQ_cen-4Q2CTMwuQy8WReeZs-M4Zj6PfPiQ@mail.gmail.com> <20180311123745.GA11826@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sun, 11 Mar 2018 09:34:39 -0400
Message-ID: <CAB_54W7MUCeYj1Nvh0nuvf=MVNrM3HNZ=s3VvAz1imRd-RZm1w@mail.gmail.com>
Subject: Re: "encryption failed" warnings in dmesg
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: Alexander Aring <aring@mojatatu.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-03-11 8:37 GMT-04:00  <anton@picapica.im>:
> On Sat, Mar 10, 2018 at 11:49:44PM -0500, Alexander Aring wrote:
>> Hi,
>>
>> I need to correct some stuff.
>>
>> On Sat, Mar 10, 2018 at 6:43 PM, Alexander Aring <aring@mojatatu.com> wrote:
>> > Hi,
>> >
>> > On Sat, Mar 10, 2018 at 12:29 PM,  <anton@picapica.im> wrote:
>> >> On Wed, Mar 07, 2018 at 10:43:09AM -0500, Alexander Aring wrote:
>> >>
>> >>>
>> >>> You need to use monitor interfaces to make it somehow working but be prepared:
>> >>>
>> >>> 1. no hardware address filtering
>> >>> 2. no hardware ack handling
>> >>>
>> >>> Have fun!
>> >>>
>> >>
>> >> Thank you for detailed answer, can you give more info about why monitor interface is
>> >> required?
>> >>
>> >
>> > There exists two filter mechanism:
>> >
>> >  - Hardware (e.g. address filter, CRC, etc.)
>> >  - Software (e.g. address filter, CRC, etc.)
>> >
>> > Of course we do it again in Software, because we don't trust hardware filters...
>>
>> CRC is offloaded by hardware, address we do again, because we need to
>> parse it anyway.
>>
>> > Anyway advantage of hardware filters is only: you get less IRQs
>> >
>> > With monitor interfaces you disable hardware side and Software side as
>> > well... (CRC on tx not, but this is another issue which we cannot
>> > change directly..., because UAPI changes. Anyway we need to fix this
>> > mess somehow).
>> >
>> > NOW... some feature which I have in my mind but doesn't exists yet...
>> >
>> > Disable Software filter and enable Hardware filters... Then using RAW sockets...
>> > _IMPORTANT_ Then address settings of user space stacks e.g.
>> > OpenThread, RIOT need to be in sync with Hardware (which is possible
>> > by doing some netlink foo).
>> >
>> > Anyway this goes too far for me and is a use case for running user
>> > space stacks only, which means: I don't like it, but I think we could
>> > accept such feature... It's just node interface without monitor...
>> >
>>
>> s/monitor/promiscuous mode/
>>
>> promiscuous mode according 802.15.4 -> disable all filtering
>>
>> If we do that we need to disable AACK, but node without software
>> filtering will still have AACK and address filter... but to make it
>> work with user space stack -> you need to held them (addresses) in
>> sync with 802.15.4 MAC layer.
>>
>> - Alex
>
> Ok, but why exactly hardware filtering cannot be used?
> OpenThread sets it's own extended addr/short addr/pan_id,
> so I tried some probably hacky way - when these settings
> are changed by OpenThread, I delete interface and create
> new one, with new extended addr, pan_id and short_addr,
> using system() call and calling "iwpan" with appropriate args.
> Then raw socket is reopened on a new interface.

Yes that's what I said with "the user space stack need to be in sync
with MAC layer".

> Seems working so far, at least instances are able to see each
> other, pair up and even occasionally ping each other from CLI.

be prepared that the kernel will filter some stuff, you should change
it that it will not do it. I think we would accept a patch to make
that possible. The kernel is filtering -> you don't running a user
space stack.

> Maybe more proper way is to set everything over netlingk,
> but seems that extended addr cannot be changed on the fly anyway,
> without bringing interface down
>

The reason why we don't change address filtering at runtime is that we
are in RX mode and we don't change RX parameters when we are in
receive mode. If OpenThread, RIOT, etc. do that it's fine, but I see
problems with that.

- Alex
