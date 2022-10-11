Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D9FC433FE
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Oct 2022 01:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKBOI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJKBOI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Oct 2022 21:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE744DB0A
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665450846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sxFeYXoCqMMianpkw6OIwMS6oBCanEKWQTOlKjpW6i8=;
        b=a7nY41nTo9TU6FgeMzmWKGFNSNQwIyS+CEDm/45emOtbRmOo1kTQhXSeMMQ6RCBGmpR9w8
        lNsnUREJ+7SMyuNLjkuiagA+e5DKwtROH3trJwAltbyk8zyleuErzs8OqdXyUWh4dExICV
        egPX3xAHiPpoRMYYpeVCH/lUO6BSn1U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-3l6e9zPAOsOA0r50sBdrJg-1; Mon, 10 Oct 2022 21:14:04 -0400
X-MC-Unique: 3l6e9zPAOsOA0r50sBdrJg-1
Received: by mail-wm1-f72.google.com with SMTP id h10-20020a1c210a000000b003c56437e529so1218933wmh.2
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxFeYXoCqMMianpkw6OIwMS6oBCanEKWQTOlKjpW6i8=;
        b=t4jKOpmNg909jaBx0dnYalyG1av32Dts7xOhC+AqGxz+VCakJunwFRNCtYXyeZ/Gwo
         AblcZF+tubziiRdMyMGcwGRoQ/CMlCSXVkd1ROjWkUhG3QAyQqvOBiOYgQ54t1owW5jN
         gq6qm/WDqZyQd1eLgVf/3C517nW1icp8J57REoun+bBuyt62jb5VHFwqZPr4/OWCYREh
         n4E0iTY+EHDfUbuX/IY81wNC1ze5x8MQAEL5JDCzHFvaS7ZwfJ/0vx7GMiY/aUxo7M3Z
         IEhwERb+vp3ecW4btkVzSXxN+DZQDOyBLIBKVAXg0EKJb269BEfPN9ZHcECeDhEKwCNO
         AEcw==
X-Gm-Message-State: ACrzQf2OhU55IYoPSv6H9PMHLrLIZM4A2uX7nTRVJDB4rKRlOGVTWUkd
        d8YR2Jbv1oFGIGVRSVw15KzWqnUxP2hkqw4UzRwx9l9o4XmlKvrwj6wnZo1fSz0CYceT/CmBkPi
        UybGbERsx3MHDt3q8l0fpBfqiHh5dd4a8xine8w==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr13073309wrs.267.1665450843798;
        Mon, 10 Oct 2022 18:14:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6I42i/UzyW5Nbsy29VOOeuh8PZtqzXMa9Odk273V1cv2MoonD8mVEdsBDjH83e4IJTuV4P64csSuoKAck5dkw=
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id
 a16-20020adffad0000000b0022e4998fd5dmr13073292wrs.267.1665450843629; Mon, 10
 Oct 2022 18:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
 <20221007085310.503366-6-miquel.raynal@bootlin.com> <CAK-6q+iun+K8F6Mv3=WLL92iZnv-9oSnoRYtY4Zex2DZqS8ABQ@mail.gmail.com>
In-Reply-To: <CAK-6q+iun+K8F6Mv3=WLL92iZnv-9oSnoRYtY4Zex2DZqS8ABQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 10 Oct 2022 21:13:52 -0400
Message-ID: <CAK-6q+iKf5bXX+EPBw9utCpAoBVjZ678na0V_n4GUes5O=NLLw@mail.gmail.com>
Subject: Re: [PATCH wpan/next v4 5/8] ieee802154: hwsim: Implement address filtering
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

On Mon, Oct 10, 2022 at 9:04 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Fri, Oct 7, 2022 at 4:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > We have access to the address filters being theoretically applied, we
> > also have access to the actual filtering level applied, so let's add a
> > proper frame validation sequence in hwsim.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/net/ieee802154/mac802154_hwsim.c | 111 ++++++++++++++++++++++-
> >  include/net/ieee802154_netdev.h          |   8 ++
> >  2 files changed, 117 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> > index 458be66b5195..84ee948f35bc 100644
> > --- a/drivers/net/ieee802154/mac802154_hwsim.c
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/device.h>
> >  #include <linux/spinlock.h>
> > +#include <net/ieee802154_netdev.h>
> >  #include <net/mac802154.h>
> >  #include <net/cfg802154.h>
> >  #include <net/genetlink.h>
> > @@ -139,6 +140,113 @@ static int hwsim_hw_addr_filt(struct ieee802154_hw *hw,
> >         return 0;
> >  }
> >
> > +static void hwsim_hw_receive(struct ieee802154_hw *hw, struct sk_buff *skb,
> > +                            u8 lqi)
> > +{
> > +       struct ieee802154_hdr hdr;
> > +       struct hwsim_phy *phy = hw->priv;
> > +       struct hwsim_pib *pib;
> > +
> > +       rcu_read_lock();
> > +       pib = rcu_dereference(phy->pib);
> > +
> > +       if (!pskb_may_pull(skb, 3)) {
> > +               dev_dbg(hw->parent, "invalid frame\n");
> > +               goto drop;
> > +       }
> > +
> > +       memcpy(&hdr, skb->data, 3);
> > +
> > +       /* Level 4 filtering: Frame fields validity */
> > +       if (hw->phy->filtering == IEEE802154_FILTERING_4_FRAME_FIELDS) {

I see, there is this big if handling. But it accesses the
hw->phy->filtering value. It should be part of the hwsim pib setting
set by the driver callback. It is a question here of mac802154 layer
setting vs driver layer setting. We should do what the mac802154 tells
the driver to do, this way we do what the mac802154 layer is set to.

However it's a minor thing and it's okay to do it so...

- Alex

