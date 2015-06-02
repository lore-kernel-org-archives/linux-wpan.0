Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45925 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758451AbbFBJxO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 05:53:14 -0400
Date: Tue, 2 Jun 2015 11:53:10 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH wpan-tools] info: add frequency to channel listing for
 phy capabilities
Message-ID: <20150602095310.GB3273@probook-6560b>
References: <20150601133534.GA14012@probook-6560b>
 <556D2CB8.4070101@gmail.com>
 <20150602060838.GA2744@probook-6560b>
 <20150602070926.GB1977@omega>
 <20150602073827.GA3273@probook-6560b>
 <20150602093451.GF1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150602093451.GF1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Jun 02, 2015 at 12:34:51PM +0300, Lennert Buytenhek wrote:
> On Tue, Jun 02, 2015 at 09:38:27AM +0200, Christoffer Holmstedt wrote:
> 
> > > > This is for the same reason as above. Alignment in the output, it is a trade
> > > > off between "readability" in two different ways. Alignment in the output or
> > > > printing the full word "Unknown". I will change this to "Unknown" and we can
> > > > change it at a later date if it ever shows up and mess up alignment. In any
> > > > case if "Unknown" shows up the actual frequency should be added instead of
> > > > fixing alignment. ;)
> > > > 
> > > 
> > > Then maybe some "-" instead "unkown", is this better, or it's too small
> > > then?
> > > 
> > 
> > The more I think about it the more I feel "Unknown" is better. If for some
> > reason the channel page and channel combination is not listed and "Unknown" is
> > printed the last thing the user will care about is alignment in the output.
> > 
> > Channel page and channel number information will not change that often
> > so we should be able to keep up with future changes (additions). I have
> > tried to get hold of the 802.15.4-2015 draft from March/April but
> > without success. The local university will charge me ~350€ or something
> > in that region for it. I wanted it to see if any new channel
> > pages/channels have been added since -2011 edition.
> 
> There are some amendments already available for download that
> document new channel pages:
> 
> 802.15.4f-2012.pdf: channel pages 7, 8
> 802.15.4g-2012.pdf: channel pages 9, 10
> 802.15.4j-2013.pdf: channel page 11
> 802.15.4k-2013.pdf: channel page 12
> 802.15.4p-2014.pdf: channel page 13

Yea, I haven't read them yet but I assumed that was the case, will look into
that. In the meantime I believe v2 can be merged and channel pages 7-13 will
added in future patches.

-- 
Christoffer Holmstedt
