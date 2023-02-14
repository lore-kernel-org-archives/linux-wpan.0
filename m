Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B65C61DA4
	for <linux-wpan@archiver.kernel.org>; Tue, 14 Feb 2023 13:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBNNxo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 14 Feb 2023 08:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBNNxn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Feb 2023 08:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BC28216
        for <linux-wpan@vger.kernel.org>; Tue, 14 Feb 2023 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676382686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83QmTK/OxRsSR+M63k5tbNt8PwWczCTZs++ini0mCYI=;
        b=AuCtNNTWreNhB4jhLQYBF0pFoT9XZOEoN84NnFgeQ9UO9h4U6PP1qddVsBaATxMJh6HZct
        nEk3aXuc5p18IDrC0fHXSU1MIl0A7HMah+K4a3/6BH/6MsZlIRAKj29kdrdF1eIZ+tS/SG
        F1RxjSKiX/rE3PIZNuLz2GVotvAT4EY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-DmMX8UhYPWiuOyWG5DSrHA-1; Tue, 14 Feb 2023 08:51:25 -0500
X-MC-Unique: DmMX8UhYPWiuOyWG5DSrHA-1
Received: by mail-ed1-f69.google.com with SMTP id y17-20020a056402359100b004acc4f8aa3fso4418443edc.3
        for <linux-wpan@vger.kernel.org>; Tue, 14 Feb 2023 05:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83QmTK/OxRsSR+M63k5tbNt8PwWczCTZs++ini0mCYI=;
        b=rK+FPNBuDIR38zq0RlSJdBUwJWyAIk6DhHy2DeRNo4SC9Pgh5fR80G+yN8X9MdiK8V
         F1NXzjl3N3JYKXtEDsD4B8N3pkjSzUZAmDHrVekyPZd3FsXxiODe4Q9cXjqjsADBWc8B
         MPiMVZqtkA478epC4MGJL3diA1PB1eHYVlelghG0J3nDZLb1d8/2HIWCtnwKrKnoFzJ4
         i8fPIkmXA1LA/mrMBpEwGf2B3yEa+corRztUcyR0ofQNcqgiVghl7TH9gS0Az80bYdC/
         /hKb8Z4RD4PHFXfszyavPZrVCI8xYrEtNEF+1YkhONZeNhN7eQQMm+Xy1iNtlsJaFjXX
         N7pw==
X-Gm-Message-State: AO0yUKVo7o85IqxsBK+M7Cvc29kQlF4x35N0ksOLRMV6eGjw7aRvoZbi
        1qaDfjWZRoSIW6zGff2G7aDXbkMe2ds0zfICYX/+QPauK4kRRxZYfBwmcwLpEakFfxbpakxJHi5
        G0umTxnsRSfpAxsc4ItP/OyXYRN/hnarLGxEbJA==
X-Received: by 2002:a17:906:c30f:b0:87a:56fc:9df1 with SMTP id s15-20020a170906c30f00b0087a56fc9df1mr1325588ejz.3.1676382684305;
        Tue, 14 Feb 2023 05:51:24 -0800 (PST)
X-Google-Smtp-Source: AK7set9m576Bio3TX1Ux+Z0xR6qbElZ1ec1kFotbUaFTfhNVnakbneez3NE3Vl9TsjQMlTrfFEqdQL5gZPUtRd6ldnY=
X-Received: by 2002:a17:906:c30f:b0:87a:56fc:9df1 with SMTP id
 s15-20020a170906c30f00b0087a56fc9df1mr1325581ejz.3.1676382684065; Tue, 14 Feb
 2023 05:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+iwqVx+6qQ-ctynykdrbN+SHxzk91gQCSdYCUD-FornZA@mail.gmail.com>
 <20230206101235.0371da87@xps-13> <CAK-6q+jav4yJD3MsOssyBobg1zGqKC5sm-xCRYX1SCkH9GhmHw@mail.gmail.com>
 <20230210182129.77c1084d@xps-13> <CAK-6q+jLKo1bLBie_xYZyZdyjNB_M8JvxDfr77RQAY9WYcQY8w@mail.gmail.com>
 <20230213111553.0dcce5c2@xps-13>
In-Reply-To: <20230213111553.0dcce5c2@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 14 Feb 2023 08:51:12 -0500
Message-ID: <CAK-6q+jP55MaB-_ZbRHKESgEb-AW+kN3bU2SMWMtkozvoyfAwA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] ieee802154: Add support for user scanning requests
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

