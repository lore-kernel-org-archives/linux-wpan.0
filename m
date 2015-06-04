Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34686 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbFDHla (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:41:30 -0400
Received: by wibut5 with SMTP id ut5so12092886wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:41:29 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:41:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: RPi model B - bluetooth-next kernel, shutdown always reboots the
 RPi
Message-ID: <20150604074123.GC13133@omega>
References: <20150604063416.GA3045@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150604063416.GA3045@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 08:34:16AM +0200, Christoffer Holmstedt wrote:
> I know some of you are using the RPi as well so I start by asking here, perhaps
> linux-rpi-kernel list is the next step. When I run "shutdown -h 0" the RPi

Maybe try "halt"? "halt" should shutdown your RPi, means unmounting
filesystems etc. and stops there (without rebooting) Then it should be
safe to pull the plug.

To poweroff the RPi, the RPi can't do that, it only can reboot itself
which is solved by some watchdog timeout, I suppose. Maybe there exists
self-builded solutions somewhere on RPi sites to shutdown the RPi
somehow (means poweroff).

- Alex
