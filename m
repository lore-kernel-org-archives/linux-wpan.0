Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:52665 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaJBKhU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 06:37:20 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so1090814wib.2
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 03:37:19 -0700 (PDT)
Date: Thu, 2 Oct 2014 12:37:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002103713.GA20200@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <20141002092804.GC3850@omega>
 <542D1C80.9050807@xsilon.com>
 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002095430.GE3850@omega>
 <20141002095841.GF3850@omega>
 <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002102200.GA19732@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141002102200.GA19732@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

On Thu, Oct 02, 2014 at 12:22:01PM +0200, Alexander Aring wrote:
...
> 
> Okay, then maybe bluetooth 6lowpan need to set it to PACKET_HOST always.
> 
> Another idea would be:
> We could also set PACKET_BROADCAST if the IPv6 address is a
> multicast/broadcast addresss.
> 
> But it looks wrong, the PACKET_FOO values should be set by mac layer only.
> 
> 
> What I deteced is at [0]. There it checks if the "mac frame" was
> broadcast or multicast. I don't know when this occurs, I need to check
> this but it seems to be broken, when we always set the PACKET_HOST.
> 
> 
> 
> Simon had issues with routing when IPv6 Layer gets a skb with PACKET_HOST and
> it was PACKET_OTHERHOSTS before.
> 
> 
> Simon:
> 
> Maybe only send patch:
> 
> [PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan
> 
> this should fix your routing problems, but issue with [0] still exists.
> 

Another idea would be to put out the handling of setting pkt_type inside
the 6LOWPAN GENERIC branch. This is what Martin does in the lowpan_rcv
fixes... I still need some time to review his patch.

Maybe Simon add patch "[PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop
PACKET_OTHERHOST skbs in 6lowpan" this only affects the 802.15.4 branch.

Then Martin solve the lowpan_rcv issue which put out the handling of
pkt_type in lowpan_header_create function. Then you can do whatever
bluetooth need to do there and we can drop the override of set this
value to PACKET_HOST.

- Alex
