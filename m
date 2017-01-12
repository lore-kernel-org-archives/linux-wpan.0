Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:35041 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdALVj1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Jan 2017 16:39:27 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [pull-request bluetooth] wpan fixes for 4.10 2017-01-07
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
Date: Thu, 12 Jan 2017 22:39:25 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <F8C67E35-BDF5-4150-A9F7-2EC42C6BC4F3@holtmann.org>
References: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Stefan,

> A set of fixes for ieee802154 drivers targeting 4.10.
> 
> Two out of the four ATUSB patches are to make sure the buffers are DMA-able
> after the changes introduced in 4.9. One of them fixes code that was already
> present in 4.9 and might be worth a backport to stable. I added a cc stable
> to it. The other two ATUSB patches are fixing problems from the patchset
> supporting the new v0.3 firmware.
> 
> For at86rf233 we got a patch from Andrey Smirnov to make sure it works well
> in hardware designs where the RSTN pin is connected to a slow GPIO pin.
> 
> The following changes since commit d896b3120b3391a2f95b2b8ec636e3f594d7f9c4:
> 
>  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf (2017-01-05 11:49:57 -0500)
> 
> are available in the git repository at:
> 
>  https://github.com/linux-wpan/linux-wpan.git for-upstream
> 
> for you to fetch changes up to 3215bb7dd0b4dc894bed61c216508ffdf8b7ebb3:
> 
>  ieee802154: atusb: fix driver to work with older firmware versions (2017-01-06 23:19:51 +0100)
> 
> ----------------------------------------------------------------
> Andrey Smirnov (1):
>      at86rf230: Allow slow GPIO pins for "rstn"
> 
> Stefan Schmidt (4):
>      ieee802154: atusb: do not use the stack for buffers to make them DMA able
>      ieee802154: atusb: make sure we set a randaom extended address if fetching fails
>      ieee802154: atusb: do not use the stack for address fetching to make it DMA able
>      ieee802154: atusb: fix driver to work with older firmware versions
> 
> drivers/net/ieee802154/at86rf230.c |  4 +--
> drivers/net/ieee802154/atusb.c     | 59 +++++++++++++++++++++++++++-----------
> 2 files changed, 45 insertions(+), 18 deletions(-)

patches have been applied to bluetooth-stable tree.

Regards

Marcel

