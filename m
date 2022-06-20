Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3115C433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Jun 2022 00:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiFTAeK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiFTAeJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 19 Jun 2022 20:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB46E64D8
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655685247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yLvRWiqvttcJ70cIxaLiRA+Z6S11BSewzDX1E+bhW2o=;
        b=AIIf+nfCi+ssX6LJU+fGLPLewqgtg86n+Ptsv/M0ocxUutMEeudEnMTfO4HrZBkHnBIHT3
        gd0SOvi5VyldMVpAVIAgOB+tC7xsURrBv+7f+l1DjF+4uKqqLMF3EnxHVjkMw3IcRCQnT2
        ornuhQbeQlWl69S00CNXafu3j44Lccg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-ck58aq7RPOKHEB6-5QvuVA-1; Sun, 19 Jun 2022 20:34:05 -0400
X-MC-Unique: ck58aq7RPOKHEB6-5QvuVA-1
Received: by mail-qk1-f198.google.com with SMTP id k188-20020a37a1c5000000b006a6c4ce2623so11488358qke.6
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLvRWiqvttcJ70cIxaLiRA+Z6S11BSewzDX1E+bhW2o=;
        b=q2vZuTJnyGSzeRFTUXdddQm8nVcVZKKw8Aol1Sap3EiO1kKBFLICthkBzAJvCnisqr
         /doXQwbsZ7LXHgdP3IaaMgkaZgg+8Hsi75cYa6cgKWkBfSYdkqZC4gieZvJajZX67oaR
         dduBzPo74NWV2ERaGc4jGEb14XEEMULpcfPa756oIRFlv9fTl8PboW+GFBC7M5/vHajh
         oZqLvytUpEQD+Zmr0Mac+HFHPZ8P2pV6vf+OCfX4/OKoGKz8RxHWbj6oSGOEggHeL+iH
         rGZKxs2PKUqP5ghzenPGpcL6E9EwWqPAXnMzmqlyzFcsdgObFi3XbYCd9Ono/gIq0DQm
         Gtsg==
X-Gm-Message-State: AJIora9E55GN8slFx2Qi6g9m42aod366pGnbniHmh+94G8JB7v3JOxkx
        uJWg60o+VqPr+C70wLwG9/6NU50S7pwKQhT5CYHHswaZpAwEufs5VA/IvVN4F2mIALTrIeM3eN/
        iTCD0ACGjDIFZHHhKhe2FWgJ8D+jAcwc1ry26jw==
X-Received: by 2002:a05:622a:1314:b0:306:657d:5f72 with SMTP id v20-20020a05622a131400b00306657d5f72mr17677668qtk.339.1655685245168;
        Sun, 19 Jun 2022 17:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t02QXdaDD1J1SA/EW3B555acqF6J/I7nIsuu4+BzkvN3ehUZL0D+tP3P3NoixruSITQe5hcbah894VBaVSTYs=
X-Received: by 2002:a05:622a:1314:b0:306:657d:5f72 with SMTP id
 v20-20020a05622a131400b00306657d5f72mr17677653qtk.339.1655685244975; Sun, 19
 Jun 2022 17:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617192914.1275611-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220617192914.1275611-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 19 Jun 2022 20:33:54 -0400
Message-ID: <CAK-6q+h3u-ReBJux4SUJ8ww4NkafrnaAqwGcXnJvm5xnXUge9Q@mail.gmail.com>
Subject: Re: [PATCH] net: mac802154: Fix a Tx warning check
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

On Fri, Jun 17, 2022 at 3:30 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The purpose of the netif_is_down() helper was to ensure that the network
> interface used was still up when performing the transmission. What it
> actually did was to check if _all_ interfaces were up. This was not
> noticed at that time because I did not use interfaces at all before
> discussing with Alexander Aring about how to handle coordinators
> properly.
>
> Drop the helper and call netif_running() on the right sub interface
> object directly.
>
> Fixes: 4f790184139b ("net: mac802154: Add a warning in the slow path")

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

