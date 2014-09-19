Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:51713 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbaISMGj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 08:06:39 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi2so1867318wib.15
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 05:06:37 -0700 (PDT)
Date: Fri, 19 Sep 2014 14:06:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919120630.GA23106@omega>
References: <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
 <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <20140919110854.GA21364@omega>
 <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
 <541C1AC2.1010308@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541C1AC2.1010308@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Fri, Sep 19, 2014 at 01:00:02PM +0100, Simon Vincent wrote:
> 
> On 19/09/14 12:45, Alexander Aring wrote:
> >On Fri, Sep 19, 2014 at 12:27:54PM +0100, Simon Vincent wrote:
> >>On 19/09/14 12:08, Alexander Aring wrote:
> >>>On Thu, Sep 18, 2014 at 04:19:11PM +0200, Alexander Aring wrote:
> >>>>On Thu, Sep 18, 2014 at 03:02:17PM +0100, Simon Vincent wrote:
> >>>>>I have created a small test program that shows this problem. It looks like a
> >>>>>race condition as sometimes the addresses are not corrupt.
> >>>>>
> >>>>Mhh maybe some used after freed and then we copy somewhere garbage sometimes.
> >>>>Don't know right now.
> >>>>
> >>>>>It looks like if the RAW socket gets the packet before the packet hits the
> >>>>>6lowpan layer the addresses are fine. If the packet hits the 6lowpan layer
> >>>>>before the RAW socket gets the packet then the addresses are corrupt.
> >>>>>
> >>>>>The test program can be found here.
> >>>>>https://github.com/xsilon/sockdebug
> >>>>>
> >>>>>I will continue debugging!
> >>>>>
> >>>>ok, good luck.
> >>>>
> >>>I gave this now a try, how can I see the issue now?
> >>>
> >>>I see on output:
> >>>
> >>>recv_raw_icmp[fe80:0:41:c863:cdab:ffff:bbaa:aaaa%lowpan0->?]
> >>>
> >>>this address doesn't exist in my network.
> >>>
> >>>I can also upload wpan wireshark logs and lowpan wireshark logs, if you
> >>>like.
> >>>
> >>>In sockdebug I changed also "const char* src_string =" to one of my
> >>>lowpan addresses. Simon are you still here to debug this issue with me?
> >>>:-)
> >>Yes this is the same error I am seeing. I find that sometimes the recv
> >>address is correct but mostly you get the corrupt address as the ipv6 header
> >>has been overwritten by our compressed 6lowpan header.
> >>
> >>If you comment out the 6lowpan header compression function it solves the
> >>problem.
> >okay, then I dig now into the issue why the address is garbage.
> >
> >>I am trying to understand how the network stack handles skbs. As it is a
> >>multicast packet it will be sent out on  802.15.4, raw socket and any other
> >>interfaces you have but it looks like in this case the interfaces all get a
> >>skb pointing to the same data. Therefore when we replace the ipv6 header
> >>with a compressed version everyone else still thinks there is a normal ipv6
> >>header still there and therefore gets corrupt data. Should each interface
> >>get a copy of the data? E.g. the ethernet, wifi, 802.15.4 and raw socket all
> >>get a copy of the skb data not a clone?
> >>
> >>Maybe normally each interface will get a copy of the skb so they can attach
> >>their own mac header but in the case of the RAW socket they don't bother
> >>doing a copy as they don't need to add a header for the socket. But then we
> >>come along and destroy the ipv6 header!!
> >>
> >>Just a theory!
> >>
> >okay, there exists a lot of there. I know what you saying because the
> >data buffer is shared there exist race conditions because some other skb
> >has in the next step a 6LoWPAN header, if I understand that correctly.
> >
> Yes I think the problem is we are sharing the databuffer and modifying the
> contents. We should probably be given a copy of the data buffer. I can't
> find the code that decides if we get a copy or clone of the skb.
> 

yea, IPv6 stack is complicated. :-)

And if you found it, it would be complicated to make any change on it,
we are only an adapation layer... All 6LoWPAN runtime decisions in IPv6
are bad and do some change. But the IPv6 are not evil, we can talk with
them that we have something which works on both stacks and doesn't
decrease much the performance of IPv6. If we have something like this
then we have a mainline solution.

> For example in ip6_finish_output2 because it is a multicast packet the skb
> is cloned (so same data buffer) and sent to the loopback interface. This
> loopback interface is going to expect the ipv6 header to be intact.
> 
ok I will remember and check it.


- Alex
