Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34858 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbbF2Loo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 07:44:44 -0400
Received: by lagh6 with SMTP id h6so50156365lag.2
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 04:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
	<20150625171557.GB3653@omega>
	<20150625173032.GC3653@omega>
	<CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com>
	<CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
	<20150626080338.GB959@omega>
	<CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
	<CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
	<20150629080937.GA1674@omega>
	<55910C2F.3070601@gmail.com>
	<CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
Date: Mon, 29 Jun 2015 13:44:42 +0200
Message-ID: <CAPpUg6NUwAGo402HgJkwcDTyT3HPBAAnSEW7V63zUyv5PHSJ8A@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

2015-06-29 11:44 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-06-29 11:13 GMT+02:00 Varka Bhadram <varkabhadram@gmail.com>:
>> On 06/29/2015 01:39 PM, Alexander Aring wrote:
>>>>
>>>> Alexander, which version of Linux bluetooth-next tree is based on?
>>>
>>> 4.1.0-rc4-01278-gfbb12f9-dirty
>>>
>>> this is currently in my development branch. Alternative you can check
>>> the Makefile of linux-kernel [0].
>>>
>>> VERSION = 4
>>> PATCHLEVEL = 1
>>> SUBLEVEL = 0
>>> EXTRAVERSION = -rc4
>>> NAME = Hurr durr I'ma sheep
>>>
>>>
>>>
>>> I really have no idea why you don't have a wpan interface by default.
>>
>>
>> May be the wpan interface is down  :-).
>>
>> can you please check with: *ifconfig -a*
>
> Varka, you were right:
> root@OpenWrt:/# ifconfig -a
> br-lan    Link encap:Ethernet  HWaddr A6:3E:F6:19:6C:F7
>           inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
>           inet6 addr: fd35:d27a:3a36::1/60 Scope:Global
>           inet6 addr: fe80::a43e:f6ff:fe19:6cf7/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:13 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:598 (598.0 B)  TX bytes:1230 (1.2 KiB)
>
> eth0      Link encap:Ethernet  HWaddr 2E:81:C8:13:EF:44
>           inet6 addr: fe80::2c81:c8ff:fe13:ef44/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:19 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:46 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1216 (1.1 KiB)  TX bytes:7418 (7.2 KiB)
>           Interrupt:5
>
> eth0.1    Link encap:Ethernet  HWaddr 2E:81:C8:13:EF:44
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:19 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:874 (874.0 B)  TX bytes:2319 (2.2 KiB)
>
> eth0.2    Link encap:Ethernet  HWaddr A6:3E:F6:19:6C:F8
>           inet6 addr: fe80::a43e:f6ff:fe19:6cf8/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 B)  TX bytes:3257 (3.1 KiB)
>
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:65536  Metric:1
>           RX packets:48 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:3936 (3.8 KiB)  TX bytes:3936 (3.8 KiB)
>
> wpan0     Link encap:UNSPEC  HWaddr
> 0E-49-D3-CD-5E-7D-3E-8C-00-00-00-00-00-00-00-00
>           BROADCAST NOARP  MTU:127  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> 'ip link set wpan0 up' sets it up.
>
>>
>>> You can delete interfaces from nl802154, but then openwrt need to speak
>>> to this netlink interface and I don't believe that it does that. :-)
>>
>>
>> Speaking to the netlink interface in OpenWRT is same as in case of bare
>> Linux kernel compiled for specific target. There is no difference.
>> So we can use the wpan-tools [1] to speak to the netlink interface.
>>
>> [1]:
>> http://git.openwrt.org/?p=openwrt.git;a=blob;f=package/network/utils/wpan-tools/Makefile;h=87a5fb1461121407f685e960b64315661aacc9bf;hb=HEAD
>>
>> --
>> Varka Bhadram.
>>
>
> I'm going to search deeper why ping6 doesn't want to communicate with SPI.
>
> --
> Baptiste

Every time I set lowpan interface up, I get an error:

root@OpenWrt:/# ip link add link wpan0 name lowpan0 type lowpan
root@OpenWrt:/# ip link set lowpan0 up
root@OpenWrt:/# [ 6950.140000] at86rf230 spi32766.1: unexcept state
change from 0x00 to 0x09. Actual state: 0x00
[ 6950.150000] ------------[ cut here ]------------
[ 6950.160000] WARNING: CPU: 0 PID: 175 at
drivers/spi/spi-mt7621.c:146
mt7621_spi_transfer_one_message+0x158/0x3b4()
[ 6950.180000] Modules linked in: at86rf230 pppoe ppp_async
iptable_nat pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
nf_conntrack_ipv4 iph
[ 6950.390000] CPU: 0 PID: 175 Comm: spi32766 Not tainted 4.0.4 #20
[ 6950.400000] Stack : 00000000 00000000 00000001 00000000 802b86d4
80311de3 000000af 8035342c
          818ee570 819a2388 00010000 00000000 00000000 80049318
00000003 802bd674
          00000092 819a2388 802bbc78 819bbd7c 00000000 8004785c
00000000 00000000
          00000001 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          ...
[ 6950.470000] Call Trace:
[ 6950.480000] [<8001475c>] show_stack+0x48/0x70
[ 6950.490000] [<80025260>] warn_slowpath_common+0xa0/0xd0
[ 6950.500000] [<80025318>] warn_slowpath_null+0x18/0x24
[ 6950.510000] [<801b7ee8>] mt7621_spi_transfer_one_message+0x158/0x3b4
[ 6950.520000] [<801b6e4c>] __spi_pump_messages+0x404/0x464
[ 6950.530000] [<8003ad80>] kthread_worker_fn+0xa8/0xf4
[ 6950.540000] [<8003aea4>] kthread+0xd8/0xe4
[ 6950.550000] [<80004878>] ret_from_kernel_thread+0x14/0x1c
[ 6950.560000]
[ 6950.560000] ---[ end trace d93d9398d7e8323c ]---

Is that normal?

-- 
Baptiste
