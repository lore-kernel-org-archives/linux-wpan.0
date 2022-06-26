Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C83C433EF
	for <linux-wpan@archiver.kernel.org>; Sun, 26 Jun 2022 02:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiFZC30 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 25 Jun 2022 22:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiFZC3Z (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Jun 2022 22:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4D40140B3
        for <linux-wpan@vger.kernel.org>; Sat, 25 Jun 2022 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656210560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJjFrVqOIs6fBbktNSds93e5JBItTxxPnrIffy3Upo8=;
        b=NVjYb2d64WNKqNsdAsrwEQoo8wHyBgy59x294ybLAEtBgPQew5/ZYA04hlFPcLMzx8b1c7
        X+G/MTbrrnkTYqgZFlvn2p3GboUDeqkZkDnccV3iR7OcPRooaEif0+O6828q4vykp8vuXS
        ly+iAxhQfDY4yHLu5tMTllFJ5PED4TI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-LsefxUC3M8-4rZxfinsmAQ-1; Sat, 25 Jun 2022 22:29:19 -0400
X-MC-Unique: LsefxUC3M8-4rZxfinsmAQ-1
Received: by mail-qv1-f70.google.com with SMTP id w18-20020a0ce112000000b0046e7f2c5a06so6225308qvk.0
        for <linux-wpan@vger.kernel.org>; Sat, 25 Jun 2022 19:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJjFrVqOIs6fBbktNSds93e5JBItTxxPnrIffy3Upo8=;
        b=L3sKRzL6kQhc6+Y69PorFi/U+W1I1mBeq2DtNcdq9a0KjJQYdjnCGWDWUT/ZAGIw+2
         9eefNd/ZbvWSx+nyLq3pUjkMdZawzaAPd3oxYJ8JGAAbF318L57o3l+UpvffltN4K9la
         od0DV/ZYouRvpYDzB3yEgkRj1koyEE1TlHXKOypSXr8e6Ruf/K3YF9/9ys5v7oRwdPuS
         s+Txa+4LwrTDAQAwAt9gJjg0s7AbH1+ZYnithcctombRDlRKZQ9m8rY6lJWQpY4ej+W9
         OxfHLKLNFttGdtpZQTiAuaOhTLf1C1CF1d479nEUHS4j29ztILce5dmZQW2+mUgIycPR
         F/oA==
X-Gm-Message-State: AJIora9vVR58u3Cc02wp6pY8SrgAqEM+9VM28dRBWsZBys86QlqqKOuo
        RcIJBVqv4EzHgh1i8P2NIc4Q5Ei49DPsZn9aetwne+mXA8oeZjnTximj3hy/sICCeo8bVlvu0k0
        APUUbadpFVgT8BSvItU1oEASVQW7R3oulHrZrqg==
X-Received: by 2002:a05:622a:1314:b0:306:657d:5f72 with SMTP id v20-20020a05622a131400b00306657d5f72mr4934477qtk.339.1656210559095;
        Sat, 25 Jun 2022 19:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqekAitkKWhhmXbbZUlHcuyp5F6ZXHfCLZj9d+7bCjelcEP//yNWVgEk4YxzJbNw+dd1NGWxD7TpZ0EGapr4Q=
X-Received: by 2002:a05:622a:1314:b0:306:657d:5f72 with SMTP id
 v20-20020a05622a131400b00306657d5f72mr4934465qtk.339.1656210558918; Sat, 25
 Jun 2022 19:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134018.62414-1-miquel.raynal@bootlin.com> <20220620134018.62414-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220620134018.62414-3-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 25 Jun 2022 22:29:08 -0400
Message-ID: <CAK-6q+jAhikJq5tp-DRx1C_7ka5M4w6EKUB_cUdagSSwP5Tk_A@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 2/4] net: ieee802154: Add support for inter
 PAN management
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
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

On Mon, Jun 20, 2022 at 10:26 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Let's introduce the basics for defining PANs:
> - structures defining a PAN
> - helpers for PAN registration
> - helpers discarding old PANs
>

I think the whole pan management can/should be stored in user space by
a daemon running in background. This can be a network manager as it
listens to netlink events as "detect PAN xy" and stores it and offers
it in their list to associate with it.

We need somewhere to draw a line and I guess the line is "Is this
information used e.g. as any lookup or something in the hot path", I
don't see this currently...

- Alex

