Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BDC4332F
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Oct 2022 01:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJKBVo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKBVd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Oct 2022 21:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF28284B
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665451291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+misfQ+bW0o79zjyOXdn/CEgg4ZD9ZtYFv9XAoRda/M=;
        b=eUdnrZ0djb1pvDnix8aGt0DkIn9D/roNJAILzWdXxFZpWMoxJnmbdbp3GAkTdDOjo25Wiv
        TIAC2LWb0LcqTzzFSSiS7eXNOiXe61kvFuwb60RiyoYCIF67xIIxJFC/lY3RIXpi4pNh6X
        gQsZsW7uIO9rNdFmZk6/1qbZpjIfkiU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-Golj1wqGOL-Zvf_MucUzOA-1; Mon, 10 Oct 2022 21:21:30 -0400
X-MC-Unique: Golj1wqGOL-Zvf_MucUzOA-1
Received: by mail-wm1-f70.google.com with SMTP id v125-20020a1cac83000000b003bd44dc5242so9799959wme.7
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+misfQ+bW0o79zjyOXdn/CEgg4ZD9ZtYFv9XAoRda/M=;
        b=meK8oY2bvhyn6AdqImySCmFyvTfuxyqtgO42hbpUT/rcbWLdnNvG5XLPwWi76r9ndn
         RF+3YOqaRCn+x3SaMvZD/ie961OZL+KOFCh63Yn8d8YJ5L6Fl0tLiTvfHD4SaTDrtA5y
         e9mNGf4/OXOYlVUDX45znx+9bUPUSc/WwPHLf5iwiqEs5XHLtzkWKKGiiilQ76PL/qH8
         Sl+6mfPFoYL6Ykh7jIctQPubL+TS9LPbpWu6x/j8G9uapa6wpKr8iVL8UILfLt796rXW
         NsnL9iv57FKkYU0noQaPZw7cX979IrSzfHrXpe6mtLKb+4iPOB576E8F2HmhZUDK6Qxg
         OMXQ==
X-Gm-Message-State: ACrzQf2antHwPVl4PEkpKz1gOAxH3rgl3HbKGqpFkuP41rwtmKhKGfNI
        osbZRdc8yH7O2XyTHbW0ZVhFV2EmQPKj5tzMAxxkKP9oQ+LKjm1PCvfMo43wIEw3b6YOX00wXDe
        o+puVB57nmNdAO/Ef8SmkhyfJg7uk72N9EDPjxw==
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id b21-20020a05600c4e1500b003b4a621b54emr14317965wmq.47.1665451288839;
        Mon, 10 Oct 2022 18:21:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6IGUL+GEoSX2BvlhjlqlBPsCtEuK1ysbTlwfH49TFoOivzsSWw4TzZ4oRerp+8LPfkTJK4QbMzlm/W63HFRmw=
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id
 b21-20020a05600c4e1500b003b4a621b54emr14317956wmq.47.1665451288674; Mon, 10
 Oct 2022 18:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
 <20221007085310.503366-6-miquel.raynal@bootlin.com> <CAK-6q+iun+K8F6Mv3=WLL92iZnv-9oSnoRYtY4Zex2DZqS8ABQ@mail.gmail.com>
 <CAK-6q+iKf5bXX+EPBw9utCpAoBVjZ678na0V_n4GUes5O=NLLw@mail.gmail.com>
In-Reply-To: <CAK-6q+iKf5bXX+EPBw9utCpAoBVjZ678na0V_n4GUes5O=NLLw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 10 Oct 2022 21:21:17 -0400
Message-ID: <CAK-6q+hO1AFzdH_DRYVM77VJhotsoeiBzqL0o7ND7sPYJhSrbQ@mail.gmail.com>
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

On Mon, Oct 10, 2022 at 9:13 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Oct 10, 2022 at 9:04 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 7, 2022 at 4:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > We have access to the address filters being theoretically applied, we
> > > also have access to the actual filtering level applied, so let's add a
> > > proper frame validation sequence in hwsim.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/net/ieee802154/mac802154_hwsim.c | 111 ++++++++++++++++++++++-
> > >  include/net/ieee802154_netdev.h          |   8 ++
> > >  2 files changed, 117 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> > > index 458be66b5195..84ee948f35bc 100644
> > > --- a/drivers/net/ieee802154/mac802154_hwsim.c
> > > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/netdevice.h>
> > >  #include <linux/device.h>
> > >  #include <linux/spinlock.h>
> > > +#include <net/ieee802154_netdev.h>
> > >  #include <net/mac802154.h>
> > >  #include <net/cfg802154.h>
> > >  #include <net/genetlink.h>
> > > @@ -139,6 +140,113 @@ static int hwsim_hw_addr_filt(struct ieee802154_hw *hw,
> > >         return 0;
> > >  }
> > >
> > > +static void hwsim_hw_receive(struct ieee802154_hw *hw, struct sk_buff *skb,
> > > +                            u8 lqi)
> > > +{
> > > +       struct ieee802154_hdr hdr;
> > > +       struct hwsim_phy *phy = hw->priv;
> > > +       struct hwsim_pib *pib;
> > > +
> > > +       rcu_read_lock();
> > > +       pib = rcu_dereference(phy->pib);
> > > +
> > > +       if (!pskb_may_pull(skb, 3)) {
> > > +               dev_dbg(hw->parent, "invalid frame\n");
> > > +               goto drop;
> > > +       }
> > > +
> > > +       memcpy(&hdr, skb->data, 3);
> > > +
> > > +       /* Level 4 filtering: Frame fields validity */
> > > +       if (hw->phy->filtering == IEEE802154_FILTERING_4_FRAME_FIELDS) {
>
> I see, there is this big if handling. But it accesses the
> hw->phy->filtering value. It should be part of the hwsim pib setting
> set by the driver callback. It is a question here of mac802154 layer
> setting vs driver layer setting. We should do what the mac802154 tells
> the driver to do, this way we do what the mac802154 layer is set to.
>
> However it's a minor thing and it's okay to do it so...

* whereas we never let the driver know at any time of what different
filter levels exist _currently_ we have only the promiscuous mode
on/off switch which is do nothing or 4_FRAME_FIELDS.
It will work for now, changing anything in the mac802154 filtering
fields or something will end in probably breakage in this handling. In
my point of view as the current state is it should not do that, as
remember that hwsim will "simulate" hardware it should not be able to
access mac802154 fields (especially when doing receiving of frames) as
other hardware will only set register bits (as hwsim pib values is
there for)...

Still I think it's fine for now.

- Alex

