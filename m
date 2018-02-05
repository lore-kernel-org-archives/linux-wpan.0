Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from honk.sigxcpu.org ([24.134.29.49]:52031 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbeBEJnY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 5 Feb 2018 04:43:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0240FFB04
        for <linux-wpan@vger.kernel.org>; Mon,  5 Feb 2018 10:33:29 +0100 (CET)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z_yLr9q8XJJN for <linux-wpan@vger.kernel.org>;
        Mon,  5 Feb 2018 10:33:26 +0100 (CET)
Date: Mon, 5 Feb 2018 10:33:25 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: wpan-tools 0.8 release
Message-ID: <20180205093325.GA6609@bogon.m.sigxcpu.org>
References: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,
On Thu, Feb 01, 2018 at 11:29:11AM +0100, Stefan Schmidt wrote:
> Hello.
> 
> 
> It is a pleasure to announce the 0.8 release of wpan-tools.
> Thanks to everyone who contributed!
> 
> More of a maintenance release this time around. We did not have a release in a while and the build error with libnl >= 3.3 started to hit
> more people. Having this fixed is worth a release alone. Thanks a lot to Thomas Petazzoni for the fix.
> 
> We also added some some examples on how to use the ieee802154 subsystem socket types from userspace.
> Xue Wenqian added some more functionality to the wpan-ping utility. Mayn thanks here as well.
> 
> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.gz
> 
> sha256sum: 0e22cadbc40d4c12d0a66e8175bda12046f03237ce6da23d4fd26fd3ab557d8b
> 
> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.xz
> 
> sha256sum: daacd38fe2f216095664dbf2628151c8f632d3f122d526059a37ba3cc4d3d8af

The Debian package has been updated as well:

    https://packages.debian.org/sid/wpan-tools

Cheers,
 -- Guido

> 
> 
> Stefan Schmidt (9):
> examples: add README with details to the various examples
> examples: af_ieee802154_tx example
> examples: af_ieee802154_rx example
> examples: add af_packet_rx example
> examples: af_inet6_rx example
> examples: af_packet_tx example
> examples: af_inet6_tx example
> examples: add .gitignore file for examples directory
> Release 0.8
> 
> Thomas Petazzoni (1):
> src/nl_extras.h: fix compatibility with libnl 3.3.0
> 
> Xue Wenqian (2):
> wpan-ping: add the support to set wpan-ping interval
> wpan-ping: Add the filtering function for frame receiving
> 
> 
> regards
> 
> Stefan Schmidt
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
