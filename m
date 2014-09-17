Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:58260 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbaIQN6H (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Sep 2014 09:58:07 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so1443453wgh.0
        for <linux-wpan@vger.kernel.org>; Wed, 17 Sep 2014 06:58:03 -0700 (PDT)
Date: Wed, 17 Sep 2014 15:57:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140917135757.GB14100@omega>
References: <20140902072627.GB25800@omega>
 <5405D284.7020606@xsilon.com>
 <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
 <20140902153742.GC15189@omega>
 <5405EB08.5040006@xsilon.com>
 <20140902162630.GD15189@omega>
 <5406123E.2080100@xsilon.com>
 <20140908104326.GC6981@omega>
 <54198CEE.7000906@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54198CEE.7000906@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Wed, Sep 17, 2014 at 02:30:22PM +0100, Simon Vincent wrote:
> I have been looking into this issue again and it looks like RPL packets
> cause the problem. It looks a bit like the header is not decompressed
> correctly.
> 

You mean now IPv6 header here? I think yes, there should no other header
compression running for this case currently.

> When I send a RPL packet I can see lowpan_header_compress is called which
> compresses the header. I can not find where the header is decompressed when
> the packet is received. By the time the packet gets to rawv6_recvmsg the src
> and dest addresses in the header are corrupt.
> 

Okay, you say here issues with source and destination addresses. I have
no idea now what's going on your side.

I need more information which types of addresses you use. Which kind of
address compression methods, note we don't support stateful address
compression but you are welcome to send patches. :-)

My idea is now, enable some more debug information while running
decompress/compress methods.

At [0], you could add "#define DEBUG" then you see more information
about the compression/uncompression while receiving/transmit. Don't know
if you already know about that.

Very simple is also to check if DAC or SAC bit in iphc1 is set. If this
is set you used stateful compression, which is not supported (should
occur a warning).

I don't know right your setup if you use linux<->linux this should never
happen. Other question is also, do you use short addresses? Handling of
short addresses, except the broadcast address is currently also not
supported. :-(

I can also not say that there is more bugs than this, Werner Almesberger
detected some issue about ICMPv6 payload size. Some issue with ICMPv6 payload
which are lesser than 4 bytes was filtered by kernel. That was wrong for
RPL... there was some crazy issue [1]. What I here want to say is, that
probaly IPv6 implementation can't also deal with it, it's hard to debug
I know. Use a little bit ctags for stepping into the code and instrument
some printk foo, more or later you will find it. :)

Sorry but I can't currently look more into this issue. Maybe simple add
the "#define DEBUG" into [1], then write some mail which information
from dmesg.

> Is this expected?
> 

No, normally all things should run fine. Otherwise you detect a bug. :-)

And of course you are also welcome to send patches for it. I know there
was some guy/girl which said the traffic class compression is broken,
but this is currently hard understandable code, need some time to
decrypt it, maybe a full rework for traffic class compression/decompress
is needed. Maybe some cases for traffic class will break your address
compression/decompression, overwriting some 6LoWPAN inline data.

- Alex

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/6lowpan/iphc.c?id=refs/tags/v3.17-rc5#n51
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1c53c8e870cdedb6fc9550f41c558bab45b5219
