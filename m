Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57622 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbaJQFdT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Oct 2014 01:33:19 -0400
Received: by mail-wi0-f182.google.com with SMTP id n3so275985wiv.9
        for <linux-wpan@vger.kernel.org>; Thu, 16 Oct 2014 22:33:18 -0700 (PDT)
Date: Fri, 17 Oct 2014 07:33:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Debug message API names for WPAN
Message-ID: <20141017053312.GD20252@omega>
References: <543FAF07.6090205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <543FAF07.6090205@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi Varka,

On Thu, Oct 16, 2014 at 05:11:59PM +0530, Varka Bhadram wrote:
> Hi,
> 
> I am planning to implement the debug message API's for WPAN.
> 

ok.

> I thought of using the name started with wpan_*. ex: wpan_info(),wpan_dbg()..
> 
> Is this API name is OK....?
> 

For what is the API for?

Such function are good for debugging device specific things. People knows
then about to which interface or phy the printout (dbg/error/warning, etc..)
belongs to. Instead to doing pr_debug("%s: ... ", wpan_phy_name(phy), ...);
Simple we should call then wpan_phy_info(phy, "...");

Now for interface we should use netdev_dbg, etc... functions, because
these interfaces belongs a netdev device and netdev_foo macros are
already exist.

For phy debugging macros we should introduce such function, because we
create the wpan_phy struct in "include/net/wpan-phy.h". It's a own
new device class.

These names for these functions should be wpan_phy_info(wpan_phy). The
wpan_phy struct contains a "struct device dev" then you should call the
generic device prinout functions like dev_info, etc...

> In which header file i can add these '#define's.. ieee802154.h or mac802154.h..?
> 

The ieee802154 header should contain ONLY things which comes from IEEE
802.15.4 standard. Put it in "include/net/wpan-phy.h".

But introduce such function only for phy handling not interface
handling, use then netdev_foo.

What I don't will ack are such things like:

#define wpan_info(...) pr_info(...)

this makes really no sense.

> If these things are confirmed patches are on the way.
> 

ok.

- Alex
