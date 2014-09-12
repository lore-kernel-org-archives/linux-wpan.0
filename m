Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56160 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbaILJSZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 12 Sep 2014 05:18:25 -0400
Message-ID: <1410513480.7977.107.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH][linux-bluetooth 2/3] 6lowpan: Move skb delivery from
 IPHC.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Fri, 12 Sep 2014 12:18:00 +0300
In-Reply-To: <20140911102555.GC20686@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
	 <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com>
	 <20140911081808.GA19675@omega> <54115C94.2050308@xsilon.com>
	 <20140911090144.GC19675@omega> <54116C6D.3090004@xsilon.com>
	 <20140911095355.GB20686@omega> <54117579.1070905@xsilon.com>
	 <20140911102555.GC20686@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On to, 2014-09-11 at 12:25 +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Thu, Sep 11, 2014 at 11:12:09AM +0100, Martin Townsend wrote:
> > Hi Alex,
> > 

> > I would also be grateful for any testing by bluetooth developers as I can't physically test the code changes I have made to the bluetooth 6lowpan code.
> > 
> 
> I know what you mean...
> 
> I cc Jukka Rissanen, he implemented the 6lowpan stuff for bluetooth. I also
> wanted that he becomes maintainer for 6LOWPAN_GENETIC too to review
> the bluetooth side. Jukka what's about that... to be maintainer?

Sure, I can be the maintainer of the BT 6LoWPAN side. I will send patch
for MAINTAINERS file shortly.


Cheers,
Jukka


