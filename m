Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38080 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbcIDSZA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2016 14:25:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAB_54W4k7MBVSfp07nbhb8ugwCbX1w_DwmUQamqoY6DiVEiD=A@mail.gmail.com>
References: <MAXPR01MB0218AF3FE3A6214F17D9047090ED0@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
 <CABBYNZLLpO0TcozFuvorwCZOOAKr=96NJhZBoLxjeUgdM+G2UA@mail.gmail.com>
 <MAXPR01MB0218E7395A5709B7785514FC90E20@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
 <CAB_54W4k7MBVSfp07nbhb8ugwCbX1w_DwmUQamqoY6DiVEiD=A@mail.gmail.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sun, 4 Sep 2016 20:24:06 +0200
Message-ID: <CAB_54W6jaFDqzCwUOqRJsBV5AWU+Fa0OPiXHeUg5UOeT1qFomw@mail.gmail.com>
Subject: Re: Regarding IPSP over GATT Support in blueZ
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Amith Raghunath <Amith.Raghunath@mindtree.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

resend my mail because gmail fail, sorry! I hope it works now.

2016-09-04 20:13 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>
> Hi,
>
> currently with my gmail mail account, because I am not subscribed on linux-bluetooth with
> another mail address, sorry.
>
> 2016-09-01 17:49 GMT+02:00 Amith Raghunath <Amith.Raghunath@mindtree.com>:
>>
>> Hi Luiz,
>>
>> > It is currently pending the implementation of MGMT interface, but you can use it with debugfs:
>>
>> Thank you for answering the query.
>> I have tried this setup on 2 Ubuntu 16.04 machines with csr 4.0 dongle.
>> Through the debugfs approach ping6 to the remote machine is working.
>>
>> I have another query:
>> In the 6lowpan.c code
>> the function "recv_pkt" sends the received packet to the upper (protocol) levels.
>
>
> yep.
>
>>
>> The function "bt_xmit" will either send the pkt to all its peers or send it to one of the peers.
>>
>
> depends on multicast or not. RFC7668 says something about only to the mulitcast listener
> group. But this isn't supported yet, so it sends it to all.
>
>>
>> In the ietf RFC7668 document, it states that 2 6LBNs can exchange packets through a 6LBR.
>> With regard to this I have the following queries:
>> 1. The 6LBR has to forward the packets sent by one node to another node based on the link-local address. Is this scenario supported in the present code base ?
>
>
> so far I know, no.
>
>>
>> 2. Are all the use cases mentioned in RFC7668 (including neighbor discovery) supported by the present code base ?
>
>
> If you mean RFC6775, no we either have no 802.15.4 6LoWPAN for it, but we introduced
> recently some ndisc_ops [2] structure where we can do "per-device (6LoWPAN interface)" changes during runtime.
> I hope this layer will help us to implement RFC6775.
>
>>
>> 3. What is the present status of bluetooth_6lowpan code with reference to ietf RFC7668 document ?
>>
>
> Some things works and some things not. :-)
>
> There exist many known issues (in my opinion) with the current implementation.
>
> - Current implementation doesn't use any IPv6 ndisc functionality. The L2 address will be
>   reconstructed by L3 address and use some net core POINT_TO_POINT mechanism, which I
>   don't know what it's currently exactly does.
>
> - The call of l2cap_chan_send need to be held the chan mutex lock.
>
> - The device address is the IID, which means if you fix the first issue the address option
>   will be the 8 byte Interface Identifier according to rfc7668.
>
> - A tx deadlock which seems to be bluetooth subsystem related.
>
> - Races, e.g. [0] which sets some skb control block information which is not per l2cap_chan
>   instance.
>
> - ....
>
> There exists some RFC about fixing the above issues, this will still not have support to ping
> another 6LN with it's link-local over a 6LBR. This sounds like some fun to implement it. :-)
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L985
> [1] http://www.spinics.net/lists/linux-wpan/msg04124.html
> [2] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/6lowpan/ndisc.c#n230
