Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39112
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759301AbcJYPyT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Oct 2016 11:54:19 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-2-h.morris@cascoda.com>
Message-ID: <623840b9-3b52-0cab-4394-563505d4ef62@osg.samsung.com>
Date: Tue, 25 Oct 2016 17:54:15 +0200
MIME-Version: 1.0
In-Reply-To: <20161024150449.11132-2-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Harry Morris <h.morris@cascoda.com>

Hello.

Against what kernel did you prepare this patches?

I tried to apply them against bluetooth-next and got the following:
Applying: ieee802154: Add CA8210 IEEE 802.15.4 device driver
error: patch failed: drivers/net/ieee802154/Kconfig:63
error: drivers/net/ieee802154/Kconfig: patch does not apply
error: patch failed: drivers/net/ieee802154/Makefile:3
error: drivers/net/ieee802154/Makefile: patch does not apply
Patch failed at 0001 ieee802154: Add CA8210 IEEE 802.15.4 device driver
The copy of the patch that failed is found in:
     /home/stefan/Kernel/bluetooth-next-rpi/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

A guess in the blue from my side would be that you did this patches 
against the latest kernel release (4.8) and not the bluetooth-next 
kernel repo?

https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/

You would need to rebase your patches on this one so we can apply them 
cleanly and test build, run checker scripts, etc.

Given the driver file itself is isolated it will likely just we some 
small conflicts in the Makefile and Kconfig.

Patch 2 and 3 fail to apply as well.

regards
Stefan Schmidt
