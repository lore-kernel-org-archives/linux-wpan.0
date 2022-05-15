Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A6C433EF
	for <linux-wpan@archiver.kernel.org>; Sun, 15 May 2022 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiEOW3L (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 May 2022 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiEOW3K (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 May 2022 18:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A059DEE2A
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652653748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPiXGxvB043ZSjvpXVuJ8kp1cvd5Znu1YEXZQlc2cCg=;
        b=aOO0+AVQeOO0fIiLsHlBfxmaB8mAQrtgqJcv7F5bGNVQ2S7dOuxU4JwS+NgFh+HW/03sSN
        7d5t1aGkncbQip5ku63SGStLJzLW28ssVnnq89ntvFWDPJFN7prFeTHAl3Yrz5fU4wPCrO
        Bsr/fkkb1/U2kTsn9kE6V/fHGLX+wGs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79--9iV0UTMMQGFnhUNVeLR3g-1; Sun, 15 May 2022 18:29:00 -0400
X-MC-Unique: -9iV0UTMMQGFnhUNVeLR3g-1
Received: by mail-qk1-f197.google.com with SMTP id m1-20020a05620a24c100b006a060e0e241so10036965qkn.17
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPiXGxvB043ZSjvpXVuJ8kp1cvd5Znu1YEXZQlc2cCg=;
        b=OBAup0dSoJtpTkdz591YWnKNxyt9LzuOT7/FBoNwszH2kEeJbvnbQcBxbNHxK+mrkX
         g4q/AocFVl/l6O3PPLivzEUcbei3sn8OJx8qZo9gD1XqF6z7/h0dHrNBt2knwOvKrbCA
         H/4b87kThOSb5cWw7hxztZuatK3fexosGvhQW+CRsSBXkRJEqJurFhQMY/paeUcWyr8f
         CF55+X6Pl/O+2C7PrHaBFYKETIsRFCTndxKebzd4kt9XILjBj8DEpEL1ORzxmvF+xN/3
         HAMuGOiZgNxpOZ3YSWDk9p9dIfzpHZTdxMPdbQt7RUQe+4wS4oxUaeOi9OiKXclquq4Y
         QlsA==
X-Gm-Message-State: AOAM530JhHhQw6ve1Dt0Egb6emIoijsHnJDptGmfdN86s0FIvH2cweU6
        /qg5PI5r1MLcKAVQuu0Uej6wnNiWnRSbD2oTE5r7fbOLieeDEhMdYJvT48a3ZQVOcwCNMxETzl7
        uqafq7CLyyaw+Esz/PjZHQhESDDeEh0Uu3bKkDA==
X-Received: by 2002:a05:622a:351:b0:2f3:d8e4:529f with SMTP id r17-20020a05622a035100b002f3d8e4529fmr13386693qtw.123.1652653739459;
        Sun, 15 May 2022 15:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzN1V1g6z450TKZD/3TQsykdXoozq5Y8cuGJSffdR7VbZUfKZvdKyuAuBdrLols3zzQRtslo34iuHJPIuEBos=
X-Received: by 2002:a05:622a:351:b0:2f3:d8e4:529f with SMTP id
 r17-20020a05622a035100b002f3d8e4529fmr13386676qtw.123.1652653739263; Sun, 15
 May 2022 15:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com> <20220512143314.235604-10-miquel.raynal@bootlin.com>
In-Reply-To: <20220512143314.235604-10-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 15 May 2022 18:28:48 -0400
Message-ID: <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 09/11] net: mac802154: Introduce a
 synchronous API for MLME commands
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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

On Thu, May 12, 2022 at 10:34 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This is the slow path, we need to wait for each command to be processed
> before continuing so let's introduce an helper which does the
> transmission and blocks until it gets notified of its asynchronous
> completion. This helper is going to be used when introducing scan
> support.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/ieee802154_i.h |  1 +
>  net/mac802154/tx.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index a057827fc48a..f8b374810a11 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -125,6 +125,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
>  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
>  void ieee802154_xmit_sync_worker(struct work_struct *work);
>  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
> +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb);
>  netdev_tx_t
>  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
>  netdev_tx_t
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 38f74b8b6740..ec8d872143ee 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -128,6 +128,31 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
>         return ieee802154_sync_queue(local);
>  }
>
> +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb)
> +{
> +       int ret;
> +
> +       /* Avoid possible calls to ->ndo_stop() when we asynchronously perform
> +        * MLME transmissions.
> +        */
> +       rtnl_lock();

I think we should make an ASSERT_RTNL() here, the lock needs to be
earlier than that over the whole MLME op. MLME can trigger more than
one message, the whole sync_hold/release queue should be earlier than
that... in my opinion is it not right to allow other messages so far
an MLME op is going on? I am not sure what the standard says to this,
but I think it should be stopped the whole time? All those sequence
diagrams show only some specific frames, also remember that on the
receive side we drop all other frames if MLME op (e.g. scan) is going
on?

- Alex

