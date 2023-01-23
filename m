Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF8C05027
	for <linux-wpan@archiver.kernel.org>; Mon, 23 Jan 2023 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjAWOEO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjAWOEM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Jan 2023 09:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1F27993
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674482588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hi9QfKF/pkHE0TQcTI+lnboZZ4KZTrK1Z51mByX9dZQ=;
        b=LU+EUsNrMsIFAlfo019g4KaaI21OH8JrQDS+VvxXEM1isabPJBHTfOVEpZQDh6Xh/a9Sqb
        FKuPm44exYmJnJVqlc81dFD2VZN4qFqER1Zhqd0Rt4hduXK9DGaxa9MAjkVRTtJEzBhVW8
        BRfpq9EnlT2RXLgBDaEf6itVZqJmH34=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-apmrdv0MO6Gvx1UkHwCrRw-1; Mon, 23 Jan 2023 09:03:06 -0500
X-MC-Unique: apmrdv0MO6Gvx1UkHwCrRw-1
Received: by mail-ej1-f70.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso7798286ejb.5
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 06:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi9QfKF/pkHE0TQcTI+lnboZZ4KZTrK1Z51mByX9dZQ=;
        b=JkKdWwuSlqSa1/1r+ydbhV/O5ZXpx/w4JD/tXMS57S2NOOhkRHO63LC00K5kx6AVwq
         myts4YK39axGnkK1eYFBeZaGuKbAVIc4qAsNnMUCABGln48oTIF68vt6HTerhfnbqDb/
         mwbFZVAO/THt+vmR49oCci7YyP0eV2HM9RAvrdzrCsJDcfJWNdkB85lt+gQ2+1GiIdOS
         F+EuvWsJ59bjAer176lcYNPZlnryugQrlUQYqL2SjqeAjhBCYZXESQcKZhVIFsy8Wo7s
         PO6cJybfEdrq3+96ojshD7Ecl/8zxhFW/OARLbtSNSOp9z1oTDu8W6RXaQsS3qtDtb32
         XEJA==
X-Gm-Message-State: AFqh2kohDnZ7umu5Kg+OKp0i0zuXvICp83DryGr+uvenrX0sfYslGPPM
        tWeTxTZ4OvhI6jkwr1yO9WoVglwetEoC2zVoYpyCdYI6CLARcQBnrav4D3u8OXQMI4bP8avnYgP
        os+kUiKL7959/aXd2KLCD7U2uKTOTy4THNqxtwg==
X-Received: by 2002:a05:6402:12d2:b0:498:7546:c610 with SMTP id k18-20020a05640212d200b004987546c610mr2711929edx.85.1674482579785;
        Mon, 23 Jan 2023 06:02:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs4nTsYKdAqMdsWtKyThyGsu3vyT19czqfeMDwfaltdaoV7HzI8Aj2H0Rc4Py+yofhBCZCL3FMzwPq0fTICDqo=
X-Received: by 2002:a05:6402:12d2:b0:498:7546:c610 with SMTP id
 k18-20020a05640212d200b004987546c610mr2711926edx.85.1674482579477; Mon, 23
 Jan 2023 06:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20230106113129.694750-1-miquel.raynal@bootlin.com>
 <CAK-6q+jNmvtBKKxSp1WepVXbaQ65CghZv3bS2ptjB9jyzOSGTA@mail.gmail.com>
 <20230118102058.3b1f275b@xps-13> <CAK-6q+gwP8P--5e9HKt2iPhjeefMXrXUVy-G+szGdFXZvgYKvg@mail.gmail.com>
In-Reply-To: <CAK-6q+gwP8P--5e9HKt2iPhjeefMXrXUVy-G+szGdFXZvgYKvg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 23 Jan 2023 09:02:48 -0500
Message-ID: <CAK-6q+gn7W9x2+ihSC41RzkhmBn1E44pKtJFHgqRdd8aBpLrVQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 0/2] ieee802154: Beaconing support
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
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 9:01 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Wed, Jan 18, 2023 at 4:21 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sun, 15 Jan 2023 20:54:02 -0500:
> >
> > > Hi,
> > >
> > > On Fri, Jan 6, 2023 at 6:33 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > Scanning being now supported, we can eg. play with hwsim to verify
> > > > everything works as soon as this series including beaconing support gets
> > > > merged.
> > > >
> > >
> > > I am not sure if a beacon send should be handled by an mlme helper
> > > handling as this is a different use-case and the user does not trigger
> > > an mac command and is waiting for some reply and a more complex
> > > handling could be involved. There is also no need for hotpath xmit
> > > handling is disabled during this time. It is just an async messaging
> > > in some interval and just "try" to send it and don't care if it fails,
> > > or? For mac802154 therefore I think we should use the dev_queue_xmit()
> > > function to queue it up to send it through the hotpath?
> > >
> > > I can ack those patches, it will work as well. But I think we should
> > > switch at some point to dev_queue_xmit(). It should be simple to
> > > switch it. Just want to mention there is a difference which will be
> > > there in mac-cmds like association.
> >
> > I see what you mean. That's indeed true, we might just switch to
> > a less constrained transmit path.
> >
>
> I would define the difference in bypass qdisc or not. Whereas the
> qdisc can drop or delay transmitting... For me, the qdisc is currently
> in a "works for now" state.

probably also bypass other hooks like tc, etc. :-/ Not sure if we want that.

- Alex

