Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45892 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751455AbbFBHif (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 03:38:35 -0400
Date: Tue, 2 Jun 2015 09:38:27 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH wpan-tools] info: add frequency to channel listing for
 phy capabilities
Message-ID: <20150602073827.GA3273@probook-6560b>
References: <20150601133534.GA14012@probook-6560b>
 <556D2CB8.4070101@gmail.com>
 <20150602060838.GA2744@probook-6560b>
 <20150602070926.GB1977@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150602070926.GB1977@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Jun 02, 2015 at 09:09:30AM +0200, Alexander Aring wrote:
> On Tue, Jun 02, 2015 at 08:08:38AM +0200, Christoffer Holmstedt wrote:
> ...
> > 
> > This is for the same reason as above. Alignment in the output, it is a trade
> > off between "readability" in two different ways. Alignment in the output or
> > printing the full word "Unknown". I will change this to "Unknown" and we can
> > change it at a later date if it ever shows up and mess up alignment. In any
> > case if "Unknown" shows up the actual frequency should be added instead of
> > fixing alignment. ;)
> > 
> 
> Then maybe some "-" instead "unkown", is this better, or it's too small
> then?
> 

The more I think about it the more I feel "Unknown" is better. If for some
reason the channel page and channel combination is not listed and "Unknown" is
printed the last thing the user will care about is alignment in the output.

Channel page and channel number information will not change that often so we
should be able to keep up with future changes (additions). I have tried to get
hold of the 802.15.4-2015 draft from March/April but without success. The local
university will charge me ~350€ or something in that region for it. I wanted it
to see if any new channel pages/channels have been added since -2011 edition.

Anyway, v2 coming in a few minutes.

> - Alex

-- 
Christoffer Holmstedt
