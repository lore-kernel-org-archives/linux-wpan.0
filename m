Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A2EC3F6B0
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Aug 2022 21:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiHXVyF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiHXVyD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Aug 2022 17:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3574DDB
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661378040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P8SV2XTXp+ycUiMu4OqXNB1nMaHaXIrJweUPXZpzvfQ=;
        b=FREfPLDSoMOy3bRN844YpHMY5kcrK57D1OQG5ZmzU9YgIiyfckwFF34dM6vfI7Yz/STVnn
        8bhskPZigrkMaw/REdSH30z4berEo2r6oQuEva+oOjBU3GqGNLUWTJ7qqt10fMgvC+140Z
        yyhFHy1rIqD6ArvLLjwV4WpMjBFxLpo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-ThADgSjMM_eF8ix0-qgQ8g-1; Wed, 24 Aug 2022 17:53:57 -0400
X-MC-Unique: ThADgSjMM_eF8ix0-qgQ8g-1
Received: by mail-qv1-f69.google.com with SMTP id k3-20020a05621414e300b00496e11f8d8aso6304814qvw.9
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 14:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=P8SV2XTXp+ycUiMu4OqXNB1nMaHaXIrJweUPXZpzvfQ=;
        b=rVcxNyb9r5E+Qe/bmS56iNPCMh39dJKfnRlHeQ6cqSZim1XL5i47ANtX15imuAfayJ
         a8whVE7ApOEJ+6M3hevKE27mNXv63Q9NUFFqQ3fA+urnQ5oNPb1majAehaUJgxRLzaSE
         eSXrB8zOoz6UorH3tjbGMfk1uZyfv9NCWiiEHXFCuP47SmwCJ6REQN9tMTgK8n8zBsvz
         lHMYYIHm/KDxNSnkTiUrwVTD3Jmitow+3ESNJfV60b5crNDTE+dVlh7iRiwqjGJkai4X
         hUfZ+G3MmH2pEo4m8tirC1WvHj0+cpW7WwPcQqq20X8530hUfiQLEjLkc+poH39mMOgS
         9Ycw==
X-Gm-Message-State: ACgBeo210mW4mSsMzGpsB7ys9vyTUO4uy23323t45GVmdg7EslOkxYCF
        1uRHD5Whr/k0dCS1NKi8FuxDkFJ6d+tu3htzxSDaS8Wl2syEM+uVhUKN0Eqnhn0Y5n09/l4nvzX
        AeJShwaKgUA4qH3vee5lZk4Dd0BK78kkBokON1Q==
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr1170355qtx.526.1661378036876;
        Wed, 24 Aug 2022 14:53:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xrH8Wkzbs/n47hMaXPwSqWBOuRh5IKesZcBM0OP/H8u9SmoqhBVInVcryoEYDFtCVHtZLNHO9ie+wH+bDji4=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr1170340qtx.526.1661378036685; Wed, 24
 Aug 2022 14:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-2-miquel.raynal@bootlin.com> <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
 <20220819191109.0e639918@xps-13> <CAK-6q+gCY3ufaADHNQWJGNpNZJMwm=fhKfe02GWkfGEdgsMVzg@mail.gmail.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13> <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
 <20220824152648.4bfb9a89@xps-13>
In-Reply-To: <20220824152648.4bfb9a89@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 24 Aug 2022 17:53:45 -0400
Message-ID: <CAK-6q+itA0C4zPAq5XGKXgCHW5znSFeB-YDMp3uB9W-kLV6WaA@mail.gmail.com>
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

On Wed, Aug 24, 2022 at 9:27 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Wed, 24 Aug 2022 08:43:20 -0400:
>
> > Hi,
> >
> > On Wed, Aug 24, 2022 at 6:21 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > ...
> > >
> > > Actually right now the second level is not enforced, and all the
> > > filtering levels are a bit fuzzy and spread everywhere in rx.c.
> > >
> > > I'm gonna see if I can at least clarify all of that and only make
> > > coord-dependent the right section because right now a
> > > ieee802154_coord_rx() path in ieee802154_rx_handle_packet() does not
> > > really make sense given that the level 3 filtering rules are mostly
> > > enforced in ieee802154_subif_frame().
> >
> > One thing I mentioned before is that we probably like to have a
> > parameter for rx path to give mac802154 a hint on which filtering
> > level it was received. We don't have that, I currently see that this
> > is a parameter for hwsim receiving it on promiscuous level only and
> > all others do third level filtering.
> > We need that now, because the promiscuous mode was only used for
> > sniffing which goes directly into the rx path for monitors. With scan
> > we mix things up here and in my opinion require such a parameter and
> > do filtering if necessary.
>
> I am currently trying to implement a slightly different approach. The
> core does not know hwsim is always in promiscuous mode, but it does
> know that it does not check FCS. So the core checks it. This is
> level 1 achieved. Then in level 2 we want to know if the core asked
> the transceiver to enter promiscuous mode, which, if it did, should
> not imply more filtering. If the device is working in promiscuous
> mode but this was not asked explicitly by the core, we don't really
> care, software filtering will apply anyway.
>

I doubt that I will be happy with this solution, this all sounds like
"for the specific current behaviour that we support 2 filtering levels
it will work", just do a parameter on which 802.15.4 filtering level
it was received and the rx path will check what kind of filter is
required and which not.
As driver ops start() callback you should say which filtering level
the receive mode should start with.

> I am reworking the rx path to clarify what is being done and when,
> because I found this part very obscure right now. In the end I don't
> think we need additional rx info from the drivers. Hopefully my
> proposal will clarify why this is (IMHO) not needed.
>

Never looked much in 802.15.4 receive path as it just worked but I
said that there might be things to clean up when filtering things on
hardware and when on software and I have the feeling we are doing
things twice. Sometimes it is also necessary to set some skb fields
e.g. PACKET_HOST, etc. and I think this is what the most important
part of it is there. However, there are probably some tune ups if we
know we are in third leveling filtering...

- Alex

