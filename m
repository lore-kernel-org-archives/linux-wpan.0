Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6269 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbcFPKBG (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 16 Jun 2016 06:01:06 -0400
Message-ID: <1466071258.31678.12.camel@linux.intel.com>
Subject: Re: current btle 6lowpan issues
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 16 Jun 2016 13:00:58 +0300
In-Reply-To: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
References: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com

Hi Alex,

On Wed, 2016-06-15 at 20:02 +0200, Alexander Aring wrote:
> Hi,
> 
> I like to collect some _big_ issues which I detected on current btle
> 6lowpan
> implementation, these are:
> 
>  1. The l2 daddr comes not from ndisc cache. This should come from
> ndisc
>     cache, instead the implementation construct the l2 from L3
> address
>     which only works for autoconfiguration addresses, all other
>     addresses seems not be working for btle 6lowpan.
> 
>  2. The dev->dev_addr should be the 6 byte baddr and NOT the eui64
>     generated baddr with fffe pattern and u/l bit. The eui64 should
> not
>     be part of source/target address options of ndisc messages, it
> should
>     be the baddr in big endian format. (dev->addr_len need to be 6
> then,
>     as well). baddr is the mac address of btle transceiver.
> 
> The 1. is easy to fix, but then I detected if we do that, the
> neighbour
> cache messages NS/NA/RS, etc use the eui64 fffe pattern with u/l bit
> for
> these messages, because the issue 2. So we will get the wrong address
> from ndisc. The ndisc should store the 6 bytes baddr in big endian
> format.
> So these two issues need to be fixed in some patch and changes
> everything
> in btle 6lowpan.
> 
> I started to work on this but the issue 2. is a big change in btle
> 6lowpan
> so I want to start the discussion about to fix that to doing it in
> the
> right way.
> 
> Jukka, do you agree that this behaviour is currently broken in btle
> 6lowpan?

Yes you are right that there are issues. Fortunately the bt0 is
currently a point-to-point link in which case ND is not really done and
everything kind of "works" ok.

I added Patrik to cc: as he has been working to fix the issues but the
patches are not yet ready. Perhaps we could combine the efforts here.


Cheers,
Jukka

