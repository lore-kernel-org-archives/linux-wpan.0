Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59248 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdHQI2Z (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 17 Aug 2017 04:28:25 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Thu, 17 Aug 2017 10:28:15 +0200
Message-ID: <1648899.xXhEr7NW1d@hella-laptop>
In-Reply-To: <1551752.M6fFiAEvOh@hella-laptop>
References: <5179358.aL3rf9WXy9@hella-laptop> <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com> <1551752.M6fFiAEvOh@hella-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hello!

> 1) The atusb_xmit function is only called *once* and then never again

I just managed to fix this problem, too. I did configure the interrupt of the 
microcontroller in the firmware incorrectly. So i did never get an interrupt 
and the kernel was never informed that the frame was transmitted successfully 
(atusb_tx_done was missing) I will send you the link to an updated patch once 
i've tested it a bit more.

-- 
Josef Filzmaier
