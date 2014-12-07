Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:65341 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaLGRTI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 12:19:08 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so4535634wgg.28
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 09:19:07 -0800 (PST)
Date: Sun, 7 Dec 2014 18:19:04 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141207171903.GC9532@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141207171311.GB9532@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael C Cambria <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

On Sun, Dec 07, 2014 at 06:13:11PM +0100, Alexander Aring wrote:
> Hi,
> 
> please use bluetooth-next [0] for the wpan-tools. For experiment things use
> wpan_rework_rfc branch. I have still patches there which should be go
> into mainline but isn't easy to touch the code without breaking.

Now I remember, I changed the netlink interface too much and doesn't
change it inside the wpan_rework_rfc branch.

So it's only working if you hack the nl802154.h header and copy it into
wpan-tools or simple forget this branch. This is my dirty dev branch
only for bringing the rework mainline, which is still in progress.

- Alex
