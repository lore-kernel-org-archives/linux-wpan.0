Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9037C433ED
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Apr 2021 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E07D613B3
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Apr 2021 22:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhDGWUj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhDGWUj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 7 Apr 2021 18:20:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF6B561246;
        Wed,  7 Apr 2021 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617834028;
        bh=zBZdi3R/7P1SW7EPPHTm2kIJ/zDMmOdDIoYpnYopv3k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hQNMpVwrW/qSrtH2wTqeQ8xVRJstBeEMmPG1MMxuJzT5ESSQLaxxDFLB5HeLpT9sk
         4BE+Khm1swj2U/8KsD3PezHT24F4Mw7GNMrZIdykrE0x1odOgUG3oePTtjMVhmQLg1
         zfDjo+1EazXEy5ufIciUf6fFvN+UPcder+qRGwBr2SSC22Lk4QxmjqQrP23zddEAGD
         mIvnkYukreByGVuCES8e2p9O7CKuY1xMybh2MD/1N1nJi3fWHitev3Il59kjvDpxTI
         cUFxG9lYgFmbYHD+h6mXMcD9T+y4S+QKS06YRv1JQ50VQs6rCFBltBW98dJOWXAKst
         Hw8zyPL1HlBQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2021-04-07
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161783402887.11274.12898338956836762292.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Apr 2021 22:20:28 +0000
References: <20210407145505.467867-1-stefan@datenfreihafen.org>
In-Reply-To: <20210407145505.467867-1-stefan@datenfreihafen.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (refs/heads/master):

On Wed,  7 Apr 2021 16:55:05 +0200 you wrote:
> Hello Dave, Jakub.
> 
> An update from ieee802154 for your *net* tree.
> 
> Most of these are coming from the flood of syzkaller reports
> lately got for the ieee802154 subsystem. There are likely to
> come more for this, but this is a good batch to get out for now.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2021-04-07
    https://git.kernel.org/netdev/net/c/5d1dbacde1a2

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


