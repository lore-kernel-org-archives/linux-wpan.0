Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33597 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbHCNyH (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 3 Aug 2015 09:54:07 -0400
Message-ID: <1438610043.2896.226.camel@linux.intel.com>
Subject: Re: [RFCv2 bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan
 private data
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 03 Aug 2015 16:54:03 +0300
In-Reply-To: <20150803133913.GA30530@omega>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
	 <1438590118.2896.224.camel@linux.intel.com> <20150803133913.GA30530@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

On ma, 2015-08-03 at 15:39 +0200, Alexander Aring wrote:
> On Mon, Aug 03, 2015 at 11:21:58AM +0300, Jukka Rissanen wrote:
> > Hi Alex,
> > 
> > On pe, 2015-07-31 at 14:38 +0200, Alexander Aring wrote:
> > > Hi,
> > > 
> > > I already thought many times to introduce something like that. Here is a draft
> > > for introducing the generic 6lowpan private data into each lowpan interface.
> > > For the beginning I introduced the enum "ll_type" which contains the LL type of
> > > a lowpan interface.
> > 
> > Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > 
> > 
> > BTW, did you document the description below somewhere, it looks very
> > useful.
> > 
> 
> no, maybe we can create a "Documentation/networking/6lowpan.txt" for
> this?

You read my mind, I was thinking exactly that :)


Cheers,
Jukka


