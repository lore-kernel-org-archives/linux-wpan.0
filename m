Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B9FC54EE9
	for <linux-wpan@archiver.kernel.org>; Fri,  9 Sep 2022 01:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIIBCp (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 8 Sep 2022 21:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIIBCo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Sep 2022 21:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4866E9020
        for <linux-wpan@vger.kernel.org>; Thu,  8 Sep 2022 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662685362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q2d3x4Dkk5GcLF+MUMfDEfqQERDFnAItNweZdV/7zYI=;
        b=SIOLTO6U7xjwbCfamYmqMfGtn8PGW6Ra96Kv31HYz57+0zkvRyMcyHGbRIqRmGlVmGfQL5
        0kI+yIE0R0Mn8FM+f5OigqtZyPRNlrqewC8wkT5n52F+11m8sLbsQyDmk2C8Yh4Wsdjr3a
        jyct33QmDoiDwREj5rFIfjVPUqrphsI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-bI-JpuqUPj-Q1dMgTTwSbw-1; Thu, 08 Sep 2022 21:02:41 -0400
X-MC-Unique: bI-JpuqUPj-Q1dMgTTwSbw-1
Received: by mail-il1-f198.google.com with SMTP id h5-20020a056e021d8500b002eb09a4f7e6so124294ila.14
        for <linux-wpan@vger.kernel.org>; Thu, 08 Sep 2022 18:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q2d3x4Dkk5GcLF+MUMfDEfqQERDFnAItNweZdV/7zYI=;
        b=ZZfNKDCfTDCGpoMlOigQwcmt6qeoznKldrp4yZYc+ieDgROUuts6m8l8qI8PF94NKo
         +MfikZADtS577NlzMO2p/G8yD0NNAoLnEkDYVEBXzr6MKO7iIn4dLAP+FkQfjPZkClHw
         kTCQF8htCR9s3rsW62sCAlRNBGGHnbzOUYxDbmPjBXONhnK60Tu4zekf8ywdCTiecO4C
         W5cm1ut81yOMRiTF+9wH4I9FDKel8p8JBVbgFZBiE+Le1A0+CzYuJcIsWdxtAMJ5bfOc
         AihsgrxdjIm817QA+OFvCKbDfnB2pbdrbjUDGU8N4UR2EXnD+lXgr8aaZXPov1Pf7x3p
         5hWw==
X-Gm-Message-State: ACgBeo0dyployTf2f0SCfyyiZd80Kog7LNsWjX1WeLTHPt2QWSVCmhDV
        v2fyNBT8ENhn4iwnCefHXAviZraq7lKVOSYna3qpeHR13f26eoNwMYM2HBprr5LhgcplfJxft51
        lgJ38i5iM8hzSJqXzSUtdXZMcSSbC9FtEfGJ2qQ==
X-Received: by 2002:a05:6638:1492:b0:34c:d42:ac2f with SMTP id j18-20020a056638149200b0034c0d42ac2fmr6215632jak.305.1662685360473;
        Thu, 08 Sep 2022 18:02:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62dyumc5VIw/U1Eq33JEOqNluH1vr9meRl5SSu5X8hz16B1yL4d4EP8X7GmqQ43clxoWwpT3zufS9SSRaedZk=
X-Received: by 2002:a05:6638:1492:b0:34c:d42:ac2f with SMTP id
 j18-20020a056638149200b0034c0d42ac2fmr6215619jak.305.1662685360286; Thu, 08
 Sep 2022 18:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220905203412.1322947-1-miquel.raynal@bootlin.com>
 <20220905203412.1322947-9-miquel.raynal@bootlin.com> <CAK-6q+jB0HQsU_wzr2T-qdGj=YSdf08DTZ0WTmRvDQt0Px7+Rg@mail.gmail.com>
In-Reply-To: <CAK-6q+jB0HQsU_wzr2T-qdGj=YSdf08DTZ0WTmRvDQt0Px7+Rg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 8 Sep 2022 21:02:29 -0400
Message-ID: <CAK-6q+g4xhqY-5HOBdYc_s4sHgZxtpZjfoN0_wXeDTKC6LmBPQ@mail.gmail.com>
Subject: Re: [PATCH wpan/next v3 8/9] net: mac802154: Ensure proper general
 purpose frame filtering
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
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

On Thu, Sep 8, 2022 at 9:00 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Sep 5, 2022 at 4:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Most of the PHYs seem to cope with the standard filtering rules by
> > default. Some of them might not, like hwsim which is only software, and
>
> yes, as I said before hwsim should pretend to be like all other
> hardware we have.
>
> > in this case advertises its real filtering level with the new
> > "filtering" internal value.
> >
> > The core then needs to check what is expected by looking at the PHY
> > requested filtering level and possibly apply additional filtering
> > rules.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/net/ieee802154_netdev.h |  8 ++++
> >  net/mac802154/rx.c              | 78 +++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >
> > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
> > index d0d188c3294b..1b82bbafe8c7 100644
> > --- a/include/net/ieee802154_netdev.h
> > +++ b/include/net/ieee802154_netdev.h
> > @@ -69,6 +69,14 @@ struct ieee802154_hdr_fc {
> >  #endif
> >  };
> >
> > +enum ieee802154_frame_version {
> > +       IEEE802154_2003_STD,
> > +       IEEE802154_2006_STD,
> > +       IEEE802154_STD,
> > +       IEEE802154_RESERVED_STD,
> > +       IEEE802154_MULTIPURPOSE_STD = IEEE802154_2003_STD,
> > +};
> > +
> >  struct ieee802154_hdr {
> >         struct ieee802154_hdr_fc fc;
> >         u8 seq;
> > diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> > index c43289c0fdd7..bc46e4a7669d 100644
> > --- a/net/mac802154/rx.c
> > +++ b/net/mac802154/rx.c
> > @@ -52,6 +52,84 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
> >                                 mac_cb(skb)->type);
> >                         goto fail;
> >                 }
> > +       } else if (sdata->required_filtering == IEEE802154_FILTERING_4_FRAME_FIELDS &&
>
> We switch here from determine that receive path, means way we are

- way

> going from interface type to the required filtering value. Sure there
> is currently a 1:1 mapping for them now but I don't know why we are
> doing that and this is in my opinion wrong. The receive path should
> depend on interface type as it was before and for scanning there is
> some early check like:
>
> if (wpan_phy_is_in_scan_mode_state(local)) {
>      do_receive_scanning(...)
>      /* don't do any other delivery because they provide it to upper layer */

In the assumption we know if the condition above is true we have
address filtering disabled.

- Alex

