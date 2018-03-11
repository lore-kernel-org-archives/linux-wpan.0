Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:37961 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCKEtp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 10 Mar 2018 23:49:45 -0500
Received: by mail-ua0-f179.google.com with SMTP id f5so4785761uam.5
        for <linux-wpan@vger.kernel.org>; Sat, 10 Mar 2018 20:49:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
References: <20180307133525.GA30047@picapica.im> <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
 <20180310172932.GA17439@picapica.im> <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Sat, 10 Mar 2018 23:49:44 -0500
Message-ID: <CAOHTApgcEvkckSgCQ_cen-4Q2CTMwuQy8WReeZs-M4Zj6PfPiQ@mail.gmail.com>
Subject: Re: "encryption failed" warnings in dmesg
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anton Sviridenko <anton@picapica.im>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

I need to correct some stuff.

On Sat, Mar 10, 2018 at 6:43 PM, Alexander Aring <aring@mojatatu.com> wrote:
> Hi,
>
> On Sat, Mar 10, 2018 at 12:29 PM,  <anton@picapica.im> wrote:
>> On Wed, Mar 07, 2018 at 10:43:09AM -0500, Alexander Aring wrote:
>>
>>>
>>> You need to use monitor interfaces to make it somehow working but be prepared:
>>>
>>> 1. no hardware address filtering
>>> 2. no hardware ack handling
>>>
>>> Have fun!
>>>
>>
>> Thank you for detailed answer, can you give more info about why monitor interface is
>> required?
>>
>
> There exists two filter mechanism:
>
>  - Hardware (e.g. address filter, CRC, etc.)
>  - Software (e.g. address filter, CRC, etc.)
>
> Of course we do it again in Software, because we don't trust hardware filters...

CRC is offloaded by hardware, address we do again, because we need to
parse it anyway.

> Anyway advantage of hardware filters is only: you get less IRQs
>
> With monitor interfaces you disable hardware side and Software side as
> well... (CRC on tx not, but this is another issue which we cannot
> change directly..., because UAPI changes. Anyway we need to fix this
> mess somehow).
>
> NOW... some feature which I have in my mind but doesn't exists yet...
>
> Disable Software filter and enable Hardware filters... Then using RAW sockets...
> _IMPORTANT_ Then address settings of user space stacks e.g.
> OpenThread, RIOT need to be in sync with Hardware (which is possible
> by doing some netlink foo).
>
> Anyway this goes too far for me and is a use case for running user
> space stacks only, which means: I don't like it, but I think we could
> accept such feature... It's just node interface without monitor...
>

s/monitor/promiscuous mode/

promiscuous mode according 802.15.4 -> disable all filtering

If we do that we need to disable AACK, but node without software
filtering will still have AACK and address filter... but to make it
work with user space stack -> you need to held them (addresses) in
sync with 802.15.4 MAC layer.

- Alex
