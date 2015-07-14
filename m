Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36570 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbGNK43 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Jul 2015 06:56:29 -0400
Received: by lbbpo10 with SMTP id po10so3761693lbb.3
        for <linux-wpan@vger.kernel.org>; Tue, 14 Jul 2015 03:56:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150713174807.GA3056@omega>
References: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
	<CAPpUg6Nyo1C9HDWqOOK-=ziP3sKECnWL=QX5vXLjYDu=Lc=ySQ@mail.gmail.com>
	<20150713174807.GA3056@omega>
Date: Tue, 14 Jul 2015 12:56:27 +0200
Message-ID: <CAPpUg6PO=E8pgxtuV+Z0Khq44XZ73D7968X35BCvca43DZkrsQ@mail.gmail.com>
Subject: Re: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-13 19:48 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> On Mon, Jul 13, 2015 at 06:18:47PM +0200, Baptiste Clenet wrote:
>> 2015-07-13 16:59 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> > Hi,
>> >
>> > Here is how I set the network:
>> > modprobe at86rf230
>> > iwpan dev wpan0 set pan_id 0xbeef
>> > ip link set wpan0 up
>> > ip link add link wpan0 name lowpan0 type lowpan
>> > ip link set lowpan0 up
>> >
>> > Then I try to do:
>> > ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
>> >
>> > Nothing is sent. (I checked by sniffing the SPI pins). No errors from
>> > ping6 or other layers in the network stack.
>> >
>> > root@OpenWrt:/# ifconfig
>> > lowpan0   Link encap:UNSPEC  HWaddr
>> > 05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
>> >           inet6 addr: fe80::738:906:90e0:5e3e/64 Scope:Link
>> >           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>> >           collisions:0 txqueuelen:0
>> >           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>> >
>> > wpan0     Link encap:UNSPEC  HWaddr
>> > 05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
>> >           UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
>> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>> >           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>> >           collisions:0 txqueuelen:300
>> >           RX bytes:0 (0.0 B)  TX bytes:75 (75.0 B)
>> >
>> > (TX bytes:75 (75.0 B), seems to be sent when you up lowpan0 ?)
>> >
>
> Yes, this is because the IPv6 neighbor discovery protocol. (We don't
> increment the lowpan interface stats currently), but this should be some
> patch later which increments the "uncompressed" part of 6LoWPAN ->
> simple IPv6 view, this is also what wireshark offers you on this
> interface.

Ok thanks.

>
>> >
>> > Is my settings right? What should I check to make sure the data goes
>> > from each layer of the network stack?
>> >
>
> Yes, the setting is right.
>
> I have no idea why it doesn't work on your side. That the "tx stats" of
> wpan interface are incremented shows me it runs the code at [0].
>
> Before we call "drv_xmit_async" which calls the function at [1].
>
> Maybe you can do some 'printk(KERN_INFO "foobar\n")' at [1] to see if
> you really call that function in driver layer, but it should.

Yes, it goes to 'at86rf230_xmit()' when lowpan goes up. That explains
the 75Bytes

>
> Do you see SPI traffic while probing? Because at [2] we have some
> id registers reads. If you don't see spi traffic and it probes
> successful then your sniffing setup seems wrong. If you see spi traffic
> then it seems to be correct and something is different in openwrt when
> calling ?spi_async?.
>

The probe runs well, I see all the exchange data (SPI traffic), it
detects the chip version of the transceiver, Write frame buffer works
great as well. The driver works with the transceiver, I think the
problem comes from upper layer.
The thing is, calling 'ip link set lowpan0 up ' goes to
'at86rf230_xmit()' and I see the data transmitted over the SPI pins
which is fine but when I try to ping6, it never goes to
'at86rf230_xmit()' and there is no data exchange on the bus.

> Do you use now the software spi bit banging driver over gpio's?
Yes I use software spi bit banging driver over gpio's which works great.
>
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/mac802154/tx.c#L106
> [1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L1027
> [2] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L1648


ip link gives me that:

root@OpenWrt:/# ip link
6: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc fq_codel state
UNKNOWN mode DEFAULT group default qlen 300
    link/ieee802.15.4 ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff
7: lowpan0@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc
noqueue state UNKNOWN mode DEFAULT group default
    link/[825] ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff

I'm wondering what [825] means? Shouldn't it be ieee802.15.4 instead?
What does ping6 -I lowpan0? Does it create an ICMP6 socket? How is
ping6 connected to lowpan0 interface? (I mean in the source code)
-- 
Baptiste
