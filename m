Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521AAC38142
	for <linux-wpan@archiver.kernel.org>; Mon, 23 Jan 2023 13:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjAWNvf (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjAWNvd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Jan 2023 08:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B391701
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674481843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vIE8NKX623PCBEKrno0xDIiJG3oiFqDswH3UtKjaTM=;
        b=bQGsyC9Ak1SCseQVhR/388aU4/AuF1bqZRX1imn8Wc+a2SMw/t+Q9OJrk4ahZTK+vqTHzS
        ga3U6EzOLqfVFTUSw2kZc+2tbBFnZyNviTOyB0AqTLWpiUywX+zVAIMkJmNOq4cEI5CrAq
        v6kgX9jhNvtsvfCbJWLcc2DpvmGhu/o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-n_Dxet4xN3O2qvPm67enJA-1; Mon, 23 Jan 2023 08:50:42 -0500
X-MC-Unique: n_Dxet4xN3O2qvPm67enJA-1
Received: by mail-ej1-f70.google.com with SMTP id gn31-20020a1709070d1f00b0087024adbba2so7873374ejc.20
        for <linux-wpan@vger.kernel.org>; Mon, 23 Jan 2023 05:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vIE8NKX623PCBEKrno0xDIiJG3oiFqDswH3UtKjaTM=;
        b=tNR8yEUWrqALjLXqcz6sVx+/JeN6BfKS4hVgCHgOsk5XtfptMvSAue5bvaTJ+Nw91u
         HoiVhVI9T0f7tp1XiYgYJDWGGUwYkOcgkIEUIZrWCMe5olJ2C1XebsHE4frbxUZhHIty
         Kf6QquHZQN7/Bp2fknR3jw2r7KlOyvuEtoWXSa3dKnoO9oDfd9dmETIaej9YOwdFUWZV
         2Otts3enOZ+GFtQV1tQXyEAPtclgQ5tuOiEvNqBS0BECTaPRrAitaDBvsyjJvNv4DiD7
         Gw17If/FbnuUL3NmDtSVDpBe8E8k8nVbmEXJ6VNxlWFWpqskG3Z1PUMv83omZrrv0pIx
         6M6w==
X-Gm-Message-State: AFqh2kq7kvK78NUSpAYYnqswT1YEDUcBsS3JQ/ochwWfVeJWx0EH+8K7
        SMNt7TDQsHILbFSeh+azrsSMcZrDX/6tSQQki8Byn4PtIvTY93ChE6Bdh7Uc7jv85RmdTbJaUEA
        B8IC85RF+xQ/FlliLD1Dvq4x6/1STLk5D9H+jMw==
X-Received: by 2002:a17:906:af09:b0:868:17de:900d with SMTP id lx9-20020a170906af0900b0086817de900dmr2965820ejb.412.1674481841287;
        Mon, 23 Jan 2023 05:50:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXts2+4/O5IrKkeUamYxBlfeg/CHDE5BWjcoqePucfpoT7Ix74SvGP4YA70ychLp3624WjRgtIhiGOTaHTGYN6A=
X-Received: by 2002:a17:906:af09:b0:868:17de:900d with SMTP id
 lx9-20020a170906af0900b0086817de900dmr2965809ejb.412.1674481841080; Mon, 23
 Jan 2023 05:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20230106113129.694750-1-miquel.raynal@bootlin.com>
 <CAK-6q+jNmvtBKKxSp1WepVXbaQ65CghZv3bS2ptjB9jyzOSGTA@mail.gmail.com>
 <20230118102058.3b1f275b@xps-13> <20230123134921.38cdfd42@xps-13>
In-Reply-To: <20230123134921.38cdfd42@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 23 Jan 2023 08:50:29 -0500
Message-ID: <CAK-6q+g9TxtEpELW1GXchBjPq2HD85CAv06VhDKSHjrQmXPCKA@mail.gmail.com>
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

On Mon, Jan 23, 2023 at 7:49 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> > > btw: what is about security handling... however I would declare this
> > > feature as experimental anyway.
> >
> > I haven't tested the security layer at all yet, would you have a few
> > commands to start with, which I could try using eg. hwsim?
>
> Using the dev_queue_xmit() doest not bypasses the whole stack anymore,
> the beacons got rejected by the llsec layer. I did just hack into it
> just to allow unsecure beacons for now:
>

Stupid questions: do the beacon frames need to be encrypted? Because
we bypass llsec always with those mlme functionality.

btw: there is currently an issue with the llsec hooks. You will not
see the transmit side being encrypted via wireshark (so far I
remember) because the capture is before encryption...

> -       if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
> +       if (hlen < 0 ||
> +           (hdr.fc.type != IEEE802154_FC_TYPE_DATA &&
> +            hdr.fc.type != IEEE802154_FC_TYPE_BEACON))
>                 return -EINVAL;
>
> I believe that would be enough as a first step, at least for merging
> beacons support for now.
>

ok.

> However I'll have to look at the spec about security stuff and
> beaconing to know how to handle this properly if security was required,
> but could you drive me through useful resources were I could quickly
> grasp how all that works? Did you make any presentation of it? Perhaps
> just a blog post or something alike? Or even just a script showing its
> use?
>

I am pretty sure I have something... you need to construct an ACL
there and there exist different methods to do a key lookup. Some are
very easy and some are more difficult to set up. I will look later...
or just do a setup again with hwsim with should work (but again don't
trust wireshark/tcpdump).

Also note: currently there exists practical issues on 802.15.4 stack
(but star topology kind of solves it, so far I understood) to
synchronize security parameters e.g. frame counter.

> While I was looking at linux-wpan.org, I realized we should both
> contribute to it with some examples about security stuff and
> beaconing/scanning?
>

yes, that would be nice... I am pretty sure there are some examples on
the mailinglist archive.

- Alex