On Mon, Feb 13, 2023 at 5:16 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> > > > > > > +static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
> > > > > > > +{
> > > > > > > +       struct cfg802154_registered_device *rdev = info->user_ptr[0];
> > > > > > > +       struct net_device *dev = info->user_ptr[1];
> > > > > > > +       struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> > > > > > > +       struct wpan_phy *wpan_phy = &rdev->wpan_phy;
> > > > > > > +       struct cfg802154_scan_request *request;
> > > > > > > +       u8 type;
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       /* Monitors are not allowed to perform scans */
> > > > > > > +       if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > > > > > > +               return -EPERM;
> > > > > >
> > > > > > btw: why are monitors not allowed?
> > > > >
> > > > > I guess I had the "active scan" use case in mind which of course does
> > > > > not work with monitors. Maybe I can relax this a little bit indeed,
> > > > > right now I don't remember why I strongly refused scans on monitors.
> > > >
> > > > Isn't it that scans really work close to phy level? Means in this case
> > > > we disable mostly everything of MAC filtering on the transceiver side.
> > > > Then I don't see any reasons why even monitors can't do anything, they
> > > > also can send something. But they really don't have any specific
> > > > source address set, so long addresses are none for source addresses, I
> > > > don't see any problem here. They also don't have AACK handling, but
> > > > it's not required for scan anyway...
> > >
> > > I think I remember why I did not want to enable scans on monitors: we
> > > actually change the filtering level to "scan", which is very
> > > different to what a monitor is supposed to receive, which means in scan
> > > mode a monitor would no longer receive all what it is supposed to
> > > receive. Nothing that cannot be workaround'ed by software, probably,
> > > but I believe it is safer right now to avoid introducing potential
> > > regressions. So I will just change the error code and still refuse
> > > scans on monitor interfaces for now, until we figure out if it's
> > > actually safe or not (and if we really want to allow it).
> > >
> >
> > Okay, for scan yes we tell them to be in scan mode and then the
> > transceiver can filter whatever it delivers to the next level which is
> > necessary for filtering scan mac frames only. AACK handling is
> > disabled for scan mode for all types != MONITORS.
> >
> > For monitors we mostly allow everything and AACK is _always_ disabled.
> > The transceiver filter is completely disabled for at least what looks
> > like a 802.15.4 MAC header (even malformed). There are some frame
> > length checks which are necessary for specific hardware because
> > otherwise they would read out the frame buffer. For me it can still
> > feed the mac802154 stack for scanning (with filtering level as what
> > the monitor sets to, but currently our scan filter is equal to the
> > monitor filter mode anyway (which probably can be changed in
> > future?)). So in my opinion the monitor can do both -> feed the scan
> > mac802154 deliver path and the packet layer. And I also think that on
> > a normal interface type the packet layer should be feeded by those
> > frames as well and do not hit the mac802154 layer scan path only.
>
> Actually that would be an out-of-spec situation, here is a quote of
> chapter "6.3.1.3 Active and passive channel scan"
>
>         During an active or passive scan, the MAC sublayer shall
>         discard all frames received over the PHY data service that are
>         not Beacon frames.
>

Monitor interfaces are not anything that the spec describes, it is
some interface type which offers the user (mostly over AF_PACKET raw
socket) full phy level access with the _default_ options. I already
run user space stacks (for hacking/development only) on monitor
interfaces to connect with Linux 802.15.4 interfaces, e.g. see [0]
(newer came upstream, somewhere I have also a 2 years old updated
version, use hwsim not fakelb).

In other words, by default it should bypass 802.15.4 MAC and it still
conforms with your spec, just that it is in user space. However, there
exists problems to do that, but it kind of works for the most use
cases. I said here by default because some people have different use
cases of what they want to do in the kernel. e.g. encryption (so users
only get encrypted frames, etc.) We don't support that but we can,
same for doing a scan. It probably requires just more mac802154 layer
filtering.

There are enough examples in wireless that they do "crazy" things and
you can do that only with SoftMAC transceivers because it uses more
software parts like mac80211 and HardMAC transceivers only do what the
spec says and delivers it to the next layer. Some of them have more
functionality I guess, but then it depends on driver implementation
and a lot of other things.

Monitors also act as a sniffer device, but you _could_ also send
frames out and then the fun part begins.

> I don't think this is possible to do anyway on devices with a single
> hardware filter setting?
>

On SoftMAC it need to support a filtering level where we can disable
all filtering and get 802.15.4 MAC frames like it's on air (even
without non valid checksum, but we simply don't care if the
driver/transceiver does not support it we will always confirm it is
correct again until somebody comes around and say "oh we can do FCS
level then mac802154 does not need to check on this because it is
always correct")... This is currently the NONE filtering level I
think?

For HardMAC it is more complicated; they don't do that, they do the
"scan" operation on their transceiver and you can dump the result and
probably never forward any beacon related frames? (I had this question
once when Michael Richardson replied).

- Alex

[0] https://github.com/RIOT-OS/RIOT/pull/5582

