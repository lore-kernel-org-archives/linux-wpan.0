Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0703CECAAD2
	for <linux-wpan@archiver.kernel.org>; Sun, 28 Aug 2022 13:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiH1Nzr (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 28 Aug 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH1Nzq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 28 Aug 2022 09:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D603135F
        for <linux-wpan@vger.kernel.org>; Sun, 28 Aug 2022 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661694945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYUATfsKEURXeZ+taS+4lhutiQmmkqDu9huIxmY1kPA=;
        b=JTSQ24yLUT0TP9PBXOxOykEKetDNGCfTP6daMN6iYWMW+dtU++klp4s8KQByWDnKQBXPGg
        wRJdvdaV4TKZlZpDB1t63OY3XBqODYno+rfAw6To8N9eVjxEDUNZEvP0Sc947zbpRdIGEc
        zassJjSvAVabFW9Q5uZhoQLd7RBjH2Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-O7He3SjDMsGtWfCsnOPEVA-1; Sun, 28 Aug 2022 09:55:36 -0400
X-MC-Unique: O7He3SjDMsGtWfCsnOPEVA-1
Received: by mail-qk1-f198.google.com with SMTP id bp11-20020a05620a458b00b006bbeffab91dso4815968qkb.11
        for <linux-wpan@vger.kernel.org>; Sun, 28 Aug 2022 06:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hYUATfsKEURXeZ+taS+4lhutiQmmkqDu9huIxmY1kPA=;
        b=WFvpxSQrkKi5PQyIxQ3RLVbTtUDR4BOVaMNfMpDnIeHpmlB7jOpjXUNRjNvQqEQr3F
         DPcF8CEr1qx+oAT0OTJCkZRqv62oqAzMyyXh51fvPpeBnTeZTKDsnZSw7QCxdT7eKmDF
         f2OjsMaAFmB8DJmolSvjT8ACRO5LP9cN9MIfueVumom9I9J/G2SGSsk7F/uMCj94HQCI
         N3yYClq50NvmlAwRODlsUCwGpKLxh0xVqb+4jZcja8xbR6Mu5+fGv4CNgcqhU4eDr7Xc
         D7O/m3qLwK6+5+A23T4A9QkBzDo+2y/dGXh/aP1yBoyQxPWZJW91OjrBAEkXAEUzdAhZ
         mTqw==
X-Gm-Message-State: ACgBeo0NYPQJDLarSTIhkG1v2OGeKZZ5FLbil23OuspOxZBklAK4Jy/s
        ymXFaHm4n+XqsbunYFXXdv+Xeg3pRFhuJf4wTViaS2J27IUOxFxOKKAidhxbL1Vzzk6RhUkPoup
        VMB+KGRaeg8slG5u2IBFX+OuBGewHac2O1CA7sA==
X-Received: by 2002:a05:6214:2462:b0:496:2772:3211 with SMTP id im2-20020a056214246200b0049627723211mr6963828qvb.28.1661694935585;
        Sun, 28 Aug 2022 06:55:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zUIr4gvAyQfT3ya3j9tC0PPNkA0epcLxiOEfrr4UIwa1wP01a504qhtFMxWaSejUBGG2wN7MpdhF4KNrwM9Q=
X-Received: by 2002:a05:6214:2462:b0:496:2772:3211 with SMTP id
 im2-20020a056214246200b0049627723211mr6963812qvb.28.1661694935361; Sun, 28
 Aug 2022 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
 <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
 <20220819190654.6af62bca@xps-13> <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
 <20220825145516.14bd5b45@xps-13> <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
 <20220826125020.414964fd@xps-13>
In-Reply-To: <20220826125020.414964fd@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 28 Aug 2022 09:55:24 -0400
Message-ID: <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
Subject: Re: [PATCH wpan-tools 0/7] iwpan: Support scanning/beaconing
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 6:50 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
>
> I've updated the tools so that we have:
>
> * "scan trigger" which does not block
> * "scan monitor" which displays with a pretty output the new
>   coordinators and stops blocking when the scan is over (either because
>   it reached the last channel to scan, or it got aborted)
> * "scan abort" which stops an ongoing scan
> * "scan" which is the same as "scan trigger; scan monitor", and will

no, there is a race in the design of "scan trigger; scan monitor".

>   send an abort command if interrupted with SIGINT
>
> On the other side there was in the previous versions a command "iwpan
> event" which I just renamed "iwpan monitor" which follows anything
> 802154 related and displays a single line each time, it looks like:
> # iwpan monitor -t // -t is an option to display timestamps
> 1661510897.820505: coord1 (phy #1): scan started
> 1661510903.874055: coord1 (phy #1): new coordinator detected: PAN 0xabcd, addr 0x42aab7e343ea5c0f
> 1661510908.953874: coord1 (phy #1): scan finished
> 1661510915.437030: coord1 (phy #1): scan started
> 1661510916.242412: coord1 (phy #1): scan aborted
>
> This should address all the needs.

I would remove the scan monitor and if it is needed a "monitor scan",
"monitor" will give you all 802.15.4 events, scan will give you a
filter for all scan events and may we add in future even a ?phy/dev?
argument to filter per interface? :)

"monitor scan" just to move event monitoring to the right command.

- Alex

