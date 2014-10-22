Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:47477 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbaJVJjn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 05:39:43 -0400
Received: by mail-wi0-f169.google.com with SMTP id r20so756272wiv.2
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 02:39:42 -0700 (PDT)
Date: Wed, 22 Oct 2014 12:03:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022100308.GE2721@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com>
 <20141022090135.GA2721@x61s.guest.pengutronix.de>
 <54476EAF.7090208@xsilon.com>
 <20141022092905.GC2721@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E5BC@SHSMSX101.ccr.corp.intel.com>
 <20141022095316.GD2721@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E654@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EBA0C22CC7D5724C87D7C17A60FEE9EE46E654@SHSMSX101.ccr.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Zhang, Baoli" <baoli.zhang@intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Wed, Oct 22, 2014 at 09:32:39AM +0000, Zhang, Baoli wrote:
> RPL in userspace, that maybe lead to performance issue.  I am thinking why they don't implement it in the kernel space.
> 

They have also a mailinglist, maybe ask there. To make a handling of
this inside kernelspace seems not so easy than to handle this inside userspace.

I can only imagine that an userspace implementation at first would be
much easier than to try to connect everything what you need in kernelspace.

802.15.4 6LoWPAN needs also some great idea's how we can deal as
adaption layer for IPv6.

- Alex
