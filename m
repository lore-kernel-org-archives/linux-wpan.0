Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2287C43334
	for <linux-wpan@archiver.kernel.org>; Mon,  4 Jul 2022 01:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiGDBSz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBSz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 3 Jul 2022 21:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62AD631E
        for <linux-wpan@vger.kernel.org>; Sun,  3 Jul 2022 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656897533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTR42qOBAPJLVpeW3qzZHpf4gBnbwpAsJ5kRjUkC5/4=;
        b=UV3xbE5VNTh1r4jXkvi8AO/h4Hg5ZBRoPHp3er3YGWnP8TZ73KaeY6g9uRx/IFhtIrfDuh
        2NeWkgy1OC34KJyPzKSDsAs7XZH7DaOnJMMAyrreSWhfCwgc6C05+AzSM52GytcdkbCNKW
        H1x5xW+f9KQ4X0YnisiFQrYrj+jOomQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-EBeqOguwOE-SJeiHV4ti6Q-1; Sun, 03 Jul 2022 21:18:51 -0400
X-MC-Unique: EBeqOguwOE-SJeiHV4ti6Q-1
Received: by mail-qk1-f199.google.com with SMTP id 186-20020a3708c3000000b006af306eb272so7364078qki.18
        for <linux-wpan@vger.kernel.org>; Sun, 03 Jul 2022 18:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTR42qOBAPJLVpeW3qzZHpf4gBnbwpAsJ5kRjUkC5/4=;
        b=xbbRYOhs27DaXlE3DwD9CDm8TUwthdgaS4o6Cb1GEqYWy3j07fSymkR+CX3yl6ct6P
         lR7alNu0M2eKEK1xK5DEVTK+q+Hkb93L996VcQ2R1VxGrjYPFMZ+Tf6OPpAdXx9L2P8f
         uzTnsulf7XGRMrNInpszwLn4/WvUFRXeYQaAzHzNIB+6vIn1tAvFHOxv8OiBVgRonq4f
         mr5QJL/EypFrIBRhAGdSR01FbN+1ZBQHTpkm6Xmon4N+38CLD4da4GrotWnZ2JUNsd3R
         IRJRcR0Jr+FgcTWj6aEJyFeXgvz1MvreJpFNnKRdEr99huYCGsNlBsDFygSsYMT2m1eM
         ln1A==
X-Gm-Message-State: AJIora+SvUqsMxDlTp6HBY3bsxwX3L1/x6uNYDavyp/ZIu8Jya+a2/DH
        U8PSdEATl6VUhRHNqm9FijdzdR+2YZ19gLjOoDXzlAxnc2nox4P5xBEz2jX55TX+qr50O6vrUfg
        Anj44mio8ke0q+jgGpLml75yXLoCAHKfeKcS/tw==
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id bs35-20020a05620a472300b006af46a28531mr18671155qkb.177.1656897531295;
        Sun, 03 Jul 2022 18:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stcCwmeFtgKS7xQd6QJ2zmIC8Kw7c89x0LvW/B3o128m4+o6swfs2oH6yMj0txMKyeikzZrxsQo7brOTHRalA=
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id
 bs35-20020a05620a472300b006af46a28531mr18671148qkb.177.1656897531121; Sun, 03
 Jul 2022 18:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 3 Jul 2022 21:18:40 -0400
Message-ID: <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
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

On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> This series follows the work done in the Linux kernel stack: now that
> the core knows about the different netlink commands and attributes in
> order to support scanning and beaconing requests from end-to-end, here
> are the userspace changes to be able to use it.
>
> Here is a list of the new available features.
>
> * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
>   valid for passively sending beacons at regular intervals. An interval
>   of 15 would request the core to answer BEACON_REQ.
>   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed rate
>   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
>   # iwpan dev coord0 beacons stop # apply to both cases
>
> * Scanning all the channels or only a subset:
>   # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEACON_REQ
>   # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_REQ
>
> * During scans, there is a dedicated netlink channel event to listen to
>   in order to get events like "a new coordinator was discovered" or "the
>   scan is over". When beacons from new devices are received, the tool
>   would print something like:
>   PAN 0xabcd (on coord1)
>         coordinator 0xe673d7a3f3a87ccc
>         page 0
>         channel 13
>         preamble code 0
>         mean prf 0
>         superframe spec. 0x4f11
>         LQI 0
>
> * It is also possible to monitor the events with:
>   # iwpan event
>
> * As well as triggering a non blocking scan:
>   # iwpan dev wpan1 scan trigger type passive duration 3
>   # iwpan dev wpan1 scan done
>   # iwpan dev wpan1 scan abort

why do we need an abort?

- Alex

