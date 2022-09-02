Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403BECAAD3
	for <linux-wpan@archiver.kernel.org>; Fri,  2 Sep 2022 02:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiIBCjX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiIBCjW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2022 22:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0074DE4
        for <linux-wpan@vger.kernel.org>; Thu,  1 Sep 2022 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662086361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5sa16WfAJiVS4NAUB8e5s2vxwClXWkTUes9RRIA8eo=;
        b=e5dIdUV+SQQdCQs+s5HnkwjLwj4gI2DZFfxzJ0/tjjxy1X4WLXgdH3FDn6v59w6XR+iA6a
        IErh4WezhGHn8nnRW+PQiRAO0LmQR7gzcWsld4Xu5Y8fxE73XWx0bg31vXtjASdxMkbphm
        4szMzWyFvHDyWu+wFFudzi8wOhKRa5k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-4gWTbdfxNLGWD_sdzFJdVg-1; Thu, 01 Sep 2022 22:39:19 -0400
X-MC-Unique: 4gWTbdfxNLGWD_sdzFJdVg-1
Received: by mail-qt1-f200.google.com with SMTP id k9-20020ac80749000000b0034302b53c6cso568418qth.22
        for <linux-wpan@vger.kernel.org>; Thu, 01 Sep 2022 19:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p5sa16WfAJiVS4NAUB8e5s2vxwClXWkTUes9RRIA8eo=;
        b=t2AFSmYG5ZZVjQnNOeNZQct5EUuPV1QibnYzPmDqMPdL0b1Tc6QXl+7oRSORfUzOZ4
         /AyWSO8WOqGpD5PX0hqTeaEQukckY5R2v71e3LmzW2WNpuDBOiByzreObR1dYvOcuFal
         CMn6Dc72JN0+PFo/2CpNGGyAqa7KbiIreraQo5g/QGTDgIW8S8h7E/cYF+Vtyb2Pdb1K
         Fy/aQxXrfwEWRl2lU+PIg8DGaR3qXGJ4DC9hF8BnWprzdqjzBIO+acCRj7CkZ8QVbiRy
         lrnIHmeUzo0bE51i7OdP1A0zDRyL9/VftqvNKYOamSZ8waS6oWPJx5xdxe/fpK0yWaF+
         k1EA==
X-Gm-Message-State: ACgBeo0X9QK/NC/V3sI2lhTG3YtBgqkLnqNvMJcTBTjJoobbO/ClJeYa
        M9B9cKDwUiP4ggEKYMFscC18bHSzBPn5bAsfYr2pt2jYN44I+l+Som4/S6UtnemPQ+Rpqpv7+LM
        BzBtH4RXqNjihHWUAsHrVTYKsRxRdboV8Ngvydw==
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id 2-20020a370a02000000b006bb17afa8e6mr21571356qkk.80.1662086359434;
        Thu, 01 Sep 2022 19:39:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jEO076+uEgAv9EmcRImmogUSA22ZZFMJ36RgYEHp2JB2+tskpwVFU/xS14foEALyejHAAonc3i56DhZl1cFM=
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id
 2-20020a370a02000000b006bb17afa8e6mr21571345qkk.80.1662086359230; Thu, 01 Sep
 2022 19:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-2-miquel.raynal@bootlin.com> <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
 <20220819191109.0e639918@xps-13> <CAK-6q+gCY3ufaADHNQWJGNpNZJMwm=fhKfe02GWkfGEdgsMVzg@mail.gmail.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13> <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
 <20220824152648.4bfb9a89@xps-13> <CAK-6q+itA0C4zPAq5XGKXgCHW5znSFeB-YDMp3uB9W-kLV6WaA@mail.gmail.com>
 <20220825145831.1105cb54@xps-13> <CAK-6q+j3LMoSe_7u0WqhowdPV9KM-6g0z-+OmSumJXCZfo0CAw@mail.gmail.com>
 <20220826095408.706438c2@xps-13> <CAK-6q+gxD0TkXzUVTOiR4-DXwJrFUHKgvccOqF5QMGRjfZQwvw@mail.gmail.com>
 <20220829100214.3c6dad63@xps-13> <CAK-6q+gJwm0bhHgMVBF_pmjD9zSrxxHvNGdTrTm0fG-hAmSaUQ@mail.gmail.com>
 <20220831173903.1a980653@xps-13> <20220901020918.2a15a8f9@xps-13> <CAK-6q+gbRZ_w-G7WBTQNfjnpawQ0EJ4DuR9tsGPbZpT6MN35cw@mail.gmail.com>
