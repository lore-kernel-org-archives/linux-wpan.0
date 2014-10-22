Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54734 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbaJVIGA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 04:06:00 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so594107wiv.1
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 01:05:58 -0700 (PDT)
Date: Wed, 22 Oct 2014 10:29:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022082919.GA1603@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Zhang, Baoli" <baoli.zhang@intel.com>
Cc: "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 22, 2014 at 07:40:37AM +0000, Zhang, Baoli wrote:
> Hi All,
> 
> I am trying to setup the 6LoWPAN network based on Linux, can anybody let me know if the latest Zigbee code had been merged into Linux kernel mainline?

don't call it "linux-zigbee", we are now "linux-wpan".

> 
> In the ZigBee sourceforget portal, I can only see the lowpan-tools, where are the other source?  Thanks in advance.
> 

this is the old repository. We moved the mailinglist to linux-wpan [0].

For latest mainline support, check linux-wpan-next [1] and lowpan-tools
[2].

Little how to is available at [3], this is the old linux-zigbee trac
wiki. We don't have a newer one now.

[0] http://vger.kernel.org/vger-lists.html#linux-wpan
[1] https://github.com/linux-wpan/linux-wpan-next
[2] https://github.com/linux-wpan/lowpan-tools
[3] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi
