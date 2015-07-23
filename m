Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34628 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbGWG7l (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2015 02:59:41 -0400
Date: Thu, 23 Jul 2015 08:59:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC v2 2/4] 6lowpan: Add stateful compression component of
 6lowpan module
Message-ID: <20150723065940.GC1941@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
 <1436788233-13960-3-git-send-email-lukasz.duda@nordicsemi.no>
 <20150723065209.GB1941@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150723065209.GB1941@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

On Thu, Jul 23, 2015 at 08:52:09AM +0200, Alexander Aring wrote:
> 
> I know why you need such functionality. This is okay for now. But I
> already thought about a nicer handling for that (which is also useful
> for other mechanism). The idea is:
> 
> The netdev structure has some private pointer "netdev->priv". Currently
> bluetooth 6lowpan/802.15.4 6lowpan do their own stuff inside this struct
> which is okay. But we should provide some "upper class" struct for all
> ARPHRD_6LOWPAN, which looks like:
> 
> -----------------------------
> |   6LOWPAN_ARPHRD_STRUCT   | <-- All ARPHRD_6LOWPAN have this struct as first
> -----------------------------
> |        PRIVATE_DATA       | <-- 802.15.4/btle own stuff (private struct of subsystem) simple a
> |                           |     "u8 priv __aligned(sizeof(void *));" inside ARPHRD_6LOWPAN which need to be at last
> -----------------------------
> 
> Then you can put the net_table into the "6LOWPAN_ARPHRD_STRUCT" and cast
> the "netdev->priv" pointer to "6LOWPAN_ARPHRD_STRUCT".
> 
> We really need such thing to avoid the above search&found functionality.
> We should introduce such behaviour at first, then you can rebase your
> stuff on it.
> 
> Also we need some functionality lowpan_alloc_netdev which ensure the
> priv size is "sizeof(6LOWPAN_ARPHRD_STRUCT) + sizeof(PRIVATE_DATA)".
> 
> In upper layers like IPv6 you can do the following then:
> 
> if (dev->type == ARPHRD_6LOWPAN) {
> 	6LOWPAN_ARPHRD_STRUCT foobar = (struct 6LOWPAN_ARPHRD_STRUCT *)dev->priv;
> 
> 	...do great cid handling here...
> }
> 
> I hope this will also help you by implementing 6CO.
> 
> btw: (struct 6LOWPAN_ARPHRD_STRUCT *) should be implemented by a macro.
> 
> 
> So please begin at first to add such functionality, please. Is that okay
> for you?
> 

This is actually the same idea like introducing the lowpan_ptr inside
the netdev structure, just a little different. I am fine also for
introducing the lowpan_ptr when netdev acked such patch. Anyway we need
some core lowpan functionality to allocate/free the memory then. Or we
just point the lowpan_ptr to the right netdev private memory area, then
we don't need to cast every time.

- Alex
