Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4BC433EF
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiERA7z (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiERA7y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 20:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D709E53E27
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652835591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TD7xyGWTuwBRGr8+dLq49qXLZB7RZzLQlThaAODywHI=;
        b=QFpT2G3hNb4ip+2Y2PsVUH1jRthQpHmrciXeFllWaQ+zMaHDPCVqWwpAKPHCalCo6nwq1e
        ujVWp4GRb/4r+MUOV4/F7HODP3Q2Fd4mqbqrLh2gYqMdq/XfEKO3mumCeXSacMro6vg6Ze
        2INwt5XDYsi5H8CfwwoMCN1oLtb51UY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-3gWFvaj-NP6VND8bsbk_IA-1; Tue, 17 May 2022 20:59:50 -0400
X-MC-Unique: 3gWFvaj-NP6VND8bsbk_IA-1
Received: by mail-qt1-f199.google.com with SMTP id a18-20020ac85b92000000b002f3c5e0a098so616508qta.7
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD7xyGWTuwBRGr8+dLq49qXLZB7RZzLQlThaAODywHI=;
        b=di/jqnoWNX6B79DQe5JSiXMbm84iN0dQXS3swDukIvaN9zlgTOXFMjYOyobvjVhuR/
         i+Hysy1Ok9UEVm5Y6OjQ74Lx6qSgcqL/ISYPtTJ6XMAWDEsrWeVDC5mubqtbqu6ZqGhG
         FkwkSDK3seNDM3/JFBjq3F1UW2FG/t0rvSsfHG4A8fb+k3WCezxYO7UHgS1LqDbKJ/Zy
         ngxq3HuqrPsN7zCB11PtTYk2rPd6fnXmOySMczChJLN6fkIwFZwHeDzzr+awa1iiEl12
         kFlJeIcF37Nhho2BRD29WpsgmrQUMrRvpke5UApUHc6DVjMXl8xvtvMxNkWYd4AbAPzj
         C/5g==
X-Gm-Message-State: AOAM5332+TlEC56e/bJA8nTokATQNyBiFLBd6hqmHXwjGaPXvL7t0DKg
        2joftaPqt4DjmFLqBJnTFaGmBf9qNP1PoU8FUPVBRh2OwJRnWAHKJ0OoCOSGFW/cAiZFgtYdMVm
        VttqCdL6RQfPR+QTZXauaMaFLHPqYxR1XUZQQ+w==
X-Received: by 2002:a37:350:0:b0:69f:8c4e:9fa5 with SMTP id 77-20020a370350000000b0069f8c4e9fa5mr18295872qkd.770.1652835590135;
        Tue, 17 May 2022 17:59:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9DI611Whfu7K7lze9PphEAOqW0KpI/sUAabwcKdkjiNkDnXDqopFW56h064GCOtFoI0VHg2qNvTM3O9a6hwc=
X-Received: by 2002:a37:350:0:b0:69f:8c4e:9fa5 with SMTP id
 77-20020a370350000000b0069f8c4e9fa5mr18295857qkd.770.1652835589895; Tue, 17
 May 2022 17:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
 <20220512143314.235604-11-miquel.raynal@bootlin.com> <CAK-6q+jYb7A2RzG3u7PJYKZU9D5A=vben-Wnu-3EsUU-rqGT2Q@mail.gmail.com>
 <20220517153655.155ba311@xps-13> <20220517165259.52ddf6fc@xps-13>
In-Reply-To: <20220517165259.52ddf6fc@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 20:59:39 -0400
Message-ID: <CAK-6q+h=gNqoUHYi_2xamdGyMOYpO0GDO6--oKXSevJC9Wywag@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 10/11] net: mac802154: Add a warning in the
 hot path
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
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

On Tue, May 17, 2022 at 10:53 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
>
> miquel.raynal@bootlin.com wrote on Tue, 17 May 2022 15:36:55 +0200:
>
> > aahringo@redhat.com wrote on Sun, 15 May 2022 18:30:15 -0400:
> >
> > > Hi,
> > >
> > > On Thu, May 12, 2022 at 10:34 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > We should never start a transmission after the queue has been stopped.
> > > >
> > > > But because it might work we don't kill the function here but rather
> > > > warn loudly the user that something is wrong.
> > > >
> > > > Set an atomic when the queue will remain stopped. Reset this atomic when
> > > > the queue actually gets restarded. Just check this atomic to know if the
> > > > transmission is legitimate, warn if it is not.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  include/net/cfg802154.h |  1 +
> > > >  net/mac802154/tx.c      | 16 +++++++++++++++-
> > > >  net/mac802154/util.c    |  1 +
> > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > > index 8b6326aa2d42..a1370e87233e 100644
> > > > --- a/include/net/cfg802154.h
> > > > +++ b/include/net/cfg802154.h
> > > > @@ -218,6 +218,7 @@ struct wpan_phy {
> > > >         struct mutex queue_lock;
> > > >         atomic_t ongoing_txs;
> > > >         atomic_t hold_txs;
> > > > +       atomic_t queue_stopped;
> > >
> > > Maybe some test_bit()/set_bit() is better there?
> >
> > What do you mean? Shall I change the atomic_t type of queue_stopped?
> > Isn't the atomic_t preferred in this situation?
>
> Actually I re-read the doc and that's right, a regular unsigned long

Which doc is that?

- Alex

