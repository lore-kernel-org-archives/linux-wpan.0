Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:39655 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbGMOXX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 10:23:23 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC v2 0/4] Adding stateful compression to IPHC
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
Date: Mon, 13 Jul 2015 10:15:08 -0400
Message-ID: <4784.1436796908@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org


Lukasz Duda <lukasz.duda@nordicsemi.no> wrote:
    > There is a need for parsing the 6CO option in ndisc.c which parses Router
    > Advertisement messages. Today the function calls to IPHC (6lowpan module) are
    > quite hard to implement in ndisc.c, as there is no guarantee that the 6lowpan
    > module will be loaded or not. It would make sense to build 6lowpan module
    > as in-build part of IPv6. The features could be compiled in by using #defines.

    > What do you think about moving 6lowpan as a component of IPv6 and modify ndisc.c
    > to handled 6LoWPAN specific options? Do you see any other solution to make sure
    > that 6CO is parsed and acted upon and still keep 6lowpan as a stand-alone module?

What about if ndisc.c accepted non-exclusive registrations for ND type codes?
Then 6lowpan could register itself as handler for RAs, and could process the
6CO options, ABROs, etc.
(BTW: 6tisch contemplates extending ABROs as well: there is more to come)

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


