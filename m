Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:64026 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdHRK0e (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 18 Aug 2017 06:26:34 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Fri, 18 Aug 2017 12:26:23 +0200
Message-ID: <751534928.IoX8EvYzkW@hella-laptop>
In-Reply-To: <79f111e5-5c1e-78d6-c1c8-b6598492fa2e@osg.samsung.com>
References: <5179358.aL3rf9WXy9@hella-laptop> <29470889.B3lc1jFHDt@hella-laptop> <79f111e5-5c1e-78d6-c1c8-b6598492fa2e@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Stefan Schmidt <stefan@osg.samsung.com>

Hi!

I did refactor both repositories. I think they should now be much more 
enjoyable to review ;) - I would however like you to have another quick look 
within my github repo before i git send-mail it to the mailing list.

I rebased the patch of the linux driver to the 4.13-rc5 source code so it 
should be much easier to mainline. It is only a single commit, i was not sure 
how i should separate the commits without having "dead code". I think the 
patch is small enough that one commit is still feasible. [1]

I did separate the firmware into two commits: One that enables debugging 
and one that introduces the new board (with refactoring). [2]

The changes were tested again on the raspberry pi with linux 4.13-rc5 and
both patches applied (Firmware and Kernel).

Today i finally sent you the Busware HUL dongle, so you should receive it
sometime next week.

Regards,
Josef

[1] https://github.com/joseffilzmaier/linux/compare/rpi-4.13.y...joseffilzmaier:atusb-busware-hul-4.13
[2] https://github.com/joseffilzmaier/ben-wpan/compare/busware-hul-final

-- 
Josef Filzmaier
