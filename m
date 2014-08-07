Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:38088 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbaHGJdP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Aug 2014 05:33:15 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so3914050wes.15
        for <linux-wpan@vger.kernel.org>; Thu, 07 Aug 2014 02:33:14 -0700 (PDT)
Date: Thu, 7 Aug 2014 11:33:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140807093305.GA17452@omega>
References: <53E34185.1040304@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53E34185.1040304@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: Latest wpan-next doesn't compile
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Aug 07, 2014 at 10:06:13AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> I'm getting the following error when trying to compile linux-wpan-next (commit id cad114ae7eceafc4252cd5b1ecbd4bdbcdc901f0)
> 
> | drivers/of/platform.c: In function 'of_dma_configure':
> | drivers/of/platform.c:170:16: error: 'struct pdev_archdata' has no member named 'dma_mask'
> |   pdev->archdata.dma_mask = 0xffffffffUL;
> |                 ^
> | make[2]: *** [drivers/of/platform.o] Error 1
> | make[1]: *** [drivers/of] Error 2
> | make[1]: *** Waiting for unfinished jobs....
> |   CC      net/sched/sch_mq.o

no, but this isn't our problem. Our branch is based on bluetooth-next.
It could be that this fix is already solved in other repository, if you
want to fix it you need to find out if it already fix and create some
patch.

I will show you a how to which I would do that:

1) check current next tree (sometimes there exists also special repos
like for bluetooth, check https://git.kernel.org/cgit/linux/kernel/):

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/of/platform.c

this shows the log of this file.

"of/platform: Fix microblaze build failure" - sounds like a build issue.
Click on it you get:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/of/platform.c?id=e1319ea5db6dee48b7fa3a5822c3940dc649ee6a

so, it's already fixed.

The linux-wpan-next branch is based on bluetooth-next and we are a
little far behind on everything which isn't the net branch.

2)
If 1) doesn't show any fix then ask on the mailinglist.

./scripts/get_maintainer.pl -f drivers/of/platform.c

Grant Likely <grant.likely@linaro.org> (maintainer:OPEN FIRMWARE AND...)      
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
linux-kernel@vger.kernel.org (open list)

there you can find the necessary people which working on this branch.



So now if you want to fix it for your working branch, then add in your
git remotes the linux-next repository and run "git cherry-pick
e1319ea5db6dee48b7fa3a5822c3940dc649ee6a", but please don't send patches
for this fix to me then. ;)

- Alex
