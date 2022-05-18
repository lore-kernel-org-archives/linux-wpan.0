Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FEC433EF
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 13:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiERNCY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 18 May 2022 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiERNCY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 May 2022 09:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37E591A15E8
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652878940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=26+FtxAyDSee114FFzjWc880ZgZ9UasEOBq5NaLMQQw=;
        b=aLNMt60IxHt2DA30sOhFNiDGXyWL5nbF+NjRPSPqwMFBmABRL8laPFphwPu39FAMTOSG+5
        hECufc4Etk5cfsrG9GPaKp7Cg65bCRtmJP6ioclYubGo71gospWrDrYExLf77DIHI5e3Rb
        76R6vmxkaPK4pPbRfMLEuN+13jxbOeA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-s7oDfAMwOOy6TO5UGHMzbA-1; Wed, 18 May 2022 09:02:19 -0400
X-MC-Unique: s7oDfAMwOOy6TO5UGHMzbA-1
Received: by mail-qv1-f69.google.com with SMTP id 11-20020a0562140d0b00b0045aac32023fso1492606qvh.19
        for <linux-wpan@vger.kernel.org>; Wed, 18 May 2022 06:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26+FtxAyDSee114FFzjWc880ZgZ9UasEOBq5NaLMQQw=;
        b=8KgK0jIJ0UvVrvZHRBfyegiXX9O0XEsQBVk/Fh3o7fue7frmhQ8gSZ7My6e9PpNeJq
         aozaQ8+/KjdtGVIjLnbrhE/ZRl0IuJ7lF0aVvuV/eChhg+4ZSG0mNSi3jpFlWYCK5cGk
         BAeuu8G8sE5T4GWSfXdAqTGYvBniY2H4I1Wk5BFxHJ+Hrz3HN7Z5rbCXnkg0OinWsDtS
         hUtPhNvacirSVGwGk110SAl5d1Rh/7C+LjB/HULhrdSCpJgtYiVcscghvWF+OFl3Se4L
         Fwmj3MO+62wpYsQJBsZjrZDfO0nDvzB6vio1KHL3idgg27rWqj/UTk9V/zq0e6ydfsoN
         6N4Q==
X-Gm-Message-State: AOAM532lqoJEo2Xo1vy6yUzNSe42gDXYC+tz3/BZ2n5OgAIdrlMz5TKj
        kQBCfh6JfU4jYEykV1fNIm4Cq9rzqhvJ5ByMW3asmwQXRFv14cfPCjnH+GKstAWxpRVqt48OTHy
        PPdSkwcV7C+6lTdYPgnplQtonin+752kg61uutQ==
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id g2-20020a05620a40c200b006a02b1b2b86mr19835976qko.80.1652878938021;
        Wed, 18 May 2022 06:02:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnFWyk/GFoqRtsoFDMM4I4sdLDOupubSU3bNq6KIaRSKj4+PPP/KbaemKa+vrhaEm7pC3RYyUdTfgir3t456M=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id
 g2-20020a05620a40c200b006a02b1b2b86mr19835901qko.80.1652878937233; Wed, 18
 May 2022 06:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com>
 <20220517163450.240299-10-miquel.raynal@bootlin.com> <CAK-6q+jQL7cFJrL6XjuaJnNDggtO1d_sB+T+GrY9yT+Y+KC0oA@mail.gmail.com>
 <20220518104435.76f5c0d5@xps-13> <CAB_54W7bLZ8i7W-ZzQ2WXgMvywcC=tEDHZqbj1yWYuKoVgm1sw@mail.gmail.com>
 <20220518144405.3ff900ea@xps-13>
In-Reply-To: <20220518144405.3ff900ea@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 18 May 2022 09:02:06 -0400
Message-ID: <CAK-6q+iq3FPC8+bCtRRdYAT7vJuyWKc=KcfqqvT4EJRTBuOmHg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 09/11] net: mac802154: Introduce a
 synchronous API for MLME commands
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

On Wed, May 18, 2022 at 8:44 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>
> alex.aring@gmail.com wrote on Wed, 18 May 2022 07:59:37 -0400:
>
> > Hi,
> >
> > On Wed, May 18, 2022 at 4:44 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Tue, 17 May 2022 20:41:41 -0400:
> > >
> > > > Hi,
> > > >
> > > > On Tue, May 17, 2022 at 12:35 PM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > This is the slow path, we need to wait for each command to be processed
> > > > > before continuing so let's introduce an helper which does the
> > > > > transmission and blocks until it gets notified of its asynchronous
> > > > > completion. This helper is going to be used when introducing scan
> > > > > support.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  net/mac802154/ieee802154_i.h |  1 +
> > > > >  net/mac802154/tx.c           | 46 ++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 47 insertions(+)
> > > > >
> > > > > diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> > > > > index a057827fc48a..b42c6ac789f5 100644
> > > > > --- a/net/mac802154/ieee802154_i.h
> > > > > +++ b/net/mac802154/ieee802154_i.h
> > > > > @@ -125,6 +125,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
> > > > >  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
> > > > >  void ieee802154_xmit_sync_worker(struct work_struct *work);
> > > > >  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
> > > > > +int ieee802154_mlme_tx_one(struct ieee802154_local *local, struct sk_buff *skb);
> > > > >  netdev_tx_t
> > > > >  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
> > > > >  netdev_tx_t
> > > > > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > > > > index 38f74b8b6740..6cc4e5c7ba94 100644
> > > > > --- a/net/mac802154/tx.c
> > > > > +++ b/net/mac802154/tx.c
> > > > > @@ -128,6 +128,52 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
> > > > >         return ieee802154_sync_queue(local);
> > > > >  }
> > > > >
> > > > > +static int ieee802154_mlme_op_pre(struct ieee802154_local *local)
> > > > > +{
> > > > > +       return ieee802154_sync_and_hold_queue(local);
> > > > > +}
> > > > > +
> > > > > +static int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       /* Avoid possible calls to ->ndo_stop() when we asynchronously perform
> > > > > +        * MLME transmissions.
> > > > > +        */
> > > > > +       rtnl_lock();
> > > > > +
> > > > > +       /* Ensure the device was not stopped, otherwise error out */
> > > > > +       if (!local->open_count)
> > > > > +               return -EBUSY;
> > > > > +
> > > >
> > > > No -EBUSY here, use ?-ENETDOWN?.
> > >
> > > Isn't it strange to return "Network is down" while we try to stop the
> > > device but fail to do so because, actually, it is still being used?
> > >
> >
> > you are right. Maybe -EPERM, in a sense of whether the netdev state
> > allows it or not.
>
> Actually you were right in your fist review, "!open_count" means
> that the net iface is down, so returning -ENETDOWN is fine, I believe.
>
ah yes, you confused me!

- Alex

