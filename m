Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC8C32793
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Aug 2022 01:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiHXBgq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Aug 2022 21:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiHXBgj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2022 21:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E866A65
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 18:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661304995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QML3kmFQbghRJ5l/in2xsmcbAF1k2a3TqT3/Sag7fw4=;
        b=EiVaFIl7EIaFP9YD/9zT3SzqrK6Zvlj8BFSuir9zbVzcuJIWlbZlRw0Q3WfwCF9oaHMoIW
        nRbD32ueQZVCfKO9fnqZCv+S6/2xohtvBESKgh4itQwTpG0d7LzWRAiOnJG35Kixby5SP1
        KrdrNhrOr+6EspM4P00FOXHe6zmqGjc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-ypDkGlTpMe218fgehlbt8A-1; Tue, 23 Aug 2022 21:36:34 -0400
X-MC-Unique: ypDkGlTpMe218fgehlbt8A-1
Received: by mail-qk1-f200.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so13714392qkp.20
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 18:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QML3kmFQbghRJ5l/in2xsmcbAF1k2a3TqT3/Sag7fw4=;
        b=w+mXkhjiuENQPvDxzb/nAkWEedT2qhSidJvX6v63qjolKg7wrP62+xFkmY/hvXVz+X
         yKw5ozQQDfnN0cYd0l+R5KZkt4H2L2YOUnQzQ7HtyVNh/ps9oQpYE8cn28Mxyfy/0ytL
         BQPWXcB1yh4o5H73qZMtNnM+pz5NdlqVv9EbbgLsBI+WQs+GvQpJ1Qqk8U9kRcDfjiYR
         vG/mZOdvcmd4n48IS+S7f2tSTEjnQEiJnvuQ3a6m16iKqtpIN9zbDdlJ171ScbCnPROk
         hw57KOqbeGHtnyzs2O6brwF6tGCRaDN1/EOLpHDUBtVMsbM/ZGjMpMsWMKcKnxoUhVnb
         wo5g==
X-Gm-Message-State: ACgBeo2D650PypGNXCM6bmnruNQhYb3w73WgW1lEuPIfoR3+EUxT6D9s
        zIYjIPawu9DJexEFxbFc2L8xSWH2oXcKQ+ZAu/+ax44ejVFCHQtuPje3lfHBh7RaosLnpLdnQW4
        KqOiAIXrdGoXKGIyezwsrxf/NTRNId2ZzvJJmrw==
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id v2-20020a05622a130200b003448a9d817dmr22264325qtk.339.1661304994219;
        Tue, 23 Aug 2022 18:36:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6LO8gfJQcBE07AAdkD6goBTbwfQBtilSCX4M6KjyICmr4GpJZz62p8ftqY89gczANfjtluFgtYxvlmlkgWGUE=
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id
 v2-20020a05622a130200b003448a9d817dmr22264316qtk.339.1661304994013; Tue, 23
 Aug 2022 18:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
 <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com> <20220819190654.6af62bca@xps-13>
In-Reply-To: <20220819190654.6af62bca@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 23 Aug 2022 21:36:23 -0400
Message-ID: <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
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

On Fri, Aug 19, 2022 at 1:07 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 3 Jul 2022 21:18:40 -0400:
>
> > Hi,
> >
> > On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hello,
> > >
> > > This series follows the work done in the Linux kernel stack: now that
> > > the core knows about the different netlink commands and attributes in
> > > order to support scanning and beaconing requests from end-to-end, here
> > > are the userspace changes to be able to use it.
> > >
> > > Here is a list of the new available features.
> > >
> > > * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
> > >   valid for passively sending beacons at regular intervals. An interval
> > >   of 15 would request the core to answer BEACON_REQ.
> > >   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed rate
> > >   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
> > >   # iwpan dev coord0 beacons stop # apply to both cases
> > >
> > > * Scanning all the channels or only a subset:
> > >   # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEACON_REQ
> > >   # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_REQ
> > >
> > > * During scans, there is a dedicated netlink channel event to listen to
> > >   in order to get events like "a new coordinator was discovered" or "the
> > >   scan is over". When beacons from new devices are received, the tool
> > >   would print something like:
> > >   PAN 0xabcd (on coord1)
> > >         coordinator 0xe673d7a3f3a87ccc
> > >         page 0
> > >         channel 13
> > >         preamble code 0
> > >         mean prf 0
> > >         superframe spec. 0x4f11
> > >         LQI 0
> > >
> > > * It is also possible to monitor the events with:
> > >   # iwpan event
> > >
> > > * As well as triggering a non blocking scan:
> > >   # iwpan dev wpan1 scan trigger type passive duration 3
> > >   # iwpan dev wpan1 scan done
> > >   # iwpan dev wpan1 scan abort
> >
> > why do we need an abort?
>
> Perhaps the tool --help would have helped to get the naming, but we
> need:
> - a command to start a scan, either use:
>   * "scan" alone and it is synchronous, I mean the command returns when
>     the scan is over
>   or
>   * "scan trigger" which is asynchronous, and returns immediately after
>     starting the operation
> - if the scan was started asynchronously with the "trigger" keyword,
>   the "done" command will wait until the scan is over (maybe this one
>   needs to be renamed?)
> - if the user made a mistake and do not want to remain blocked for
>   several minutes (a scan can last for very long time), we need the
>   "abort" command to tell the kernel to stop and return to a standard
>   state. Once this has been processed and the scan effectively stopped,
>   the kernel will send a nl command saying the scan is over (which
>   "scan done" would capture)
>

For me, trigger and done should be for the simple cli use case in one
command like "scan list". It will block them and trigger any scan
event popping up. The user can send SIGINT to stop scanning?

Although there should be still available an asynchronous way which is
for me "scan trigger" (non-blocking) and the user can do "iwpan
monitor" to observe upcoming events (all inclusive scan) and tell
optionally "scan done" to stop scanning if necessary (which probably
also produces an event to notify all listeners e.g. iwpan monitor).

However I think most people using iwpan want to trigger and wait and
the cli is filling up events and blocks until it's done (that would be
a combination with trigger/monitor into one command).

Both solutions should be possible over cli?

Does this sound okay?

- Alex

