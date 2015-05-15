Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35085 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934565AbbEOPXN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 May 2015 11:23:13 -0400
Received: by wghe15 with SMTP id e15so2982147wgh.2
        for <linux-wpan@vger.kernel.org>; Fri, 15 May 2015 08:23:12 -0700 (PDT)
Date: Fri, 15 May 2015 17:23:09 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150515152305.GB11157@omega>
References: <5555EC72.6060302@xsilon.com>
 <20150515142026.GA11157@omega>
 <55560A88.1050903@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55560A88.1050903@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Fri, May 15, 2015 at 04:02:32PM +0100, Simon Vincent wrote:
> I tried the solution you proposed but it did not work, it resulted in a
> kernel crash (bad paging request).
> 

okay, then simple send a patch with your solution. This should only
affect driver which using xmit_sync callback anyway.

I will notice a point at your previous work.

> We require multiple 802.15.4 interfaces for routing between different
> 802.15.4 networks. We have a 802.15.4 powerline phy (Hanadu [1]) and a
> 802.15.4 radio phy (MRF24J40). On some boxes we have both phys and route
> using RPL between the powerline and radio networks.
> 

Okay, then we don't talking about multiple interfaces. We talking about
multiple phy's and that's when the issue occurs, because we have
multiple ieee802154_hw but one global ieee802154_xmit_cb.

My patch should define ieee802154_xmit_cb per ieee802154_hw instead.
Don't know what's your current issue is.

The ieee802154_xmit_cb is protected then by stop/wake queue which
garantuees that this struct isn't used twice (in case of multiple
interfaces), for multiple phy this is currently a bug.

- Alex
