Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:56106 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaI3Ijp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 04:39:45 -0400
Received: by mail-we0-f182.google.com with SMTP id x48so3336751wes.13
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 01:39:43 -0700 (PDT)
Date: Tue, 30 Sep 2014 10:39:35 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930083835.GA20280@omega>
References: <54295556.3030800@xsilon.com>
 <20140929131200.GA14608@omega>
 <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
 <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
 <20140929164157.GA17633@omega>
 <542A6B15.7060203@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542A6B15.7060203@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On Tue, Sep 30, 2014 at 09:34:29AM +0100, Simon Vincent wrote:
> I can confirm that this fixes the problem. I will create some patches when I
> get a chance.
> Thanks
> 

This should make trouble on phy's which have no address filter...

But when IPv6 Layer look on PACKET_BROADCAST then this is also another
bug...

I did a grep:

grep -r "PACKET_BROADCAST" net/IPv6

matches on:

net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)

whatever this is, it's also fixed by this. Because we override always
this value with PACKET_HOST.

Don't look at me, it wasn't me which introduce the setting of
PACKET_HOST. :-)

I cc Jukka here, this is also setted in 6LoWPAN GENERIC, so bluetooth is
also affected into this.

- Alex
