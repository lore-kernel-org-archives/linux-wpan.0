Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB19C53210
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Jan 2023 01:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjACBSb (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjACBSa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2023 20:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC56BA3
        for <linux-wpan@vger.kernel.org>; Mon,  2 Jan 2023 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672708662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vh6hg6ay+xuwkY2tbG9YHBc76gPmVbwDOLCD/YBLlw=;
        b=jWt7U/t6ZCf/Jux4o58Hfb8zkP0dqPD4ncoyr/qE/T09Mkr69ZjnqGdnSh95Kv1a6NPkZe
        nhZSSkVmMqM0XrYGohAMY/8Zw6V0S6GEPAGiMqFgTtbyXf5ZdUi5cqw3el6+DNqH5+nzWf
        x+ScH4JrNcmBCTEsvSc0MyftggLM2Do=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-6ARicngYOhKxqr3nkt-QKA-1; Mon, 02 Jan 2023 20:17:41 -0500
X-MC-Unique: 6ARicngYOhKxqr3nkt-QKA-1
Received: by mail-ej1-f69.google.com with SMTP id sg39-20020a170907a42700b007c19b10a747so18129316ejc.11
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jan 2023 17:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vh6hg6ay+xuwkY2tbG9YHBc76gPmVbwDOLCD/YBLlw=;
        b=DcFqNCrGYdIMGRz9VBROppPgRIslcyA2lhkqPTbhLc1twYr2Tzdx8ybLMBVpx3uqgZ
         mQGaJ/Z6tm/+YFrbELrrseGgdx8DSOmsXibZzoVDMxtSd2GmnFw3686fGzvVv4teWLPL
         tY6tB4Urjce4SV6IMNctO84OFU5CbKY6PfWvW+pRRAS7VG0MRhPxzCxUPuBKzJUzZIsk
         Q7YzFy2w5sGKwk8C7yNvIKxshveGsWb4fiWeGytrROJkPoSgaVUm7NZsvNTc5BZEvP/3
         qxz8P6GZ3KkHwtoW7s89JigSihVcdzScopXDWC5ieHyGjVUv6WQo7GIPhA8UNtw5p+Nt
         uMZQ==
X-Gm-Message-State: AFqh2kqfVvIjD9xt+l0RxdrZ1NNbqk3T2UWhmaKLypTwVqskm0RbT2vY
        9+GD8N/Pl+9odNEaLgwVfl9e5mDoZUiJEuGPQspPb9vIchoylkB150WIuo2Vp2TIXd+AZ2EXZco
        5uVChSFrh8B550LSpwHNaUd+uWD8yWRwBGkU2BQ==
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id fc18-20020a1709073a5200b007c0e23f17cdmr2418811ejc.491.1672708660048;
        Mon, 02 Jan 2023 17:17:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtF6GamvP/lFKPyjn6QWJuTd2kHJglmsUYVMCEebkqfOlklwNbbXGyj5g6iQ8IvsiYmVSS2SmoUk5O7ndBgfoQ=
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id
 fc18-20020a1709073a5200b007c0e23f17cdmr2418807ejc.491.1672708659928; Mon, 02
 Jan 2023 17:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20221217000226.646767-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221217000226.646767-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 2 Jan 2023 20:17:28 -0500
Message-ID: <CAK-6q+gnLOu2qfXSLcAb3YR7pHJXRS95rtcUF47D2hfHQ9gA-g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/6] IEEE 802.15.4 passive scan support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Dec 16, 2022 at 7:04 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> We now have the infrastructure to report beacons/PANs, we also have the
> capability to transmit MLME commands synchronously. It is time to use
> these to implement a proper scan implementation.
>
> There are a few side-changes which are necessary for the soft MAC scan
> implementation to compile/work, but nothing big. The two main changes
> are:
> * The introduction of a user API for managing scans.
> * The soft MAC implementation of a scan.
>
> In all the past, current and future submissions, David and Romuald from
> Qorvo are credited in various ways (main author, co-author,
> suggested-by) depending of the amount of rework that was involved on
> each patch, reflecting as much as possible the open-source guidelines we
> follow in the kernel. All this effort is made possible thanks to Qorvo
> Inc which is pushing towards a featureful upstream WPAN support.
>
> Example of output:
>
>         # iwpan monitor
>         coord1 (phy #1): scan started
>         coord1 (phy #1): beacon received: PAN 0xabcd, addr 0xb2bcc36ac5570abe
>         coord1 (phy #1): scan finished
>         coord1 (phy #1): scan started
>         coord1 (phy #1): scan aborted
>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks, good work.

- Alex

