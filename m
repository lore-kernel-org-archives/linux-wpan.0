Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E1CDB482
	for <linux-wpan@archiver.kernel.org>; Wed, 18 Oct 2023 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjJRAWd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 Oct 2023 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRAWd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Oct 2023 20:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6484A4;
        Tue, 17 Oct 2023 17:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D3C433C8;
        Wed, 18 Oct 2023 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697588551;
        bh=1ILIudyutyqZMoLATDL7ktSJVKE0d4FEmyHMN6PVyv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ew8nsr/crp6mvSPZsT9b6FvTqZJ3I1MknEdLUAoEtQr9yozMAX7djc/6Rl35YIvyx
         JiRcLMweJCI8OXEKoR+WB6YKVBMyufhZV6UDRz6ppNMCwerS0zPpqnx12EOy9uCt59
         s903rRG6Ouwx7ivk0GZwMuLL0G/55PvDEwyGac/uUBG+KjNp7dWoXaSO5v6L7+RfN0
         b6dC18FrB40qt06ewalWwYsTXTU3ddkea/gbsv+7JZQdzw6SMK05RS36xCQJ5LevM1
         qGst42zsQLKKazxd0GOlgwDMdWF4P7zQ0f/RrwNt9/Xn7lRTvbKP5vcuzcmUHhP1Mb
         Pi8qIa58O/GDg==
Date:   Tue, 17 Oct 2023 17:22:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <20231017172229.582c58d8@kernel.org>
In-Reply-To: <20231017172202.71c8dcf9@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
        <20231017172202.71c8dcf9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Tue, 17 Oct 2023 17:22:02 -0700 Jakub Kicinski wrote:
> Hi Arnd, the WiFi changes are now in net, could you rebase & repost?

s/net/net-next/ to be more clear this time..
