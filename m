Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35073 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbGXMDL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 08:03:11 -0400
Received: by lblf12 with SMTP id f12so13745340lbl.2
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 05:03:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150724101842.GA7552@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
	<20150724083106.GA2655@omega>
	<CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
	<CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
	<20150724094804.GA6561@omega>
	<CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
	<20150724101842.GA7552@omega>
Date: Fri, 24 Jul 2015 14:03:09 +0200
Message-ID: <CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-24 12:18 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Fri, Jul 24, 2015 at 11:56:08AM +0200, Baptiste Clenet wrote:
>> 2015-07-24 11:48 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> > On Fri, Jul 24, 2015 at 11:02:30AM +0200, Baptiste Clenet wrote:
>> >> 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> >> > 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> >> >> Hi,
>> >> >>
>> >> >> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
>> >> >>> Hi,
>> >> >>>
>> >> >>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
>> >> >>> supported" when I receive a ping from another board.
>> >> >>>
>> >> >>
>> >> >> I think you hit [0]. You got that because we received some 6LoWPAN frame
>> >> >> with context based address compression (the source address). See also [1].
>> >> > Yes for [0]
>> >> >
>> >> >>
>> >> >> Your options are:
>> >> >>
>> >> >>  - That the other board use stateless (means SAC = 0, see [1]) address
>> >> >>    compression.
>> >> > How may I check?
>> >> > They use both the same settings, they are based on the same source code.
>> >> SAC bit is set.
>> >
>> > Yes SAC bit means context based address compression and we don't support
>> > it. We should support it, that's what rfc6282 said. But we don't have
>> > support for that now. :-)
>> >
>> > What do you mean with "they are based on the same source code"? It's a
>> > linux<->linux communication?
>> Yes it is linux to linux transmission.
>> Yeah I understand for the support :-)
>> The question is now why my linux use context based address compression
>> if it shouldn't? Where is it (SAC) set when transmitting a message?
>>
>
> We don't set it. Which kernel do you use?
Linux 4.1.0 (yeah I should use bluetooth-next kernel)
I see that the only way it is set is when
'source address is unspecified, setting SAC'

root@OpenWrt:/# ifconfig
lowpan0   Link encap:UNSPEC  HWaddr
07-7B-21-44-65-D9-6F-AC-00-00-00-00-00-00-00-00
          inet6 addr: fe80::57b:2144:65d9:6fac/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wpan0     Link encap:UNSPEC  HWaddr
07-7B-21-44-65-D9-6F-AC-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
          RX packets:20 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300
          RX bytes:1001 (1001.0 B)  TX bytes:568 (568.0 B)

(There is some printk for irq as well)
root@OpenWrt:/#ip link set lowpan0 up
root@OpenWrt:/# [   66.248286] IPv6 header dump:
[   66.248286]  version = 6
[   66.248286]  length  = 36
[   66.248286]  nexthdr = 0x00
[   66.248286]  hop_lim = 1
[   66.248286]  dest    = ff02::16
[   66.281193] source address is unspecified, setting SAC
// ??
[   66.301541] destination address is multicast: compressed to 1 octet
[   66.313959] header len 4 skb 40
[   66.320242] at86rf230_xmit
[   66.340482]  GINT_STAT_0 8000
[   66.346539] at86rf230_isr
[   66.598282] IPv6 header dump:
[   66.598282]  version = 6
[   66.598282]  length  = 36
[   66.598282]  nexthdr = 0x00
[   66.598282]  hop_lim = 1
[   66.598282]  dest    = ff02::16
[   66.631184] source address is unspecified, setting SAC
[   66.651532] destination address is multicast: compressed to 1 octet


root@OpenWrt:/# ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
PING fe80::a8af:ac69:e53e:c7f1(f
[ 6770.810640] IPv6 header dump:
[ 6770.810640]  version = 6
[ 6770.810640]  length  = 40
[ 6770.810640]  nexthdr = 0x3a
[ 6770.810640]  hop_lim = 255
[ 6770.810640]  dest    = ff02::1:ff3e:c7f1
e80::a8af:ac69:e[ 6770.847947] address compression 0 bits
53e:c7f1) from f[ 6770.857961] source address unicast link-local
fe80::57b:2144:65d9:6fac iphc1 0x30
e80::57b:2144:65[ 6770.875515] destination address is multicast:
d9:6fac lowpan0:compressed to 6 octets
 56 data bytes
[ 6770.893603] header len 9 skb 49
[ 6770.902635] at86rf230_xmit
[ 6770.925237]  GINT_STAT_0 8000
[ 6770.931285] at86rf230_isr
[ 6771.808151] IPv6 header dump:
[ 6771.808151]  version = 6
[ 6771.808151]  length  = 40
[ 6771.808151]  nexthdr = 0x3a
[ 6771.808151]  hop_lim = 255
[ 6771.808151]  dest    = ff02::1:ff3e:c7f1
[ 6771.842953] address compression 0 bits
[ 6771.850379] source address unicast link-local
fe80::57b:2144:65d9:6fac iphc1 0x30
[ 6771.865198] destination address is multicast: compressed to 6 octets


>
> - Alex



-- 
Baptiste
