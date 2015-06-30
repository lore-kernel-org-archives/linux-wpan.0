Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:36320 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbF3JMh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Jun 2015 05:12:37 -0400
Received: by lagc2 with SMTP id c2so5143468lag.3
        for <linux-wpan@vger.kernel.org>; Tue, 30 Jun 2015 02:12:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150629220929.GB1165@omega>
References: <20150625173032.GC3653@omega>
	<CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com>
	<CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
	<20150626080338.GB959@omega>
	<CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
	<CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
	<20150629080937.GA1674@omega>
	<55910C2F.3070601@gmail.com>
	<CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
	<CAPpUg6NUwAGo402HgJkwcDTyT3HPBAAnSEW7V63zUyv5PHSJ8A@mail.gmail.com>
	<20150629220929.GB1165@omega>
Date: Tue, 30 Jun 2015 11:12:36 +0200
Message-ID: <CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

2015-06-30 0:09 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> On Mon, Jun 29, 2015 at 01:44:42PM +0200, Baptiste Clenet wrote:
>> 2015-06-29 11:44 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> > 2015-06-29 11:13 GMT+02:00 Varka Bhadram <varkabhadram@gmail.com>:
>> >> On 06/29/2015 01:39 PM, Alexander Aring wrote:
>> >>>>
>> >>>> Alexander, which version of Linux bluetooth-next tree is based on?
>> >>>
>> >>> 4.1.0-rc4-01278-gfbb12f9-dirty
>> >>>
>> >>> this is currently in my development branch. Alternative you can check
>> >>> the Makefile of linux-kernel [0].
>> >>>
>> >>> VERSION = 4
>> >>> PATCHLEVEL = 1
>> >>> SUBLEVEL = 0
>> >>> EXTRAVERSION = -rc4
>> >>> NAME = Hurr durr I'ma sheep
>> >>>
>> >>>
>> >>>
>> >>> I really have no idea why you don't have a wpan interface by default.
>> >>
>> >>
>> >> May be the wpan interface is down  :-).
>> >>
>> >> can you please check with: *ifconfig -a*
> ...
>>
>> Every time I set lowpan interface up, I get an error:
>>
>> root@OpenWrt:/# ip link add link wpan0 name lowpan0 type lowpan
>> root@OpenWrt:/# ip link set lowpan0 up
>> root@OpenWrt:/# [ 6950.140000] at86rf230 spi32766.1: unexcept state
>> change from 0x00 to 0x09. Actual state: 0x00
>> [ 6950.150000] ------------[ cut here ]------------
>> [ 6950.160000] WARNING: CPU: 0 PID: 175 at
>> drivers/spi/spi-mt7621.c:146
>> mt7621_spi_transfer_one_message+0x158/0x3b4()
>> [ 6950.180000] Modules linked in: at86rf230 pppoe ppp_async
>> iptable_nat pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
>> nf_conntrack_ipv4 iph
>> [ 6950.390000] CPU: 0 PID: 175 Comm: spi32766 Not tainted 4.0.4 #20
>> [ 6950.400000] Stack : 00000000 00000000 00000001 00000000 802b86d4
>> 80311de3 000000af 8035342c
>>           818ee570 819a2388 00010000 00000000 00000000 80049318
>> 00000003 802bd674
>>           00000092 819a2388 802bbc78 819bbd7c 00000000 8004785c
>> 00000000 00000000
>>           00000001 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>>           00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>>           ...
>> [ 6950.470000] Call Trace:
>> [ 6950.480000] [<8001475c>] show_stack+0x48/0x70
>> [ 6950.490000] [<80025260>] warn_slowpath_common+0xa0/0xd0
>> [ 6950.500000] [<80025318>] warn_slowpath_null+0x18/0x24
>> [ 6950.510000] [<801b7ee8>] mt7621_spi_transfer_one_message+0x158/0x3b4
>> [ 6950.520000] [<801b6e4c>] __spi_pump_messages+0x404/0x464
>> [ 6950.530000] [<8003ad80>] kthread_worker_fn+0xa8/0xf4
>> [ 6950.540000] [<8003aea4>] kthread+0xd8/0xe4
>> [ 6950.550000] [<80004878>] ret_from_kernel_thread+0x14/0x1c
>> [ 6950.560000]
>> [ 6950.560000] ---[ end trace d93d9398d7e8323c ]---
>>
>> Is that normal?
>>
>
> No. When the lowpan interface cames up, the IPv6 stack sends some ndisc
> messages (you can capture that over wireshark/tcpdump). This means the
> transceiver driver tries to send some frames.
>
> The warning:
>
> "[ 6950.140000] at86rf230 spi32766.1: unexcept state change from 0x00 to
>  0x09. Actual state: 0x00"
>
> smells like you reading zeros on the bus. It wonders me how the driver
> survived the probing, because it will read some ID registers.
>
> Does the probing working well on your side, look in dmesg if the
> transceiver was right detected.
>
> More details about the messages is:
>
> You try to chenges from state 0x00 (was readed from register) to 0x09
> (TX_ON, not readed from any register. It's set by the transceiver). It
> fails and detected you are in state 0x00 (readed from register). So it
> smells like you reading zeros only.
>
> Try to check the spi bus and chipselect, also check the slp_tr pin.
> Otherwise I have no idea why you reading zeros only.
>
> - Alex

root@OpenWrt:/# dmesg | grep at86rf230
[   94.820000] at86rf230 spi32766.1: Detected at86rf212 chip version 3
[   94.830000] at86rf230 spi32766.1: unexcept state change from 0x00
to 0x08. Actual state: 0x00

It detects the chip but yes definitely, there is problem to read the state.
Will check the pins

-- 
Baptiste
