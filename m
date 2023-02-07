Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F0C05027
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Feb 2023 00:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjBGA3x (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjBGA3r (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Feb 2023 19:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54031E0B
        for <linux-wpan@vger.kernel.org>; Mon,  6 Feb 2023 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675729723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR8gNmrQrNo2Gv81DzGnwIaPbLzejYY73cC+JieUkbw=;
        b=G3Fpi0cMjzg73UJvkXOZgnSIQzoYQlNzqrHx8HbKB6F52wE+IVtNIwvCATYD2tXxt1udq+
        wHYKrx25gWgL1qKQMxkro2EadR32dkstaLJK4DGTDLvQsrtSz34MvcYRJHF5GmmOAO8g+X
        PVve5v/blqSIfHuOEQJ8pCVq4zXo/bs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-WM5MVzyxNROBhZeqDrSHuA-1; Mon, 06 Feb 2023 19:28:41 -0500
X-MC-Unique: WM5MVzyxNROBhZeqDrSHuA-1
Received: by mail-ed1-f70.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso8790655edw.4
        for <linux-wpan@vger.kernel.org>; Mon, 06 Feb 2023 16:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR8gNmrQrNo2Gv81DzGnwIaPbLzejYY73cC+JieUkbw=;
        b=v7/cn/2IKuoDtaontsPSEml9PUFvSOe/rOU26ejOnVdNhYP8dYceIrj0ezAHtPFl5U
         srtm6UOIMIBtUFneiP3p/OEpSbcPX6o+mgTypVHpdr7VoDDU2IQ4oindSm9NKyA7uskC
         8AXDa+geRvKE+lD5Wg9o8sDukQLwU8PSP11GxkvKP1BSqH6LAUoQptw1CO1uZVJcIp/+
         bZYgOi9WGwjIaytj7xb0MxITuOoRaXTAu1sOPdlOWOhCZR3bPvxmFeRSvY81X4vKzGHN
         +oLHRrGvji5RXFlu3SDbb7KATv2dNKEzqkawgyxyKjdgcvYtfCIeZiSHjt2DUjw0qmKE
         hTiA==
X-Gm-Message-State: AO0yUKUkp4myPahh6BaGMqS4JIdMTS01kUaJyFtM6S7sENGta4ryxeux
        2URTrSgg0d6xJ6Gh+YVfzIr4kdPDMC2QWvv/QENtOpsffO+sxxRR7w+ao/8m3voPHlhj9rrx4x/
        +y++M2nNWuTBVNmulYRdcoKo129wrJtVTgHxqUQ==
X-Received: by 2002:a50:bb65:0:b0:499:cfee:8d96 with SMTP id y92-20020a50bb65000000b00499cfee8d96mr423690ede.21.1675729717735;
        Mon, 06 Feb 2023 16:28:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/hdhz3HlNvzMPzFbBltC0we4bh7zRRGwrurV4bN1yT8/SArzlEGvZpDmXyzJR2veHES5PlCVDBA9PqACqGFTk=
X-Received: by 2002:a50:bb65:0:b0:499:cfee:8d96 with SMTP id
 y92-20020a50bb65000000b00499cfee8d96mr423685ede.21.1675729717517; Mon, 06 Feb
 2023 16:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20230130154306.114265-1-miquel.raynal@bootlin.com>
 <f604d39b-d801-8373-9d8f-e93e429b7cdd@datenfreihafen.org> <CAK-6q+iOXe2CQ=Bc4Ba8vK=M_hTW7cdJ5TormiHy5DJsiyr_BQ@mail.gmail.com>
 <20230131120346.65d42f25@xps-13> <CAK-6q+hge2XhTw87RM4+NJN_mRz7R7qb6Zo93dApUQe8V4=3Rg@mail.gmail.com>
 <20230206095334.404dcea8@xps-13>
In-Reply-To: <20230206095334.404dcea8@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 6 Feb 2023 19:28:26 -0500
Message-ID: <CAK-6q+jKTr2yTmYkcabT+y_r+_ZaeHBXJzymLwu2uvyrgS50Dw@mail.gmail.com>
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

On Mon, Feb 6, 2023 at 3:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 5 Feb 2023 20:37:45 -0500:
>
> > Hi,
> >
> > On Tue, Jan 31, 2023 at 6:03 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Mon, 30 Jan 2023 11:41:20 -0500:
> > >
> > > > Hi,
> > > >
> > > > On Mon, Jan 30, 2023 at 11:34 AM Stefan Schmidt
> > > > <stefan@datenfreihafen.org> wrote:
> > > > >
> > > > > Hello.
> > > > >
> > > > > On 30.01.23 16:43, Miquel Raynal wrote:
> > > > > > When compiling scan.c with C=1, Sparse complains with:
> > > > > >
> > > > > >     sparse:     expected unsigned short [usertype] val
> > > > > >     sparse:     got restricted __le16 [usertype] pan_id
> > > > > >     sparse: sparse: cast from restricted __le16
> > > > > >
> > > > > >     sparse:     expected unsigned long long [usertype] val
> > > > > >     sparse:     got restricted __le64 [usertype] extended_addr
> > > > > >     sparse: sparse: cast from restricted __le64
> > > > > >
> > > > > > The tool is right, both pan_id and extended_addr already are rightfully
> > > > > > defined as being __le16 and __le64 on both sides of the operations and
> > > > > > do not require extra endianness handling.
> > > > > >
> > > > > > Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > ---
> > > > > >   net/mac802154/scan.c | 4 ++--
> > > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > > > > > index cfbe20b1ec5e..8f98efec7753 100644
> > > > > > --- a/net/mac802154/scan.c
> > > > > > +++ b/net/mac802154/scan.c
> > > > > > @@ -419,8 +419,8 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
> > > > > >       local->beacon.mhr.fc.source_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
> > > > > >       atomic_set(&request->wpan_dev->bsn, -1);
> > > > > >       local->beacon.mhr.source.mode = IEEE802154_ADDR_LONG;
> > > > > > -     local->beacon.mhr.source.pan_id = cpu_to_le16(request->wpan_dev->pan_id);
> > > > > > -     local->beacon.mhr.source.extended_addr = cpu_to_le64(request->wpan_dev->extended_addr);
> > > > > > +     local->beacon.mhr.source.pan_id = request->wpan_dev->pan_id;
> > > > > > +     local->beacon.mhr.source.extended_addr = request->wpan_dev->extended_addr;
> > > > > >       local->beacon.mac_pl.beacon_order = request->interval;
> > > > > >       local->beacon.mac_pl.superframe_order = request->interval;
> > > > > >       local->beacon.mac_pl.final_cap_slot = 0xf;
> > > > >
> > > > > This patch has been applied to the wpan-next tree and will be
> > > > > part of the next pull request to net-next. Thanks!
> > > >
> > > > fyi: in my opinion, depending on system endianness this is actually a bug.
> > >
> > > Actually there are many uses of __le16 and __le64 for PAN IDs, short
> > > and extended addresses. I did follow the existing patterns, I think
> > > they are legitimate. Can you clarify what you think is a bug in the
> > > current state? I always feel a bit flaky when it comes to properly
> > > handling endianness, so all feedback welcome, if you have any hints
> > > of what should be fixed after this patch, I'll do it.
> > >
> >
> > net/ policy is so far I understood to always use endianness how it's
> > stored on wire. There is no bug that addresses are stored as little
> > endian, but there is a bug doing a conversion when it's not necessary.
> > In this example, so far I see, big endian does a byteswap here.
> > And as you figured there will be less byteswaps when it's stored as
> > little endian. Consider this in netlink, that we store things as it is
> > on wire (or in our case on air/wireless).
>
> Ah ok I get it: "keep the endianness as on the medium". All right so

Note: this is valid even for 802.15.4 UAPI. Just want to mention it again.

- Alex

