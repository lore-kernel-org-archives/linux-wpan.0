Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:33989 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbcEKROz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 May 2016 13:14:55 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: allow netns create of lowpan interface
In-Reply-To: <1462959859-6669-3-git-send-email-aar@pengutronix.de>
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de> <1462959859-6669-3-git-send-email-aar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16669.1462986892.1@obiwan.sandelman.ca>
Content-Transfer-Encoding: 8BIT
Date: Wed, 11 May 2016 13:14:52 -0400
Message-ID: <16670.1462986892@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Alexander Aring <aar@pengutronix.de> wrote:
    > This patch reverts commit f9d1ce8f81eb ("ieee802154: fix netns settings").
    > The lowpan interface need to be created inside the net namespace where
    > the wpan interface is available. The wpan namespace can be changed only
    > by nl802154 before. Without this patch it's not possible to create a
    > lowpan interface for a wpan interface which isn't inside init_net
    > namespace.

I know that we can't support multiple lowpan interfaces on a single wpan
at this time.  If one could, via a macvlan like way, would we want to
put different lowpan interfaces in different netns on top of the same
physical radio.

I'm also ignorant here: can one create macvlan against a physical interface
into a netns?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

