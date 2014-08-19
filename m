Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:63528 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaHSPX2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 11:23:28 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so6610340wes.18
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 08:23:27 -0700 (PDT)
Date: Tue, 19 Aug 2014 17:23:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: mac802154: TX results and ACK processing
Message-ID: <20140819152319.GA1116@omega>
References: <CAJ018wBU9OXQfrVr3x+EoeT0V8CM+s80xcCUvM4Urj-zdtHcsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ018wBU9OXQfrVr3x+EoeT0V8CM+s80xcCUvM4Urj-zdtHcsA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?utf-8?B?Sm/Do28=?= Pedro Taveira <joao.p.taveira@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Aug 19, 2014 at 02:33:29PM +0100, João Pedro Taveira wrote:
> Hi to all,
> 
> I'm working on a RPL implementation to linux. It works with

ok.

> rpl_of_of0, but to get rpl_of_mhrof working, it requires ETX
> calculations. In order to get ETX working on linux, it would be
> required to get mac802154 Tx results. Are you planning on get track of
> radios autoacks and/or transceivers Tx results?
> 

Mh. The at86rf2xx have something to get some tx results. See [0] page
66, do you mean something like this?

At at86rf2xx this can be read at point [1], currently we don't have any
mac layer functionality to make this available for any other layer.

> RPL must not know anything about 6lowpan, but since it will use link
> metrics, the RPL mechanisms should be able to get neighbors links
> stats.
> 

I thought RPL needs the LQI value. For the LQI value I (we) thought about
to handle the LQI value like the wireless signal strength.

If you have a wireless card, simple type:

"iw dev $WLAN_DEV scan dump" (maybe you need to run a scan first). You will
see all access points and their signal strength etc.

We should have something similar for all neighbor nodes and LQI values,
tx failures and similar information.

> What's your opinion?
> 

I think we should get a working mac layer with a working 6LoWPAN layer
at first, then we can do effort to implement RPL or RFC6775.

There are currently unsolved issues and if we implement upper layers
these issues are not easy to solve afterwards.

First we should have something to offer these information in userspace.
(Like the "iw dev $WLAN_DEV scan dump"), but you don't need these information
in userspace. If we have this functionality, we can think about to get these
information in RPL layer (which is kernelspace).


btw. we are far away to offer these information in userspace.

- Alex

[0] http://www.atmel.com/images/doc8111.pdf
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ieee802154/at86rf230.c?id=refs/tags/v3.17-rc1#n735
