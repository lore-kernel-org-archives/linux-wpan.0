Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7083 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbcFPNlo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 16 Jun 2016 09:41:44 -0400
Message-ID: <1466084491.13892.99.camel@linux.intel.com>
Subject: Re: current btle 6lowpan issues
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Date: Thu, 16 Jun 2016 16:41:31 +0300
In-Reply-To: <1466071258.31678.12.camel@linux.intel.com>
References: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
	 <1466071258.31678.12.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Alexander Aring <aar@pengutronix.de>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, 2016-06-16 at 13:00 +0300, Jukka Rissanen wrote:
> Yes you are right that there are issues. Fortunately the bt0 is
> currently a point-to-point link in which case ND is not really done
> and everything kind of "works" ok.
> 
> I added Patrik to cc: as he has been working to fix the issues but
> the patches are not yet ready. Perhaps we could combine the efforts
> here.

I had some patches that make BTLE interfaces non-point-to-point. Let me
check that they can be applied on the latest bluetooth-next and that
they still compile after a few months of sitting on an old version.
Then let's hope they also work as expected...

Cheers,

	Patrik

