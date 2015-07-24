Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34436 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbGXMNe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 08:13:34 -0400
Received: by wibud3 with SMTP id ud3so62878437wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 05:13:33 -0700 (PDT)
Date: Fri, 24 Jul 2015 14:13:35 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150724121331.GA7623@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
 <20150724083106.GA2655@omega>
 <CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
 <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
 <20150724094804.GA6561@omega>
 <CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
 <20150724101842.GA7552@omega>
 <CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jul 24, 2015 at 02:03:09PM +0200, Baptiste Clenet wrote:
> 2015-07-24 12:18 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> > On Fri, Jul 24, 2015 at 11:56:08AM +0200, Baptiste Clenet wrote:
> >> 2015-07-24 11:48 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> >> > On Fri, Jul 24, 2015 at 11:02:30AM +0200, Baptiste Clenet wrote:
> >> >> 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> >> >> > 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> >> >> >> Hi,
> >> >> >>
> >> >> >> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
> >> >> >>> Hi,
> >> >> >>>
> >> >> >>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
> >> >> >>> supported" when I receive a ping from another board.
> >> >> >>>
> >> >> >>
> >> >> >> I think you hit [0]. You got that because we received some 6LoWPAN frame
> >> >> >> with context based address compression (the source address). See also [1].
> >> >> > Yes for [0]
> >> >> >
> >> >> >>
> >> >> >> Your options are:
> >> >> >>
> >> >> >>  - That the other board use stateless (means SAC = 0, see [1]) address
> >> >> >>    compression.
> >> >> > How may I check?
> >> >> > They use both the same settings, they are based on the same source code.
> >> >> SAC bit is set.
> >> >
> >> > Yes SAC bit means context based address compression and we don't support
> >> > it. We should support it, that's what rfc6282 said. But we don't have
> >> > support for that now. :-)
> >> >
> >> > What do you mean with "they are based on the same source code"? It's a
> >> > linux<->linux communication?
> >> Yes it is linux to linux transmission.
> >> Yeah I understand for the support :-)
> >> The question is now why my linux use context based address compression
> >> if it shouldn't? Where is it (SAC) set when transmitting a message?
> >>
> >
> > We don't set it. Which kernel do you use?
> Linux 4.1.0 (yeah I should use bluetooth-next kernel)
> I see that the only way it is set is when
> 'source address is unspecified, setting SAC'
> 

yes, apologize it wasn't correct. But the SAM value was 0x3 in your case
and this shouldn't be.

The SAC = 1 and SAM = 0 is a very simple case [0]. It's simple do
nothing.

> root@OpenWrt:/# ifconfig
> lowpan0   Link encap:UNSPEC  HWaddr
> 07-7B-21-44-65-D9-6F-AC-00-00-00-00-00-00-00-00
>           inet6 addr: fe80::57b:2144:65d9:6fac/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> wpan0     Link encap:UNSPEC  HWaddr
> 07-7B-21-44-65-D9-6F-AC-00-00-00-00-00-00-00-00
>           UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
>           RX packets:20 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300
>           RX bytes:1001 (1001.0 B)  TX bytes:568 (568.0 B)
> 
> (There is some printk for irq as well)
> root@OpenWrt:/#ip link set lowpan0 up
> root@OpenWrt:/# [   66.248286] IPv6 header dump:
> [   66.248286]  version = 6
> [   66.248286]  length  = 36
> [   66.248286]  nexthdr = 0x00
> [   66.248286]  hop_lim = 1
> [   66.248286]  dest    = ff02::16
> [   66.281193] source address is unspecified, setting SAC
> // ??

Yes this is simple case at [0]. But then SAM should be 0 not 3. And in
some previous mail it was set 3 in your case.

We set the SAC bit once at [1] only, but then SAM should be 0. 

- Alex

[0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L148
