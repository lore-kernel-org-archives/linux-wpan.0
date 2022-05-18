Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AF0C433EF
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiEROcN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 18 May 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiEROcK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 May 2022 10:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33B0513C352
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652884328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NxmFDuLsapwzf8QkP6j59BYhx83cNJvECfwJ8BgydY=;
        b=DC7qIgBVXrrbcF8ZdTqEASrTzt3RrYCZYYf7OG1m67WG8zEsgvBTS19W3rOgDASW4l2Q/y
        DDWYuUfti1MDk4c+llOA0tPBB0z6ozpvD6pnkzknY8icLJnnRJWqBAdjf1Q+3yXroJi/nL
        nAGm6VAo3dOEXGxXyuU4v5l9IZG0KNY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-GAanfFIROQeCQMS8tslv6Q-1; Wed, 18 May 2022 10:32:07 -0400
X-MC-Unique: GAanfFIROQeCQMS8tslv6Q-1
Received: by mail-qk1-f197.google.com with SMTP id o18-20020a05620a2a1200b006a0cc3d8463so1711012qkp.4
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NxmFDuLsapwzf8QkP6j59BYhx83cNJvECfwJ8BgydY=;
        b=J2p1B5Mi35AwNFa1TGi3+kjPhaZd86TjgA2h9Gemg/YXwZKhsCFU0jleA+vRz4CEU2
         ndxUo9f2cQhzEMAdcMFWXfDTp0qH+rk/NbQOvIYCWRKLOnL0o3+fTzoIPOs8utdClq/c
         P4Hl3aCNXkF5jBmTjD00fjoM+bWVqZBIIzaXiWPYa1LejSe8mW54mJQ3vUoDJfn/PpUC
         DClKVwvQWZS/2jg67oJ/yzWZoWX3rVD+H7EpmN9aiG8zxOeC0gpvf2ekIHj/bR/nS9Jr
         kNPtOq5m/Wug7cdAzcuVR2ufw7YwmD17U/omsqJ1V/zgdSpaA5kLpu5m/BLxLtXCHu8k
         mPXQ==
X-Gm-Message-State: AOAM530gmIgBiijdgtgCt2TQCzhGmjHXK7ncPmJKdsKkuVEir4mJqElE
        Oh0neAYanOAjlFKwS/z1qzDL3TUuWGnD1WbqCOCz6xZ9ZbLt+Pa4ZkLCjqdNl9HUpH3CqJ4qx8P
        UHAoDTLdFdRMulYE2przxiwg8Nc6ClruTCNmCmA==
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id a9-20020a0562140c2900b0045afedd7315mr24543809qvd.59.1652884326222;
        Wed, 18 May 2022 07:32:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb1Kg3lD6H71VYLEttsjoNdAC0Ho2U3IqJWBUvNtS6gjTzCGNPFbzEFH6DxKTolRYZO9rcaqyI+bZUmkrz2pc=
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id
 a9-20020a0562140c2900b0045afedd7315mr24543779qvd.59.1652884326024; Wed, 18
 May 2022 07:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com>
 <20220517163450.240299-11-miquel.raynal@bootlin.com> <CAK-6q+g=9_aqTOmMYxCn6p=Z=uPNyifjVXe4hzC82ZF1QPpLMg@mail.gmail.com>
 <20220518105543.54cda82f@xps-13>
In-Reply-To: <20220518105543.54cda82f@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 18 May 2022 10:31:55 -0400
Message-ID: <CAK-6q+j-EgoO-mWx_zRrORmA9-75h_=_fh22KMxySdSgeLsJEA@mail.gmail.com>
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

On Wed, May 18, 2022 at 4:55 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>
> aahringo@redhat.com wrote on Tue, 17 May 2022 20:58:19 -0400:
>
> > Hi,
> >
> > On Tue, May 17, 2022 at 12:35 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > We should never start a transmission after the queue has been stopped.
> > >
> > > But because it might work we don't kill the function here but rather
> > > warn loudly the user that something is wrong.
> > >
> > > Set an atomic when the queue will remain stopped. Reset this atomic when
> > > the queue actually gets restarded. Just check this atomic to know if the
> > > transmission is legitimate, warn if it is not.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/net/cfg802154.h |  1 +
> > >  net/mac802154/tx.c      | 16 +++++++++++++++-
> > >  net/mac802154/util.c    |  1 +
> > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index 8881b6126b58..f4e7b3fe7cf0 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -218,6 +218,7 @@ struct wpan_phy {
> > >         spinlock_t queue_lock;
> > >         atomic_t ongoing_txs;
> > >         atomic_t hold_txs;
> > > +       unsigned long queue_stopped;
> >
> > Can we name it something like state_flags (as phy state flags)? Pretty
> > sure there will be more coming, or internal_flags, no idea...
> > something_flags...
>
> 'phy_flags'? Just 'flags', maybe?

make it so.

- Alex

