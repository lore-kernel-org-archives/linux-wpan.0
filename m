Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AEFC433F5
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Oct 2022 01:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJKBBe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKBBa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Oct 2022 21:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093E792E9
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665450085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIc0PRRAegvqEDcOrK3Tyz8JLKn11AkZNNcOR20Pjew=;
        b=NNeEVpPRaI/4+PGBfP4G6EEpLokzAmhbaLrgjwz9A5zGpU/uRfAf0vCJzPDvU69CWukoct
        jr4uMCKCG6SsFEP1USydgyHsu9llZhcIpxNmaqKO1izLtPl5OwGarO2FzKZv9mgOQ+85IW
        G3S4hs6Pkr3yKiZU+sOlzkrd+yBXgGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-UPYIDyI6Ogu05nSloXPenQ-1; Mon, 10 Oct 2022 21:01:24 -0400
X-MC-Unique: UPYIDyI6Ogu05nSloXPenQ-1
Received: by mail-wm1-f70.google.com with SMTP id 133-20020a1c028b000000b003c5e6b44ebaso2785663wmc.9
        for <linux-wpan@vger.kernel.org>; Mon, 10 Oct 2022 18:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIc0PRRAegvqEDcOrK3Tyz8JLKn11AkZNNcOR20Pjew=;
        b=xgE20S/l6/6X54x+atLHWVDCY3CQqcwycHc9o0euEzVNPCKS4yzlFAEAMcAuUWa7t4
         SA6urrTlSbyv8p8GxL28dIKjwk7BVgR3rFvQLaZuLxcgO5UIcuPZpveORxoPHr+nQG6t
         89Layu5bMRdP70bjJRgJlYT8UFQZwedSw3Sq88V94ijn23UwngXmSm7KpWHY01Uf88xv
         Hu++bTEIAZkNu7b3PrJuzfp2shnllQ/zKQVp0YwM2CLDRpIvSPHdj3wyG3xUmy8Q9OC2
         AXQa9oXALM4FaSZ0PcbqAxMCpQAm6/S22uFYSxABsmyq5NswTkNE1y6Iud+AE4AGvVPl
         j9ig==
X-Gm-Message-State: ACrzQf2hgRGN1X+S6IOCtjcbPRuHkXhVet3/oyxPvVDq96i7lWjAjQya
        EVEalgMW914vI+I8OfZDSEu4AznoFRyAzluhnVTetntMA6RoCk5cxd/Wxp4fWCpXbJqOLGTZEaf
        iOrTbAlE7jnQ/yNqj3mKPOYDrHtntaobvGz4uLA==
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id b21-20020a05600c4e1500b003b4a621b54emr14277445wmq.47.1665450083348;
        Mon, 10 Oct 2022 18:01:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7leXsoXu7bEaYryj01zogLfSvFzsSiHWmZ8Id8pVM45N4IvlvWQO1JQvMzo7j2ZcgITlNxZRrxltSF8YBdsJo=
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id
 b21-20020a05600c4e1500b003b4a621b54emr14277427wmq.47.1665450083184; Mon, 10
 Oct 2022 18:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221007085310.503366-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 10 Oct 2022 21:01:12 -0400
Message-ID: <CAK-6q+i6LPM2YjCCaWU-LL6vFUCY=SweiWDJrA12M1cKtNYGUQ@mail.gmail.com>
Subject: Re: [PATCH wpan/next v4 0/8] net: ieee802154: Improve filtering support
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Oct 7, 2022 at 4:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> A fourth version of this series, where we try to improve filtering
> support to ease scan integration. Will then come a short series about
> the coordinator interfaces and then the proper scan series.
>

I think this patch series goes into the right direction. So I would
give it a go:

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

