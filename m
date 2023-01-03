Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED8C3DA7A
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Jan 2023 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjACBFW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjACBFV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2023 20:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B639E
        for <linux-wpan@vger.kernel.org>; Mon,  2 Jan 2023 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672707872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=833D69flNGoAhTElO37GsAV9tlud8Fu/bVYJk2LoT2w=;
        b=WBDtSfhWBYgio8JnnAPqoBHQBea8Ph7G7gjCws7iPKISTmwJ71J7yBlGdzt8uFyrLtcGPN
        sMyuT3S3GHMns4RliJdqYH8NcBwi6zn9jnLJvz4ztYRynbjCWWjqc+4TGfSz/+QqOXLJCb
        rnr7ryU8H3tsUx+/tr9NqTd3wC/id8g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-0_YiWBNHNoa-IxKv5PoD8g-1; Mon, 02 Jan 2023 20:04:31 -0500
X-MC-Unique: 0_YiWBNHNoa-IxKv5PoD8g-1
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso9605240edd.10
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jan 2023 17:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=833D69flNGoAhTElO37GsAV9tlud8Fu/bVYJk2LoT2w=;
        b=YvbeNTCq0PsYpsX32cZruLxOLD5mamEvnGYj266BQQMlKn4u7wTa370e1Of74zZBDC
         2srJuOJqHwKUsk+QgYpDp08Q7DCXkQFnXpiBRweos3LViRoDHfstOTlxJq+R9Gl5tTdo
         f2c5rEn40gzcLrL8a5mACcu5YdCbLHZPgOrfyxcK4voY7UP4nE4F3pnwW6BbdidPZo5P
         5yYQioeBrAClICggWDavdJLfOAS1cR9ns+K8Ff32iFWQL3YTnXSZonN+VZsWH7Knvtjx
         htqBnZ/KraGc8NXBZI5JS+z4ekhxRPKfS+hPzw60nGHUxJKVF9bZ8EGF+oVyTJV+Fx7m
         5kjw==
X-Gm-Message-State: AFqh2krh4JCkqAoD0f6gSMr8im/9nHLnHTXzTe3lv82J3+QOwkN9PSe1
        D58pHNiN/n52SiKRydvJBLaCCoCOtyjqBqyQqkutf5jkLY9CeUevu92G0mA0AdUVuI3vPTt2hlW
        9mh6tghofDsnx2psfq/ogPHx7n+sbC8e/LJ7HNg==
X-Received: by 2002:a17:906:340c:b0:7c0:fe68:9c2e with SMTP id c12-20020a170906340c00b007c0fe689c2emr2650940ejb.278.1672707869902;
        Mon, 02 Jan 2023 17:04:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsLJSyUgBSOGCF6PmMszSZr7X8B+YXodDNQCg7PaXocuGdsb1DH23N9iDoZiQEjH6I005AxKcry5AehhYt9Ni4=
X-Received: by 2002:a17:906:340c:b0:7c0:fe68:9c2e with SMTP id
 c12-20020a170906340c00b007c0fe689c2emr2650938ejb.278.1672707869682; Mon, 02
 Jan 2023 17:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20221217000226.646767-1-miquel.raynal@bootlin.com> <20221217000226.646767-7-miquel.raynal@bootlin.com>
In-Reply-To: <20221217000226.646767-7-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 2 Jan 2023 20:04:18 -0500
Message-ID: <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 7:04 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
> +void mac802154_scan_worker(struct work_struct *work)
> +{
> +       struct ieee802154_local *local =
> +               container_of(work, struct ieee802154_local, scan_work.work);
> +       struct cfg802154_scan_request *scan_req;
> +       struct ieee802154_sub_if_data *sdata;
> +       unsigned int scan_duration = 0;
> +       struct wpan_phy* wpan_phy;
> +       u8 scan_req_duration;
> +       u8 page, channel;
> +       int ret;
> +
> +       /* Ensure the device receiver is turned off when changing channels
> +        * because there is no atomic way to change the channel and know on
> +        * which one a beacon might have been received.
> +        */
> +       drv_stop(local);
> +       synchronize_net();

Do we do that for every channel switch? I think this is not necessary.
It is necessary for bringing the transceiver into scan filtering mode,
but we don't need to do that for switching the channel.

And there is a difference why we need to do that for filtering. In my
mind I had the following reason that the MAC layer is handled in Linux
(softMAC) and by offloaded parts on the transceiver, this needs to be
synchronized. The PHY layer is completely on the transceiver side,
that's why you can switch channels during interface running. There
exist some MAC parameters which are offloaded to the hardware and are
currently not possible to synchronize while an interface is up,
however this could change in future because the new helpers to
synchronize softmac/transceiver mac handling.

There is maybe a need here to be sure everything is transmitted on the
hardware before switching the channel, but this should be done by the
new mlme functionality which does a synchronized transmit. However we
don't transmit anything here, so there is no need for that yet. We
should never stop the transceiver being into receive mode and during
scan we should always be into receive mode in
IEEE802154_FILTERING_3_SCAN level without never leaving it.

... and happy new year.

I wanted to ack this series but this came into my mind. I also wanted
to check what exactly happens when a mlme op returns an error like
channel access failure? Do we ignore it? Do we do cond_resched() and
retry again later? I guess these are questions only if we get into
active scanning with more exciting sending of frames, because here we
don't transmit anything.

- Alex

