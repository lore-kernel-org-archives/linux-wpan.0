Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:35914 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbcGZLYo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Jul 2016 07:24:44 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCHv4 bluetooth-next 3/8] ieee802154: 6lowpan: fix intra pan id check
In-Reply-To: <e1bf7fb5-59d6-bf5f-bbde-27054c1bb4a1@pengutronix.de>
References: <20160706213231.23058-1-aar@pengutronix.de> <20160706213231.23058-4-aar@pengutronix.de> <4f73efde-c6f8-c7e9-dcc9-1efbf42025cb@pengutronix.de> <e1bf7fb5-59d6-bf5f-bbde-27054c1bb4a1@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14711.1469532283.1@obiwan.sandelman.ca>
Date: Tue, 26 Jul 2016 07:24:43 -0400
Message-ID: <14712.1469532283@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Alexander Aring <aar@pengutronix.de> wrote:
    > Everything is more complicated because if src pan and dst pan is the
    > same and the the intra-pan bit isn't set -> it's an invalid frame. So
    > the behaviour before was correct.

We might want a sysctl to permit such a thing...

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

