Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F99DC433FE
	for <linux-wpan@archiver.kernel.org>; Sun, 16 Oct 2022 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJPBAN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 15 Oct 2022 21:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJPBAM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Oct 2022 21:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E42C12A
        for <linux-wpan@vger.kernel.org>; Sat, 15 Oct 2022 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665882009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYsQV77jSVZ1xo/DJ7SyfJsKSPF5nuGhpJ71epheuCI=;
        b=bx0VOb3OP6AQkaQ9mGu59n22wbGpKKh5Jom/6o5tDlijSsJ7EKxivC9XcCCMsIpxyKctMT
        fKDvnJPIAr7bJBzrt8QE18BY0UA4QwKhwYapFa4vrl5jRqaScTfrDMmWCWHys5p/D0wJ/l
        CzXSFZunI4oPu6drLMkC/Hhf+IOzyvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139--LSOLVt0NTu_IJg0z7fmtg-1; Sat, 15 Oct 2022 21:00:08 -0400
X-MC-Unique: -LSOLVt0NTu_IJg0z7fmtg-1
Received: by mail-wm1-f69.google.com with SMTP id i5-20020a1c3b05000000b003c47c8569easo7124294wma.1
        for <linux-wpan@vger.kernel.org>; Sat, 15 Oct 2022 18:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYsQV77jSVZ1xo/DJ7SyfJsKSPF5nuGhpJ71epheuCI=;
        b=gDUlnvWsGJu48aUJEFFJ8Nko7u0ZhKJyNaKcEuhTuhU+RScoW6YecHs+Mbhqph76Q/
         5JDtySoDuURk3OwEFFr3pIAMqJ7mGV4axEe32pBwdSPB4qd7z+uL9+eQvRXtP5KW6J81
         qIOF5XBGTFZ4n5FoJCifLwqPwSTXDOlPA61OBxX9b/Z3x9B3mkMKS688y3wCO7vTvyuP
         IpeeIzW1YaMykVhvokWCqvWyVzM5Ajr7Qh7U2Q+vA3LUm31WbvOk9DhYQgkDiPf5uVgx
         sEMBnBlbHkFWI+kSUhQzKlsUiTE6CtiY9VTYug89MPvHGDZPRDjsKuyjIjGzGeSYZHLW
         yl2Q==
X-Gm-Message-State: ACrzQf2meCLKk1NnmJgaDIfHKNewWUlFJOGux0FGNr3aMB6g6xzmg8wD
        lkQGzSrx7e1CjIEH5Lk5iS6r9I6m09/cBK7hEaIuHTkyJkixfUpW926EnmkKfAqSZRYOEcXT5OL
        GEI4hB8EPBk54toSg11wY8mxEFdXgZID+fuDQKA==
X-Received: by 2002:a05:600c:510e:b0:3b4:fed8:e65c with SMTP id o14-20020a05600c510e00b003b4fed8e65cmr2883873wms.93.1665882007006;
        Sat, 15 Oct 2022 18:00:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66HPDxlXvYzsqrga5jABjfOB5xiJMXx7sbgnn4jYzeoaIdfmXlF6XrUgOtw9Z8Dmo+83EndNOj/1gwm66a0gw=
X-Received: by 2002:a05:600c:510e:b0:3b4:fed8:e65c with SMTP id
 o14-20020a05600c510e00b003b4fed8e65cmr2883860wms.93.1665882006813; Sat, 15
 Oct 2022 18:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
 <20221007085310.503366-6-miquel.raynal@bootlin.com> <CAK-6q+iun+K8F6Mv3=WLL92iZnv-9oSnoRYtY4Zex2DZqS8ABQ@mail.gmail.com>
 <CAK-6q+iKf5bXX+EPBw9utCpAoBVjZ678na0V_n4GUes5O=NLLw@mail.gmail.com>
 <CAK-6q+hO1AFzdH_DRYVM77VJhotsoeiBzqL0o7ND7sPYJhSrbQ@mail.gmail.com> <20221012155828.5a5cade8@xps-13>
