Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45732 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaJVIiN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 04:38:13 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so652274wid.7
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 01:38:12 -0700 (PDT)
Date: Wed, 22 Oct 2014 11:01:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022090135.GA2721@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Zhang, Baoli" <baoli.zhang@intel.com>
Cc: "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Wed, Oct 22, 2014 at 08:27:34AM +0000, Zhang, Baoli wrote:
> Hi,
> 
> Great, thanks Alexander.
> 
> I also don't see the RPL implementation.....not integrated? Or not implemented?
> 

there exist a couple of tries for kernelspace and userspace RPL.
Some names are: simpleRPL, linux-rpl, lot's of other which I don't know
the name anymore.

For me it is important to get a working 802.15.4/6LoWPAN implementation at
first. But currently there exist no general RPL implementation, some people
tried to implement a userspace solution.

It would be really nice to have it, but we also detect some critical 6LoWPAN
bugs which indicates that multicast, etc... was always broken before. :)


- Alex
