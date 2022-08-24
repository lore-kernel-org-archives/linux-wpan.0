Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11594C00140
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Aug 2022 12:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiHXMng (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 24 Aug 2022 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiHXMne (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Aug 2022 08:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845EE7F12B
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661345012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfBSLwmcH4eSGSU96LAujL7kLmANp0zLheegbWZ48gQ=;
        b=K6jkrtdindBjebK1DM2SKr2zfmuFlSUceWONYR/CZH6QD1zREkRW2/Klb+2nh1GM5Iqb/S
        FPALeRqshVa+lTg8iJgZQr0x/SgtPnAYJrVo+fFnX3n9iUT2le7T/mqJqpPK+NyqO+B1el
        /vNzVcxXpow3PuL107aRDcBVQ1KoAp4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-ic3TzufXPien9xaUBgAbhA-1; Wed, 24 Aug 2022 08:43:31 -0400
X-MC-Unique: ic3TzufXPien9xaUBgAbhA-1
Received: by mail-qt1-f200.google.com with SMTP id y12-20020ac8708c000000b00342f1bb8428so12700936qto.5
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 05:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NfBSLwmcH4eSGSU96LAujL7kLmANp0zLheegbWZ48gQ=;
        b=pxw6Z2yTJIN4LLbGcJsqpxieqpim9cam7dWWQPGgCoGx13s+lNYXaXzLZh5QRsnm7k
         tTuEk6nieMG8IExikFKGVzw3FgMbAriiL9wTIjNUHxCpxONJneIbBFDmcF5lorWsJQgp
         oexlxHJQnqu7kBaAX9ngJByk13NZpW44FMfmjvhvo6AX28Cuxz/89dudXO2TfsN7mxON
         hdmM0n0QDyFMmQWHksURVOd9AnfbJR0YvW2jIeUw7prWLaZoAppkmU8Wii3ozD+PXFqL
         PdkZ5RRqr3o+AicoIFL1/xUxndVPPQ2O+1fQIZu5Nj5jlCjtYIjHxzPoLSom4uOdRq09
         5Byg==
X-Gm-Message-State: ACgBeo2U0p6zFOUjMqs/AQhsTROLSMyL14Z4X6KOQHh920zXc8dJI6nZ
        0N5m/NhI4mjSUD1jn+kYPyozchE7sszKlV2sQa0UOo05bFPzW8LGmW/kp8zYUuXXBTk02DQyFz/
        kzOm/dCu94I/B53xYdUOgum+FHgZOHiztc+o4lg==
X-Received: by 2002:a05:620a:10a4:b0:6ba:e280:3aff with SMTP id h4-20020a05620a10a400b006bae2803affmr19651864qkk.177.1661345011129;
        Wed, 24 Aug 2022 05:43:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5b32f1Ioybd27CXOEYrx2s2fvvutQPgMZWKs8jqW8kBj+JAYuWTSzfX8nlDDdeo7pZT9vpTIVzECUgIqN8uMU=
X-Received: by 2002:a05:620a:10a4:b0:6ba:e280:3aff with SMTP id
 h4-20020a05620a10a400b006bae2803affmr19651848qkk.177.1661345010915; Wed, 24
 Aug 2022 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-2-miquel.raynal@bootlin.com> <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
 <20220819191109.0e639918@xps-13> <CAK-6q+gCY3ufaADHNQWJGNpNZJMwm=fhKfe02GWkfGEdgsMVzg@mail.gmail.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13>
In-Reply-To: <20220824122058.1c46e09a@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 24 Aug 2022 08:43:20 -0400
Message-ID: <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
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

On Wed, Aug 24, 2022 at 6:21 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
>
> Actually right now the second level is not enforced, and all the
> filtering levels are a bit fuzzy and spread everywhere in rx.c.
>
> I'm gonna see if I can at least clarify all of that and only make
> coord-dependent the right section because right now a
> ieee802154_coord_rx() path in ieee802154_rx_handle_packet() does not
> really make sense given that the level 3 filtering rules are mostly
> enforced in ieee802154_subif_frame().

One thing I mentioned before is that we probably like to have a
parameter for rx path to give mac802154 a hint on which filtering
level it was received. We don't have that, I currently see that this
is a parameter for hwsim receiving it on promiscuous level only and
all others do third level filtering.
We need that now, because the promiscuous mode was only used for
sniffing which goes directly into the rx path for monitors. With scan
we mix things up here and in my opinion require such a parameter and
do filtering if necessary.

- Alex

