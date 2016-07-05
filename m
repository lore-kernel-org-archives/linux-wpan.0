Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:46110 "EHLO
	relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcGFBFu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Jul 2016 21:05:50 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: current btle 6lowpan issues
In-reply-to: <1466071258.31678.12.camel@linux.intel.com>
References: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de> <1466071258.31678.12.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2524.1467724395.1@dooku.sandelman.ca>
Date: Tue, 05 Jul 2016 09:13:15 -0400
Message-ID: <2525.1467724395@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Alexander Aring <aar@pengutronix.de>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com

Jukka Rissanen <jukka.rissanen@linux.intel.com> wrote:
    >> I started to work on this but the issue 2. is a big change in btle
    >> 6lowpan so I want to start the discussion about to fix that to doing
    >> it in the right way.
    >>
    >> Jukka, do you agree that this behaviour is currently broken in btle
    >> 6lowpan?

    > Yes you are right that there are issues. Fortunately the bt0 is
    > currently a point-to-point link in which case ND is not really done and
    > everything kind of "works" ok.

I've read that btle 4.2, while it won't permit one to maintain multiple
links at the same time, will permit a device to quickly cycle between
multiple attachments.  A device could therefore move from one btle star to
another one several times per second, and route packets that way.
This puts btle in the same space as time slotted -- 6tisch (802.15.4e).

My gut is that btle will be *the* low-power mesh tech in ten years.
(Unless it's DECT...)

The other situation in which we might need more than ptp is when we have
multiple btle radios, or when we are doing any kind of layer-3 mesh with
multiple technologies...
