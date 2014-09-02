Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:64313 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaIBH0c (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 03:26:32 -0400
Date: Tue, 2 Sep 2014 09:26:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan status
Message-ID: <20140902072627.GB25800@omega>
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
 <20140901113835.GA21564@omega>
 <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com>
 <20140902071214.GA25800@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140902071214.GA25800@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

> > > 
> > > The 802.15.4 mac layer has some neighbor discovery issues which are not
> > > solved currently. It's about two kinds of mac addresses, for bluetooth
> > > it should be fine. A small description about this problem is here [1].
> > > 
> > > We need some way to trigger 6LoWPAN/Layer 2 data across the IPv6 layer
> > > and this isn't easy. Everything what we do on runtime decisions makes
> > > the IPv6 stack slower and we should avoid that.
> > 
> > Yep, agreed.
> > 
> 
> That's the big challenge to make an acceptable mainline solution. :-)
> 
> At the end it should be acked by IPv6 community, they should scream if a
> solution makes runtime decisions which slower down the stack too much.
> 

btw. I need L2 data in the neighbor discovery cache to handle the "two
kinds mac addresses". I will try to find a way after the rework of the mac
layer. This was discussed at [0].

- Alex

[0] http://marc.info/?l=linux-netdev&m=140724093516806&w=2
