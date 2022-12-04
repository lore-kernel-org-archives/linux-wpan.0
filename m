Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8231FC4332F
	for <linux-wpan@archiver.kernel.org>; Sun,  4 Dec 2022 22:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiLDWu6 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Dec 2022 17:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLDWuy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Dec 2022 17:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8460E9
        for <linux-wpan@vger.kernel.org>; Sun,  4 Dec 2022 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670194191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAH0a91c7U1jqtpok3gsbLLRM6v87SVVxbB37wK7DIA=;
        b=f+6kzS7DRNIPG5uV8d3yMaN3jkgYyxJlPS2MojefeXKF5/Nij5BOxXYA1XNU+SuI79nttV
        S1GAiwlbCI5qUaPViwOrnH2we/syEnMcz4H/CLq8UsyGHPUwNfq/TzRCw5a58c2wMe2hQM
        oQGRWXs7MaPgWDq6IVao52wWn2JhM9Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-JqClyYiHNPaKqIubqjGMFQ-1; Sun, 04 Dec 2022 17:49:47 -0500
X-MC-Unique: JqClyYiHNPaKqIubqjGMFQ-1
Received: by mail-ed1-f72.google.com with SMTP id z4-20020a05640240c400b0046c51875c17so2176031edb.1
        for <linux-wpan@vger.kernel.org>; Sun, 04 Dec 2022 14:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAH0a91c7U1jqtpok3gsbLLRM6v87SVVxbB37wK7DIA=;
        b=lOjkVNhkPLcQwdzXbUvJABSbzv2tiQlLyPe6PGu7jbm+GUXU+4JXXaWl7F9kYa3XLe
         Hw2bXeEZVxux4LBb2jnDxDaLSnJdLP5/nopLTtfpi53Sz5zN4Pasx1jKqDckyPOhxyu7
         yi/dhiNbQI8H/SAnZFofLehaGJzY6T6w9p7NIvAVvCH1reISgGYuqypetV2gsbASs3UP
         LgG04g3Ey78ajAAl2EHtgbWJsJ2O/sy9Pxbd3H6qBD7IRNVSl0kU3MWpRkjLlzjTbX+z
         qrEVcPWIN5t2/HbQoELel0tiJ4+6Z3JaVYNQB2J7JMq/otbrx8TH2mGU5tDgiaCO7IjE
         DViA==
X-Gm-Message-State: ANoB5pl3fiuPlV/8zUpoBAQwMZqTHu5h+C7bIAnHyA1YJe0i7i0IT512
        TUEsMPsIGR2X1o5TeVU/L9rQM+ELHxQT+uvGyXbeXsJFpIthRog+zDyVbNhIi6/i1fKqLWZAGNL
        pw/72majwFdPtf7CB54AgYO9AKh+8MCf/aK5KiA==
X-Received: by 2002:a17:906:698f:b0:78d:93b1:b3ba with SMTP id i15-20020a170906698f00b0078d93b1b3bamr69575386ejr.66.1670194186291;
        Sun, 04 Dec 2022 14:49:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7TZ3aOChwOEI1M64XGnQEXCszIrZ0w3nmS13wa7e/xB9FJwTErCNwaGXgqxtnrEcH0zUQa48CYQ/nOY2Jts2Q=
X-Received: by 2002:a17:906:698f:b0:78d:93b1:b3ba with SMTP id
 i15-20020a170906698f00b0078d93b1b3bamr69575372ejr.66.1670194186091; Sun, 04
 Dec 2022 14:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20221130091705.1831140-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20221130091705.1831140-1-weiyongjun@huaweicloud.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 4 Dec 2022 17:49:34 -0500
Message-ID: <CAK-6q+gN9d2_=bN9tvCqCxSbymMfyJjF0j=gj4kUbi-bfSnF4g@mail.gmail.com>
Subject: Re: [PATCH wpan] mac802154: fix missing INIT_LIST_HEAD in ieee802154_if_add()
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 4:19 AM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Kernel fault injection test reports null-ptr-deref as follows:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> RIP: 0010:cfg802154_netdev_notifier_call+0x120/0x310 include/linux/list.h:114
> Call Trace:
>  <TASK>
>  raw_notifier_call_chain+0x6d/0xa0 kernel/notifier.c:87
>  call_netdevice_notifiers_info+0x6e/0xc0 net/core/dev.c:1944
>  unregister_netdevice_many_notify+0x60d/0xcb0 net/core/dev.c:1982
>  unregister_netdevice_queue+0x154/0x1a0 net/core/dev.c:10879
>  register_netdevice+0x9a8/0xb90 net/core/dev.c:10083
>  ieee802154_if_add+0x6ed/0x7e0 net/mac802154/iface.c:659
>  ieee802154_register_hw+0x29c/0x330 net/mac802154/main.c:229
>  mcr20a_probe+0xaaa/0xcb1 drivers/net/ieee802154/mcr20a.c:1316
>
> ieee802154_if_add() allocates wpan_dev as netdev's private data, but not
> init the list in struct wpan_dev. cfg802154_netdev_notifier_call() manage
> the list when device register/unregister, and may lead to null-ptr-deref.
>
> Use INIT_LIST_HEAD() on it to initialize it correctly.
>
> Fixes: fcf39e6e88e9 ("ieee802154: add wpan_dev_list")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Nice catch. :)

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

