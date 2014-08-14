Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54589 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaHNHLS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Aug 2014 03:11:18 -0400
Message-ID: <53EC6113.3090701@xsilon.com>
Date: Thu, 14 Aug 2014 08:11:15 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <53E34185.1040304@xsilon.com> <20140807093305.GA17452@omega>
In-Reply-To: <20140807093305.GA17452@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: Latest wpan-next doesn't compile
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

Thanks for the info on finding the maintainers, I'm sure this will come in useful in the future.  I found the patch I needed, thanks again :)

- Martin.

On 07/08/14 10:33, Alexander Aring wrote:
> Hi,
>
> On Thu, Aug 07, 2014 at 10:06:13AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> I'm getting the following error when trying to compile linux-wpan-next (commit id cad114ae7eceafc4252cd5b1ecbd4bdbcdc901f0)
>>
>> | drivers/of/platform.c: In function 'of_dma_configure':
>> | drivers/of/platform.c:170:16: error: 'struct pdev_archdata' has no member named 'dma_mask'
>> |   pdev->archdata.dma_mask = 0xffffffffUL;
>> |                 ^
>> | make[2]: *** [drivers/of/platform.o] Error 1
>> | make[1]: *** [drivers/of] Error 2
>> | make[1]: *** Waiting for unfinished jobs....
>> |   CC      net/sched/sch_mq.o
> no, but this isn't our problem. Our branch is based on bluetooth-next.
> It could be that this fix is already solved in other repository, if you
> want to fix it you need to find out if it already fix and create some
> patch.
>
> I will show you a how to which I would do that:
>
> 1) check current next tree (sometimes there exists also special repos
> like for bluetooth, check https://git.kernel.org/cgit/linux/kernel/):
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/of/platform.c
>
> this shows the log of this file.
>
> "of/platform: Fix microblaze build failure" - sounds like a build issue.
> Click on it you get:
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/of/platform.c?id=e1319ea5db6dee48b7fa3a5822c3940dc649ee6a
>
> so, it's already fixed.
>
> The linux-wpan-next branch is based on bluetooth-next and we are a
> little far behind on everything which isn't the net branch.
>
> 2)
> If 1) doesn't show any fix then ask on the mailinglist.
>
> ./scripts/get_maintainer.pl -f drivers/of/platform.c
>
> Grant Likely <grant.likely@linaro.org> (maintainer:OPEN FIRMWARE AND...)      
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
> linux-kernel@vger.kernel.org (open list)
>
> there you can find the necessary people which working on this branch.
>
>
>
> So now if you want to fix it for your working branch, then add in your
> git remotes the linux-next repository and run "git cherry-pick
> e1319ea5db6dee48b7fa3a5822c3940dc649ee6a", but please don't send patches
> for this fix to me then. ;)
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

