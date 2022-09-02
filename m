Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C46ECAAD2
	for <linux-wpan@archiver.kernel.org>; Fri,  2 Sep 2022 02:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiIBCi2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBCi1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2022 22:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A872EED
        for <linux-wpan@vger.kernel.org>; Thu,  1 Sep 2022 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662086305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ5WzgrUVpBMTZuQ11KykY8wLoJKrIZC5psSubne8Vc=;
        b=JWaIPzt6sW/cGcuP+hi7P1gW2uucpcN1g+Sa/sypLhcb/2ZlEiKPD4shYha0a8WIr1OZDa
        ASpRtVnwhlNMqi0Of7II3WQfa49QivKr1rWI1MVhShM4sNJ+HLK3MlEdTJo4bywbwSNB0m
        b3ZFNts3IF7K9jtMWPYrv5EBEqZg5U4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-O-xhft9yNem4keKjbWUNsg-1; Thu, 01 Sep 2022 22:38:24 -0400
X-MC-Unique: O-xhft9yNem4keKjbWUNsg-1
Received: by mail-qk1-f197.google.com with SMTP id bl16-20020a05620a1a9000b006bc3aa1908dso878331qkb.15
        for <linux-wpan@vger.kernel.org>; Thu, 01 Sep 2022 19:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VQ5WzgrUVpBMTZuQ11KykY8wLoJKrIZC5psSubne8Vc=;
        b=FW1H06z6drhYyQkpoYGDeWE6NqVnZ3fDgy2mJAr7Zg4qePs5iD8k3QG+m48Se7FU/J
         OY2Ndji7ZSp5R6Ki1i1L80c18sdWneXzONi8zAOIIJBgTayP5jwyFSaIQZTuO+P6Rt+D
         aaAzU4H+fj6gke7mWvC2Vo1OlsBFQVBOBMaK4YZifU9jHvhqpwUJ1F1uT+38x8ZGtKdt
         HJYYZb0kOo5YOfTp0gFz1Frihpm7A7pnaiVj2mGUNjz3slNJONoC1cKB35CEBI6tPUBI
         4p/Z9qLGd/qSHjCsAkWs8tZLDLc57cAiMWW8EdtaMA8Y2nCZhFjJGkhDQeDeKLere6kP
         okuw==
X-Gm-Message-State: ACgBeo1mRWzzFW+wk/lxWPOms84OZmEC+r99t03kr2siJPdPYqZF/oCk
        uTY/VR3nBj3faKiMfj3OPtLm9bSEIJ//ZUzxdxmdy7GliwORXN6exFO9ueNR7RHr90k905lu5YM
        tGqOUfTSWERIzExgVRqS4kHsOjEy/udeUBakcrQ==
X-Received: by 2002:a05:6214:1c07:b0:499:1927:7dc7 with SMTP id u7-20020a0562141c0700b0049919277dc7mr11963351qvc.28.1662086303963;
        Thu, 01 Sep 2022 19:38:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kTQxDXc68svQlq6lbFEPDpl75SVNLmDyPxAgXJvHBWdyoe8sKgkTO8WVTNtS9j9beThKbtyCPz8TYMxM/rjA=
X-Received: by 2002:a05:6214:1c07:b0:499:1927:7dc7 with SMTP id
 u7-20020a0562141c0700b0049919277dc7mr11963334qvc.28.1662086303696; Thu, 01
 Sep 2022 19:38:23 -0700 (PDT)
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
 <20220831173903.1a980653@xps-13> <20220901020918.2a15a8f9@xps-13> <20220901150917.5246c2d0@xps-13>
In-Reply-To: <20220901150917.5246c2d0@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 1 Sep 2022 22:38:12 -0400
Message-ID: <CAK-6q+g1Gnew=zWsnW=HAcLTqFYHF+P94Q+Ywh7Rir8J8cgCgw@mail.gmail.com>
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

