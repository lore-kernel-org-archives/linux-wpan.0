Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:53143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbdHQLOe (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 17 Aug 2017 07:14:34 -0400
Received: from hella-laptop.localnet ([193.83.185.56]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MGip3-1dmNMf0tgf-00DXsn for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017
 13:14:32 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Thu, 17 Aug 2017 13:14:31 +0200
Message-ID: <29470889.B3lc1jFHDt@hella-laptop>
In-Reply-To: <17366136-0ab6-99ea-89e4-916938a0ed17@osg.samsung.com>
References: <5179358.aL3rf9WXy9@hella-laptop> <1551752.M6fFiAEvOh@hella-laptop> <17366136-0ab6-99ea-89e4-916938a0ed17@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Cc: linux-wpan@vger.kernel.org

Hello!

First i want to thank you for taking your time to look at my code and all the 
useful comments. I will go through them step by step.

I have some general questions:

My thought was to squash all the commits into a single one once the code is in 
good enough shape. Do you prefer to keep the commit history?

I did debug the firmware over UART. I thought it might be a useful option to 
other developers (using the DEBUG flag) working on this firmware, but i can of 
course also remove my debug code completely if it is not needed?

> As for review I can go through your changes on the github links and do
> some initial review there but the final patches and review to get
> applied to the tree need to come as git patches to this mailing list.

I have seen the git send-email tutorial on the linux-wpan homepage (To change 
the homepage). Never used git send-email before but i guess this is how it 
should be done with the code as well, once the code is in good shape.

> I also send you the address from my private mail (datenfreihafen.org).
> Did this one end up in your SPAM folder? That would be odd.

It actually did. No clue why :)

-- 
Josef Filzmaier
