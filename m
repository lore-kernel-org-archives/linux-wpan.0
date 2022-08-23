Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E725C32772
	for <linux-wpan@archiver.kernel.org>; Tue, 23 Aug 2022 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiHWQNT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiHWQMv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2022 12:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068125FF56
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661258025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7RL6Rg0320PkYWybc3HsS+NBLoW2T6OrM/yKT96X3M=;
        b=Q5rEGn1gIGYcZ0qNtM+NgHQxBvqWIJI3fJiZFCr3zH7HrKqaF9KaiOyZS8VDHDr6fmJs99
        gNj3RqRLew4DHiHcUm8I0ONO0r0KVFzhRLV0TP9uLW+OApeRc9om1cMyzSc+0YZ3bm7JNr
        aJPejDHhMboluXg+FoNbtJ4OORitnX4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-Vgo_CUprNdmAWdyqXkR-Iw-1; Tue, 23 Aug 2022 08:33:41 -0400
X-MC-Unique: Vgo_CUprNdmAWdyqXkR-Iw-1
Received: by mail-qt1-f198.google.com with SMTP id h19-20020ac85493000000b00343408bd8e5so10401158qtq.4
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B7RL6Rg0320PkYWybc3HsS+NBLoW2T6OrM/yKT96X3M=;
        b=Z2HOyCdfZOK7kkZxZS2qTsTvnHsRbYLGG4U934YARkuziqL5Vc6c0e9132dMkF56zb
         IqQy6IBFANavlA84q1Flqwhda9y6ic5ZILGg4iN5KSDksZjtZL6nxlRftQUHzDf71/gN
         buCFKKi5fw6oMzm2WoyalP/0EsTPBEDheYBaTXaci5G/zrYBiLkF2u8RfV4oRg2spnE7
         Lhv4LmEWP0Hbz2EqXR2+u9j6+/Z9z8aYV8bnWnc0ff4bYKZOK1SuJLO1OjnkGcSYbi6Z
         yzhrf2X3u3vZlQbIrZvcfBzUMoiUFFYlZHJbiWEpS+mpPfb7dLfQVNcQCXHf7jpfnaAP
         pz2A==
X-Gm-Message-State: ACgBeo0mwrAvZVOXtUUINNKM+0pBgIbZxHK8DmL/TQQLYG6aHF4PNOhn
        lTrXLUeVWZ1+HfT9YrYJ0gs+ZuJQ8/x5lvLASUKOD9SNQ1tHOUThXf2Oju4nwU5MNNdZ0L7swEY
        m4x8TYg+oLJTzzLptMqMzMZGuS/5hG6B+WPRFig==
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id x4-20020a05622a000400b0034494b7a396mr17581279qtw.123.1661258021290;
        Tue, 23 Aug 2022 05:33:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DEr3LfrwPuNYexjcOCXXipt4XIghkH+zsbEOeIMCpBNb36NC7B8V5o+6weiNXQjfZqp1n3QnxlpxCQyPZdao=
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id
 x4-20020a05622a000400b0034494b7a396mr17581261qtw.123.1661258021051; Tue, 23
 Aug 2022 05:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-2-miquel.raynal@bootlin.com> <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
 <20220819191109.0e639918@xps-13>
In-Reply-To: <20220819191109.0e639918@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 23 Aug 2022 08:33:30 -0400
Message-ID: <CAK-6q+gCY3ufaADHNQWJGNpNZJMwm=fhKfe02GWkfGEdgsMVzg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 01/20] net: mac802154: Allow the creation of
 coordinator interfaces
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

