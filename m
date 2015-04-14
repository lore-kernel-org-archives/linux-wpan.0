Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34990 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbbDNM2J (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 14 Apr 2015 08:28:09 -0400
Message-ID: <1429014486.2837.81.camel@linux.intel.com>
Subject: Re: creating infrastructure for generic 6LoWPAN branch
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 14 Apr 2015 15:28:06 +0300
In-Reply-To: <20150414114917.GA2179@omega>
References: <20150414114917.GA2179@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

On ti, 2015-04-14 at 13:49 +0200, Alexander Aring wrote:
> Hi,
> 
> I was thinking about to create some infrastructure to handle generic
> 6LoWPAN development things, which is shared between bluetooth and
> 802.15.4. I mean everything which is in "net/6lowpan" and things which
> are 6LoWPAN "specific/related/mostly used in 6LoWPAN" and works in L3 and
> upper layers.
> 
> What we should need is some kind of website which contains a ToDo list
> of everything which is outside there and what we currently support. I
> mean a general information site for "6LoWPAN" implementation inside
> Linux kernel.
> 
> Additionally we need some repository which contains some userspace tools
> for handling generic 6LoWPAN things like userspace configuration tool
> for the 6LoWPAN nhc layer. These tools can be used then for all 6LoWPAN
> implementations (BTLE/802.15.4 at the moment). That was one idea which
> was discussed while bringing nhc layer mainline.
> 
> Any ideas where we should host this site, do we really need this or
> any others suggestions?

As Marc suggested, the kernel.org wiki would be a good choice. And all
the userspace tools could be there also.


Cheers,
Jukka


