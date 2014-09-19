Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59509 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbaISLuJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 07:50:09 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so702407wib.8
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 04:50:08 -0700 (PDT)
Date: Fri, 19 Sep 2014 13:50:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919115005.GB22396@omega>
References: <20140918084515.GB3774@omega>
 <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
 <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <20140919110854.GA21364@omega>
 <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140919114549.GA22396@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Fri, Sep 19, 2014 at 01:45:49PM +0200, Alexander Aring wrote:
> On Fri, Sep 19, 2014 at 12:27:54PM +0100, Simon Vincent wrote:
> > 
> > On 19/09/14 12:08, Alexander Aring wrote:
> > >On Thu, Sep 18, 2014 at 04:19:11PM +0200, Alexander Aring wrote:
> > >>On Thu, Sep 18, 2014 at 03:02:17PM +0100, Simon Vincent wrote:
> > >>>I have created a small test program that shows this problem. It looks like a
> > >>>race condition as sometimes the addresses are not corrupt.
> > >>>
> > >>Mhh maybe some used after freed and then we copy somewhere garbage sometimes.
> > >>Don't know right now.
> > >>
> > >>>It looks like if the RAW socket gets the packet before the packet hits the
> > >>>6lowpan layer the addresses are fine. If the packet hits the 6lowpan layer
> > >>>before the RAW socket gets the packet then the addresses are corrupt.
> > >>>
> > >>>The test program can be found here.
> > >>>https://github.com/xsilon/sockdebug
> > >>>
> > >>>I will continue debugging!
> > >>>
> > >>ok, good luck.
> > >>
> > >I gave this now a try, how can I see the issue now?
> > >
> > >I see on output:
> > >
> > >recv_raw_icmp[fe80:0:41:c863:cdab:ffff:bbaa:aaaa%lowpan0->?]
> > >
> > >this address doesn't exist in my network.
> > >
> > >I can also upload wpan wireshark logs and lowpan wireshark logs, if you
> > >like.
> > >
> > >In sockdebug I changed also "const char* src_string =" to one of my
> > >lowpan addresses. Simon are you still here to debug this issue with me?
> > >:-)
> > Yes this is the same error I am seeing. I find that sometimes the recv
> > address is correct but mostly you get the corrupt address as the ipv6 header
> > has been overwritten by our compressed 6lowpan header.
> > 
> > If you comment out the 6lowpan header compression function it solves the
> > problem.
> 
> okay, then I dig now into the issue why the address is garbage.
> 

funny, I see a pattern:

recv_raw_icmp[fe80:0:41:c85d:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c85e:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c85f:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c860:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c861:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c862:cdab:ffff:bbaa:aaaa%lowpan0->?]
recv_raw_icmp[fe80:0:41:c863:cdab:ffff:bbaa:aaaa%lowpan0->?]
                          ^^

The ^^ is looking like there is some sequence number which is increasing. :-)

- Alex
