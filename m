Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35668 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbaIQQEA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Sep 2014 12:04:00 -0400
Received: by mail-wi0-f179.google.com with SMTP id r20so790956wiv.12
        for <linux-wpan@vger.kernel.org>; Wed, 17 Sep 2014 09:03:58 -0700 (PDT)
Date: Wed, 17 Sep 2014 18:03:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140917160353.GC14100@omega>
References: <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
 <20140902153742.GC15189@omega>
 <5405EB08.5040006@xsilon.com>
 <20140902162630.GD15189@omega>
 <5406123E.2080100@xsilon.com>
 <20140908104326.GC6981@omega>
 <54198CEE.7000906@xsilon.com>
 <20140917135757.GB14100@omega>
 <5419A9DD.5070804@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5419A9DD.5070804@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Sep 17, 2014 at 04:33:49PM +0100, Simon Vincent wrote:
> Hi Alex,
> 
> It looks like the problem is internal to Linux. I am running on a single
> Linux box, outputting a RPL message which is put onto a 802154 fakelb
> driver. The RPL message is also picked up by the code in my application that
> is listening on a RAW socket. This is where the corrupt addresses are seen.
> 
> All addresses are local link. Short addressing is used for the broadcast
> address only. I am not using stateful compression.
> 
> Is the same buffer used for the 6lowpan and ipv6 or is a copy taken to do
> the ipv6 header compression? If so the message is output on the 802154 but
> first the ipv6 header is compressed. The message is also passed to my RAW
> ipv6 socket from the ipv6 layer using the same buffer which now contains the
> compressed header?
> 
> 
>                     |--->   recvmsg RAW skt
> sendmsg RAW skt --->|
>                     |--->   6lowpan/802.15.4
> 
> My debug can see the header getting compressed at the 6lowpan layer but

<--- compressed means tx working and no rx.

> there is no receive debug triggered so the RAW socket is getting the message
> from the ipv6 layer.
> 

mhhh, I have a theory. The linux networking stack is too clever. It see's
that these addresses are on the _same_ HOST and running it only one some
loopback interfaces. It's like ping6 ::1 on a lowpan interface, if you
want to do that, we never replace the IPv6 header with an 6LoWPAN header
because the current behaviour doesn't send it to the lower layers.
In this case "linux networking stack" see's "ahhh the same host -> doing
magic optimization". Then the IPv6 stack doesn't call the necessary 
callbacks to do 6LoWPAN magic.

Please instrument some driver layer of fakelb driver [1] then we can check
this theory, When you instrument some printk's at driver layer we can
see if your frames ever reached the lower layer. I am right not sure if
this could be true, I never tested so much the fakelb driver.

Also please instrument this function [0], it's necessary to run
decompression when receiving. If my theory is true, then it's a
complicated issue and don't know right now a easy workaround.

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L456
[1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/fakelb.c#L81