On Thu, Sep 1, 2022 at 9:09 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> miquel.raynal@bootlin.com wrote on Thu, 1 Sep 2022 02:09:18 +0200:
>
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
> > Finally, changing the channel was also a piece of the puzzle, because I
> > think some of my smart light bulbs tried to say hello and it kind of
> > disturbed me :)
>
> I tried to scan my ATUSB devices from a Zephyr based Arduino Nano
> BLE but for now it does not work, the ATUSB devices receive the scan
> requests from Zephyr and send their beacons, the ATUSB monitor shows
> the beacons on Wireshark but the ieee80154_recv() callback is never
> triggered on Zephyr side. I am new to this OS so if you have any idea
> or debugging tips, I would be glad to hear them.
>
> > > I could not find a documentation of the firmware interface, I went
> > > through the wiki but I did not find something clear about what to
> > > expect or "what the driver should do". But perhaps this will ring a
> > > bell on your side?
> > >
> > > [...]
> > >
> > > > I did not see the v2 until now. Sorry for that.
> > >
> > > Ah! Ok, no problem :)
> > >
> > > >
> > > > However I think there are missing bits here at the receive handling
> > > > side. Which are:
> > > >
> > > > 1. Do a stop_tx(), stop_rx(), start_rx(filtering_level) to go into
> > > > other filtering modes while ifup.
> > >
> > > Who is supposed to change the filtering level?
> > >
> > > For now there is only the promiscuous mode being applied and the user
> > > has no knowledge about it, it's just something internal.
> > >
> > > Changing how the promiscuous mode is applied (using a filtering level
> > > instead of a "promiscuous on" boolean) would impact all the drivers
> > > and for now we don't really need it.
> > >
> > > > I don't want to see all filtering modes here, just what we currently
> > > > support with NONE (then with FCS check on software if necessary),
> > > > ?THIRD/FOURTH? LEVEL filtering and that's it. What I don't want to see
> > > > is runtime changes of phy flags. To tell the receive path what to
> > > > filter and what's not.
> > >
> > > Runtime changes on a dedicated "filtering" PHY flag is what I've used
> > > and it works okay for this situation, why don't you want that? It
> > > avoids the need for (yet) another rework of the API with the drivers,
> > > no?
> > >
> > > > 2. set the pan coordinator bit for hw address filter. And there is a
> > > > TODO about setting pkt_type in mac802154 receive path which we should
> > > > take a look into. This bit should be addressed for coordinator support
> > > > even if there is the question about coordinator vs pan coordinator,
> > > > then the kernel needs a bit as coordinator iface type parameter to
> > > > know if it's a pan coordinator and not coordinator.
> > >
> > > This is not really something that we can "set". Either the device
> > > had performed an association and it is a child device: it is not the
> > > PAN coordinator, or it initiated the PAN and it is the PAN coordinator.
> > > There are commands to change that later on but those are not supported.
> > >
> > > The "PAN coordinator" information is being added in the association
> > > series (which comes after the scan). I have handled the pkt_type you are
> > > mentioning.
> > >
> > > > I think it makes total sense to split this work in transmit handling,
> > > > where we had no support at all to send something besides the usual
> > > > data path, and receive handling, where we have no way to change the
> > > > filtering level besides interface type and ifup time of an interface.
> > > > We are currently trying to make a receive path working in a way that
> > > > "the other ideas flying around which are good" can be introduced in
> > > > future.
> > > > If this is done, then take care about how to add the rest of it.
> > > >
> > > > I will look into v2 the next few days.
> >
> > If possible, I would really like to understand what you expect in terms
> > of filtering. Maybe as well a short snippet of code showing what kind
> > of interface you have in mind. Are we talking about a rework of the
> > promiscuous callback? Are we talking about the hardware filters? What
> > are the inputs and outputs for these callbacks? What do we expect from
> > the drivers in terms of advertising? I will be glad to make the
> > relevant changes once I understand what is needed because on this topic
> > I have a clear lack of experience, so I will try to judge what is
> > reachable based on your inputs.
>

I am sorry, I never looked into Zephyr for reasons... Do they not have
something like /proc/interrupts look if you see a counter for your
802.15.4 transceiver?

> Also, can you please clarify when are we talking about software and
> when about hardware filters.
>

Hardware filter is currently e.g. promiscuous mode on or off setting.
Software filtering is depending which receive path the frame is going
and which hardware filter is present which then acts like actually
with hardware filtering.
I am not sure if this answers this question?

- Alex