In-Reply-To: <CAK-6q+gbRZ_w-G7WBTQNfjnpawQ0EJ4DuR9tsGPbZpT6MN35cw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 1 Sep 2022 22:39:08 -0400
Message-ID: <CAK-6q+hs19WP8_myYz8-f0n6LGqp1FykJ_2PdHrLSS4VZXQ3AQ@mail.gmail.com>
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

On Thu, Sep 1, 2022 at 10:23 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Wed, Aug 31, 2022 at 8:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hello again,
> >
> > miquel.raynal@bootlin.com wrote on Wed, 31 Aug 2022 17:39:03 +0200:
> >
> > > Hi Alexander & Stefan,
> > >
> > > aahringo@redhat.com wrote on Mon, 29 Aug 2022 22:23:09 -0400:
> > >
> > > I am currently testing my code with the ATUSB devices, the association
> > > works, so it's a good news! However I am struggling to get the
> > > association working for a simple reason: the crafted ACKs are
> > > transmitted (the ATUSB in monitor mode sees it) but I get absolutely
> > > nothing on the receiver side.
> > >
> > > The logic is:
> > >
> > > coord0                 coord1
> > > association req ->
> > >                 <-     ack
> > >                 <-     association response
> > > ack             ->
> > >
> > > The first ack is sent by coord1 but coord0 never sees anything. In
> > > practice coord0 has sent an association request and received a single
> > > one-byte packet in return which I guess is the firmware saying "okay, Tx
> > > has been performed". Shall I interpret this byte differently? Does it
> > > mean that the ack has also been received?
> >
> > I think I now have a clearer understanding on how the devices behave.
> >
> > I turned the devices into promiscuous mode and could observe that some
> > frames were considered wrong. Indeed, it looks like the PHYs add the
> > FCS themselves, while the spec says that the FCS should be provided to
> > the PHY. Anyway, I dropped the FCS calculations from the different MLME
> > frames forged and it helped a lot.
> >
>
> This is currently the case because monitor interfaces and AF_PACKET
> will not have the FCS in the payload. As you already figured out you
> can't refer 802.15.4 promiscuous mode to mac802154 promiscuous mode,
> it was a historically growing term as people wanted to have a sniffer
> device and used a promiscuous term from a datasheet (my guess).
> Vendors has a different meaning of promiscuous mode as the one from
> 802.15.4. IFF_PROMISC should be mapped to non-filtered mode which is
> more equal to a sniffer device. However we need to find solutions
> which fulfill everybody.
>
> > I also kind of "discovered" the concept of hardware address filtering
> > on atusb which makes me realize that maybe we were not talking about
> > the same "filtering" until now.
> >
> > Associations and disassociations now work properly, I'm glad I fixed
> > "everything". I still need to figure out if using the promiscuous mode
> > everywhere is really useful or not (maybe the hardware filters were
> > disabled in this mode and it made it work). However, using the
> > promiscuous mode was the only way I had to receive acknowledgements,
> > otherwise they were filtered out by the hardware (the monitor was
> > showing that the ack frames were actually being sent).
> >
>
> This is correct, the most hardware will turn off automatic
> ackknowledge handling if address filtering is off (I am sure I said
> that before). We cannot handle acks on mac802154 if they are time
> critical.
>

If this is required we should discuss this topic...

- Alex