On Fri, Aug 19, 2022 at 1:11 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Tue, 5 Jul 2022 21:51:02 -0400:
>
> > Hi,
> >
> > On Fri, Jul 1, 2022 at 10:36 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > As a first strep in introducing proper PAN management and association,
> > > we need to be able to create coordinator interfaces which might act as
> > > coordinator or PAN coordinator.
> > >
> > > Hence, let's add the minimum support to allow the creation of these
> > > interfaces. This might be restrained and improved later.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  net/mac802154/iface.c | 14 ++++++++------
> > >  net/mac802154/rx.c    |  2 +-
> > >  2 files changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> > > index 500ed1b81250..7ac0c5685d3f 100644
> > > --- a/net/mac802154/iface.c
> > > +++ b/net/mac802154/iface.c
> > > @@ -273,13 +273,13 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
> > >                 if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
> > >                         int ret;
> > >
> > > -                       /* TODO currently we don't support multiple node types
> > > -                        * we need to run skb_clone at rx path. Check if there
> > > -                        * exist really an use case if we need to support
> > > -                        * multiple node types at the same time.
> > > +                       /* TODO currently we don't support multiple node/coord
> > > +                        * types we need to run skb_clone at rx path. Check if
> > > +                        * there exist really an use case if we need to support
> > > +                        * multiple node/coord types at the same time.
> > >                          */
> > > -                       if (wpan_dev->iftype == NL802154_IFTYPE_NODE &&
> > > -                           nsdata->wpan_dev.iftype == NL802154_IFTYPE_NODE)
> > > +                       if (wpan_dev->iftype != NL802154_IFTYPE_MONITOR &&
> > > +                           nsdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR)
> > >                                 return -EBUSY;
> > >
> > >                         /* check all phy mac sublayer settings are the same.
> > > @@ -577,6 +577,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
> > >         wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
> > >
> > >         switch (type) {
> > > +       case NL802154_IFTYPE_COORD:
> > >         case NL802154_IFTYPE_NODE:
> > >                 ieee802154_be64_to_le64(&wpan_dev->extended_addr,
> > >                                         sdata->dev->dev_addr);
> > > @@ -636,6 +637,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
> > >         ieee802154_le64_to_be64(ndev->perm_addr,
> > >                                 &local->hw.phy->perm_extended_addr);
> > >         switch (type) {
> > > +       case NL802154_IFTYPE_COORD:
> > >         case NL802154_IFTYPE_NODE:
> > >                 ndev->type = ARPHRD_IEEE802154;
> > >                 if (ieee802154_is_valid_extended_unicast_addr(extended_addr)) {
> > > diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> > > index b8ce84618a55..39459d8d787a 100644
> > > --- a/net/mac802154/rx.c
> > > +++ b/net/mac802154/rx.c
> > > @@ -203,7 +203,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
> > >         }
> > >
> > >         list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> > > -               if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE)
> > > +               if (sdata->wpan_dev.iftype == NL802154_IFTYPE_MONITOR)
> > >                         continue;
> >
> > I probably get why you are doing that, but first the overall design is
> > working differently - means you should add an additional receive path
> > for the special interface type.
> >
> > Also we "discovered" before that the receive path of node vs
> > coordinator is different... Where is the different handling here? I
> > don't see it, I see that NODE and COORD are the same now (because that
> > is _currently_ everything else than monitor). This change is not
> > enough and does "something" to handle in some way coordinator receive
> > path but there are things missing.
> >
> > 1. Changing the address filters that it signals the transceiver it's
> > acting as coordinator
> > 2. We _should_ also have additional handling for whatever the
> > additional handling what address filters are doing in mac802154
> > _because_ there is hardware which doesn't have address filtering e.g.
> > hwsim which depend that this is working in software like other
> > transceiver hardware address filters.
> >
> > For the 2. one, I don't know if we do that even for NODE right or we
> > just have the bare minimal support there... I don't assume that
> > everything is working correctly here but what I want to see is a
> > separate receive path for coordinators that people can send patches to
> > fix it.
>
> Yes, we do very little differently between the two modes, that's why I
> took the easy way: just changing the condition. I really don't see what
> I can currently add here, but I am fine changing the style to easily
> show people where to add filters for such or such interface, but right
> now both path will look very "identical", do we agree on that?

mostly yes, but there exists a difference and we should at least check
if the node receive path violates the coordinator receive path and
vice versa.
Put it in a receive_path() function and then coord_receive_path(),
node_receive_path() that calls the receive_path() and do the
additional filtering for coordinators, etc.

There should be a part in the standard about "third level filter rule
if it's a coordinator".
btw: this is because the address filter on the transceiver needs to
have the "i am a coordinator" boolean set which is missing in this
series. However it depends on the transceiver filtering level and the
mac802154 receive path if we actually need to run such filtering or
not.

- Alex

