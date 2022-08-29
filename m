Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF524ECAAD4
	for <linux-wpan@archiver.kernel.org>; Mon, 29 Aug 2022 13:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH2NEE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiH2NDf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Aug 2022 09:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425B861E3
        for <linux-wpan@vger.kernel.org>; Mon, 29 Aug 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661777834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcP6ValkWWpzgumTf5whCf+XxKoGULQJyQXg47i7YXU=;
        b=GFH1vD0mpNQgqrIs7zNZL0aCW/ExguVvJl321UoqgYLH2xGWScMTd1LeuuXLkagT55EGTZ
        C0i/74NiA40U9O+zuy9q/g9oZcmg1FiB6KexVCR3p8hhIjBQmSEOP/H8aQdabtG5wLwJxy
        dObA8n3WmKEH6SA0FVStNhm/+0do/mI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-8qH6s9HdNRy1mQGgXgPeog-1; Mon, 29 Aug 2022 08:57:13 -0400
X-MC-Unique: 8qH6s9HdNRy1mQGgXgPeog-1
Received: by mail-qt1-f197.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so6293783qta.12
        for <linux-wpan@vger.kernel.org>; Mon, 29 Aug 2022 05:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fcP6ValkWWpzgumTf5whCf+XxKoGULQJyQXg47i7YXU=;
        b=wcc5LRsA6e9m5cCR/B+GNz0YuenytEAJlhF3Fkn69PYMH7eJ1zSs5VZiAEwWUB/AV/
         1vTep+62ey2yyrRqUHj6881M/ZHD+fvmGjr21zwkF0ciIIpX+m9zOtQXvq7hy1oZDT9K
         L0kuJK0v74n2Qoo6Y9VTxraopIeXw7dt6RbXXmYHXMEP57PmiufxbRY1viubxHqCeJYm
         8aXR0jbJDVzc2PoZZGjI3PJ4n/EnURq8J2xPj721L/ZLZqVUz3BVJhTqOdcFGJb3fVel
         hBJ3jZZTk2rY46at6pds5EQHxJFFqGjIj4tmiBbV2KFkl7uSwM6p/ie0peXH1mVl+aUZ
         OmUg==
X-Gm-Message-State: ACgBeo0E7KrZn6eBgs/WakeNfsZbv9P6CHjM6w6M4KUj4UOeG2rt2aj+
        MQNQEB725Bt+ocDR3QPajPhIshfGxicsBSECL/tTRoH+dZeDlIH2By8Y3Ol6WfSRe3DZE8nB8rZ
        6OqCciCbKP+UZsmovnEXY3W6jOVhPBbE8tZPlEg==
X-Received: by 2002:a05:6214:1bce:b0:499:504:7631 with SMTP id m14-20020a0562141bce00b0049905047631mr2325150qvc.92.1661777832667;
        Mon, 29 Aug 2022 05:57:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR58j/vDKtlAFApSzY4YEWqcnYvtoRLw1y2HmvfcViigJkQW7zxQXJikFfPDkyqmBMP9Cvq5HeJz3TqUZt0lJJ0=
X-Received: by 2002:a05:6214:1bce:b0:499:504:7631 with SMTP id
 m14-20020a0562141bce00b0049905047631mr2325131qvc.92.1661777832434; Mon, 29
 Aug 2022 05:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
 <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
 <20220819190654.6af62bca@xps-13> <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
 <20220825145516.14bd5b45@xps-13> <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
 <20220826125020.414964fd@xps-13> <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
 <20220829103702.4cce4670@xps-13>
In-Reply-To: <20220829103702.4cce4670@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 29 Aug 2022 08:57:01 -0400
Message-ID: <CAK-6q+j3mak0exMnQT9kw3pu6zNkXwY6Fxbjz8akap3N04AEeQ@mail.gmail.com>
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

On Mon, Aug 29, 2022 at 4:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 28 Aug 2022 09:55:24 -0400:
>
> > Hi,
> >
> > On Fri, Aug 26, 2022 at 6:50 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > ...
> > >
> > > I've updated the tools so that we have:
> > >
> > > * "scan trigger" which does not block
> > > * "scan monitor" which displays with a pretty output the new
> > >   coordinators and stops blocking when the scan is over (either because
> > >   it reached the last channel to scan, or it got aborted)
> > > * "scan abort" which stops an ongoing scan
> > > * "scan" which is the same as "scan trigger; scan monitor", and will
> >
> > no, there is a race in the design of "scan trigger; scan monitor".
>
> Right, I've used pthread to first start the monitoring, before actually
> triggering the scan. That should be enough.
>

I think we should look at this, because it requires that all
applications link to pthreads if we offer such an API. Any thoughts
about alternative ways, can it not be done over libnl, that libnl
internally used e.g. select()? The above example is only regarding the
process context.

> > >   send an abort command if interrupted with SIGINT
> > >
> > > On the other side there was in the previous versions a command "iwpan
> > > event" which I just renamed "iwpan monitor" which follows anything
> > > 802154 related and displays a single line each time, it looks like:
> > > # iwpan monitor -t // -t is an option to display timestamps
> > > 1661510897.820505: coord1 (phy #1): scan started
> > > 1661510903.874055: coord1 (phy #1): new coordinator detected: PAN 0xabcd, addr 0x42aab7e343ea5c0f
> > > 1661510908.953874: coord1 (phy #1): scan finished
> > > 1661510915.437030: coord1 (phy #1): scan started
> > > 1661510916.242412: coord1 (phy #1): scan aborted
> > >
> > > This should address all the needs.
> >
> > I would remove the scan monitor and if it is needed a "monitor scan",
>
> Actually we need both "scan monitor" and "monitor scan". The former
> shows what is happening in a clean manner, with a detailed view of all
> the information about the beacon received, while the latter would more
> something that we run aside to follow what's happening, it's a bare and
> short output (one-liners).
>

For me that can be already provided by the iwpan monitor command,
maybe with some pretty print args or json args to have it in a nice
way or json whatever looks like ip/iw thingy. :)

However I don't really bother here, except that it might confuse
people who want to scan and probably want the blocked command only and
think the other scan commands are necessary to perform a scan...

- Alex

