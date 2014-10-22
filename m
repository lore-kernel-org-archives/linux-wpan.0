Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:52808 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaJVItv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 04:49:51 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so3179217wgh.28
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 01:49:50 -0700 (PDT)
Date: Wed, 22 Oct 2014 11:13:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022091316.GB2721@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com>
 <20141022090135.GA2721@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E2CB@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EBA0C22CC7D5724C87D7C17A60FEE9EE46E2CB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Zhang, Baoli" <baoli.zhang@intel.com>
Cc: "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Wed, Oct 22, 2014 at 08:42:42AM +0000, Zhang, Baoli wrote:
> Yes, I also see the simpleRPL and some other implemeation, but it's strange that there is no general one. Thanks for your explanation.
> 
> I also see the inter-operation issue between contiki and linux solution.....maybe that's another challenge.
> 

we are mostly RFC complaint... depends on what you want to do. Ping
works, but I know some "special" rare issues, where we need a better
solution for it to be rfc complaint. Or something we need to support
like stateful address compression...

Simple ping or UDP application with contiki should work, but depends on
what you try to using. Some people reports about multicast issues, the
last one was of course a bug in 6LoWPAN. I think I need more test cases
for multicast, to make a globaloverview that all things working fine there.

- Alex
