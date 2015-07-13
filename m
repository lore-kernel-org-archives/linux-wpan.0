Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35163 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbGMQSt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 12:18:49 -0400
Received: by lblf12 with SMTP id f12so58377816lbl.2
        for <linux-wpan@vger.kernel.org>; Mon, 13 Jul 2015 09:18:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
References: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
Date: Mon, 13 Jul 2015 18:18:47 +0200
Message-ID: <CAPpUg6Nyo1C9HDWqOOK-=ziP3sKECnWL=QX5vXLjYDu=Lc=ySQ@mail.gmail.com>
Subject: Re: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

2015-07-13 16:59 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> Hi,
>
> Here is how I set the network:
> modprobe at86rf230
> iwpan dev wpan0 set pan_id 0xbeef
> ip link set wpan0 up
> ip link add link wpan0 name lowpan0 type lowpan
> ip link set lowpan0 up
>
> Then I try to do:
> ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
>
> Nothing is sent. (I checked by sniffing the SPI pins). No errors from
> ping6 or other layers in the network stack.
>
> root@OpenWrt:/# ifconfig
> lowpan0   Link encap:UNSPEC  HWaddr
> 05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
>           inet6 addr: fe80::738:906:90e0:5e3e/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> wpan0     Link encap:UNSPEC  HWaddr
> 05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
>           UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300
>           RX bytes:0 (0.0 B)  TX bytes:75 (75.0 B)
>
> (TX bytes:75 (75.0 B), seems to be sent when you up lowpan0 ?)
>
>
> Is my settings right? What should I check to make sure the data goes
> from each layer of the network stack?
>
> Regards,
>
> --
> Baptiste

More info:
Running Linux 4.1.0

root@OpenWrt:/# ip link
6: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc fq_codel state
UNKNOWN mode DEFAULT group default qlen 300
    link/ieee802.15.4 ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff
7: lowpan0@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc
noqueue state UNKNOWN mode DEFAULT group default
    link/[825] ef:57:b2:a9:2f:4e:90:76 brd ff:ff:ff:ff:ff:ff:ff:ff

root@OpenWrt:/# iwpan phy
wpan_phy phy0
supported channels:
        page 0: 0,1,2,3,4,5,6,7,8,9,10
        page 2: 0,1,2,3,4,5,6,7,8,9,10
current_page: 0
current_channel: 5
cca_mode: 1
tx_power: 0

root@OpenWrt:/# iwpan dev
phy#0
        Interface wpan0
                ifindex 6
                wpan_dev 0x1
                extended_addr 0xef57b2a92f4e9076
                short_addr 0xffff
                pan_id 0xbeef
                type node
                max_frame_retries -1
                min_be 3
                max_be 5
                max_csma_backoffs 4
                lbt 0

Let me know if you need more info.

-- 
Baptiste
