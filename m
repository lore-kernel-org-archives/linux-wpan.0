Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85AAC433F5
	for <linux-wpan@archiver.kernel.org>; Sun, 15 May 2022 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiEOWae (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 May 2022 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiEOWac (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 May 2022 18:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17CECDF21
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652653828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNOJjfT5TRUPaCz6oz9ahXU+hrVa4PXoiSsuweG0pE0=;
        b=cLqJ5wTOY+WNyv0Yrwfk5/WIPMyeacd5Cz42m/MZOSiL9YSZyYjsWjsbkjSJh+jr2BH9Vy
        pvm169kLtgie1AaKBHMn4P0X/ESBAk2Uye2xls+KLPqFOoJIG+sUfwzo5ly6QGms7Hol1A
        8IyWq+sEnzZUwI89XOqqepez68P2+jc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-4rEgSS5mPP2Bf6nKGks8rA-1; Sun, 15 May 2022 18:30:27 -0400
X-MC-Unique: 4rEgSS5mPP2Bf6nKGks8rA-1
Received: by mail-qv1-f71.google.com with SMTP id t15-20020ad45bcf000000b0045a8cfef66bso10846429qvt.11
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNOJjfT5TRUPaCz6oz9ahXU+hrVa4PXoiSsuweG0pE0=;
        b=fwB1ho6yWQxU4rSD/e5rmZTms7LUNmm6TFdR9GtbhsCUvgVzbZ52VaIMVkOGkekorK
         ui8xMUHmBsAs+D/DRToLuL1QfFkQaakPtGh+HPWoY4bKjH+KlngJJu3R6EnINw4oMUsw
         jJ30CcliE9rUl6xKH5Wg0aaQtcs3Q9WjThXqyAsyfy28JUYPOUyMW3iudc4JUEwGeDiR
         k85TyS+2lFlFfUckFXRvEXnzbnH1dqYSvxCo8oKmy3TVlreWuqB7avjagnP51I3vz1+O
         9UaYxbp6727OL9FXYoABirYhYyzsDHkziF64l426buBdZS4nUsdHMGzXZ/RL4Mkmg2DP
         /nzw==
X-Gm-Message-State: AOAM5336mQwT4XzpIQtt8144bEwf/FMD4tDxxs3jJco2AIrpYWmHgDwP
        LprOeVjPva75iFpwepg8jKUMBQ9cWT8UnFIIB7gweSYPXhSXBx8q6fdk034EijVnmhF8O8Wb3eQ
        VnrvbTMEob0/BHeraNkco1kZf6oFDHCjvGsDIsA==
X-Received: by 2002:a05:6214:f64:b0:45b:955:84a5 with SMTP id iy4-20020a0562140f6400b0045b095584a5mr13077740qvb.2.1652653826462;
        Sun, 15 May 2022 15:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwurA33+UVORZOkm63/xFqkRTjb6WYNLouBoePnslHeEpYr8sSC8jRCKvQufsm2AW1iz+0NDXTQ8L8LOK5VxnQ=
X-Received: by 2002:a05:6214:f64:b0:45b:955:84a5 with SMTP id
 iy4-20020a0562140f6400b0045b095584a5mr13077729qvb.2.1652653826273; Sun, 15
 May 2022 15:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com> <20220512143314.235604-11-miquel.raynal@bootlin.com>
In-Reply-To: <20220512143314.235604-11-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 15 May 2022 18:30:15 -0400
Message-ID: <CAK-6q+jYb7A2RzG3u7PJYKZU9D5A=vben-Wnu-3EsUU-rqGT2Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 10/11] net: mac802154: Add a warning in the
 hot path
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
> We should never start a transmission after the queue has been stopped.
>
> But because it might work we don't kill the function here but rather
> warn loudly the user that something is wrong.
>
> Set an atomic when the queue will remain stopped. Reset this atomic when
> the queue actually gets restarded. Just check this atomic to know if the
> transmission is legitimate, warn if it is not.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h |  1 +
>  net/mac802154/tx.c      | 16 +++++++++++++++-
>  net/mac802154/util.c    |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 8b6326aa2d42..a1370e87233e 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -218,6 +218,7 @@ struct wpan_phy {
>         struct mutex queue_lock;
>         atomic_t ongoing_txs;
>         atomic_t hold_txs;
> +       atomic_t queue_stopped;

Maybe some test_bit()/set_bit() is better there?

- Alex

