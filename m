Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33428 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbbGNVSs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Jul 2015 17:18:48 -0400
Received: by laem6 with SMTP id m6so13495608lae.0
        for <linux-wpan@vger.kernel.org>; Tue, 14 Jul 2015 14:18:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150714181114.GA3113@omega>
References: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
	<CAPpUg6Nyo1C9HDWqOOK-=ziP3sKECnWL=QX5vXLjYDu=Lc=ySQ@mail.gmail.com>
	<20150713174807.GA3056@omega>
	<CAPpUg6PO=E8pgxtuV+Z0Khq44XZ73D7968X35BCvca43DZkrsQ@mail.gmail.com>
	<CAPpUg6OQLD=4Kc-zz+dv5PCkPyWJ5hed22i_1CP7Gcoxy3vjuQ@mail.gmail.com>
	<20150714181114.GA3113@omega>
Date: Tue, 14 Jul 2015 23:18:46 +0200
Message-ID: <CAPpUg6NgesUxPYqSMkGm1O3suKdw7br6eCNfWAVwrVzE1HVXdA@mail.gmail.com>
Subject: Re: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-14 20:11 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Tue, Jul 14, 2015 at 07:45:52PM +0200, Baptiste Clenet wrote:
> ...
>> >
>> > The probe runs well, I see all the exchange data (SPI traffic), it
>> > detects the chip version of the transceiver, Write frame buffer works
>> > great as well. The driver works with the transceiver, I think the
>> > problem comes from upper layer.
>> > The thing is, calling 'ip link set lowpan0 up ' goes to
>> > 'at86rf230_xmit()' and I see the data transmitted over the SPI pins
>> > which is fine but when I try to ping6, it never goes to
>> > 'at86rf230_xmit()' and there is no data exchange on the bus.
>> >
>
> I have no idea why you have this problem. Everything should be fine to
> use "ping6 -I lowpan0 ....".
>
>> >> Do you use now the software spi bit banging driver over gpio's?
>> > Yes I use software spi bit banging driver over gpio's which works great.
>> >>
>> >>
>> >> - Alex
>> >>
>> >> [0] http://lxr.free-electrons.com/source/net/mac802154/tx.c#L106
>> >> [1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L1027
>> >> [2] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L1648
>> >
>> >
>> > ip link gives me that:
>> >
>> > root@OpenWrt:/# ip link
>> > 6: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc fq_codel state
>> > UNKNOWN mode DEFAULT group default qlen 300
>> >     link/ieee802.15.4 ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff
>> > 7: lowpan0@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc
>> > noqueue state UNKNOWN mode DEFAULT group default
>> >     link/[825] ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff
>> >
>> > I'm wondering what [825] means? Shouldn't it be ieee802.15.4 instead?
>> > What does ping6 -I lowpan0? Does it create an ICMP6 socket? How is
>
> So fat I know, ping6 utility opens an IPv6 raw socket, then you can
> generate the ICMPv6 header inside the userspace. See [4].
>
> I also saw some example which use ETH raw sockets and build the complete
> mac + ipv6 + ICMPv6 inside userspace, see [5] "ping6_ll.c".
>
> Indeed the example at [5] should not work on lowpan interface, but I
> don't think that there are "ping6" implementation outside which works
> like this.
>
>
> Which ping6 implementation do you use, the one from busybox?
Yes from busybox v1.23.2, iputils-s20101006 downloaded from
http://www.skbuff.net/iputils.
it differs a bit from the latest version, I'm going to try the latest
release (iputils-s20121221.tar.bz2)
OpenWRT adds some patches to iputil so I would need to review thes
patches before going to the new version.

How could I try that it actually works with something else than ping6?

>
>> > ping6 connected to lowpan0 interface? (I mean in the source code)
>
> Yea, I need to write some more documentation. Maybe look at my draft for
> make some "global (maybe not enough detailed) stack architecture" ascii
> art [1].

I need to go through all the layers to see where it fails (without
saying any errors...)
Your architecture is great! Thanks, I see that while using IPV6, we
don't use i802154 socket, this is what I was observing earlier, so
that seems ok.


> You will see the 6lowpan box sends frames via "dev_queue_xmit" [2] and
> receives frames from the linux packet layer [3].
>
> Don't know what I should tell here more about "how it works", on sending
> the lowpan interface puts frames via dev_queue_xmit into wpan interface
> and on receiving we make 6LoWPAN to IPv6. 6LoWPAN is an adaptation
> layer. The lowpan interface to this adaptation.
>
> btw:
>
> (Okay it's not really true that we can do everything as adaptation, you
> maybe saw the 6CO question on the last mails which I haven't time yet to
> review. In this case the IPv6 stack need to know something from 6LoWPAN
> stack.) Or the other option would be to reparse and regenerate the
> IPv6/ICMPv6 headers, but this sounds crazy.
>
>>
>> Could you tell me what should be the result of:
>> cat ./sys/devices/virtual/net/lowpan0/type
>> I get 825 and for wpan 0, it is 804
>>
>
> That's fine, they are different interface types. wpan interfaces it's
> 802.15.4. lowpan is IPv6. See [0].
>
> Some userspace application will check that, e.g. wireshark will indicate
> parse frames as 802.15.4 if it's ARPHRD_IEEE802154 and parse IPv6 if
> it's ARPHRD_6LOWPAN.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/include/uapi/linux/if_arp.h#L89
> [1] https://raw.githubusercontent.com/linux-wpan/wpan-misc/master/architecture/general/wpan
> [2] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/tx.c#L262
> [3] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/rx.c#L160
> [4] https://github.com/iputils/iputils/blob/master/ping.c#L444
> [5] http://www.pdbuchan.com/rawsock/rawsock.html

Ok, thanks for your explanation. What can say now is, it goes to
dev_queue_xmit each time but not to at86rf230_xmit.

While setting up lowpan 0, 7 messages are sent (dev_queue_xmit) but
actually only one is sent to the 230! because only one at86rf230_xmit
is called.
So I'm wondering if IRQ has something to do with that? It feels like
the at86rf230 is locked and can't send more messages.

-- 
Baptiste
