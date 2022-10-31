Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF8ECAAA1
	for <linux-wpan@archiver.kernel.org>; Mon, 31 Oct 2022 22:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJaWIP (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJaWIO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 31 Oct 2022 18:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE54140F4
        for <linux-wpan@vger.kernel.org>; Mon, 31 Oct 2022 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667254040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iZ0pV3SBOzW1z26S60SpkgdQOzJ1jKWT7LgrMsWLSw=;
        b=YHRVBpUAM41TLYu3MbFEVWy9kK+MreJ8KJlMhAX1fvVlKKj2ZfgezIarcpANgnvPK4yfBQ
        jz1S3qaI3t5hrveg6Am+RlZdhnWNGOll/MefFvAy/lRf1e5efse/mPn+az9t+0cRGvd6sC
        qcjYM2uESWpvio045y7fJ7nme6EYQCQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-357-q9s9cHI4MMePOIo1KaKIDA-1; Mon, 31 Oct 2022 18:07:19 -0400
X-MC-Unique: q9s9cHI4MMePOIo1KaKIDA-1
Received: by mail-ed1-f72.google.com with SMTP id m11-20020a056402510b00b00462e5d7688fso5762184edd.11
        for <linux-wpan@vger.kernel.org>; Mon, 31 Oct 2022 15:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iZ0pV3SBOzW1z26S60SpkgdQOzJ1jKWT7LgrMsWLSw=;
        b=6vBj1cfjrNLvnvHBdMWzbEPkwvNK+6pgiUHIEkiKCDl8YZ9zRUG6yNiNx0VneR0z1R
         Y0znh2GPI/2jjr1fDACabIqxyxe67n6l0vog5gnvEorlzaL+16sMWyavah4j8VQiUVsm
         1EqSPkEpjTWOmeZHNeQ3ZrbevsFslOyly3WdKj4qV7RNBzfkYXGnrgysST2ZN/KBfi8H
         elAC4KzgASgQemf9Z6pDZj54DZSJR1xbP7Yw+/0BNtOzwWa2j0N0WsbkHD+1Y0td5i+Y
         kXOhL9NFLZ+Y4B+dwBdrvnrzdObNjbP002Azylr3Q/rTVHqyrLq6pn7aJZgO1nrblnDq
         a89Q==
X-Gm-Message-State: ACrzQf2/I38cHaf+m/MOR/9M6z3gaeKjIUgVC9Go1yxRTRM7j0ltqTVM
        290nu96+m2RHX5CguKBFHKovt+FS/D/MbSQtJiI4PSZpXOV+AHJyII93sDR0YEMVIx9vif/b8mq
        WduER3jmLBNPje1AsNPfV56WUArowhxqOdQCbmA==
X-Received: by 2002:a17:906:a246:b0:78d:ee08:1867 with SMTP id bi6-20020a170906a24600b0078dee081867mr15060ejb.123.1667254037496;
        Mon, 31 Oct 2022 15:07:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7808CBkgMpm2IjH8zlljCUguJuPX1x0B9oPTLTfUq3CiS9A72iS2SRvn8xSQPXLui8a1FHlXuRoePvlJ0JBYM=
X-Received: by 2002:a17:906:a246:b0:78d:ee08:1867 with SMTP id
 bi6-20020a170906a24600b0078dee081867mr15052ejb.123.1667254037330; Mon, 31 Oct
 2022 15:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221026093502.602734-1-miquel.raynal@bootlin.com> <CAK-6q+jXPyruvdtS3jgzkuH=f599EiPk7vWTWLhREFCMj5ayNg@mail.gmail.com>
In-Reply-To: <CAK-6q+jXPyruvdtS3jgzkuH=f599EiPk7vWTWLhREFCMj5ayNg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 31 Oct 2022 18:07:05 -0400
Message-ID: <CAK-6q+iRAjEPLQqH-_YSxNnobd7o=NLaF-4XB+zvNTXpWgpb8A@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/3] IEEE 802.15.4: Add coordinator interfaces
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

On Sun, Oct 30, 2022 at 10:20 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Wed, Oct 26, 2022 at 5:35 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hello,
> > These three patches allow the creation of coordinator interfaces, which
> > were already defined without being usable. The idea behind is to use
> > them advertizing PANs through the beaconing feature.
> >
>
> I still don't know how exactly those "leaves" and "non-leaves" are
> acting here regarding the coordinator interfaces. If this is just a
> bit here to set in the interface I am fine with it. But yea,
> "relaying" feature is a project on its own, as we said previously.
>
> Another mail I was asking myself what a node interface is then,
> currently it is a mesh interface with none of those 802.15.4 PAN
> management functionality? Or can it act also as a "leave"
> coordinator... I am not sure about that.
>
> However I think we can think about something scheduled later as we can
> still decide later if we really want that "node" can do that.
> Regarding to 6LoWPAN I think the current type what "node" interface is
> as a just a node in a mesh is required, it might depends on if you
> want routing on IP or "relaying" on MAC (mesh-over vs mesh-under), but

*route-over

> I never saw mesh-under in 6LoWPAN.
>

we will see how that works, because you can actually run a 6lowpan
interface on the new coordinator type.

- Alex

