Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40549 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbaIBPTA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 11:19:00 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so14484976wib.10
        for <linux-wpan@vger.kernel.org>; Tue, 02 Sep 2014 08:18:59 -0700 (PDT)
Date: Tue, 2 Sep 2014 17:18:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140902151855.GB15189@omega>
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
 <20140901113835.GA21564@omega>
 <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com>
 <20140902071214.GA25800@omega>
 <20140902072627.GB25800@omega>
 <5405D284.7020606@xsilon.com>
 <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5405D961.4060006@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Tue, Sep 02, 2014 at 03:51:13PM +0100, Simon Vincent wrote:
> The program can be found at this github. branch all_fixes.
> https://github.com/smee204/unstrung/tree/all_fixes
> 
> The socket is created in iface.cpp network_interface::setup()
> The receive problem is in iface.cpp network_interface::receive(const time_t
> now)
> 
Thanks I will look at it, but I mean a small example not a complete RPL
framework. Nevertheless I think this is a good start to add a testing
framework into the wpan-tools. I will create a small test application
for raw sockets and different settings of sockopts.

6LoWPAN is only an adaptation layer we don't have any changes in the
IPv6 stack. Maybe you can also say something about which IPv6 address
type it was with the address compression according the address type?

For example link-local which is based on the mac address (SLAAC). I
already said we have issues with short addresses and 802.15.4 6LoWPAN. I
hope you don't want to try something with short addresses.

- Alex
