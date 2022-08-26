Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9AEECAAA3
	for <linux-wpan@archiver.kernel.org>; Fri, 26 Aug 2022 01:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiHZBF0 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 25 Aug 2022 21:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiHZBFY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Aug 2022 21:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437BBCCF7
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2022 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661475922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZ6x291U+k5zOPJ065fYydO8mp0gi/eDAH8hFpBNVvU=;
        b=S+LEmgBndmZGWja6keWQnundD0Soek4+Jc0J5FOHaxfFGUfxyYqRtqLoIeoHxjEDE4Qk7j
        qqg2FIMWnjJh2WaghcYN+EZEYVSRgFVaBOSQmaNjQtuGm2L0+56dTmPsaTTEV9hKaqv8Sn
        ZR9lwA6oS2nZ+8jakM6NNLcpYde7ilI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-73yDEEGWMvu-hSvJ3b54JQ-1; Thu, 25 Aug 2022 21:05:21 -0400
X-MC-Unique: 73yDEEGWMvu-hSvJ3b54JQ-1
Received: by mail-qt1-f200.google.com with SMTP id z6-20020ac875c6000000b0034454b14c91so251014qtq.15
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2022 18:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AZ6x291U+k5zOPJ065fYydO8mp0gi/eDAH8hFpBNVvU=;
        b=7+W1VUiNDb7wDnudoypm3UvgCuQ+J0Owfj5BXGeOManT5vUCU0pIOwDMoC1nTXllv1
         afg2poadE+D5OAZ3fSzcGrFnPtKZIFvB2tvkzeNjJjxkSfHpwAlmTWcWD15d4ma+tlH6
         P9XiA9mBZbVg3W2ZNvzscoczuKxeKd50U1/A7+t/CWdF8rTzVMUgmU/d1sGsWta7zwbl
         QXFw0quNqToBb4SEo2eDeErztmVFXQ8B7LpMchkOct6LfXZSjaJR+/WNC0uISGErZ5v2
         s3bH6WWfckFeLWOCid3BFQwrFNpE/SzfZPrPpmAiB9dov6dLJ6BBqiN1UrxTQXHiC50O
         rztA==
X-Gm-Message-State: ACgBeo0kTti6ERFp39Xw45g/K+TOAOgt5CsXRQeaaCWrN7rLL3ufKguh
        xqlWDCEl53awgG2u7bUUpDUQcSA0mB9Smxlv6ECNyk16/6zGREZBPq5ynimncEevCMXbwl8ixMf
        Er31zxo6FVbbprjBUr/gv5xQysy3ZjVeT84arSg==
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id x9-20020ac85f09000000b0034367b396f5mr6050804qta.470.1661475920704;
        Thu, 25 Aug 2022 18:05:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5z6ltDAexG0pi2Y22s7FVimz0nursqLQRCtI3HVpB4V4tKfPF05PfEbO6ZojJZA1AZdU750oATQ5yS8CLj5j0=
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id
 x9-20020ac85f09000000b0034367b396f5mr6050783qta.470.1661475920479; Thu, 25
 Aug 2022 18:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-2-miquel.raynal@bootlin.com> <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
 <20220819191109.0e639918@xps-13> <CAK-6q+gCY3ufaADHNQWJGNpNZJMwm=fhKfe02GWkfGEdgsMVzg@mail.gmail.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13> <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
 <20220824152648.4bfb9a89@xps-13> <CAK-6q+itA0C4zPAq5XGKXgCHW5znSFeB-YDMp3uB9W-kLV6WaA@mail.gmail.com>
 <20220825145831.1105cb54@xps-13>
In-Reply-To: <20220825145831.1105cb54@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 25 Aug 2022 21:05:09 -0400
Message-ID: <CAK-6q+j3LMoSe_7u0WqhowdPV9KM-6g0z-+OmSumJXCZfo0CAw@mail.gmail.com>
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

