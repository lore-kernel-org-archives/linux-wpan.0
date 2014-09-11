Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36631 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaIKLAZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 07:00:25 -0400
Date: Thu, 11 Sep 2014 13:00:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH][linux-bluetooth 3/3] 6lowpan: Refactored lowpan_rcv so
 it's RFC compliant
Message-ID: <20140911110020.GF20686@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-5-git-send-email-martin.townsend@xsilon.com>
 <20140911085353.GB19675@omega>
 <54116BC6.2030609@xsilon.com>
 <20140911095052.GA20686@omega>
 <541174D6.7060200@xsilon.com>
 <20140911103321.GD20686@omega>
 <54117D66.3070102@xsilon.com>
 <20140911105505.GE20686@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140911105505.GE20686@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Martin,

On Thu, Sep 11, 2014 at 12:55:05PM +0200, Alexander Aring wrote:
> On Thu, Sep 11, 2014 at 11:45:58AM +0100, Martin Townsend wrote:
> > Hi Alex,
> > 
> > On 11/09/14 11:33, Alexander Aring wrote:
> > > On Thu, Sep 11, 2014 at 11:09:26AM +0100, Martin Townsend wrote:
> > >> Hi Alex,
> > >>
> > >> Reposting to everyone this time :)
> > >>
> > > ok
> > > ...
> > >>>>> I know this issue and we should not do that in this way.
> > >>>>>
> > >>>>> Why?
> > >>>>>
> > >>>>> Because this works only for fragmentation with IPHC, for example if we
> > >>>>> support mesh or Broadcast or HC1 compression. We should call after
> > >>>>> successfully reassembled "means lowpan_frag_rcv returns 1" the lowpan_rcv again.
> > >>>>> So this is a recursion and we don't should use recursion to much, but it
> > >>>>> should only be one recursion, so I think that's okay. :-)
> > >>>> The spec says that the headers of the 6LoWPAN frame must fit in the first fragment.  You need to process these headers to get to the fragmentation header, this is why the code is this way.
> > >>> yes this is for IPHC dispatch values your code works, I don't want to
> > >>> say that it doesn't work. Because fragmentation is something to
> > >>> reconstruct the full payload, we should first evaluate the fragmentation
> > >>> dispatches and then all others. To be sure that we can use fragmentation
> > >>> on any dispatch value which is not the fragmentation dispatch values.
> > >>> :-)
> > >>>
> > >>> Simple move it before nalp check. Maybe somebody fragment something and
> > >>> the dispatch value after fragmentation is nalp. I know it should catch
> > >>> the default branch above, but it's a little bit cleaner. I hope you are
> > >>> in the same opinion.
> > >> I think it should stay where it is.
> > >> From RFC 4944
> > >> NALP: Specifies that the following bits are not a part of the LoWPAN
> > >> encapsulation, and any LoWPAN node that encounters a dispatch
> > >> value of 00xxxxxx shall discard the packet. Other non-LoWPAN
> > >> protocols that wish to coexist with LoWPAN nodes should include a
> > >> byte matching this pattern immediately following the 802.15.4.
> > >> header.
> > >>
> > >> The last sentence implies that this NALP code is expected as the first byte following the MAC Header.  If a NALP is encountered after processing the 6LoWPAN header stack then it will be treated as an unknown compression type.
> > >>
> > > yes. But the issue is more a reassembled fragmentet 6LoWPAN packet have
> > > a dispatch value. This dispatch value should not NALP, but maybe
> > > somebody did it and then we should make the same code like what we do
> > > for NALP dispatches without fragmentation.
> > A NALP dispatch byte should be the first byte in the MAC payload that allows other protocols to co-exist with 6LoWPAN.  I think Jennet use this to insert their own protocol between 802.15.4 and 6LoWPAN.  So we have to check for this before we do anything.  Having a NALP byte after re-assembly isn't valid and should be treated as an unknown compression type in my opinion.
> > 
> 
> Okay, I agree with you with the NALP dispatch. What's about the others.
> 
ok. This is out of interest because we don't support all others than
IPV6 and IPHC. The important thing is, if we don't know the dispatch
after fragmentation -> drop it.

We will think about that issue, if somebody implements that.

- Alex