In-Reply-To: <20221012155828.5a5cade8@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 15 Oct 2022 20:59:55 -0400
Message-ID: <CAK-6q+jAr9qFY6dB6tYuycHyMNX=Ge9k4sJS38O_eRdvgLhnAA@mail.gmail.com>
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

On Sat, Oct 15, 2022 at 4:59 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Mon, 10 Oct 2022 21:21:17 -0400:
>
> > Hi,
> >
> > On Mon, Oct 10, 2022 at 9:13 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Oct 10, 2022 at 9:04 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Oct 7, 2022 at 4:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > We have access to the address filters being theoretically applied, we
> > > > > also have access to the actual filtering level applied, so let's add a
> > > > > proper frame validation sequence in hwsim.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  drivers/net/ieee802154/mac802154_hwsim.c | 111 ++++++++++++++++++++++-
> > > > >  include/net/ieee802154_netdev.h          |   8 ++
> > > > >  2 files changed, 117 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> > > > > index 458be66b5195..84ee948f35bc 100644
> > > > > --- a/drivers/net/ieee802154/mac802154_hwsim.c
> > > > > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > > > > @@ -18,6 +18,7 @@
> > > > >  #include <linux/netdevice.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/spinlock.h>
> > > > > +#include <net/ieee802154_netdev.h>
> > > > >  #include <net/mac802154.h>
> > > > >  #include <net/cfg802154.h>
> > > > >  #include <net/genetlink.h>
> > > > > @@ -139,6 +140,113 @@ static int hwsim_hw_addr_filt(struct ieee802154_hw *hw,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static void hwsim_hw_receive(struct ieee802154_hw *hw, struct sk_buff *skb,
> > > > > +                            u8 lqi)
> > > > > +{
> > > > > +       struct ieee802154_hdr hdr;
> > > > > +       struct hwsim_phy *phy = hw->priv;
> > > > > +       struct hwsim_pib *pib;
> > > > > +
> > > > > +       rcu_read_lock();
> > > > > +       pib = rcu_dereference(phy->pib);
> > > > > +
> > > > > +       if (!pskb_may_pull(skb, 3)) {
> > > > > +               dev_dbg(hw->parent, "invalid frame\n");
> > > > > +               goto drop;
> > > > > +       }
> > > > > +
> > > > > +       memcpy(&hdr, skb->data, 3);
> > > > > +
> > > > > +       /* Level 4 filtering: Frame fields validity */
> > > > > +       if (hw->phy->filtering == IEEE802154_FILTERING_4_FRAME_FIELDS) {
> > >
> > > I see, there is this big if handling. But it accesses the
> > > hw->phy->filtering value. It should be part of the hwsim pib setting
> > > set by the driver callback. It is a question here of mac802154 layer
> > > setting vs driver layer setting. We should do what the mac802154 tells
> > > the driver to do, this way we do what the mac802154 layer is set to.
> > >
> > > However it's a minor thing and it's okay to do it so...
> >
> > * whereas we never let the driver know at any time of what different
> > filter levels exist _currently_ we have only the promiscuous mode
> > on/off switch which is do nothing or 4_FRAME_FIELDS.
> > It will work for now, changing anything in the mac802154 filtering
> > fields or something will end in probably breakage in this handling. In
> > my point of view as the current state is it should not do that, as
> > remember that hwsim will "simulate" hardware it should not be able to
> > access mac802154 fields (especially when doing receiving of frames) as
> > other hardware will only set register bits (as hwsim pib values is
> > there for)...
> >
> > Still I think it's fine for now.
>
> I see your point, indeed I could have added another PIB attribute
> instead of accessing the PHY state.
>
> I am fine doing it in a followup patch if this what you prefer. Shall I
> do it?

okay, note that you did it right with the address filter patches by
copying them from the drivers-ops.

- Alex

