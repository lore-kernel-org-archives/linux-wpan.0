Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB79ECAAA1
	for <linux-wpan@archiver.kernel.org>; Wed, 31 Aug 2022 03:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiHaDSF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 30 Aug 2022 23:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiHaDRu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Aug 2022 23:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315564F66F
        for <linux-wpan@vger.kernel.org>; Tue, 30 Aug 2022 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661915868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/gVeVtlI+QoqYdj58o6LTZamMR9BvTUPTO4dNCQ1EcY=;
        b=UULMxoqPsHrTYIHWRK2MVCKb9TwDm1JorSyigl/aMuFsBrV8ekjBR4RIYXNm+v+uqA1e3H
        CNmrkVAw7pmWd9lgnE8a50JpSW6fPhgVP4NBH5PHEgLPIq3Oe39vMWoRxvLMbMXC/Ea5lk
        5cOx1hNhk4NZRbzI+Gue+LVTlSaxKRQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-ycQQHN0YPLif_0JRZRcUKA-1; Tue, 30 Aug 2022 23:17:46 -0400
X-MC-Unique: ycQQHN0YPLif_0JRZRcUKA-1
Received: by mail-qv1-f72.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so8363581qvs.18
        for <linux-wpan@vger.kernel.org>; Tue, 30 Aug 2022 20:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/gVeVtlI+QoqYdj58o6LTZamMR9BvTUPTO4dNCQ1EcY=;
        b=PREHOdnFgt9gn8wN0bHMByyLDQkqlLHkH0XsVk/LQ/lntoP2Y/O/79DNIBGYFliFNo
         tFC+e91DeiLj8Tq0J8z8Wpo+ZLDl1Q4nx12mVJjdeXoAWoxYOWkARt3ET+3vkxpqoPVm
         X4g3yeTOIKAbDN1bnZCUv2s7fMe2TGIqYB3GXxwCbkdCWHgBfYITtC1EJQAs8qhPQrNM
         4OAIWJXiFEBQsWnHsDUmGufejI2ipTAG2zCrUGUmXYnhwDQ66pZTqj3tMPkEFRwK9MQd
         Uqy9m0Y4kwJTYpM8CvrFD7hy2JJHg7WDBWTpAg6ztDXlPYoyYZx/Nyev7bgy98uBzSUM
         N1Kg==
X-Gm-Message-State: ACgBeo2R05fkWMzBn7nry+Lq3T1MRCNqxMQ5cRrzgVv5f2tZA3a2CNCm
        2nYiq8Oob31Y5F+28yCBWa3ZZUrNHQb5igBOxZJzgqaLinJRwESImXWTKCoURseR+dRxJFOxNaY
        xCE5zdb7dMF2z5GZjdO0rySaeR8N5PnOd46ejVA==
X-Received: by 2002:a05:622a:214:b0:342:f97c:1706 with SMTP id b20-20020a05622a021400b00342f97c1706mr17162920qtx.291.1661915866392;
        Tue, 30 Aug 2022 20:17:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ToCoGy18LFLi7qppNLN5y49LtaQLEAbgn7fqmGdbU3ReBAnv05V6Afrb7XhJfxT7pdzMHE6Q7fhz4WdIgk+c=
X-Received: by 2002:a05:622a:214:b0:342:f97c:1706 with SMTP id
 b20-20020a05622a021400b00342f97c1706mr17162912qtx.291.1661915866224; Tue, 30
 Aug 2022 20:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
 <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
 <20220819190654.6af62bca@xps-13> <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
 <20220825145516.14bd5b45@xps-13> <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
 <20220826125020.414964fd@xps-13> <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
 <20220829103702.4cce4670@xps-13> <CAK-6q+j3mak0exMnQT9kw3pu6zNkXwY6Fxbjz8akap3N04AEeQ@mail.gmail.com>
In-Reply-To: <CAK-6q+j3mak0exMnQT9kw3pu6zNkXwY6Fxbjz8akap3N04AEeQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 30 Aug 2022 23:17:35 -0400
Message-ID: <CAK-6q+jxtxvkcmmfRnQad7NhsWJ1OSAsdhw1PsfgT2SDhwGNrw@mail.gmail.com>
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

On Mon, Aug 29, 2022 at 8:57 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Aug 29, 2022 at 4:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sun, 28 Aug 2022 09:55:24 -0400:
> >
> > > Hi,
> > >
> > > On Fri, Aug 26, 2022 at 6:50 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > ...
> > > >
> > > > I've updated the tools so that we have:
> > > >
> > > > * "scan trigger" which does not block
> > > > * "scan monitor" which displays with a pretty output the new
> > > >   coordinators and stops blocking when the scan is over (either because
> > > >   it reached the last channel to scan, or it got aborted)
> > > > * "scan abort" which stops an ongoing scan
> > > > * "scan" which is the same as "scan trigger; scan monitor", and will
> > >
> > > no, there is a race in the design of "scan trigger; scan monitor".
> >
> > Right, I've used pthread to first start the monitoring, before actually
> > triggering the scan. That should be enough.
> >
>
> I think we should look at this, because it requires that all
> applications link to pthreads if we offer such an API. Any thoughts
> about alternative ways, can it not be done over libnl, that libnl
> internally used e.g. select()? The above example is only regarding the
> process context.
>

I think pthreads are not necessary here. If we don't close and open
the nl socket everything should be queued.
Forget that with select(), just send() and recv() (whatever that is
underneath of libnl) should be enough.

- Alex

