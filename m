Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9B6C433EF
	for <linux-wpan@archiver.kernel.org>; Wed,  4 May 2022 00:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiEDAoJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 May 2022 20:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiEDAoH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 May 2022 20:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE981209C
        for <linux-wpan@vger.kernel.org>; Tue,  3 May 2022 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651624832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLAQfNS9bxV5UUONuHMYWtLooFAoUcb9nN3xkf4uzEs=;
        b=aKpI45a539cEzs1M8RyUhTd+xI75q5Bl4xt/+nb5S6OJNxPtWtU9+lFYgpEZgdoIlWmYFf
        Bgdt1oCOZmfeOMjYlZaH7MJTeH//2tzh7fTGqT7siRU2E9PBEJLACOzPFBL92UynVNqIOF
        j1bciGSqh6va0N8RmevM7qmMwLBmGTA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-tibxBWnjNpmCD26lZMUPDQ-1; Tue, 03 May 2022 20:40:31 -0400
X-MC-Unique: tibxBWnjNpmCD26lZMUPDQ-1
Received: by mail-qk1-f197.google.com with SMTP id bs18-20020a05620a471200b0069f8c1c8b27so13531872qkb.8
        for <linux-wpan@vger.kernel.org>; Tue, 03 May 2022 17:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLAQfNS9bxV5UUONuHMYWtLooFAoUcb9nN3xkf4uzEs=;
        b=oFFGNks4mrGHjksFCmYm7OPgAXDj141ByVq0cFhZFZpt2bpZ9rMEuWEWCLNk4mMhoZ
         +3kJDrT+0IbxP0k0FNo/QjKLo8rmbE+tS5lkAMQhauLvsBn9Ixr3shPZW4VlJXqpvq3R
         C5wUHy29yXG0pAqO9wTg7Eohu08wDv5s3G8bPPZb7HDZqxxtDCggkBKqxF0iTu1JGn08
         P3/87JqMIrZ1/u+OOS1hHHtyzauhB4fqqzKcV7Noq7TfNiisSPNN6ILNX7lJ3QPZFzXO
         lhRODU7JLcnpfrbZYXFf4B1KUn2di1zBn49OXzBzMBlTaFuuZu+KwWxONo4EOE9IaQ4N
         WqJg==
X-Gm-Message-State: AOAM530Yh1cisc51Jwsr4nyUAtpknPC6NKrANtvssxaM4ezeGd/EFn8D
        i4FfcJj49aeUFZOkhuaj74fyDvXdkZPOWPgRw7FesgFoPwmuTemL0NOOh3OlI3zyI6Fk7WOrMH+
        Ry6QaNY04TC6cKn5XELCU8e8Blci8OgR3I4qHjQ==
X-Received: by 2002:ac8:7e81:0:b0:2f3:9a1d:3732 with SMTP id w1-20020ac87e81000000b002f39a1d3732mr17256738qtj.339.1651624831093;
        Tue, 03 May 2022 17:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmRta/5dz57eHGaZAZaApDGeL8uCIFZvdMqxAsvJ5V/0ZNqBP+vcVj+tL79ZmFnh087L9aAEn5NDrx0Mdy2dw=
X-Received: by 2002:ac8:7e81:0:b0:2f3:9a1d:3732 with SMTP id
 w1-20020ac87e81000000b002f39a1d3732mr17256719qtj.339.1651624830872; Tue, 03
 May 2022 17:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220427164659.106447-1-miquel.raynal@bootlin.com> <20220427164659.106447-11-miquel.raynal@bootlin.com>
In-Reply-To: <20220427164659.106447-11-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 3 May 2022 20:40:20 -0400
Message-ID: <CAK-6q+gkMbf7HGFWtaB2QX9z10dvbk2ac28to3TMUDS9MdWuvA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 10/11] net: mac802154: Introduce a tx queue
 flushing mechanism
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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

On Wed, Apr 27, 2022 at 12:55 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Right now we are able to stop a queue but we have no indication if a
> transmission is ongoing or not.
>
> Thanks to recent additions, we can track the number of ongoing
> transmissions so we know if the last transmission is over. Adding on top
> of it an internal wait queue also allows to be woken up asynchronously
> when this happens. If, beforehands, we marked the queue to be held and
> stopped it, we end up flushing and stopping the tx queue.
>
> Thanks to this feature, we will soon be able to introduce a synchronous
> transmit API.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h      |  1 +
>  net/ieee802154/core.c        |  1 +
>  net/mac802154/cfg.c          |  3 +--
>  net/mac802154/ieee802154_i.h |  1 +
>  net/mac802154/tx.c           | 24 +++++++++++++++++++++++-
>  net/mac802154/util.c         |  7 +++++--
>  6 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 043d8e4359e7..0d385a214da3 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -217,6 +217,7 @@ struct wpan_phy {
>         /* Transmission monitoring and control */
>         atomic_t ongoing_txs;
>         atomic_t hold_txs;
> +       wait_queue_head_t sync_txq;
>
>         char priv[] __aligned(NETDEV_ALIGN);
>  };
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index de259b5170ab..0953cacafbff 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -129,6 +129,7 @@ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
>         wpan_phy_net_set(&rdev->wpan_phy, &init_net);
>
>         init_waitqueue_head(&rdev->dev_wait);
> +       init_waitqueue_head(&rdev->wpan_phy.sync_txq);
>
>         return &rdev->wpan_phy;
>  }
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 0540a2b014d2..c17e38bef425 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -46,8 +46,7 @@ static int ieee802154_suspend(struct wpan_phy *wpan_phy)
>         if (!local->open_count)
>                 goto suspend;
>
> -       ieee802154_hold_queue(local);
> -       ieee802154_stop_queue(local);
> +       ieee802154_sync_and_hold_queue(local);
>         synchronize_net();
>
>         /* stop hardware - this must stop RX */
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index c686a027555a..c87c7fa04435 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -124,6 +124,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
>
>  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
>  void ieee802154_xmit_sync_worker(struct work_struct *work);
> +int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
>  netdev_tx_t
>  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
>  netdev_tx_t
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 021dddfea542..5f94973b57e4 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -45,7 +45,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
>         /* Restart the netif queue on each sub_if_data object. */
>         ieee802154_wake_queue(local);
>         kfree_skb(skb);
> -       atomic_dec(&local->phy->ongoing_txs);
> +       if (!atomic_dec_and_test(&local->phy->ongoing_txs))
> +               wake_up(&local->phy->sync_txq);
>         netdev_dbg(dev, "transmission failed\n");
>  }

There is a missing handling of dec() wake_up() in ieee802154_tx()
"err_tx" label.

- Alex

