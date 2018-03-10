Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33134 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeCJXnC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 10 Mar 2018 18:43:02 -0500
Received: by mail-vk0-f50.google.com with SMTP id z130so4258109vkd.0
        for <linux-wpan@vger.kernel.org>; Sat, 10 Mar 2018 15:43:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180310172932.GA17439@picapica.im>
References: <20180307133525.GA30047@picapica.im> <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
 <20180310172932.GA17439@picapica.im>
From: Alexander Aring <aring@mojatatu.com>
Date: Sat, 10 Mar 2018 18:43:01 -0500
Message-ID: <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
Subject: Re: "encryption failed" warnings in dmesg
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anton Sviridenko <anton@picapica.im>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Sat, Mar 10, 2018 at 12:29 PM,  <anton@picapica.im> wrote:
> On Wed, Mar 07, 2018 at 10:43:09AM -0500, Alexander Aring wrote:
>
>>
>> You need to use monitor interfaces to make it somehow working but be prepared:
>>
>> 1. no hardware address filtering
>> 2. no hardware ack handling
>>
>> Have fun!
>>
>
> Thank you for detailed answer, can you give more info about why monitor interface is
> required?
>

There exists two filter mechanism:

 - Hardware (e.g. address filter, CRC, etc.)
 - Software (e.g. address filter, CRC, etc.)

Of course we do it again in Software, because we don't trust hardware filters...
Anyway advantage of hardware filters is only: you get less IRQs

With monitor interfaces you disable hardware side and Software side as
well... (CRC on tx not, but this is another issue which we cannot
change directly..., because UAPI changes. Anyway we need to fix this
mess somehow).

NOW... some feature which I have in my mind but doesn't exists yet...

Disable Software filter and enable Hardware filters... Then using RAW sockets...
_IMPORTANT_ Then address settings of user space stacks e.g.
OpenThread, RIOT need to be in sync with Hardware (which is possible
by doing some netlink foo).

Anyway this goes too far for me and is a use case for running user
space stacks only, which means: I don't like it, but I think we could
accept such feature... It's just node interface without monitor...

- Alex
