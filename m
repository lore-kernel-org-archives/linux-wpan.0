Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A3EB64D7
	for <linux-wpan@archiver.kernel.org>; Tue, 20 Jun 2023 08:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjFTIkY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 20 Jun 2023 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFTIkX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jun 2023 04:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6102A2
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jun 2023 01:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEAB6108E
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jun 2023 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914FDC433C9;
        Tue, 20 Jun 2023 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687250421;
        bh=STn26UReOdww+gFkvsGcZseosgz8Mkk/DE9VpCXMDcE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iPnFzEpavGuXn1Fxxqhmwcf+EkhEUoA49Rn68EQgHOmM7fu9HpgK/wc+l1tN9p92/
         xooSuJxdO8rouy0Np0titl1n3yycrdqglfd5veXKtRQD2X+SNdf/JGXCr6ts4dNYr1
         lwHlHXnnOlq6V+afSkxPPYXzI4s0fIz392oyK1uZxAQydru+JLJCvZlKZRslGep6f7
         M+VmdruPB2BMpW+POPUf4TddmHmnmUzFACqSpe43HnOy6JA/++WR4bU7bls90kHC4L
         Xl3vJsGUZBhBVDfebiC40kcSKSe/cIE8mfCCqRPOG43wZMfDLXrFULRBq6LmLrsyQo
         oyRcXKZHxK+lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 738BAC43157;
        Tue, 20 Jun 2023 08:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2023-06-19
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168725042146.7255.2793148637060076867.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 08:40:21 +0000
References: <20230619070927.825332-1-stefan@datenfreihafen.org>
In-Reply-To: <20230619070927.825332-1-stefan@datenfreihafen.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Jun 2023 09:09:27 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Two small fixes and MAINTAINERS update this time.
> 
> Azeem Shaikh ensured consistent use of strscpy through the tree and fixed
> the usage in our trace.h.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2023-06-19
    https://git.kernel.org/netdev/net/c/8340eef98d45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


