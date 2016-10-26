Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:53485 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754407AbcJZJ7c (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 26 Oct 2016 05:59:32 -0400
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-2-h.morris@cascoda.com>
 <623840b9-3b52-0cab-4394-563505d4ef62@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <a7b6a231-6a09-9bd4-4395-317ed1b119c7@cascoda.com>
Date: Wed, 26 Oct 2016 10:59:25 +0100
MIME-Version: 1.0
In-Reply-To: <623840b9-3b52-0cab-4394-563505d4ef62@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Stefan,

You're absolutely right, my apologies. I've rebuilt my patches against 
the bluetooth-next tree and will re-submit a v2.

Regards,

Harry

On 25/10/2016 16:54, Stefan Schmidt wrote:
> Hello.
>
> Against what kernel did you prepare this patches?
>
> I tried to apply them against bluetooth-next and got the following:
> Applying: ieee802154: Add CA8210 IEEE 802.15.4 device driver
> error: patch failed: drivers/net/ieee802154/Kconfig:63
> error: drivers/net/ieee802154/Kconfig: patch does not apply
> error: patch failed: drivers/net/ieee802154/Makefile:3
> error: drivers/net/ieee802154/Makefile: patch does not apply
> Patch failed at 0001 ieee802154: Add CA8210 IEEE 802.15.4 device driver
> The copy of the patch that failed is found in:
>     /home/stefan/Kernel/bluetooth-next-rpi/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> A guess in the blue from my side would be that you did this patches 
> against the latest kernel release (4.8) and not the bluetooth-next 
> kernel repo?
>
> https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/ 
>
>
> You would need to rebase your patches on this one so we can apply them 
> cleanly and test build, run checker scripts, etc.
>
> Given the driver file itself is isolated it will likely just we some 
> small conflicts in the Makefile and Kconfig.
>
> Patch 2 and 3 fail to apply as well.
>
> regards
> Stefan Schmidt
>
