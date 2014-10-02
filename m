Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63599 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaJBJ6q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:58:46 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so2619159wgh.33
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 02:58:44 -0700 (PDT)
Date: Thu, 2 Oct 2014 11:58:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002095841.GF3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <20141002092804.GC3850@omega>
 <542D1C80.9050807@xsilon.com>
 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002095430.GE3850@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141002095430.GE3850@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

On Thu, Oct 02, 2014 at 11:54:30AM +0200, Alexander Aring wrote:
> Jukka,
> 
> On Thu, Oct 02, 2014 at 12:43:05PM +0300, Jukka Rissanen wrote:
> > Hi Simon,
> > 
> > On to, 2014-10-02 at 10:36 +0100, Simon Vincent wrote:
> > > I will add this patch when I rebase on bluetooth-next.
> > 
> > and thanks for doing that.
> > 
> 
> I see now, that the bluetooth layer never sets this value. I don't know
> how bluetooth deal with that. But you need to set PACKET_HOST if packet
> belongs to you, OTHERHOST if packets belongs not to you, or
> PACKET_BROADCAST if packet belongs to you, but is a broadcast.
> 
> Also for PACKET_MULTICAST, if bluetooth support MULTICAST frames.
> 
> 
> I think you need handling for this in bluetooth 6lowpan layer.
> 

and this should be fixed before Simon's patches. I add Marcel here in
cc, maybe he can bring some new information if bluetooth ever set's the
pkt_type in sk_buff.

Point is IPv6 needs this information and we should set it to a valid value.
... and this is not always set PACKET_HOST, IPv6 also check on PACKET_BROADCAST.

- Alex
