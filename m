Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A1DC04A95
	for <linux-wpan@archiver.kernel.org>; Tue, 25 Oct 2022 04:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJYEae (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 25 Oct 2022 00:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiJYEaY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Oct 2022 00:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8E233B4;
        Mon, 24 Oct 2022 21:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDB361738;
        Tue, 25 Oct 2022 04:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2254C43140;
        Tue, 25 Oct 2022 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666672218;
        bh=DZ5f0hcQi5M4+K6VeNVXl2gdC/uaNsgc+nI6C+rYZYE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JKaW81hmB72au1x9+EAj8V5QB8JnqD1kviqx/HiRuh5iNWIOICb2uuQuLG9YJUwqn
         29ftIFzSNG+lwWseAOlK2BUgvTCU3Z6IdO6yMJhAyis5tXPetiYDkBjWBeBK0MMrAP
         cqSgoWO0nEhOfH1JtsTZeFWuCFs37GGqpfeZuuOHIM8CmZO2FjPWuVawZ+o+BgOb6s
         JQ+y7ml2ubV4M1NBW43/iXufX6i80TgkxhTg7cXMdzAwnwkcWBhtyWNZI5YOzcMfTI
         WLO+MajZtW6MYxSVcNkDBltrya4UrInP/pL7r7vRf7jhehb3EjfqPDRSCtNrMBUqp3
         MjVLhzQRRW3Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C80E9E4D005;
        Tue, 25 Oct 2022 04:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2022-10-24
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166667221781.14254.9707515554053242753.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 04:30:17 +0000
References: <20221024102301.9433-1-stefan@datenfreihafen.org>
In-Reply-To: <20221024102301.9433-1-stefan@datenfreihafen.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Oct 2022 12:23:01 +0200 you wrote:
> Hello Dave, Jakub.
> 
> An update from ieee802154 for your *net* tree:
> 
> Two fixup patches for return code changes of an earlier commit.
> Wei Yongjun fixed a missed -EINVAL return on the recent change, while
> Alexander Aring adds handling for unknown address type cases as well.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2022-10-24
    https://git.kernel.org/netdev/net/c/baee5a14ab2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


