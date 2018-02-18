Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36399 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRTK3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 18 Feb 2018 14:10:29 -0500
Received: by mail-io0-f177.google.com with SMTP id t22so9199380iob.3
        for <linux-wpan@vger.kernel.org>; Sun, 18 Feb 2018 11:10:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180218190427.GA3925@picapica.im>
References: <20180217184113.GA7717@picapica.im> <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
 <20180218152128.GA31698@picapica.im> <CAB_54W74JZ55ehr1ZY2QZJD=k97jz_V=b8x0hhpb0ciYjd04tA@mail.gmail.com>
 <CAB_54W6YUYA8THF=QGxxQ0s1-9iagvAchs9KjQ+CjOhdYuQUmg@mail.gmail.com> <20180218190427.GA3925@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sun, 18 Feb 2018 14:10:28 -0500
Message-ID: <CAB_54W4asjXzOd+rCxDTVFs-RpVo+TzrowHx2i9uxaDyBR3KCA@mail.gmail.com>
Subject: Re: issues with at86rf212b transceiver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-18 14:04 GMT-05:00  <anton@picapica.im>:
> On Sun, Feb 18, 2018 at 10:50:57AM -0500, Alexander Aring wrote:
>> >
>> > Check your wiring, make a lower spi clock (Maybe we should make the
>> > clock at the devicetree documentation lower).
>> >
>> > But... this messages should not happen unless something is broken.
>> >
>>
>> You can try to read registers with debugfs and regmap entry... and
>> look if the registers are the same as hw_init in the driver... if not
>> something weird going on e.g. lossy connection, too high spi-clock,
>> magnetic field, moon position, etc.
>>
>> - Alex
>
> I set SPI clock to 500 000, still have
>
> at86rf230 spi32765.0: not supported irq 00 received
>
> probably it is an IRQ pin wiring issue, not SPI frequency.
>
> I am trying to do wpan-ping and ping over IPv6,
> ping values seem too high for devices located on the same table
> and IPv6 ping has more than double RTT time, maybe it is due to
> protocol overhead and so on, but does 45ms for wpan-ping look normal?
>
>
> # wpan-ping -a 0x0002
> PING 0x0002 (PAN ID 0xbeef) 5 data bytes
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=0 time=59.9 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=1 time=44.5 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=2 time=59.8 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=3 time=57.9 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=4 time=47.0 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=5 time=57.9 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 5 bytes from 0x0002 seq=6 time=43.6 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> # at86rf230 spi32765.0: not supported irq 00 received
>
> # ping -6 fe80::bcef:ff:fe00:2%lowpan0at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
>
> PING fe80::bcef:ff:fe00:2%lowpan0(fe80::bcef:ff:fe00:2) 56 data bytes
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 64 bytes from fe80::bcef:ff:fe00:2: icmp_seq=2 ttl=64 time=105 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 64 bytes from fe80::bcef:ff:fe00:2: icmp_seq=3 ttl=64 time=109 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 64 bytes from fe80::bcef:ff:fe00:2: icmp_seq=4 ttl=64 time=109 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> 64 bytes from fe80::bcef:ff:fe00:2: icmp_seq=5 ttl=64 time=114 ms
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> ^C
> --- fe80::bcef:ff:fe00:2%lowpan0 ping statistics ---
> 6 packets transmitted, 4 received, 33% packet loss, time 5033ms
> rtt min/avg/max/mdev = 105.572/109.775/114.680/3.239 ms
> # at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received
> at86rf230 spi32765.0: not supported irq 00 received

definitely the irq line, it is triggered and IRQ_STATUS says "no irq
signaled". This is cleaned only if you read irq stats out.

- Alex
