Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:35910 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbcGZLYK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Jul 2016 07:24:10 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCHv4 bluetooth-next 3/8] ieee802154: 6lowpan: fix intra pan id check
In-Reply-To: <4f73efde-c6f8-c7e9-dcc9-1efbf42025cb@pengutronix.de>
References: <20160706213231.23058-1-aar@pengutronix.de> <20160706213231.23058-4-aar@pengutronix.de> <4f73efde-c6f8-c7e9-dcc9-1efbf42025cb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14581.1469532248.1@obiwan.sandelman.ca>
Date: Tue, 26 Jul 2016 07:24:08 -0400
Message-ID: <14582.1469532248@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Alexander Aring <aar@pengutronix.de> wrote:
    > I had some dicussion at IETF that the destination pan id could be
    > different than the source pan. So we need to change it "again" to remove
    > it. :-)

    > On rx side:
    > - dst pan id can be everything (also 0xfff?)
    > - src pan cannot be 0xffff, which should be filtered before reaching
    > packet layer.

    > On tx side:
    > - We some mechanism to tell the destination pan, we need anyway a
    > 6lowpan netlink api, so we could add 802.15.4 6lowpan option on it,
    > to change the destination panid per interface.

    > Or we do what vlan does:

    > # ip link add link eth0 name eth0.100 type vlan id 100

    > e.g.

    > # ip link add link wpan0 name lowpan0 type lowpan pan id 0xbeef

    > which can be handled by ip plugin command stuff.

I suggest that panid be handled in the same way as vlan tags: by creating new
virtual lowpanX interfaces.   That requires some work below...

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