On Thu, Aug 25, 2022 at 8:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Wed, 24 Aug 2022 17:53:45 -0400:
>
> > Hi,
> >
> > On Wed, Aug 24, 2022 at 9:27 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Wed, 24 Aug 2022 08:43:20 -0400:
> > >
> > > > Hi,
> > > >
> > > > On Wed, Aug 24, 2022 at 6:21 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > ...
> > > > >
> > > > > Actually right now the second level is not enforced, and all the
> > > > > filtering levels are a bit fuzzy and spread everywhere in rx.c.
> > > > >
> > > > > I'm gonna see if I can at least clarify all of that and only make
> > > > > coord-dependent the right section because right now a
> > > > > ieee802154_coord_rx() path in ieee802154_rx_handle_packet() does not
> > > > > really make sense given that the level 3 filtering rules are mostly
> > > > > enforced in ieee802154_subif_frame().
> > > >
> > > > One thing I mentioned before is that we probably like to have a
> > > > parameter for rx path to give mac802154 a hint on which filtering
> > > > level it was received. We don't have that, I currently see that this
> > > > is a parameter for hwsim receiving it on promiscuous level only and
> > > > all others do third level filtering.
> > > > We need that now, because the promiscuous mode was only used for
> > > > sniffing which goes directly into the rx path for monitors. With scan
> > > > we mix things up here and in my opinion require such a parameter and
> > > > do filtering if necessary.
> > >
> > > I am currently trying to implement a slightly different approach. The
> > > core does not know hwsim is always in promiscuous mode, but it does
> > > know that it does not check FCS. So the core checks it. This is
> > > level 1 achieved. Then in level 2 we want to know if the core asked
> > > the transceiver to enter promiscuous mode, which, if it did, should
> > > not imply more filtering. If the device is working in promiscuous
> > > mode but this was not asked explicitly by the core, we don't really
> > > care, software filtering will apply anyway.
> > >
> >
> > I doubt that I will be happy with this solution, this all sounds like
> > "for the specific current behaviour that we support 2 filtering levels
> > it will work", just do a parameter on which 802.15.4 filtering level
> > it was received and the rx path will check what kind of filter is
> > required and which not.
> > As driver ops start() callback you should say which filtering level
> > the receive mode should start with.
> >
> > > I am reworking the rx path to clarify what is being done and when,
> > > because I found this part very obscure right now. In the end I don't
> > > think we need additional rx info from the drivers. Hopefully my
> > > proposal will clarify why this is (IMHO) not needed.
> > >
> >
> > Never looked much in 802.15.4 receive path as it just worked but I
> > said that there might be things to clean up when filtering things on
> > hardware and when on software and I have the feeling we are doing
> > things twice. Sometimes it is also necessary to set some skb fields
> > e.g. PACKET_HOST, etc. and I think this is what the most important
> > part of it is there. However, there are probably some tune ups if we
> > know we are in third leveling filtering...
>
> Ok, I've done the following.
>
> - Adding a PHY parameter which reflects the actual filtering level of
>   the transceiver, the default level is 4 (standard situation, you're

3?

>   receiving data) but of course if the PHY does not support this state
>   (like hwsim) it should overwrite this value by setting the actual
>   filtering level (none, in the hwsim case) so that the core knows what
>   it receives.
>

ok.

> - I've replaced the specific "do not check the FCS" flag only used by
>   hwsim by this filtering level, which gives all the information we
>   need.
>

ok.

> - I've added a real promiscuous filtering mode which truly does not
>   care about the content of the frame but only checks the FCS if not
>   already done by the xceiver.
>

not sure what a "real promiscuous filtering here is" people have
different understanding about it, but 802.15.4 has a definition for
it. You should consider that having monitors, frames with bad fcs
should not be filtered out by hardware. There it comes back what I
said before, the filtering level should be a parameter for start()
driver ops.

> - I've also implemented in software filtering level 4 for most regular

3?

>   data packets. Without changing the default PHY level mentioned in the
>   first item above, this additional filtering will be skipped which
>   ensures we keep the same behavior of most driver. In the case of hwsim
>   however, these filters will become active if the MAC is not in
>   promiscuous mode or in scan mode, which is actually what people
>   should be expecting.
>

To give feedback to that I need to see code. And please don't send the
whole feature stuff again, just this specific part of it. Thanks.

> Hopefully all this fits what you had in mind.
>
> I have one item left on my current todo list: improving a bit the
> userspace tool with a "monitor" command.
>
> Otherwise the remaining things to do are to discuss the locking design
> which might need to be changed to avoid lockdep issues and keep the
> rtnl locked eg. during a channel change. I still don't know how to do
> that, so it's likely that the right next version will not include any
> change in this area unless something pops up.

I try to look at that on the weekend.

- Alex

