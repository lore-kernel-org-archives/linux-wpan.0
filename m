Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37287 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434AbcB1OHL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 28 Feb 2016 09:07:11 -0500
Received: by mail-wm0-f43.google.com with SMTP id p65so14801339wmp.0
        for <linux-wpan@vger.kernel.org>; Sun, 28 Feb 2016 06:07:11 -0800 (PST)
Date: Sun, 28 Feb 2016 15:07:04 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4G support?
Message-ID: <20160228140659.GA17980@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Remi Philippe <remi@linqio.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Feb 25, 2016 at 10:22:45PM +0400, Remi Philippe wrote:
> Hello,
> 
> We’re currently developing a driver for RF215 (dual radio) using
> 6lowpan and are nearly done with it. We’ve figured out the current MAC
> and PHY are built for 15.4 and not 15.4g which is a blocking point the
> sub-ghz module.
> 

ok.

> 
> It doesn’t look like there is a need for a huge amount of work to get
> a basic version of it working (key ones we’ve seen are different MTU
> and also some changes in the header like PHR).
> 

I took a look into 802.15.4g and you probaly mean with different MTU:

aMaxPHYPacketSize:

	2047 for SUN PHYs
	127 for all other PHYs

So we working currently with "127" for aMaxPHYPacketSize. In your case you
will have "2047".


Current issue is:

We don't handle this parameter as a variable, it's a define see [0]. :-)
I am fine to change it as variable declaration into PIB [1], then add a
new PHY FLAG [2] for such "SUN PHY's", while registering [3] the phy, it will
update specific constants for such phy's e.g. aMaxPHYPacketSize.


6LoWPAN:

You want to run 6LoWPAN on it, current the 802.15.4 calculates a lot of
stuff with the IEEE802154_MTU define, in most cases when using
fragmentation.

It seems you don't need fragmentation in your case, because you reach
the 1280 minimum MTU for IPv6. The condition at [4] should be always
true then.

Another question would be:
You can run 6LoWPAN on it, but nobody specifies to run 6LoWPAN on such
"SUN PHY's". I actually don't see that. Everything is specified with 127
MTU.

I don't want to tell you cannot run 6LoWPAN on it, but does somebody
need to specify 6LoWPAN for 802.15.4g at first?

> 
> Before jumping in coding, is anyone on the list already working on
> this? Or has any starting points.
> 
> 

I describe one point above for handling different MTU size. I don't know
if somebody already working on 802.15.4g support.

- Alex

[0] http://lxr.free-electrons.com/source/include/linux/ieee802154.h#L29
[1] http://lxr.free-electrons.com/source/include/net/cfg802154.h#L184
[2] http://lxr.free-electrons.com/source/include/net/mac802154.h#L127
[3] http://lxr.free-electrons.com/source/net/mac802154/main.c#L150
[4] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/tx.c#L285
