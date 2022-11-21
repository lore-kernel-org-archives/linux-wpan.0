Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74440C433FE
	for <linux-wpan@archiver.kernel.org>; Mon, 21 Nov 2022 00:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKUA6k (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKUA6j (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Nov 2022 19:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B861580E
        for <linux-wpan@vger.kernel.org>; Sun, 20 Nov 2022 16:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668992265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jxsIXFYclf8wtFWpCZq4TUf3EVT0jNWhKh/5TSvsdz4=;
        b=FagYOw+UIq6h6+CzbSvBJbUWZK2E91orz5vF1xBmWwSC1gDGU9HtHKn0OXoXkeAXUAvYkO
        +M5dGN6ye1Xi6iN7d8SCdZ6JtUK+jw+jlAflCbAyVlVp1sFAfvs8ck0i9yewtsvmveAbYc
        FR3E2dsRf500fc/AMNK9ZumKd4tX4u4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-l1uvE1-6NwybH1IYMGxK2A-1; Sun, 20 Nov 2022 19:57:43 -0500
X-MC-Unique: l1uvE1-6NwybH1IYMGxK2A-1
Received: by mail-ej1-f70.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so5731630ejc.11
        for <linux-wpan@vger.kernel.org>; Sun, 20 Nov 2022 16:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxsIXFYclf8wtFWpCZq4TUf3EVT0jNWhKh/5TSvsdz4=;
        b=yYinPUxXzBo0cjqZREoomSmQpyh3Eyk7HJwUykFcOAckcfZHXXjcGt5ag7Rglbuicb
         MYg8xnK6bEW395Kyk/S+glnz0y0UF0QsrUcaB7lpxVqKPTM7jccRvrQWeRbxAlkYkYq2
         l24wDRp6lPy2fRERhszk9UM588Nyg/BvQ3syMWoUuNCsUNJRKavySdujeRk0dA5JI9Cp
         2FVQyxhWvZaliT1CQh+6cVNHHXxM2iYclkSnzWXWi7um/v9A7+U1MnqejyJsz6LU3I6J
         mkZwJj2PoFRZXy+ahsKjCOfl0xZSJXLIZf97lBPfL6AScrJZv7ES6PpEuQEHGSx3AvuN
         eR5Q==
X-Gm-Message-State: ANoB5pk1fx88+5sdYd056IXx/ZJUkeShFvOLp1rnSSx7iLYTrTIHRI0e
        miG2XdTDzw32kK0E6cqE+zO9tleGgnt8Kvz213Mu8UXB5v1zTUgopSRWcJ5LN4Fq4L+ZAXM3IRX
        Krpse9qKCEyUPFzd1Ev9aquma5QelCB+KN9tJgQ==
X-Received: by 2002:a17:906:130b:b0:7ad:92c5:637a with SMTP id w11-20020a170906130b00b007ad92c5637amr13559316ejb.87.1668992262594;
        Sun, 20 Nov 2022 16:57:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jGW9ht2OhWbXj3/aT0aHIfYQ3nkHk3hKufg7dp2B4QMWK9Jyv/D0II23Ji7H+emF+AYTb9mfnxzDCeQBYEqw=
X-Received: by 2002:a17:906:130b:b0:7ad:92c5:637a with SMTP id
 w11-20020a170906130b00b007ad92c5637amr13559307ejb.87.1668992262364; Sun, 20
 Nov 2022 16:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20221102151915.1007815-1-miquel.raynal@bootlin.com>
 <20221102151915.1007815-2-miquel.raynal@bootlin.com> <CAK-6q+iSzRyDDiNusXiRWvUsS5dSS5bSzAtNjSLTt6kgaxtbHg@mail.gmail.com>
 <20221118230443.2e5ba612@xps-13>
In-Reply-To: <20221118230443.2e5ba612@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 20 Nov 2022 19:57:31 -0500
Message-ID: <CAK-6q+jJKoFy359_Pd4_d+EfqLw4PTdG4F7H4u+URD=UKu9k6w@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/3] ieee802154: Advertize coordinators discovery
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Nov 18, 2022 at 5:04 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 6 Nov 2022 21:01:35 -0500:
>
> > Hi,
> >
> > On Wed, Nov 2, 2022 at 11:20 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Let's introduce the basics for advertizing discovered PANs and
> > > coordinators, which is:
> > > - A new "scan" netlink message group.
> > > - A couple of netlink command/attribute.
> > > - The main netlink helper to send a netlink message with all the
> > >   necessary information to forward the main information to the user.
> > >
> > > Two netlink attributes are proactively added to support future UWB
> > > complex channels, but are not actually used yet.
> > >
> > > Co-developed-by: David Girault <david.girault@qorvo.com>
> > > Signed-off-by: David Girault <david.girault@qorvo.com>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/net/cfg802154.h   |  20 +++++++
> > >  include/net/nl802154.h    |  44 ++++++++++++++
> > >  net/ieee802154/nl802154.c | 121 ++++++++++++++++++++++++++++++++++++++
> > >  net/ieee802154/nl802154.h |   6 ++
> > >  4 files changed, 191 insertions(+)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index e1481f9cf049..8d67d9ed438d 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -260,6 +260,26 @@ struct ieee802154_addr {
> > >         };
> > >  };
> > >
> > > +/**
> > > + * struct ieee802154_coord_desc - Coordinator descriptor
> > > + * @coord: PAN ID and coordinator address
> > > + * @page: page this coordinator is using
> > > + * @channel: channel this coordinator is using
> > > + * @superframe_spec: SuperFrame specification as received
> > > + * @link_quality: link quality indicator at which the beacon was received
> > > + * @gts_permit: the coordinator accepts GTS requests
> > > + * @node: list item
> > > + */
> > > +struct ieee802154_coord_desc {
> > > +       struct ieee802154_addr *addr;
> >
> > Why is this a pointer?
>
> No reason anymore, I've changed this member to be a regular structure.
>

ok.

> >
> > > +       u8 page;
> > > +       u8 channel;
> > > +       u16 superframe_spec;
> > > +       u8 link_quality;
> > > +       bool gts_permit;
> > > +       struct list_head node;
> > > +};
> > > +
> > >  struct ieee802154_llsec_key_id {
> > >         u8 mode;
> > >         u8 id;
> > > diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> > > index 145acb8f2509..cfe462288695 100644
> > > --- a/include/net/nl802154.h
> > > +++ b/include/net/nl802154.h
> > > @@ -58,6 +58,9 @@ enum nl802154_commands {
> > >
> > >         NL802154_CMD_SET_WPAN_PHY_NETNS,
> > >
> > > +       NL802154_CMD_NEW_COORDINATOR,
> > > +       NL802154_CMD_KNOWN_COORDINATOR,
> > > +
> >
> > NEW is something we never saw before and KNOWN we already saw before?
> > I am not getting that when I just want to maintain a list in the user
> > space and keep them updated, but I think we had this discussion
> > already or? Currently they do the same thing, just the command is
> > different. The user can use it to filter NEW and KNOWN? Still I am not
> > getting it why there is not just a start ... event, event, event ....
> > end. and let the user decide if it knows that it's new or old from its
> > perspective.
>
> Actually we already discussed this once and I personally liked more to
> handle this in the kernel, but you seem to really prefer letting the
> user space device whether or not the beacon is a new one or not, so
> I've updated both the kernel side and the userspace side to act like
> this.
>

I thought there was some problem about when the "scan-op" is running
and there could be the case that the discovered PANs are twice there,
but this looks more like handling UAPI features as separate new and
old ones? I can see that there can be a need for the first case?

> >
> > >         /* add new commands above here */
> > >
> > >  #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> > > @@ -133,6 +136,8 @@ enum nl802154_attrs {
> > >         NL802154_ATTR_PID,
> > >         NL802154_ATTR_NETNS_FD,
> > >
> > > +       NL802154_ATTR_COORDINATOR,
> > > +
> > >         /* add attributes here, update the policy in nl802154.c */
> > >
> > >  #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> > > @@ -218,6 +223,45 @@ enum nl802154_wpan_phy_capability_attr {
> > >         NL802154_CAP_ATTR_MAX = __NL802154_CAP_ATTR_AFTER_LAST - 1
> > >  };
> > >
> > > +/**
> > > + * enum nl802154_coord - Netlink attributes for a coord
> > > + *
> > > + * @__NL802154_COORD_INVALID: invalid
> > > + * @NL802154_COORD_PANID: PANID of the coordinator (2 bytes)
> > > + * @NL802154_COORD_ADDR: coordinator address, (8 bytes or 2 bytes)
> > > + * @NL802154_COORD_CHANNEL: channel number, related to @NL802154_COORD_PAGE (u8)
> > > + * @NL802154_COORD_PAGE: channel page, related to @NL802154_COORD_CHANNEL (u8)
> > > + * @NL802154_COORD_PREAMBLE_CODE: Preamble code used when the beacon was received,
> > > + *     this is PHY dependent and optional (u8)
> > > + * @NL802154_COORD_MEAN_PRF: Mean PRF used when the beacon was received,
> > > + *     this is PHY dependent and optional (u8)
> > > + * @NL802154_COORD_SUPERFRAME_SPEC: superframe specification of the PAN (u16)
> > > + * @NL802154_COORD_LINK_QUALITY: signal quality of beacon in unspecified units,
> > > + *     scaled to 0..255 (u8)
> > > + * @NL802154_COORD_GTS_PERMIT: set to true if GTS is permitted on this PAN
> > > + * @NL802154_COORD_PAYLOAD_DATA: binary data containing the raw data from the
> > > + *     frame payload, (only if beacon or probe response had data)
> > > + * @NL802154_COORD_PAD: attribute used for padding for 64-bit alignment
> > > + * @NL802154_COORD_MAX: highest coordinator attribute
> > > + */
> > > +enum nl802154_coord {
> > > +       __NL802154_COORD_INVALID,
> > > +       NL802154_COORD_PANID,
> > > +       NL802154_COORD_ADDR,
> > > +       NL802154_COORD_CHANNEL,
> > > +       NL802154_COORD_PAGE,
> > > +       NL802154_COORD_PREAMBLE_CODE,
> >
> > Interesting, if you do a scan and discover pans and others answers I
> > would think you would see only pans on the same preamble. How is this
> > working?
>
> Yes this is how it is working, you only see PANs on one preamble at a
> time. That's why we need to tell on which preamble we received the
> beacon.
>

But then I don't know how you want to change the preamble while
scanning? I know there are registers for changing the preamble and I
thought that is a vendor specific option. However I am not an expert
to judge if it's needed or not, but somehow curious how it's working.

NOTE: that the preamble is so far I know (and makes sense for me)
_always_ filtered on PHY side.

> >
> > > +       NL802154_COORD_MEAN_PRF,
> > > +       NL802154_COORD_SUPERFRAME_SPEC,
> > > +       NL802154_COORD_LINK_QUALITY,
> >
> > not against it to have it, it's fine. I just think it is not very
> > useful. A way to dump all LQI values with some timestamp and having
> > something in user space to collect stats and do some heuristic may be
> > better?
>
> Actually I really like seeing this in the event logs in userspace, so if
> you don't mind I'll keep this parameter. It can safely be ignored by the
> userspace anyway, so I guess it does not hurt.
>

ok.

- Alex

