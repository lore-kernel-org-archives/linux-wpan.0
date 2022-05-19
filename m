Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA8C433F5
	for <linux-wpan@archiver.kernel.org>; Thu, 19 May 2022 01:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiESBxE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 18 May 2022 21:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiESBxE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 May 2022 21:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EED0C5E55
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652925181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IjGLeBrRcw11u28Bb8tNR9LrGiBRTUJ4GJwFixtddiw=;
        b=gfwkGdvU3BlJzZl6PNf4HgoKClqpGduSlVj8m7Y6j4owl32kqBnCLCPtqDMRCZjdbBeZ3W
        50bGism35EoSB4xQtAqUR4USoTxNyYY38Cu1z1V+sprJvW+oVlJE6F0cEe8+p423x4oX3E
        fJsfOx88oSScChuwdQ89i1Wf3RN8hwI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-mAHU44ZmPgWDowWdCpne0g-1; Wed, 18 May 2022 21:53:00 -0400
X-MC-Unique: mAHU44ZmPgWDowWdCpne0g-1
Received: by mail-qv1-f69.google.com with SMTP id a12-20020a056214062c00b0045a7b4a1a29so3114919qvx.10
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 18:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjGLeBrRcw11u28Bb8tNR9LrGiBRTUJ4GJwFixtddiw=;
        b=MqUv3YPq1QHWYdwfcQldDTs2NPMwq1QFOGeLqp5jYiX4t3rfq8D2G0Bx12RM2MiKLh
         Ag4UPpyhUHOdBVGGbUDQbM3+Wi81YFN3m43ECi1mKZMQNKkZGTPRN2PnKRrd6/I3w35h
         N0tw9mtRhFPauPULjy6RzxBcOqYGOKL+Lj+Bb72NyfSoUFB7XfRAPprArVR3c+McvMjU
         RgpgTS4IgifSv9974u3D3Hg5x43hNculCnvAZW3TtzS/P8k+8KF65wsPoipDTdHJ3F0Z
         QNTqLSEUuDs/QC/yyunmrqMkxZh0ozZKZUvVvn78WwhXnOAiXYbIBq0rUdA62hjgZ++S
         ORwg==
X-Gm-Message-State: AOAM532UDw/GIuPPuCZfWFLAP2RFWPpUPn3Zzy3h2Krkg/RohQAurZk5
        pc7IYRWUuhFeA9vQS7wLZSjY7WoV/tFEs5995el2mUK8QiLQo2r/RZDWAVxGtz24DqPBxHGcI8p
        UEVzXHrpbxzhOHUJ8icwn8soxZs+2Cv/WDfQFzg==
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id a9-20020a0562140c2900b0045afedd7315mr2187506qvd.59.1652925179960;
        Wed, 18 May 2022 18:52:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk/KwXjsA45B15BsH6jVLLRSb0d2OOK/MOklJzWLaVEiA9jnKoJREiL0Y7gBXS+atdP4fKg+Pw75WVyqjl4yc=
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id
 a9-20020a0562140c2900b0045afedd7315mr2187498qvd.59.1652925179803; Wed, 18 May
 2022 18:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com>
 <20220517163450.240299-11-miquel.raynal@bootlin.com> <CAK-6q+g=9_aqTOmMYxCn6p=Z=uPNyifjVXe4hzC82ZF1QPpLMg@mail.gmail.com>
 <20220518105543.54cda82f@xps-13> <CAK-6q+j-EgoO-mWx_zRrORmA9-75h_=_fh22KMxySdSgeLsJEA@mail.gmail.com>
 <20220518182917.10323dea@xps-13>
In-Reply-To: <20220518182917.10323dea@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 18 May 2022 21:52:48 -0400
Message-ID: <CAK-6q+hudcKW4Z38bpj8FoYAMW8-Qp8BqiDtLP2wO-HN0ZpP0w@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 10/11] net: mac802154: Add a warning in the
 hot path
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 12:29 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
>
> aahringo@redhat.com wrote on Wed, 18 May 2022 10:31:55 -0400:
>
> > Hi,
> >
> > On Wed, May 18, 2022 at 4:55 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > >
> > > aahringo@redhat.com wrote on Tue, 17 May 2022 20:58:19 -0400:
> > >
> > > > Hi,
> > > >
> > > > On Tue, May 17, 2022 at 12:35 PM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > We should never start a transmission after the queue has been stopped.
> > > > >
> > > > > But because it might work we don't kill the function here but rather
> > > > > warn loudly the user that something is wrong.
> > > > >
> > > > > Set an atomic when the queue will remain stopped. Reset this atomic when
> > > > > the queue actually gets restarded. Just check this atomic to know if the
> > > > > transmission is legitimate, warn if it is not.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  include/net/cfg802154.h |  1 +
> > > > >  net/mac802154/tx.c      | 16 +++++++++++++++-
> > > > >  net/mac802154/util.c    |  1 +
> > > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > > > index 8881b6126b58..f4e7b3fe7cf0 100644
> > > > > --- a/include/net/cfg802154.h
> > > > > +++ b/include/net/cfg802154.h
> > > > > @@ -218,6 +218,7 @@ struct wpan_phy {
> > > > >         spinlock_t queue_lock;
> > > > >         atomic_t ongoing_txs;
> > > > >         atomic_t hold_txs;
> > > > > +       unsigned long queue_stopped;
> > > >
> > > > Can we name it something like state_flags (as phy state flags)? Pretty
> > > > sure there will be more coming, or internal_flags, no idea...
> > > > something_flags...
> > >
> > > 'phy_flags'? Just 'flags', maybe?
> >
> > make it so.
>
> Oh, there is already a flags entry in wpan_phy. I've adjusted the
> naming to what existed (keeping the _STATE_ prefix) and kept that
> "flags" entry instead of creating a new one.
>
make it so.

- Alex

