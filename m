Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B226FCDB465
	for <linux-wpan@archiver.kernel.org>; Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJLAa0 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLAa0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Oct 2023 20:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629A90
        for <linux-wpan@vger.kernel.org>; Wed, 11 Oct 2023 17:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A017EC433C9;
        Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070624;
        bh=7KfXduPd7hp5hJ9Im+WCKUqxTvsxCJXZAHy9STti0CM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P/2hc4kC+AXq9BwMLQJ6l+o3quSFdJ/VSELWGEIUZi1QtHh+5mNDBdBoKJMovVDR2
         JbTEptNA1W/HVQls34WPdxkvEZKN9tHGcBWESK/td4VstIXoh6XGIiLRbgfRl2q+n4
         7H4hUt638Th6bPB0C8wrED9CHAU6NbqUwpHm2eVeQA71YHDE/ADGYEpYaWJ1DdnZEZ
         COGSjC5XgYXQ8vWbxpNQC/z44ToSKIjOrj3cPlTZVDxk+cy2a8n32N591bE/dJAzJL
         aNHQjY0aL51U8h09GZbbBKbV/itSGo6mjnWrkSY+NavZQrTBIahjKWeahSQClfXdts
         uNEn8bRwQGSgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84D62C595C5;
        Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2023-10-10
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707062453.15864.2496383735128357487.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:30:24 +0000
References: <20231010200943.82225-1-stefan@datenfreihafen.org>
In-Reply-To: <20231010200943.82225-1-stefan@datenfreihafen.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 22:09:43 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Just one small fix this time around.
> 
> Dinghao Liu fixed a potential use-after-free in the ca8210 driver probe
> function.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2023-10-10
    https://git.kernel.org/netdev/net/c/8bcfc9ded21c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


