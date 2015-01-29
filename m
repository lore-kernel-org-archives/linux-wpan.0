Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:63001 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbA2Hcz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Jan 2015 02:32:55 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so20487571wid.2
        for <linux-wpan@vger.kernel.org>; Wed, 28 Jan 2015 23:32:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150128210426.GA2125@omega>
References: <CAAkG1NMPUEg1jo=a84vndiScGQkox8SZHzRsVQ9EAP=-12sEag@mail.gmail.com>
	<CAAkG1NMx59Xma0pwUmEZkGaDVmw521xDzdKrHiVfx3Aw08M=4g@mail.gmail.com>
	<20150128210426.GA2125@omega>
Date: Thu, 29 Jan 2015 13:02:54 +0530
Message-ID: <CAAkG1NNoFOe8OjRWySVH2GOwixfNX+6hjbB+nYF8B2PXoTbhMw@mail.gmail.com>
Subject: Re: Sample code for 6Lo tx/rx
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

So, if I create a regular IPV6 DGRAM socket, it'll use the lowpan
interface as long as I bind it to the lowpan's IPV6 address? Or do I
not even need to bind() and the kernel will choose the lowpan
interface depending on the destination IP? Please correct me if I'm
wrong. I'm working on a couple of different things - one will need
6lowpan and the other can work with just 802.15.4.

I looked at the izchat example and understood most of it. The one
thing I don't understand is why the code calls connect() on the DGRAM
socket. Is it in some ways necessary for all 802.15.4 DGRAM sockets?
Or is it just for the convenience of using send() v/s sendto()?

Thanks a lot!

-Rohit

On Thu, Jan 29, 2015 at 2:34 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 28, 2015 at 04:39:48PM +0530, Rohit Kulkarni wrote:
>> Hi,
>>
>> I was wondering if there is any example code that can tx/rx over a
>> 6LoWPAN "node" interface. I've looked through the Unstrung code for
>> some examples but it uses ICMP all over. I'd really appreciate if
>> someone had any code samples for sending udp data over wpan. I tried
>> creating a SOCK_DGRAM socket over AF_IEEE802154 and got the "Protocol
>> not supported" error. Creating a SOCK_RAW worked but my life would be
>> much easier if I could start using DGRAMs :-) (One of the earlier
>> emails on the list mentioned DGRAMs over 6LoWPAN!).
>>
>> Also, I've never used RAW sockets before, so any help with RAW sockets
>> over wpan (if DGRAM is not really an option) will also be a huge help!
>>
>
> we need to clarify what exactly you want to do.
>
> wpan interface:
>
> Over this interface you can send IEEE 802.15.4 frames.
>
> 802.15.4 DGRAM sockets:
> When creating a 802.15.4 DGRAM socket this will be dataframes only.
>
> 802.15.4 RAW sockets:
> You can send whatever you want, you build the frame inside userspace
> (except the FCS).
>
>
> lowpan interface:
>
> There should only create IPv6 connection on it, all others sockets types
> will be dropped. Internal mechanism will translate IPv6 to 6LoWPAN and
> vice versa.
>
> For DGRAM, STREAM, RAW IPv6 socket types it's just the same like for
> others link-types like ethernet.
>
> Important note here: you can't create 802.15.4 sockets for a lowpan interface.
>
>
>
> Now to your question if there exists examples:
>
> Yes, there was some examples in the old lowpan-tools names "izchat" [0], but
> this is an example for DGRAM sockets only.
>
> Maybe we could add also some example like this in wpan-tools (we need to
> reprogramm it, lowpan-tools ist GPLv2 and the new wpan-tools are under
> the same license like "iw" which isn't GPL).
>
> Possible idea would be to add example program like izchat with some switch to
> use DGRAM or RAW 802.15.4 socket communication.
>
> - Alex
>
> [0] https://github.com/linux-wpan/lowpan-tools/blob/master/src/izchat.c
