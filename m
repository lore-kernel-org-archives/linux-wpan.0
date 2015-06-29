Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:32929 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbF2JoE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 05:44:04 -0400
Received: by laar3 with SMTP id r3so56518593laa.0
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 02:44:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55910C2F.3070601@gmail.com>
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
Date: Mon, 29 Jun 2015 11:44:02 +0200
Message-ID: <CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

2015-06-29 11:13 GMT+02:00 Varka Bhadram <varkabhadram@gmail.com>:
> On 06/29/2015 01:39 PM, Alexander Aring wrote:
>>>
>>> Alexander, which version of Linux bluetooth-next tree is based on?
>>
>> 4.1.0-rc4-01278-gfbb12f9-dirty
>>
>> this is currently in my development branch. Alternative you can check
>> the Makefile of linux-kernel [0].
>>
>> VERSION = 4
>> PATCHLEVEL = 1
>> SUBLEVEL = 0
>> EXTRAVERSION = -rc4
>> NAME = Hurr durr I'ma sheep
>>
>>
>>
>> I really have no idea why you don't have a wpan interface by default.
>
>
> May be the wpan interface is down  :-).
>
> can you please check with: *ifconfig -a*

Varka, you were right:
root@OpenWrt:/# ifconfig -a
br-lan    Link encap:Ethernet  HWaddr A6:3E:F6:19:6C:F7
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fd35:d27a:3a36::1/60 Scope:Global
          inet6 addr: fe80::a43e:f6ff:fe19:6cf7/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:598 (598.0 B)  TX bytes:1230 (1.2 KiB)

eth0      Link encap:Ethernet  HWaddr 2E:81:C8:13:EF:44
          inet6 addr: fe80::2c81:c8ff:fe13:ef44/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19 errors:0 dropped:0 overruns:0 frame:0
          TX packets:46 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1216 (1.1 KiB)  TX bytes:7418 (7.2 KiB)
          Interrupt:5

eth0.1    Link encap:Ethernet  HWaddr 2E:81:C8:13:EF:44
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19 errors:0 dropped:0 overruns:0 frame:0
          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:874 (874.0 B)  TX bytes:2319 (2.2 KiB)

eth0.2    Link encap:Ethernet  HWaddr A6:3E:F6:19:6C:F8
          inet6 addr: fe80::a43e:f6ff:fe19:6cf8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:3257 (3.1 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3936 (3.8 KiB)  TX bytes:3936 (3.8 KiB)

wpan0     Link encap:UNSPEC  HWaddr
0E-49-D3-CD-5E-7D-3E-8C-00-00-00-00-00-00-00-00
          BROADCAST NOARP  MTU:127  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

'ip link set wpan0 up' sets it up.

>
>> You can delete interfaces from nl802154, but then openwrt need to speak
>> to this netlink interface and I don't believe that it does that. :-)
>
>
> Speaking to the netlink interface in OpenWRT is same as in case of bare
> Linux kernel compiled for specific target. There is no difference.
> So we can use the wpan-tools [1] to speak to the netlink interface.
>
> [1]:
> http://git.openwrt.org/?p=openwrt.git;a=blob;f=package/network/utils/wpan-tools/Makefile;h=87a5fb1461121407f685e960b64315661aacc9bf;hb=HEAD
>
> --
> Varka Bhadram.
>

I'm going to search deeper why ping6 doesn't want to communicate with SPI.

-- 
Baptiste
