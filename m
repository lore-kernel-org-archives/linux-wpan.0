Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C42C3DA7A
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Jan 2023 01:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjACBQZ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjACBQW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2023 20:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2DD188
        for <linux-wpan@vger.kernel.org>; Mon,  2 Jan 2023 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672708539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVPzk5o7igQTGpKeVYQ3N+jhV1xQAhqlOB2+IYBNkrg=;
        b=Njrkiv/2H+9nvZ2uqo8S9eJZkESS3GszryPKWHtFWdM29D13YlZCcUpAZUFjVGjQHIqog/
        Rb+4A0qcuJ+/UOrJe2H7oPVcwqpzKTub20tgbn27Ay28PJaij8PqvtsL3GBDl53SXk15Hw
        WGfB97YHzeVRy9O1Av09lXpf8VHUTPY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-4MQrPI2xOzqKXLMFTAkbbg-1; Mon, 02 Jan 2023 20:15:38 -0500
X-MC-Unique: 4MQrPI2xOzqKXLMFTAkbbg-1
Received: by mail-ej1-f69.google.com with SMTP id qb2-20020a1709077e8200b00842b790008fso18336218ejc.21
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jan 2023 17:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVPzk5o7igQTGpKeVYQ3N+jhV1xQAhqlOB2+IYBNkrg=;
        b=I3EZcM+cFrPB7cI7NtZg572O3havbj8ZCrOBsPHLHppsyeuANKhHsLbZdtZYjqqxBp
         LAAYmWEeFvesKUQYumXkOy9SsRm4VBlJ0j7y909H/2GRo6lrGvJ3UjjcjbbsxTtp5gqO
         BqRwCt6ox8dqf9AfyBCPqNveM9LZQc4nea/CI70uMWPLhq2ycMV5mj9WYVHI3lAxL1mB
         VrOkqQEaDUA6buCiUR9hG6izuxuVSMdw6iuja7KZ88yRhFidkr/amC7aIimL1xtdFlqL
         CsNKTfmAcM+7CqtY518G8tY241nBtKe0cvNmFHaLBzf5+Ra3+MT3Ne+9ceZRwG3090iy
         ICDQ==
X-Gm-Message-State: AFqh2kpIpqVMA0BZgZxim5XE+yEvxfCseAYfeuAzYp7VjqGNE9zLE04A
        CCFlzI0z/nPU5LMDnIvmvDOaBcGiDQt6/eJWjuhNMoeAYdktqrtx+yuwWIiI/ZyRVwLucNeiZC/
        17qvFuf9uz4KkWXHePlsQx+7Gt8b6YCOLiaIjog==
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id fc18-20020a1709073a5200b007c0e23f17cdmr2418550ejc.491.1672708537449;
        Mon, 02 Jan 2023 17:15:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXteZAesA4qZFLpE6BVuBQWONnaun6dqv2r41kHwVwYftYROWzRaXXqCpu+eRY8AE1t34DS+y77wm++FEdG2dOg=
X-Received: by 2002:a17:907:3a52:b0:7c0:e23f:17cd with SMTP id
 fc18-20020a1709073a5200b007c0e23f17cdmr2418538ejc.491.1672708537107; Mon, 02
 Jan 2023 17:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20221217000226.646767-1-miquel.raynal@bootlin.com>
 <20221217000226.646767-7-miquel.raynal@bootlin.com> <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
In-Reply-To: <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 2 Jan 2023 20:15:25 -0500
Message-ID: <CAK-6q+gTQwS5n+YVFDeGTqEnSREt9KjC58zq9r2c8T456zXagQ@mail.gmail.com>
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
>
> ... and happy new year.
>
> I wanted to ack this series but this came into my mind. I also wanted
> to check what exactly happens when a mlme op returns an error like
> channel access failure? Do we ignore it? Do we do cond_resched() and
> retry again later? I guess these are questions only if we get into
> active scanning with more exciting sending of frames, because here we
> don't transmit anything.

Ignore that above about stopping the transceiver being in receive
mode, you are right... you cannot know on which channel/page
combination the beacon was received because as the comment says, it is
not atomic to switch it... sadly the transceiver does not tell us that
on a per frame basis.

Sorry for the noise. Still with my previous comments why it's still
valid to switch channels while phy is in receive mode but not in scan
mode, I would say if a user does that... then we don't care. Some
offloaded parts and softMAC handling still need indeed to be
synchronized because we don't know how a transceiver reacts on it to
change registers there while transmitting.

- Alex

