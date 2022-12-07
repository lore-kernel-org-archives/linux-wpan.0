Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E7CC352A1
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Dec 2022 13:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLGN2m (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLGN2l (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Dec 2022 08:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B62A726
        for <linux-wpan@vger.kernel.org>; Wed,  7 Dec 2022 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670419668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgseVJJ7WmF/bkqY12ysuOXBIUt4NeFY3wPrF5M9O48=;
        b=D53g6Cc2oOBP02wpzYzZxEgu1HUu4+5m9E+WAdsGo/WKHpOc6sFwVG8qqWBod0JPPrTgGN
        QdwcO5W3URqOLY0w8dbQC7bWoOzGb61OCWJnRru77SlzCKEhh90mb/xOdG+zGEiS3uvwZx
        H5Gm6v0mGwDBeDZJjnXBixvj8ZIuQ+I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-BGbpF3sHPDqn1eNWrJGHDw-1; Wed, 07 Dec 2022 08:27:47 -0500
X-MC-Unique: BGbpF3sHPDqn1eNWrJGHDw-1
Received: by mail-ed1-f71.google.com with SMTP id t4-20020a056402524400b004620845ba7bso9898858edd.4
        for <linux-wpan@vger.kernel.org>; Wed, 07 Dec 2022 05:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgseVJJ7WmF/bkqY12ysuOXBIUt4NeFY3wPrF5M9O48=;
        b=ODqjmM6in7tQgyceh21pYD1bQjqDqzolc7XraR7Q/TH7ypM1kqa8sSA2qdkTpFuJfH
         YJRk3V1WEsZ14OhGe51hagB+YPXXiIN19NG/YhJbl0qpFzMNINPcL58AaCfhEG5TFPw3
         B79FefJ+dSkjUgvi1cW4wyKcPraPSZ9xPEhbyu/ByFOGSdOCBhiI2lvC8viLh80V7BLg
         H6j3uNGRWenxKTu5TbUDVktNkJCegPno5rxWU5GLA90hgl/GMyV7fyvyyBTftNvggePR
         GIzczaV5fW8W2R6YKfcOTTWUBEu2iGDWcuBRRRTO5of7GAXmHnGOaqeM9U62w4lOSo4W
         aiVA==
X-Gm-Message-State: ANoB5pmlyAo2hXaj19cli+lI1pqnvXVMlkq+nTHpM6a1LgS0U5ApRhfY
        P/INArcf9thYhIi+is+7Bq1Vor9J7gHV9Ou/82dMujViZUivpYkvLDAcjh+NbcvmOFUY84qe8vm
        yGWurvw8AXH0AiA4b9Xt+K9cznenB1B3mE8aUFA==
X-Received: by 2002:a17:906:5213:b0:7b6:12ee:b7fc with SMTP id g19-20020a170906521300b007b612eeb7fcmr26594407ejm.265.1670419666543;
        Wed, 07 Dec 2022 05:27:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf67irLKAhKJ09wvrN0Zjv57UM6SGBsIBFclXQBMjowd46Ks1m+PWeKD3PYjWDoSQH2kOu62XxegHyeNHVreuP8=
X-Received: by 2002:a17:906:5213:b0:7b6:12ee:b7fc with SMTP id
 g19-20020a170906521300b007b612eeb7fcmr26594396ejm.265.1670419666308; Wed, 07
 Dec 2022 05:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+hjXKmOrf-p=hRzuD=4pOJeWNUu46iU8YAVL4BqWC437A@mail.gmail.com>
 <20221205105752.6ce87721@xps-13>
In-Reply-To: <20221205105752.6ce87721@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 7 Dec 2022 08:27:35 -0500
Message-ID: <CAK-6q+hMDMGqpNzStXu+tpGgwn13mYqRgAKUJQXdA3eWi-rsGQ@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 4:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 4 Dec 2022 17:44:24 -0500:
>
> > Hi,
> >
> > On Tue, Nov 29, 2022 at 11:02 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > The ieee802154 layer should be able to scan a set of channels in order
> > > to look for beacons advertizing PANs. Supporting this involves adding
> > > two user commands: triggering scans and aborting scans. The user should
> > > also be notified when a new beacon is received and also upon scan
> > > termination.
> > >
> > > A scan request structure is created to list the requirements and to be
> > > accessed asynchronously when changing channels or receiving beacons.
> > >
> > > Mac layers may now implement the ->trigger_scan() and ->abort_scan()
> > > hooks.
> > >
> > > Co-developed-by: David Girault <david.girault@qorvo.com>
> > > Signed-off-by: David Girault <david.girault@qorvo.com>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/linux/ieee802154.h |   3 +
> > >  include/net/cfg802154.h    |  25 +++++
> > >  include/net/nl802154.h     |  49 +++++++++
> > >  net/ieee802154/nl802154.c  | 215 +++++++++++++++++++++++++++++++++++++
> > >  net/ieee802154/nl802154.h  |   3 +
> > >  net/ieee802154/rdev-ops.h  |  28 +++++
> > >  net/ieee802154/trace.h     |  40 +++++++
> > >  7 files changed, 363 insertions(+)
> > >
> > > diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> > > index 0303eb84d596..b22e4147d334 100644
> > > --- a/include/linux/ieee802154.h
> > > +++ b/include/linux/ieee802154.h
> > > @@ -44,6 +44,9 @@
> > >  #define IEEE802154_SHORT_ADDR_LEN      2
> > >  #define IEEE802154_PAN_ID_LEN          2
> > >
> > > +/* Duration in superframe order */
> > > +#define IEEE802154_MAX_SCAN_DURATION   14
> > > +#define IEEE802154_ACTIVE_SCAN_DURATION        15
> > >  #define IEEE802154_LIFS_PERIOD         40
> > >  #define IEEE802154_SIFS_PERIOD         12
> > >  #define IEEE802154_MAX_SIFS_FRAME_SIZE 18
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index d09c393d229f..76d4f95e9974 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -18,6 +18,7 @@
> > >
> > >  struct wpan_phy;
> > >  struct wpan_phy_cca;
> > > +struct cfg802154_scan_request;
> > >
> > >  #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> > >  struct ieee802154_llsec_device_key;
> > > @@ -67,6 +68,10 @@ struct cfg802154_ops {
> > >                                 struct wpan_dev *wpan_dev, bool mode);
> > >         int     (*set_ackreq_default)(struct wpan_phy *wpan_phy,
> > >                                       struct wpan_dev *wpan_dev, bool ackreq);
> > > +       int     (*trigger_scan)(struct wpan_phy *wpan_phy,
> > > +                               struct cfg802154_scan_request *request);
> > > +       int     (*abort_scan)(struct wpan_phy *wpan_phy,
> > > +                             struct wpan_dev *wpan_dev);
> > >  #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> > >         void    (*get_llsec_table)(struct wpan_phy *wpan_phy,
> > >                                    struct wpan_dev *wpan_dev,
> > > @@ -278,6 +283,26 @@ struct ieee802154_coord_desc {
> > >         bool gts_permit;
> > >  };
> > >
> > > +/**
> > > + * struct cfg802154_scan_request - Scan request
> > > + *
> > > + * @type: type of scan to be performed
> > > + * @page: page on which to perform the scan
> > > + * @channels: channels in te %page to be scanned
> > > + * @duration: time spent on each channel, calculated with:
> > > + *            aBaseSuperframeDuration * (2 ^ duration + 1)
> > > + * @wpan_dev: the wpan device on which to perform the scan
> > > + * @wpan_phy: the wpan phy on which to perform the scan
> > > + */
> > > +struct cfg802154_scan_request {
> > > +       enum nl802154_scan_types type;
> > > +       u8 page;
> > > +       u32 channels;
> > > +       u8 duration;
> > > +       struct wpan_dev *wpan_dev;
> > > +       struct wpan_phy *wpan_phy;
> > > +};
> > > +
> > >  struct ieee802154_llsec_key_id {
> > >         u8 mode;
> > >         u8 id;
> > > diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> > > index b79a89d5207c..79fbd820b25a 100644
> > > --- a/include/net/nl802154.h
> > > +++ b/include/net/nl802154.h
> > > @@ -73,6 +73,9 @@ enum nl802154_commands {
> > >         NL802154_CMD_DEL_SEC_LEVEL,
> > >
> > >         NL802154_CMD_SCAN_EVENT,
> > > +       NL802154_CMD_TRIGGER_SCAN,
> > > +       NL802154_CMD_ABORT_SCAN,
> > > +       NL802154_CMD_SCAN_DONE,
> >
> > Is NL802154_CMD_SCAN_DONE reserved now? I don't see it implemented in
> > this series and I think we had some discussion about the need of abort
> > vs done. Is the event now?
>
> To be very honest I went back and forth about the "abort" information
> so I don't remember exactly what was supposed to be implemented. The
> current implementation forwards to userspace the reason (whether the
> scan was finished or was aborted for an external reason). So it is
> implemented this way:
>

I think it was also to implement a way to signal all listeners that
there is such an operation ongoing? Do we have something like that?

> * Patch 6/6 adds in mac802154/scan.c:
>
> +       cmd = aborted ? NL802154_CMD_ABORT_SCAN : NL802154_CMD_SCAN_DONE;
> +       nl802154_scan_done(wpan_phy, wpan_dev, cmd);
>
> * And in patch 1/6, in ieee802154/nl802154.c:
>
> +static int nl802154_send_scan_msg(struct cfg802154_registered_device *rdev,
> +                                 struct wpan_dev *wpan_dev, u8 cmd)
> +{
> [...]
> +
> +       ret = nl802154_prep_scan_msg(msg, rdev, wpan_dev, 0, 0, 0, cmd);
>
> Is this working for you?

Sure this works in some way, I would put a reason parameter on DONE,
but however...

- Alex

