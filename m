Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF0C32789
	for <linux-wpan@archiver.kernel.org>; Tue, 23 Aug 2022 16:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbiHWQXQ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbiHWQWn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2022 12:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC990815
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661258650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1QR7/fEkSEGvtR9cdL+cMtMgSlf4RLGbFttX75oGMA=;
        b=hgIltdZnr9HWCnOOdDiqiSfkTvzyx2R5Lkdz4eSwBNWUtVXSVaqLj8u4GypJ1itSDg6e+x
        3IDRj1UfksM/dsdfmDrdXs2ntzIsswT5UduhOipKXh9x7o0MFU76PHrPohsG78yiYdI2O2
        BnVJL85fKUocpZC2xGvl2lYEFFT2jVQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-fd0RDKdoNS6WAvwCIIJmIg-1; Tue, 23 Aug 2022 08:44:09 -0400
X-MC-Unique: fd0RDKdoNS6WAvwCIIJmIg-1
Received: by mail-qv1-f72.google.com with SMTP id cv17-20020ad44d91000000b00496b9fdf13bso7279797qvb.22
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N1QR7/fEkSEGvtR9cdL+cMtMgSlf4RLGbFttX75oGMA=;
        b=EAdL9Y+SeB7SnpFj9Ci8LGTblmp+4Hmhf8FB0GkWmkABfNcxEjRMiQVxD6TkBumIF2
         4z5QXd+sySrdHxd0NSDxBJiqHscRnRoAUMBSbAnDGNoSc4fY5ZwivTbAoNgt8LrQMkvZ
         n/I14kx1ZF/SAxqTdLtU5MqIeqlP8P/+0wl6aXPVl7pFz0NNXFzQ9xydqTlTE1DJP1vt
         XrJSRZ8XoXrjte50HFi1VEl4aWZTunhom68mnbvpofmz0jlkqreiYEfBxiGY01YoZ14U
         KlWhi4Ll4F5/UMFBk1vnsUS9ia7hduNcSeMpZuAOiX7bHtPIKzzxyaXMcm3uO67/VBzG
         PJ3g==
X-Gm-Message-State: ACgBeo2emX+/QqQIx5EkptpLzmbCO/9J8bWiB4K/EC83zX3IPbcOAqrA
        wh1e4W6O86HWnwzGQj/fxquttN7IYi95L9hWEVlAbhoFH6tPr+IqHuI31vDNrC+d8s/CsLXh4ta
        s5N4yKL/Qd5JtaW/HFdXEsNEqJ8KAlu6SCD8smw==
X-Received: by 2002:a37:b741:0:b0:6b9:3b67:d0a7 with SMTP id h62-20020a37b741000000b006b93b67d0a7mr15353201qkf.770.1661258649009;
        Tue, 23 Aug 2022 05:44:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6KweMoriQTnzj4bnDSdUC0ausC1ixTLBAZJs1rzMT28/lX0LmWpmYCqZFNCfTj7g42M1xViFj9SYYbBbJHl68=
X-Received: by 2002:a37:b741:0:b0:6b9:3b67:d0a7 with SMTP id
 h62-20020a37b741000000b006b93b67d0a7mr15353188qkf.770.1661258648785; Tue, 23
 Aug 2022 05:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-18-miquel.raynal@bootlin.com> <CAK-6q+ifj5DNrq31qjjyk3OoAsf0+LuBttM5o8Rs8Pt_TA_JMg@mail.gmail.com>
 <20220819191315.387ba71b@xps-13>
In-Reply-To: <20220819191315.387ba71b@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 23 Aug 2022 08:43:58 -0400
Message-ID: <CAK-6q+inCxP_wCWw8VCHXCETB7QqPYRw5L3c+gF4CSTKYO9Mjg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 17/20] net: ieee802154: Handle limited devices
 with only datagram support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
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

On Fri, Aug 19, 2022 at 1:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Thu, 14 Jul 2022 23:16:33 -0400:
>
> > Hi,
> >
> > On Fri, Jul 1, 2022 at 10:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Some devices, like HardMAC ones can be a bit limited in the way they
> > > handle mac commands. In particular, they might just not support it at
> > > all and instead only be able to transmit and receive regular data
> > > packets. In this case, they cannot be used for any of the internal
> > > management commands that we have introduced so far and must be flagged
> > > accordingly.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/net/cfg802154.h   | 3 +++
> > >  net/ieee802154/nl802154.c | 6 ++++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index d6ff60d900a9..20ac4df9dc7b 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -178,12 +178,15 @@ wpan_phy_cca_cmp(const struct wpan_phy_cca *a, const struct wpan_phy_cca *b)
> > >   *     setting.
> > >   * @WPAN_PHY_FLAG_STATE_QUEUE_STOPPED: Indicates that the transmit queue was
> > >   *     temporarily stopped.
> > > + * @WPAN_PHY_FLAG_DATAGRAMS_ONLY: Indicates that transceiver is only able to
> > > + *     send/receive datagrams.
> > >   */
> > >  enum wpan_phy_flags {
> > >         WPAN_PHY_FLAG_TXPOWER           = BIT(1),
> > >         WPAN_PHY_FLAG_CCA_ED_LEVEL      = BIT(2),
> > >         WPAN_PHY_FLAG_CCA_MODE          = BIT(3),
> > >         WPAN_PHY_FLAG_STATE_QUEUE_STOPPED = BIT(4),
> > > +       WPAN_PHY_FLAG_DATAGRAMS_ONLY    = BIT(5),
> > >  };
> > >
> > >  struct wpan_phy {
> > > diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> > > index 00b03c33e826..b31a0bd36b08 100644
> > > --- a/net/ieee802154/nl802154.c
> > > +++ b/net/ieee802154/nl802154.c
> > > @@ -1404,6 +1404,9 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
> > >         if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > >                 return -EPERM;
> > >
> > > +       if (wpan_phy->flags & WPAN_PHY_FLAG_DATAGRAMS_ONLY)
> > > +               return -EOPNOTSUPP;
> > > +
> >
> > for doing a scan it's also required to turn the transceiver into
> > promiscuous mode, right?
> >
> > There is currently a flag if a driver supports promiscuous mode or
> > not... I am not sure if all drivers have support for it. For me it
> > looks like a mandatory feature but I am not sure if every driver
> > supports it.
> > We have a similar situation with acknowledge retransmit handling...
> > some transceivers can't handle it and for normal dataframes we have a
> > default behaviour that we don't set it. However sometimes it's
> > required by the spec, then we can't do anything here.
> >
> > I think we should check on it but we should plan to drop this flag if
> > promiscuous mode is supported or not.
>
> Yes, you are right, I should check this flag is set, I will do it at
> the creation of the MONITOR interface, which anyway does not make sense
> if the device has no filtering support (promiscuous being a very
> standard one, but, as you said below, will later be replaced by some
> more advanced levels).
>
> > I also think that the
> > promiscuous driver_ops should be removed and moved as a parameter for
> > start() driver_ops to declare which "receive mode" should be
> > enabled... but we can do that in due course.
>
> Agreed.

We need to keep in mind that hwsim is a transceiver which only can run
in promiscuous mode and all receive paths need to be aware of this.
Yes, we can do that by saying on the ieee802154_rx() it always
receives frames in promiscuous mode and mac802154 does all the
filtering. I have the feeling there needs to be more done, because the
driver op to run into promiscuous mode and the mac802154 layer thinks
it's not BUT hwsim was it all the time. :-/

- Alex

