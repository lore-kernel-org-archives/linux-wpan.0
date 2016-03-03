Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:40802 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbcCCOgF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Mar 2016 09:36:05 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: 802.15.4G support?
In-Reply-To: <20160228140659.GA17980@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28980.1457015214.1@obiwan.sandelman.ca>
Date: Thu, 03 Mar 2016 09:26:54 -0500
Message-ID: <28981.1457015214@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Alexander Aring <alex.aring@gmail.com> wrote:
    > You want to run 6LoWPAN on it, current the 802.15.4 calculates a lot of
    > stuff with the IEEE802154_MTU define, in most cases when using
    > fragmentation.

    > It seems you don't need fragmentation in your case, because you reach
    > the 1280 minimum MTU for IPv6. The condition at [4] should be always
    > true then.

I believe that they do, as 15.4g PHYs can communicate with 15.4 PHYs, and
so the fragment on/off/MTU decision will need to be added to the neighbour
cache.

    > Another question would be: You can run 6LoWPAN on it, but nobody
    > specifies to run 6LoWPAN on such "SUN PHY's". I actually don't see
    > that. Everything is specified with 127 MTU.

    > I don't want to tell you cannot run 6LoWPAN on it, but does somebody
    > need to specify 6LoWPAN for 802.15.4g at first?

WiSun alliance did that, I think.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

