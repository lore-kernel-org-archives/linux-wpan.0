Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E6C53210
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Jan 2023 01:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjACBHu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjACBHt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2023 20:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE16462
        for <linux-wpan@vger.kernel.org>; Mon,  2 Jan 2023 17:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672708022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rKEcniu8y/j8TL1AS2/CkwoKpYsBCNUv3gh7eqUlJA=;
        b=gZb9Uw4wCWKX+gIF72ag37eMjCwReSR0E4rc5WIQcVncHlpdp9xf98xsBHCmJABObxNyVO
        w0r7h347ksjo7PAmIsmbri9Pdx8SL1gFIQL9oyw8LtAMtKkKzoAe3iF6+WWZrKPbx/Y0hT
        gGpygrWBltRAYgP7ydckPlYOkNdNFnk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-ban7W5gyME2nSzXFgHtU6Q-1; Mon, 02 Jan 2023 20:07:01 -0500
X-MC-Unique: ban7W5gyME2nSzXFgHtU6Q-1
Received: by mail-ed1-f69.google.com with SMTP id b16-20020a056402279000b0046fb99731e6so18417422ede.1
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jan 2023 17:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rKEcniu8y/j8TL1AS2/CkwoKpYsBCNUv3gh7eqUlJA=;
        b=dbZv1CSFOngbp7LjYX4fxv9Wxboa13Pxx56SYzOWtDYGE6cU5NvE7rVrL9pjKJAO/1
         goyCfcGawJ4s9s1sSsLHqvrDQOPbdjbWIPKcBrTxtsKOy+TGYd7IBK1fyul+8+NezYW1
         niYQ1no6zB7tgS0w+x5ApEx8g//OBVOTzwppz84axMiVnBSYvVeDr/eCPe+DArAqDhVg
         zIy9hlEhZXnjVHChzhnlmV384ScT+jPuyh6ErozZ/1XfTrAtggnV99dI4j/XQoPXFb0F
         PKYCJ9AzmyKkcyuIqP7yTaqtzY+6TvfORuxX9eMHpaZmshTGAAI4f8SW2LaxsbCfzH5d
         mGfQ==
X-Gm-Message-State: AFqh2krUUNsCh8XopsghL2R+AOrXh2THWHFzFQlIFmJ/CNa+jV1wV0YK
        PoUO1Lq+mv/vaML0IHJhUtDQgscSQRq9OGwF7x57BjjdvwuK0xQ/3uIKyg7oqhDN965O0wwZVZr
        Ld1USBQS3hEep/A0G4ZJ2zjd5GpRR75GKThTniw==
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id fc18-20020a1709073a5200b007c0e23f17cdmr2417533ejc.491.1672708020284;
        Mon, 02 Jan 2023 17:07:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt3q5LA1m8FiqaIblOq7WJyUm+jPTcHob2DMXpvnMkMn4dCRH6N8MxN8HQFzDbmx9rx6TqSg3QO+KDnIR7ZQrg=
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id
 fc18-20020a1709073a5200b007c0e23f17cdmr2417528ejc.491.1672708020144; Mon, 02
 Jan 2023 17:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20221217000226.646767-1-miquel.raynal@bootlin.com>
 <20221217000226.646767-7-miquel.raynal@bootlin.com> <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
In-Reply-To: <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 2 Jan 2023 20:06:49 -0500
Message-ID: <CAK-6q+hWBAPB=qT+nH29rzn_Up8UO+FYgTJ+GHH1TWJYu=2B5g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 6/6] mac802154: Handle passive scanning
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Jan 2, 2023 at 8:04 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Fri, Dec 16, 2022 at 7:04 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> ...
> > +void mac802154_scan_worker(struct work_struct *work)
> > +{
> > +       struct ieee802154_local *local =
> > +               container_of(work, struct ieee802154_local, scan_work.work);
> > +       struct cfg802154_scan_request *scan_req;
> > +       struct ieee802154_sub_if_data *sdata;
> > +       unsigned int scan_duration = 0;
> > +       struct wpan_phy* wpan_phy;
> > +       u8 scan_req_duration;
> > +       u8 page, channel;
> > +       int ret;
> > +
> > +       /* Ensure the device receiver is turned off when changing channels
> > +        * because there is no atomic way to change the channel and know on
> > +        * which one a beacon might have been received.
> > +        */
> > +       drv_stop(local);
> > +       synchronize_net();
>
> Do we do that for every channel switch? I think this is not necessary.
> It is necessary for bringing the transceiver into scan filtering mode,
> but we don't need to do that for switching the channel.
>
> And there is a difference why we need to do that for filtering. In my
> mind I had the following reason that the MAC layer is handled in Linux
> (softMAC) and by offloaded parts on the transceiver, this needs to be
> synchronized. The PHY layer is completely on the transceiver side,
> that's why you can switch channels during interface running. There
> exist some MAC parameters which are offloaded to the hardware and are
> currently not possible to synchronize while an interface is up,
> however this could change in future because the new helpers to
> synchronize softmac/transceiver mac handling.
>
> There is maybe a need here to be sure everything is transmitted on the
> hardware before switching the channel, but this should be done by the
> new mlme functionality which does a synchronized transmit. However we
> don't transmit anything here, so there is no need for that yet. We
> should never stop the transceiver being into receive mode and during
> scan we should always be into receive mode in
> IEEE802154_FILTERING_3_SCAN level without never leaving it.

s/without/and/

- Alex

