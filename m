Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69723C38142
	for <linux-wpan@archiver.kernel.org>; Mon, 23 Jan 2023 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjAWOhf (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAWOhf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Jan 2023 09:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367D7DA7
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 06:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674484610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBpjmEQyfavPuUGASQW20In6kphIvOV/Jy7jnr721lM=;
        b=iDqVojE+u9TMlGRB54TkrLPfFSLDevEazXhDTdB/giI6ej+8kSWMsYXGhOacSWBD9cwceM
        Ibb/3OsztG3r7Ts+ZAuXknr0zOUc2iKJyxnWqL6UVbO8J1stdV5W7Bh7QbqApluak0IJqy
        ufPtBpJx8d05mMyDtc4Q+yAp9cGTU6c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-VgZbELMuPu6aFkLHHYX7gA-1; Mon, 23 Jan 2023 09:36:48 -0500
X-MC-Unique: VgZbELMuPu6aFkLHHYX7gA-1
Received: by mail-ej1-f71.google.com with SMTP id sa32-20020a1709076d2000b0084d4593797eso7855078ejc.16
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 06:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBpjmEQyfavPuUGASQW20In6kphIvOV/Jy7jnr721lM=;
        b=0zovg+SFWqJ36xwkqpMtunC08SNj7i9zo1vo7te5/MjvqzalC0LCAGr6bGZPNkLOIP
         /FFXVRX5FmtTYIsssM7KJArjpnX80zO8JDkFySf3vfaO0upEOHIb1nmo5WXmdyu1g1jK
         s/dMWYpNgaQDSYRPZKfr/JhH4U+f/ASUJP0LgH9dj+IZ5fvWrgNjC2s4vsSc/01xBD1q
         Gh/OyVm9b4wQZ0WXdRi15M7HPZbpCsPe/GX02JNOsrYgt1D3DGLamLHugLKrhYZH+gnl
         U5ybd39VrCvqLUZ1ImS9d2LhUcBAujtuBnQo0gZQCd6l+KG8lzssEGR5qJY0Z7I0l69b
         jwMQ==
X-Gm-Message-State: AFqh2kqR2bD6AoXm8seElA89bP3EtscngSEPNBjJRR6UtcPik3hfRE+3
        qfCuRiEH0hwhjhUmH2jnQKEYVVxmMyzUOF3EzH5BjU90cupvW/06wZkSdG6/Cm+rl1JSqWHf9ny
        5hwewDZRrMkWa91vm44dXbzq3PFqCGsAPDKYGWQ==
X-Received: by 2002:a17:906:15d4:b0:7c0:fa5f:a032 with SMTP id l20-20020a17090615d400b007c0fa5fa032mr1805359ejd.112.1674484607089;
        Mon, 23 Jan 2023 06:36:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGkXxV3VbA8WAPWaj4aQnx/BD+6nTiYZiN40lGMyPKWnGiT3ZYqEqQiLlzbGTvxAcQYjWWYNyJ7YwQp7PmTjE=
X-Received: by 2002:a17:906:15d4:b0:7c0:fa5f:a032 with SMTP id
 l20-20020a17090615d400b007c0fa5fa032mr1805351ejd.112.1674484606933; Mon, 23
 Jan 2023 06:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20230106113129.694750-1-miquel.raynal@bootlin.com>
 <CAK-6q+jNmvtBKKxSp1WepVXbaQ65CghZv3bS2ptjB9jyzOSGTA@mail.gmail.com>
 <20230118102058.3b1f275b@xps-13> <20230123134921.38cdfd42@xps-13> <CAK-6q+g9TxtEpELW1GXchBjPq2HD85CAv06VhDKSHjrQmXPCKA@mail.gmail.com>
In-Reply-To: <CAK-6q+g9TxtEpELW1GXchBjPq2HD85CAv06VhDKSHjrQmXPCKA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 23 Jan 2023 09:36:35 -0500
Message-ID: <CAK-6q+jf2EWASVGkTXLkD2V4gpzjEAkYTXt=rcZRXTDhO5so3w@mail.gmail.com>
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

On Mon, Jan 23, 2023 at 8:50 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 23, 2023 at 7:49 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Alexander,
> >
> > > > btw: what is about security handling... however I would declare this
> > > > feature as experimental anyway.
> > >
> > > I haven't tested the security layer at all yet, would you have a few
> > > commands to start with, which I could try using eg. hwsim?
> >
> > Using the dev_queue_xmit() doest not bypasses the whole stack anymore,
> > the beacons got rejected by the llsec layer. I did just hack into it
> > just to allow unsecure beacons for now:
> >
>
> Stupid questions: do the beacon frames need to be encrypted? Because
> we bypass llsec always with those mlme functionality.
>
> btw: there is currently an issue with the llsec hooks. You will not
> see the transmit side being encrypted via wireshark (so far I
> remember) because the capture is before encryption...

You can do with hwsim a sniffer device, just create a phy and have
from every node an edge to it, then create a monitor interface on it
and you will see all frames on air correctly encrypted and let
wireshark decrypt it. This is a workaround I had.

- Alex

