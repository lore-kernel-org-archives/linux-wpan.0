Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:45657 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761636AbbA2CXH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Jan 2015 21:23:07 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so2937298wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 28 Jan 2015 18:23:06 -0800 (PST)
Date: Wed, 28 Jan 2015 22:04:28 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Sample code for 6Lo tx/rx
Message-ID: <20150128210426.GA2125@omega>
References: <CAAkG1NMPUEg1jo=a84vndiScGQkox8SZHzRsVQ9EAP=-12sEag@mail.gmail.com>
 <CAAkG1NMx59Xma0pwUmEZkGaDVmw521xDzdKrHiVfx3Aw08M=4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAkG1NMx59Xma0pwUmEZkGaDVmw521xDzdKrHiVfx3Aw08M=4g@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rohit Kulkarni <rmkulkar@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Jan 28, 2015 at 04:39:48PM +0530, Rohit Kulkarni wrote:
> Hi,
> 
> I was wondering if there is any example code that can tx/rx over a
> 6LoWPAN "node" interface. I've looked through the Unstrung code for
> some examples but it uses ICMP all over. I'd really appreciate if
> someone had any code samples for sending udp data over wpan. I tried
> creating a SOCK_DGRAM socket over AF_IEEE802154 and got the "Protocol
> not supported" error. Creating a SOCK_RAW worked but my life would be
> much easier if I could start using DGRAMs :-) (One of the earlier
> emails on the list mentioned DGRAMs over 6LoWPAN!).
> 
> Also, I've never used RAW sockets before, so any help with RAW sockets
> over wpan (if DGRAM is not really an option) will also be a huge help!
> 

we need to clarify what exactly you want to do.

wpan interface:

Over this interface you can send IEEE 802.15.4 frames.

802.15.4 DGRAM sockets:
When creating a 802.15.4 DGRAM socket this will be dataframes only.

802.15.4 RAW sockets:
You can send whatever you want, you build the frame inside userspace
(except the FCS).


lowpan interface:

There should only create IPv6 connection on it, all others sockets types
will be dropped. Internal mechanism will translate IPv6 to 6LoWPAN and
vice versa.

For DGRAM, STREAM, RAW IPv6 socket types it's just the same like for
others link-types like ethernet.

Important note here: you can't create 802.15.4 sockets for a lowpan interface.



Now to your question if there exists examples:

Yes, there was some examples in the old lowpan-tools names "izchat" [0], but
this is an example for DGRAM sockets only.

Maybe we could add also some example like this in wpan-tools (we need to
reprogramm it, lowpan-tools ist GPLv2 and the new wpan-tools are under
the same license like "iw" which isn't GPL).

Possible idea would be to add example program like izchat with some switch to
use DGRAM or RAW 802.15.4 socket communication.

- Alex

[0] https://github.com/linux-wpan/lowpan-tools/blob/master/src/izchat.c
