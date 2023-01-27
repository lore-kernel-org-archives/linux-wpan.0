Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83865C54EAA
	for <linux-wpan@archiver.kernel.org>; Fri, 27 Jan 2023 01:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjA0BtN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 Jan 2023 20:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjA0BtE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Jan 2023 20:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE7206A6
        for <linux-wpan@vger.kernel.org>; Thu, 26 Jan 2023 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674784096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UdNReRsqkFMj+61fQ7QVmGJiJhm8D0MWz3RUXRqbpVA=;
        b=g0BAR77kplZ8AIGyfYm1s1M3qGzwjSQ3Tv0iKo1U+vb2uFzlvJI6q/0sbdzfDdBUPbGHE5
        C6mHxeuaAjfpqmG/H6/U9KU0xIZ1WuDvX9DzWjWclG7qyori4xu3jKzQaRRdb9fMUKuU2g
        Cm6DOREsZl/Xz8Ai7cMTPolXMsnEzT0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-gIHK2yWLNUSTa9LBCf8l4w-1; Thu, 26 Jan 2023 20:48:15 -0500
X-MC-Unique: gIHK2yWLNUSTa9LBCf8l4w-1
Received: by mail-ed1-f69.google.com with SMTP id m12-20020a056402430c00b0049e4ac58509so2588353edc.16
        for <linux-wpan@vger.kernel.org>; Thu, 26 Jan 2023 17:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdNReRsqkFMj+61fQ7QVmGJiJhm8D0MWz3RUXRqbpVA=;
        b=ItZTX7sOFUbh865ZtP4/lp56Tk8RC2S1PfRmUZ/AJFjY1dCOVGhUUNCxurQE7mCgHb
         mqNa0QjKtgo4/4wxVtv3VrN3agXuuB9WnnmQb8I0H9w4vIa88pieSzLu9wLUXY8woL4o
         rLrYNU5prneofs5ui2sf4CxfnSGxXtR5D+O2oN65GDtOKqJj1fL+8kQcRkFmPvW4z7S6
         0F7QOsR7rSBxNbF6FbolbRuTN+uF1egSVgAjXXOMhZU5MUBEt4k8nEkvdho9rj/g4ii7
         1p7Ch0NSSDy63MhWgJFNjA/9tWdpQS11+K9fP7jERY5g5CRXUmIExBx6mYkQ1ct+NO2/
         wScw==
X-Gm-Message-State: AFqh2kqQxB/Yq4zSCUz2KPNEc6Dq/a1FAlcOYlOpC/t0NfraHm9fAtGA
        2kvMy7F8SNfY3cPbuL9n+pAM8QplDvGQgm+1Hw2PLowd68FeON0mlBcwxlm8osCqzpjx0D8ciaw
        110gtfEGGD60PpW48MZnMCOFmBYqdVhbettg+AA==
X-Received: by 2002:a17:906:4988:b0:871:e963:1508 with SMTP id p8-20020a170906498800b00871e9631508mr6388968eju.185.1674784093960;
        Thu, 26 Jan 2023 17:48:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0rLnhMLRLq/D8RTL4zbjByx8IKkthjOspdHq+VArO1TyNIiLQIzO9qDLMJorz7BX7HORmEMkmfJsNzgzNv/U=
X-Received: by 2002:a17:906:4988:b0:871:e963:1508 with SMTP id
 p8-20020a170906498800b00871e9631508mr6388960eju.185.1674784093835; Thu, 26
 Jan 2023 17:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20230125102923.135465-1-miquel.raynal@bootlin.com> <CAK-6q+jN1bnP1FdneGrfDJuw3r3b=depEdEP49g_t3PKQ-F=Lw@mail.gmail.com>
In-Reply-To: <CAK-6q+jN1bnP1FdneGrfDJuw3r3b=depEdEP49g_t3PKQ-F=Lw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 26 Jan 2023 20:48:02 -0500
Message-ID: <CAK-6q+hoquVswZTm+juLasQzUJpGdO+aQ7Q3PCRRwYagge5dTw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: Beaconing support
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
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Jan 26, 2023 at 8:45 PM Alexander Aring <aahringo@redhat.com> wrote=
:
>
> Hi,
>
> On Wed, Jan 25, 2023 at 5:31 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Scanning being now supported, we can eg. play with hwsim to verify
> > everything works as soon as this series including beaconing support get=
s
> > merged.
> >
> > Thanks,
> > Miqu=C3=A8l
> >
> > Changes in v2:
> > * Clearly state in the commit log llsec is not supported yet.
> > * Do not use mlme transmission helpers because we don't really need to
> >   stop the queue when sending a beacon, as we don't expect any feedback
> >   from the PHY nor from the peers. However, we don't want to go through
> >   the whole net stack either, so we bypass it calling the subif helper
> >   directly.
> >

moment, we use the mlme helpers to stop tx but we use the
ieee802154_subif_start_xmit() because of the possibility to invoke
current 802.15.4 hooks like llsec? That's how I understand it.

- Alex

