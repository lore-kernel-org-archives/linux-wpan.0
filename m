Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:47027 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbbFBKhK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 06:37:10 -0400
Date: Tue, 2 Jun 2015 13:37:09 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH wpan-tools] info: add frequency to channel listing for
 phy capabilities
Message-ID: <20150602103708.GG1897@wantstofly.org>
References: <20150601133534.GA14012@probook-6560b>
 <556D2CB8.4070101@gmail.com>
 <20150602060838.GA2744@probook-6560b>
 <20150602070926.GB1977@omega>
 <20150602073827.GA3273@probook-6560b>
 <20150602093451.GF1897@wantstofly.org>
 <20150602101516.GD1977@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150602101516.GD1977@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Christoffer Holmstedt <christoffer@christofferholmstedt.se>, Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Jun 02, 2015 at 12:15:17PM +0200, Alexander Aring wrote:

> > > > > This is for the same reason as above. Alignment in the output, it is a trade
> > > > > off between "readability" in two different ways. Alignment in the output or
> > > > > printing the full word "Unknown". I will change this to "Unknown" and we can
> > > > > change it at a later date if it ever shows up and mess up alignment. In any
> > > > > case if "Unknown" shows up the actual frequency should be added instead of
> > > > > fixing alignment. ;)
> > > > > 
> > > > 
> > > > Then maybe some "-" instead "unkown", is this better, or it's too small
> > > > then?
> > > > 
> > > 
> > > The more I think about it the more I feel "Unknown" is better. If for some
> > > reason the channel page and channel combination is not listed and "Unknown" is
> > > printed the last thing the user will care about is alignment in the output.
> > > 
> > > Channel page and channel number information will not change that often
> > > so we should be able to keep up with future changes (additions). I have
> > > tried to get hold of the 802.15.4-2015 draft from March/April but
> > > without success. The local university will charge me ~350€ or something
> > > in that region for it. I wanted it to see if any new channel
> > > pages/channels have been added since -2011 edition.
> > 
> > There are some amendments already available for download that
> > document new channel pages:
> > 
> > 802.15.4f-2012.pdf: channel pages 7, 8
> > 802.15.4g-2012.pdf: channel pages 9, 10
> > 802.15.4j-2013.pdf: channel page 11
> > 802.15.4k-2013.pdf: channel page 12
> > 802.15.4p-2014.pdf: channel page 13
> 
> mhhh, I looked into this. At the moment we have a highest channel number
> define (don't asking me where this comes from, was before there) [0]. I
> thought somewhere from the standard, that's why it's inside
> ieee802154.h.
> 
> I see for example 802.15.4k-2013 that the "phyCurrentChannel" range is
> above of them. e.g. Table 681. Currently we save it in some array file
> and the current channel is a bitfield [1].
> 
> So I think if we support it in kernel, we need some more granularity
> representation of the channels/pages, maybe also introduce some enums
> about band identifier information and such things.
> 
> I want to note that only.

I'm guessing that it's probably because page 0 supports channels 0-26,
and before 802.15.4-2006 there was no concept of channel pages at all.


> The current nl802154 for asking supported channel/page should be easily
> extendable since we doing for_each_nested stuff there. But Currently there
> is a lack of support for channel/page stuff, the datatype is also "u8" and
> seems also to be something which fits not in there like "current channel
> range: 1-416".
> 
> Oh well, that would be fun to change it again. :-)

:-)
