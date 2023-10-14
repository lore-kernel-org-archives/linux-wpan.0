Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D6ECDB465
	for <linux-wpan@archiver.kernel.org>; Sat, 14 Oct 2023 04:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJNE6W (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 14 Oct 2023 00:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNE6V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Oct 2023 00:58:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E9C2;
        Fri, 13 Oct 2023 21:58:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2005EC433C8;
        Sat, 14 Oct 2023 04:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697259499;
        bh=bC06wekgYjGHqy1sHjwyZxjBb7s+oWdSTrNPtgW20Bc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kk/iTTZ2RR/TmlnrepoYqGc6mUAC4pf8x/P/BY+8rUpNlxVvCuu6smc83Lto6uwRc
         qJg0HkBoYb7Vo7xljX+KgiU8MwaLVN30bzsXpdzDim+XALyZq1R2GRZPFfhCVtUc09
         kjWolSBkeelgYaKZcN9ygMY4I3s2MjL3o/SyzxgiUVyGejHmVeNDB4QLAs4XONISam
         J8oRmI1AP7X8j+y3LLGS1waujLbNPQWYnPMO+2SzHcc16vdSxb3EFwORkFNaWl/bib
         xOI4jT8ioNqim2bTPZZORvxGaRHz1KA8u9gfKoJPCb4dxB3u2sKFlEfBPdupKUivF4
         zI5gGCQgVqziA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Johannes Berg" <johannes@sipsolutions.net>,
        "Arnd Bergmann" <arnd@arndb.de>, "Jiri Pirko" <jiri@resnulli.us>,
        "Arnd Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Rodolfo Zitellini" <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
References: <20231011140225.253106-1-arnd@kernel.org>
        <ZSa5bIcISlvW3zo5@nanopsycho>
        <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
        <20231013170732.587afd86@kernel.org>
Date:   Sat, 14 Oct 2023 08:00:51 +0300
In-Reply-To: <20231013170732.587afd86@kernel.org> (Jakub Kicinski's message of
        "Fri, 13 Oct 2023 17:07:32 -0700")
Message-ID: <87r0lxer24.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Oct 2023 17:57:38 +0200 Arnd Bergmann wrote:
>> The .ndo_do_ioctl() netdev operation used to be how one communicates
>> with a network driver from userspace, but since my previous cleanup [1],
>> it is purely internal to the kernel.
>> 
>> Removing the cops appletalk/localtalk driver made me revisit the
>> missing pieces from that older series, removing all the unused
>> implementations in wireless drivers as well as the two kernel-internal
>> callers in the ieee802154 and appletalk stacks.
>> 
>> One ethernet driver was already merged in the meantime that should
>> have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
>> With the complete removal, any future drivers making this mistake
>> cause build failures that are easier to spot.
>> 
>> [1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/
>
> Kalle, Johannes, do these apply for you?
> I'm getting a small conflict on patch 8 and bigger one on patch 9.

Yes, 'git am -3' was able to solve the conflicts automatically and these
do apply to wireless-next.

> If this applies for you maybe you can take it and flush out
> wireless-next soon after?

Ok, we'll do that. Does next Wednesday sound soon enough? :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
