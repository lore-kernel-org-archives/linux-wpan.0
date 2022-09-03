Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A8C38145
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Sep 2022 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiICEUU (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Sep 2022 00:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiICEUT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Sep 2022 00:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9D37F98;
        Fri,  2 Sep 2022 21:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F7960B45;
        Sat,  3 Sep 2022 04:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 744DAC43143;
        Sat,  3 Sep 2022 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662178817;
        bh=CXM6fdt01pUpnTFE1ZiIS3lFATA5fwdQZ9XDfYYLUw8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bsgSyd3TZe6StnbT3Rt/JlSkV/i7xhrl6+87wn4pxJqnTEZ9BT/T+ArZ7BlkMa3ZW
         0ensIwz7TYO8lFzlPlNCzye6R3lLzbkiyI6BmEI79+GHuzHzOO6vtg/H85et6CEMyx
         4IZGXqMio0MhBQzMxDRf4wojh9+N7IogV0vjHeaw+TSeC5sib0jgj0omg+VLL5eX7p
         2mQvwLd9wYwYglvYfKTtFcOTK71W7stf6GXFL3WlE5tZyACeFtbPs1lUIvyo9AJnbu
         ivHGzPG0gMXtljeGiw2P14l6q59FQxQHndWmPCrS1YQGQHX4m9jBsg7GJ8uWDMhvs9
         v1ODOstXyKISQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F051E924D9;
        Sat,  3 Sep 2022 04:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ieee802154: Fix compilation error when
 CONFIG_IEEE802154_NL802154_EXPERIMENTAL is disabled
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166217881737.4142.16142229655847739839.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Sep 2022 04:20:17 +0000
References: <20220902030620.2737091-1-kuba@kernel.org>
In-Reply-To: <20220902030620.2737091-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, leon@kernel.org, sudipm.mukherjee@gmail.com,
        gal@nvidia.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
        paul@paul-moore.com, linux-wpan@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Sep 2022 20:06:20 -0700 you wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> When CONFIG_IEEE802154_NL802154_EXPERIMENTAL is disabled,
> NL802154_CMD_DEL_SEC_LEVEL is undefined and results in a compilation
> error:
> net/ieee802154/nl802154.c:2503:19: error: 'NL802154_CMD_DEL_SEC_LEVEL' undeclared here (not in a function); did you mean 'NL802154_CMD_SET_CCA_ED_LEVEL'?
>  2503 |  .resv_start_op = NL802154_CMD_DEL_SEC_LEVEL + 1,
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                   NL802154_CMD_SET_CCA_ED_LEVEL
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ieee802154: Fix compilation error when CONFIG_IEEE802154_NL802154_EXPERIMENTAL is disabled
    https://git.kernel.org/netdev/net-next/c/8254393663f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


