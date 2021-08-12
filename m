Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63BC4338F
	for <linux-wpan@archiver.kernel.org>; Thu, 12 Aug 2021 19:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869866108C
	for <linux-wpan@archiver.kernel.org>; Thu, 12 Aug 2021 19:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhHLTAg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234360AbhHLTAb (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 12 Aug 2021 15:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D22D06109D;
        Thu, 12 Aug 2021 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628794805;
        bh=w8jGFJAdclqZ92GLirMs1mh9yihdQRVzuj3pKIj6b+I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nohEsS/aeplCw1ozqrAVquKWJ47sERQaMitg02WS6/8v0pfxEvrEE9Ij0nDs6t4n+
         8FpzMZMgnMSYbaAq8uC19GNukCrFtT9XUtPJrZqnhUzcSD9AuTnm7PrcS/iqb1tYzP
         7h1IrOj3rqR699E7DHqBkLPVX9yUK7htgCiMHc79f7An2lonMcARyRcB2RYf4i92XI
         90+HpSF8gdin/qb3SgvkG7VRACtOoQrN+RDSi64SpGGZhZ0ucsVWYrsQB4MWzMzPCk
         KL75QxUTLvwyIt//s/Ju9RoKOBk9QxolJuhUIoSBoGuT/p6uvi33UlrqHKl73DVhV1
         xPJOwDUtaRScw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2021-08-12 v2
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162879480580.7983.10412295435937743215.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Aug 2021 19:00:05 +0000
References: <20210812183912.1663996-1-stefan@datenfreihafen.org>
In-Reply-To: <20210812183912.1663996-1-stefan@datenfreihafen.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (refs/heads/master):

On Thu, 12 Aug 2021 20:39:12 +0200 you wrote:
> Hello Dave, Jakub.
> 
> An update from ieee802154 for your *net* tree.
> 
> This is a v2 with the merge commit elided.
> 
> Mostly fixes coming from bot reports. Dongliang Mu tackled some syzkaller
> reports in hwsim again and Takeshi Misawa a memory leak  in  ieee802154 raw.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2021-08-12 v2
    https://git.kernel.org/netdev/net/c/a9a507013a6f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


