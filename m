Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5AC27C7C
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Feb 2023 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjBTTPO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjBTTPH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 14:15:07 -0500
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86101E28E;
        Mon, 20 Feb 2023 11:14:37 -0800 (PST)
Received: from [IPV6:2003:e9:d746:344d:8e4a:ccf0:3715:218] (p200300e9d746344d8e4accf037150218.dip0.t-ipconnect.de [IPv6:2003:e9:d746:344d:8e4a:ccf0:3715:218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id E2D5CC04A2;
        Mon, 20 Feb 2023 20:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1676920449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2r7JoFnyRah0Ql1YQJUVTbDgCbxchA+BJRIsqfnHXU=;
        b=BCdGOpNh1JQyJmx+CilGqRwym3dCd8pDbHAIQI/ZFSq9gy4Qvsb9I43nyvZEtN7lUaygNh
        xp/Bcb336yzXzWuTXWx5fM99ZzafEFS8Qj0i3+D//z7KKdYI108hdhsn6Q+5aCipXvXdh+
        J48k9yPMHhf0wm41EpK8BiznqRumU1pbc7i6kcGE1PzWYkfGE28OjPZJb2+5VHqHognPHq
        4xcCMDSOkF8jB45hHvLHsfLCa6aqwEOJ7UEHkiEzuz6T4brFuLhE0/S6DwttIUnLzz2vwu
        HOYTWbhuB2S50LPTRiNAKd0E+txjen6qAYMqMPeDDwaqyrpn/p0SKa4R7wfu9Q==
Message-ID: <1a2f2a87-eff6-cee7-24f2-f903f42fec3b@datenfreihafen.org>
Date:   Mon, 20 Feb 2023 20:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH wpan v2 0/6] ieee802154: Scan/Beacon fixes
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230214135035.1202471-1-miquel.raynal@bootlin.com>
Content-Language: en-US
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230214135035.1202471-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 14.02.23 14:50, Miquel Raynal wrote:
> Hello,
> 
> Following Jakub's review on Stefan's MR, a number of changes were
> requested for him in order to pull the patches in net. In the mean time,
> a couple of discussions happened with Alexander (return codes for
> monitor scans and transmit helper used for beacons).
> 
> Hopefully this series addresses everything.
> 
> Thanks,
> Miquèl
> 
> Changes in v2:
> * Fixes lines with upsteam commit hashes rather than local
>    hashes. Everything else is exactly the same.
> 
> Miquel Raynal (6):
>    ieee802154: Use netlink policies when relevant on scan parameters
>    ieee802154: Convert scan error messages to extack
>    ieee802154: Change error code on monitor scan netlink request
>    mac802154: Send beacons using the MLME Tx path
>    mac802154: Fix an always true condition
>    ieee802154: Drop device trackers
> 
>   net/ieee802154/nl802154.c | 125 ++++++++++++++------------------------
>   net/mac802154/scan.c      |  25 ++++++--
>   2 files changed, 65 insertions(+), 85 deletions(-)


These patches have been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
