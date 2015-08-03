Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34489 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbHCNi5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 09:38:57 -0400
Date: Mon, 3 Aug 2015 15:39:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan
 private data
Message-ID: <20150803133913.GA30530@omega>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
 <1438590118.2896.224.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1438590118.2896.224.camel@linux.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

On Mon, Aug 03, 2015 at 11:21:58AM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On pe, 2015-07-31 at 14:38 +0200, Alexander Aring wrote:
> > Hi,
> > 
> > I already thought many times to introduce something like that. Here is a draft
> > for introducing the generic 6lowpan private data into each lowpan interface.
> > For the beginning I introduced the enum "ll_type" which contains the LL type of
> > a lowpan interface.
> 
> Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> 
> 
> BTW, did you document the description below somewhere, it looks very
> useful.
> 

no, maybe we can create a "Documentation/networking/6lowpan.txt" for
this?

- Alex
