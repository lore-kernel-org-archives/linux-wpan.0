Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46286 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142AbbFDGeX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 02:34:23 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id BE7CF140D79
	for <linux-wpan@vger.kernel.org>; Thu,  4 Jun 2015 02:34:21 -0400 (EDT)
Date: Thu, 4 Jun 2015 08:34:16 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: RPi model B - bluetooth-next kernel, shutdown always reboots the RPi
Message-ID: <20150604063416.GA3045@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I know some of you are using the RPi as well so I start by asking here, perhaps
linux-rpi-kernel list is the next step. When I run "shutdown -h 0" the RPi
turns off but in a few seconds U-Boot starts again and boots linux, so I can't
turn it off from software. The only solution is to pull the plug, which will
eventually corrupt the SD card so that is not a good long-term solution.

Others have had simliar problems with kernels 3.8 - 3.12 but back then it was
something about activity on some GPIO (e.g. SCL) could trigger boot. This is
not the case now as my problem exists both with the Openlabs board connected
and disconnected.

There are a lot of moving parts here, during shutdown Raspbian with 4.1.0-rcX
kernel doesn't set proper registers perhaps or U-Boot is missing some
configuration so I'm not sure how to debug this issue.  Installing a fresh
raspbian installation on the SD card with 3.18 kernel "shutdown -h 0" works
just fine. As soon as I "install" U-Boot and the blutooth-next kernel it stops
working.

Any pointers to a solution, debug steps or even a tutorial on how the
shutdown/boot-up process works is appreciated, because I'm totally lost on this
one.

Regards
-- 
Christoffer Holmstedt
