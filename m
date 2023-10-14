Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B62CDB47E
	for <linux-wpan@archiver.kernel.org>; Sat, 14 Oct 2023 00:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjJNAHg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 13 Oct 2023 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjJNAHf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Oct 2023 20:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888DEAD;
        Fri, 13 Oct 2023 17:07:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744BCC433C7;
        Sat, 14 Oct 2023 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242054;
        bh=6kpMwlfSNasU9AQMtLitDygCjCpDKwjI+adsPbqa9OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdBr2wcD9YbkjCo7SyrOU7C2P7cOL79UAKLiM1BqeppHoumCz76G9EbxX7WR2a7v0
         Y60I+lH6kFJnJziGqDlxqaLZNQaM/awAaSidgcGYR+9q83BJ2QxSZEZjTjIuk348Pi
         ffyBwFqzUhY++R8GyWNdABQ2xssKv/CC5BMpYdyuVHIv/3fh2UddcuGDzzePUzM0Zj
         ZFZNP9zKbvbYP8evuVMaLBq3Uhtdj7X0PFkWqqfqRdG+UIQQ5Ycc52CB8UiFnpBAQL
         Xh9FykSlCiuWrvhF9vOqoSKQIaFP4aVwTfh1v/CEpEBtX9JaFGG1pCzHzRUPMxahBz
         kL3fZdQ9ejoyw==
Date:   Fri, 13 Oct 2023 17:07:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "Arnd Bergmann" <arnd@arndb.de>, "Jiri Pirko" <jiri@resnulli.us>,
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
Message-ID: <20231013170732.587afd86@kernel.org>
In-Reply-To: <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
References: <20231011140225.253106-1-arnd@kernel.org>
        <ZSa5bIcISlvW3zo5@nanopsycho>
        <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 11 Oct 2023 17:57:38 +0200 Arnd Bergmann wrote:
> The .ndo_do_ioctl() netdev operation used to be how one communicates
> with a network driver from userspace, but since my previous cleanup [1],
> it is purely internal to the kernel.
> 
> Removing the cops appletalk/localtalk driver made me revisit the
> missing pieces from that older series, removing all the unused
> implementations in wireless drivers as well as the two kernel-internal
> callers in the ieee802154 and appletalk stacks.
> 
> One ethernet driver was already merged in the meantime that should
> have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
> With the complete removal, any future drivers making this mistake
> cause build failures that are easier to spot.
> 
> [1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/

Kalle, Johannes, do these apply for you?
I'm getting a small conflict on patch 8 and bigger one on patch 9.
If this applies for you maybe you can take it and flush out
wireless-next soon after?
