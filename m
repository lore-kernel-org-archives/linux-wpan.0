Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6680DCD37BD
	for <linux-wpan@archiver.kernel.org>; Sat, 16 Sep 2023 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjIPPgw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 16 Sep 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjIPPgh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 16 Sep 2023 11:36:37 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB8CE3
        for <linux-wpan@vger.kernel.org>; Sat, 16 Sep 2023 08:36:32 -0700 (PDT)
Received: from [192.168.2.51] (p4fe718a3.dip0.t-ipconnect.de [79.231.24.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 6F165C03EF;
        Sat, 16 Sep 2023 17:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1694878585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGVXSNxIx1AgOehcMWtP0csSRTY2gwx8o98lG1cdRsU=;
        b=L2j6qtAoHyo8kaF5G/9xsPcwI8TdHViUyG8Km7J3FptB3/4mrQfYQYyMD0A98YM1qQews8
        BeYfhEtw4/L6BW00c7kg1vyyZfl5KHQUhSTfLR4EGCBvjt2FoxU8diEZ5deoPyfrUiqFW5
        IGcOmxgMG1mqCec7k9uyIIET5OxwAs4K3Ar4pmF7e7S3r9B35xeKCWYjjIW+cEW9HZj65s
        wn4PSDIPIPfqw+DFC0EQ//gPwyIQRgiNAKBg5INbRUK+ifaTPORBI84sFA1L/SSZcUrL5q
        KYclEERuI9KpcWfn8yUGYyCJ4USjQ2iJNSxxubeww7oWgA1SLW6N/kdYc6g0bw==
Message-ID: <85942db2-2dbe-ae64-49d9-c2f0fd53e31e@datenfreihafen.org>
Date:   Sat, 16 Sep 2023 17:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH wpan-next v2 04/11] mac802154: Handle associating
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
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
 <20230901170501.1066321-5-miquel.raynal@bootlin.com>
Content-Language: en-US
In-Reply-To: <20230901170501.1066321-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel.

On 01.09.23 19:04, Miquel Raynal wrote:
> Joining a PAN officially goes by associating with a coordinator. This
> coordinator may have been discovered thanks to the beacons it sent in
> the past. Add support to the MAC layer for these associations, which
> require:
> - Sending an association request
> - Receiving an association response
> 
> The association response contains the association status, eventually a
> reason if the association was unsuccessful, and finally a short address
> that we should use for intra-PAN communication from now on, if we
> required one (which is the default, and not yet configurable).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   include/net/cfg802154.h         |   1 +
>   include/net/ieee802154_netdev.h |   5 ++
>   net/ieee802154/core.c           |  14 ++++
>   net/mac802154/cfg.c             |  70 ++++++++++++++++++
>   net/mac802154/ieee802154_i.h    |  19 +++++
>   net/mac802154/main.c            |   2 +
>   net/mac802154/rx.c              |   9 +++
>   net/mac802154/scan.c            | 127 ++++++++++++++++++++++++++++++++
>   8 files changed, 247 insertions(+)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 1c22cef77425..df1f6c905c2d 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -503,6 +503,7 @@ struct wpan_dev {
>   	struct mutex association_lock;
>   	struct ieee802154_pan_device *parent;
>   	struct list_head children;
> +	unsigned int association_generation;

Could you explain what you are suing this for? I see it icreases in 
free_peer_structure as weel as in associate. But I am not clear what 
this is used for.

regards
Stefan Schmidt
