Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64524 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbaJBKvX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 06:51:23 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so1121807wib.2
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 03:51:22 -0700 (PDT)
Date: Thu, 2 Oct 2014 12:51:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002105118.GB20337@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <20141002092804.GC3850@omega>
 <542D1C80.9050807@xsilon.com>
 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002095430.GE3850@omega>
 <20141002095841.GF3850@omega>
 <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

Hi,

On Thu, Oct 02, 2014 at 01:12:44PM +0300, Jukka Rissanen wrote:
> 
> Hmm, bluetooth 6lowpan is a bit different from ieee802154 as the
> bluetooth link is a point-to-point one and typically only uses link
> local addresses so normally every packet is really meant for that host.
> 

mhh, when it's point-to-point, how can multicast work? Okay, maybe it's
some broadcast/multicast over point-to-point communication.

I don't understand maybe I should download some 802.15.1 material and read a
little bit more, but for now I have enough to care about the 802.15.4 layer.

- Alex
