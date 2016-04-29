Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37054 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbcD2PZM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 Apr 2016 11:25:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id a17so42159095wme.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 Apr 2016 08:25:12 -0700 (PDT)
Date: Fri, 29 Apr 2016 17:25:03 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [riot-devel] RIOT+ULAs: no router entry
Message-ID: <20160429152458.GA15676@omega>
References: <B354489C-54BF-4CAF-8B41-04A946D83478@mlng.net>
 <20160422102833.GA5671@omega>
 <7BCB9BD8-C255-458C-83F6-0F7FE69F5C7F@mlng.net>
 <20160422122816.GA6364@omega>
 <20160424200528.GA27492@omega>
 <20160424203128.GA27936@omega>
 <3CFBDFC0-3AB2-4931-8BCB-B034EBDC0B9C@mlng.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3CFBDFC0-3AB2-4931-8BCB-B034EBDC0B9C@mlng.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: RIOT OS kernel developers <devel@riot-os.org>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 29, 2016 at 04:58:04PM +0200, smlng wrote:
> Hi Alex,
> hi all,
> 
> over the last days I did some more extensive tests and enabled/added some debug output in RIOT, and I got close to the root cause of the problem. 
> 
> TL;DR: 
> - Linux does not set the router flag in its NAs
> - but it should when `radvd` is running (or `radvd` should enable it). 
> - RIOT behaves correctly, according to RFC-4861 7.2.4.
> 
> ----
> 
> Now the slightly longer version; I quickly recap my setup:
> 
> - a RasPi with OpenLabs transceiver, and `radvd` (linux-wpan version from github)
> - Atmel samr21-xpro running RIOT with `gnrc_networking` example (2016.04-branch)
> - `radvd` announces a ULA-prefix (though ULA doesn't matter, could global as well)
> 
> I observed the following behavior:
> 
> - RIOT send RS on boot, `radvd` on RasPi replies with RA (incl. PIO, ABRO, SLLAO)
> - RIOT parse RA, generates IP from prefix, adds NCE for router with router flag set
> - RIOT send NS for RasPi/routers link-local address -> RasPi replies with NA
> - RIOT parses NA, but router flag not set -> unset router flag in NCE of router
> - hence no more router in cache -> no ping or data transfer via non-link-local (e.g. ULA) IPs 
> 
> so my question @alex and @linux-wpan: can I manually set/enable the routers flag for NAs in Linux Kernel? Or somehow _convince_ `radvd` to do so on startup?

Routers are indicated by the "forwarding" setting. radvd silent warns
about that if this isn't set for interfaces with RA advert is on, so far I
know you need to increase the debug level for that.

I simple set:

echo 1 > /proc/sys/net/ipv6/conf/all/forwarding

this will set forwarding for all interfaces.

Some code explaining:

See http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L838

this is at function when NS is received, the routeri flag will be set when
forwarding is enabled.

Maybe this solves all your current issues. :-)

> I'm running latest Raspbian with Kernel 'Linux raspberrypi 4.1.19+' and wpan-tools from github on the RasPi.
> 

I would better use bluetooth-next, if possible. With all recent patches
you could also try to use 6CO in radvd.

btw: the radvd wants to accept my patches for 6lowpan 6CO stuff, but
basic 6LoWPAN-ND (first short address support for NA/NS) will be added
and short-address handling will not work with RIOT, but that's another
issue...

- Alex
