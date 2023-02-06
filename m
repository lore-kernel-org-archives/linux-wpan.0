Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D8C636CD
	for <linux-wpan@archiver.kernel.org>; Mon,  6 Feb 2023 01:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBFBix (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 5 Feb 2023 20:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFBiv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Feb 2023 20:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A318147
        for <linux-wpan@vger.kernel.org>; Sun,  5 Feb 2023 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675647482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJNf25MQPqOmcnH6m5Zw/Z111+4Pcrl4UBVFceXoLg0=;
        b=dZW/tJql6doOcoXbGfbYulcR73sjvp7cGcEvO2Qq1fmNCsk8+KnQg14An2ymFD2IXPVeu9
        F+V2x6tIq9hbNXBW9PSQEdTQs7sZ/eumMe6RmlTeJ88V+KlxYKlptX9xHA1//f620mKJTq
        QHQYln+oUJUzrCTWPQjRwhvB24M2Ezk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-_jcSP2C2NcyyEtvxa2vYWg-1; Sun, 05 Feb 2023 20:38:01 -0500
X-MC-Unique: _jcSP2C2NcyyEtvxa2vYWg-1
Received: by mail-ej1-f70.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso7510917ejb.14
        for <linux-wpan@vger.kernel.org>; Sun, 05 Feb 2023 17:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJNf25MQPqOmcnH6m5Zw/Z111+4Pcrl4UBVFceXoLg0=;
        b=l/WG6L2kBI5F7rn+38NaaRUC+B0xSrfAK69slGwBdT6hQDzP3h26gAFApXkMgq1EUb
         1mPG4zhFoxKQGU4DOpRwW5J0qJWkLIark77M9xRtmHozVhVGuL7YdoWTNY1lBq1j0qY/
         0TSHiDt+5DyhdIjdUpMLxUJHHIATqA2FowKFWTpexPWqmebJOibdTylRUbbzKnSZEuBq
         ENJ70kaP27nV8pABzggjPt3b+1wHeeZNf4qr/E/SiucCUncY0a9hFTGGRokC1loovdOO
         DGC45KuMpx/6biABK18cul4n0YZ1JzxTRxleKrhBHc7iHjwzo3/4SFeuudMnKIWrQipD
         M5aQ==
X-Gm-Message-State: AO0yUKV7jp3GCS6kMSFql86mHw7Y3yOycTGw5NYpPT5oE9DMTIUZrFXk
        n87Qul2vwFm5YQ6H9xWMWW69S4qAMYjZPtXlwhgru41NOPRJgP/HsxYfpetjJnDy7drST9/sHUx
        fRv4Ea8htU1T1bcTX1rC0A7gl2shXHvEliizVUw==
X-Received: by 2002:a17:906:48b:b0:878:69e5:b797 with SMTP id f11-20020a170906048b00b0087869e5b797mr4238764eja.228.1675647477415;
        Sun, 05 Feb 2023 17:37:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+TOREn1ZBpd2uZYcTUHPN0DIGKY4EvdC8pqtWebIlDrvb6zNTsvSUM1t/SUbSBnkS48z8YJvUhDDazXFud6CY=
X-Received: by 2002:a17:906:48b:b0:878:69e5:b797 with SMTP id
 f11-20020a170906048b00b0087869e5b797mr4238750eja.228.1675647477240; Sun, 05
 Feb 2023 17:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20230130154306.114265-1-miquel.raynal@bootlin.com>
 <f604d39b-d801-8373-9d8f-e93e429b7cdd@datenfreihafen.org> <CAK-6q+iOXe2CQ=Bc4Ba8vK=M_hTW7cdJ5TormiHy5DJsiyr_BQ@mail.gmail.com>
 <20230131120346.65d42f25@xps-13>
In-Reply-To: <20230131120346.65d42f25@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 5 Feb 2023 20:37:45 -0500
Message-ID: <CAK-6q+hge2XhTw87RM4+NJN_mRz7R7qb6Zo93dApUQe8V4=3Rg@mail.gmail.com>
Subject: Re: [PATCH wpan-next] mac802154: Avoid superfluous endianness handling
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Jan 31, 2023 at 6:03 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Mon, 30 Jan 2023 11:41:20 -0500:
>
> > Hi,
> >
> > On Mon, Jan 30, 2023 at 11:34 AM Stefan Schmidt
> > <stefan@datenfreihafen.org> wrote:
> > >
> > > Hello.
> > >
> > > On 30.01.23 16:43, Miquel Raynal wrote:
> > > > When compiling scan.c with C=1, Sparse complains with:
> > > >
> > > >     sparse:     expected unsigned short [usertype] val
> > > >     sparse:     got restricted __le16 [usertype] pan_id
> > > >     sparse: sparse: cast from restricted __le16
> > > >
> > > >     sparse:     expected unsigned long long [usertype] val
> > > >     sparse:     got restricted __le64 [usertype] extended_addr
> > > >     sparse: sparse: cast from restricted __le64
> > > >
> > > > The tool is right, both pan_id and extended_addr already are rightfully
> > > > defined as being __le16 and __le64 on both sides of the operations and
> > > > do not require extra endianness handling.
> > > >
> > > > Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >   net/mac802154/scan.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > > > index cfbe20b1ec5e..8f98efec7753 100644
> > > > --- a/net/mac802154/scan.c
> > > > +++ b/net/mac802154/scan.c
> > > > @@ -419,8 +419,8 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
> > > >       local->beacon.mhr.fc.source_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
> > > >       atomic_set(&request->wpan_dev->bsn, -1);
> > > >       local->beacon.mhr.source.mode = IEEE802154_ADDR_LONG;
> > > > -     local->beacon.mhr.source.pan_id = cpu_to_le16(request->wpan_dev->pan_id);
> > > > -     local->beacon.mhr.source.extended_addr = cpu_to_le64(request->wpan_dev->extended_addr);
> > > > +     local->beacon.mhr.source.pan_id = request->wpan_dev->pan_id;
> > > > +     local->beacon.mhr.source.extended_addr = request->wpan_dev->extended_addr;
> > > >       local->beacon.mac_pl.beacon_order = request->interval;
> > > >       local->beacon.mac_pl.superframe_order = request->interval;
> > > >       local->beacon.mac_pl.final_cap_slot = 0xf;
> > >
> > > This patch has been applied to the wpan-next tree and will be
> > > part of the next pull request to net-next. Thanks!
> >
> > fyi: in my opinion, depending on system endianness this is actually a bug.
>
> Actually there are many uses of __le16 and __le64 for PAN IDs, short
> and extended addresses. I did follow the existing patterns, I think
> they are legitimate. Can you clarify what you think is a bug in the
> current state? I always feel a bit flaky when it comes to properly
> handling endianness, so all feedback welcome, if you have any hints
> of what should be fixed after this patch, I'll do it.
>

net/ policy is so far I understood to always use endianness how it's
stored on wire. There is no bug that addresses are stored as little
endian, but there is a bug doing a conversion when it's not necessary.
In this example, so far I see, big endian does a byteswap here.
And as you figured there will be less byteswaps when it's stored as
little endian. Consider this in netlink, that we store things as it is
on wire (or in our case on air/wireless).

- Alex

