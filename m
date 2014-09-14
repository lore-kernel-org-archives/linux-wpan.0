Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:64609 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaINXqA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Sep 2014 19:46:00 -0400
Received: by mail-wg0-f52.google.com with SMTP id x13so3108198wgg.35
        for <linux-wpan@vger.kernel.org>; Sun, 14 Sep 2014 16:45:59 -0700 (PDT)
Date: Mon, 15 Sep 2014 01:45:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140914234551.GA7009@omega>
References: <5412F199.7010803@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5412F199.7010803@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

On Fri, Sep 12, 2014 at 02:14:01PM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> You sent me a patch not long ago to allow automatic setting of promiscous mode.  I seem to have lost this patch, could you resend as I want to look into it.
> 

some of my old branch [0].

btw.

I added to the rework now the promiscous mode and decided to not enable
this mode while setting promiscous mode flag.

It's now setted by doing a ifup of a monitor interface. See [1].

Maybe you will change it like this (it's better) but there are so many
issue to think about (Disable promiscous if netif on non MONITOR
interfaces etc...).

And also you can't have NODE and MONITOR running because it's phy mac
sublayer attribute.

I will cc linux-wpan, hope it's okay.

In next days I will draw some fancy architecture graphic about the
rework. To understand what I really did there. (I also have no idea
about to implement it 100% right, I do experiments and then think about
it "how we can do that in a better way") and very important in a way
where we could easily handle/add _new features_.

If anybody has questions about this implementation I would be very happy
to answer them. :-)

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commits/alex/wip
[1] https://github.com/linux-wpan/linux-wpan-next/blob/d5d62172f69ecf8db4dce77e790403e532687662/net/mac802154/iface.c#L42
