Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42296 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbaJBKna (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 06:43:30 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so2776235wgh.28
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 03:43:29 -0700 (PDT)
Date: Thu, 2 Oct 2014 12:43:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002104320.GA20337@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <20141002092804.GC3850@omega>
 <542D1C80.9050807@xsilon.com>
 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002095430.GE3850@omega>
 <20141002095841.GF3850@omega>
 <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002102200.GA19732@omega>
 <542D2B45.3000909@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542D2B45.3000909@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

Hi Simon,

....
> >
> >[PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan
> >
> >this should fix your routing problems, but issue with [0] still exists.
> So I should rebase and submit the whole patch series on bluetooth-next but
> not add a new patch to change net/bluetooth/6lowpan.c ?
> 

until we don't clarify how bluetooth need to handle the pkt_type value
in skb. You should only send one patch [PATCH linux-wpan 3/3] based on
wpan-next then. 

This should fix your routing issue but for me there exist still an issue
at [0] which nobody hit yet.

[0] http://lxr.free-electrons.com/source/net/ipv6/mcast.c#L1413
