Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59937 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaJBJnI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 2 Oct 2014 05:43:08 -0400
Message-ID: <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 02 Oct 2014 12:43:05 +0300
In-Reply-To: <542D1C80.9050807@xsilon.com>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
	 <20141002092804.GC3850@omega> <542D1C80.9050807@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com

Hi Simon,

On to, 2014-10-02 at 10:36 +0100, Simon Vincent wrote:
> I will add this patch when I rebase on bluetooth-next.

and thanks for doing that.

> 
> On 02/10/14 10:28, Alexander Aring wrote:
> > On Thu, Oct 02, 2014 at 09:56:43AM +0100, Simon Vincent wrote:
> >> This series of patches fix the cases where the pkt_type is overriden
> >> resulting in skbs of type PACKET_OTHERHOST getting set to PACKET_HOST.
> >> Also it drops packets of PACKET_OTHERHOST type in the 6lowpan layer
> >> as there is not point processing them as they are dropped at the next
> >> layer.
> > Please don't forget:
> >
> > $ grep -r -n "PACKET_HOST" net/bluetooth/6lowpan.c
> >
> > 276:		local_skb->pkt_type = PACKET_HOST;
> >
> > - Alex
> 


Cheers,
Jukka


