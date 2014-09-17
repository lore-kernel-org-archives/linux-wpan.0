Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65161 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaIQPn0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Sep 2014 11:43:26 -0400
Message-ID: <5419AC1C.8000704@xsilon.com>
Date: Wed, 17 Sep 2014 16:43:24 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <5419ABD6.70607@xsilon.com>
In-Reply-To: <5419ABD6.70607@xsilon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi Alex,

It looks like the problem is internal to Linux. I am running on a single 
Linux box, outputting a RPL message which is put onto a 802154 fakelb 
driver. The RPL message is also picked up by the code in my application 
that is listening on a RAW socket. This is where the corrupt addresses 
are seen.

All addresses are local link. Short addressing is used for the broadcast 
address only. I am not using stateful compression.

Is the same buffer used for the 6lowpan and ipv6 or is a copy taken to 
do the ipv6 header compression? If so the message is output on the 
802154 but first the ipv6 header is compressed. The message is also 
passed to my RAW ipv6 socket from the ipv6 layer using the same buffer 
which now contains the compressed header?


                                     |--->   recvmsg RAW skt
sendmsg RAW skt --->|
                                     |--->   6lowpan/802.15.4

My debug can see the header getting compressed at the 6lowpan layer but 
there is no receive debug triggered so the RAW socket is getting the 
message from the ipv6 layer.

Thanks

Simon

On 17/09/14 14:57, Alexander Aring wrote:
> Hi Simon,
>
> On Wed, Sep 17, 2014 at 02:30:22PM +0100, Simon Vincent wrote:
>> I have been looking into this issue again and it looks like RPL packets
>> cause the problem. It looks a bit like the header is not decompressed
>> correctly.
>>
> You mean now IPv6 header here? I think yes, there should no other header
> compression running for this case currently.
>> When I send a RPL packet I can see lowpan_header_compress is called which
>> compresses the header. I can not find where the header is decompressed when
>> the packet is received. By the time the packet gets to rawv6_recvmsg the src
>> and dest addresses in the header are corrupt.
>>
> Okay, you say here issues with source and destination addresses. I have
> no idea now what's going on your side.
>
> I need more information which types of addresses you use. Which kind of
> address compression methods, note we don't support stateful address
> compression but you are welcome to send patches. :-)
>
> My idea is now, enable some more debug information while running
> decompress/compress methods.
>
> At [0], you could add "#define DEBUG" then you see more information
> about the compression/uncompression while receiving/transmit. Don't know
> if you already know about that.
>
> Very simple is also to check if DAC or SAC bit in iphc1 is set. If this
> is set you used stateful compression, which is not supported (should
> occur a warning).
>
> I don't know right your setup if you use linux<->linux this should never
> happen. Other question is also, do you use short addresses? Handling of
> short addresses, except the broadcast address is currently also not
> supported. :-(
>
> I can also not say that there is more bugs than this, Werner Almesberger
> detected some issue about ICMPv6 payload size. Some issue with ICMPv6 payload
> which are lesser than 4 bytes was filtered by kernel. That was wrong for
> RPL... there was some crazy issue [1]. What I here want to say is, that
> probaly IPv6 implementation can't also deal with it, it's hard to debug
> I know. Use a little bit ctags for stepping into the code and instrument
> some printk foo, more or later you will find it. :)
>
> Sorry but I can't currently look more into this issue. Maybe simple add
> the "#define DEBUG" into [1], then write some mail which information
> from dmesg.
>
>> Is this expected?
>>
> No, normally all things should run fine. Otherwise you detect a bug. :-)
>
> And of course you are also welcome to send patches for it. I know there
> was some guy/girl which said the traffic class compression is broken,
> but this is currently hard understandable code, need some time to
> decrypt it, maybe a full rework for traffic class compression/decompress
> is needed. Maybe some cases for traffic class will break your address
> compression/decompression, overwriting some 6LoWPAN inline data.
>
> - Alex
>
> [0]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/6lowpan/iphc.c?id=refs/tags/v3.17-rc5#n51
> [1]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1c53c8e870cdedb6fc9550f41c558bab45b5219





