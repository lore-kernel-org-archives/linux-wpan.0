Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFAC433EF
	for <linux-wpan@archiver.kernel.org>; Wed,  6 Jul 2022 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiGFBXi (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGFBXh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Jul 2022 21:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8EC218356
        for <linux-wpan@vger.kernel.org>; Tue,  5 Jul 2022 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657070614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgRO2LsJ2aYmwc8L5Dz0LPduacftx8Zt8A0gl3JpkJE=;
        b=ZTsPUx3alfSMMtMINcO9WGywwiYBEzCDXUPjEic645/jxaA5EU2z9eeL+zTLurfGSpBe5P
        hDEdmsC405I4K7p4iZlrttVH4fpsy7FHULBOnxC4U3wNL10h0rCN9V1+5FQGiRykXI1/RE
        EJZ1yt2iySnoE4JDrXrk9tcNt5GaW3A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-1XKtDSctMUmTOWmKAwhi9Q-1; Tue, 05 Jul 2022 21:23:32 -0400
X-MC-Unique: 1XKtDSctMUmTOWmKAwhi9Q-1
Received: by mail-qk1-f197.google.com with SMTP id o70-20020a37a549000000b006af05e7eca3so13179291qke.10
        for <linux-wpan@vger.kernel.org>; Tue, 05 Jul 2022 18:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgRO2LsJ2aYmwc8L5Dz0LPduacftx8Zt8A0gl3JpkJE=;
        b=R4+LK2ahv6/l2JZfZUV+cXwTEX+j8vYtez9GQnHI2ugNv+mN9h+3e/4b6MQCRvXOZB
         jgLe6daSR4e0qiTrQzSP4j0pAr160DiJowNlIfBCxtiDxBHvkzef1prTBb8JNKqF9wq5
         4HJa5s+hRdjkSToXke22VQZiKwxJTehg4Ft/HTKyN5CPv10M+eQLpEpjB/NfOJ0JTNSW
         d9Yk0+5wZXRrjE3LzDFtjwwXlGGCDY0OI6HBrELEuxpb1+U3rgMo5N2Dl8XVvKOUqqkB
         IE4Ie5XctmO4cKZOpq898ulCcatD5PtWGO44mnyWs0fr5tciX9TJD5aiVKgCYV0Xo3hH
         RLjA==
X-Gm-Message-State: AJIora+imWd0LGYxT1VOUGUjwuWHC3SvGiqI4ElyFG9yFoJTuvZdiVGR
        n+0ijRkKc6/2/Xt+VCwogeBLqHS2i1KwzItWVx56n3hOOdwMLd9ztkdFxT0F09DFIwZsvUgwFgW
        ZZ5D08C94Iqs+yzu1+0zxRfe3SKuoiszf4b/SAw==
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id v6-20020a05622a130600b0031af73e3d6dmr31008152qtk.339.1657070612543;
        Tue, 05 Jul 2022 18:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v7NctD63htmmRps11di1rFpfwAzvuDqVBdjDk5DGUahVyeqNJfi8VMs+GwOXUYxlcV4+NsvlFs/zav2KIJ0xI=
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id
 v6-20020a05622a130600b0031af73e3d6dmr31008140qtk.339.1657070612377; Tue, 05
 Jul 2022 18:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com> <20220701143052.1267509-20-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143052.1267509-20-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 5 Jul 2022 21:23:21 -0400
Message-ID: <CAK-6q+ihSui2ra188kt9W5CT0HPfJgHoOJfsMS_XDLfVvoQJTg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 19/20] ieee802154: hwsim: Do not check the rtnl
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

On Fri, Jul 1, 2022 at 10:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> There is no need to ensure the rtnl is locked when changing a driver's
> channel. This cause issues when scanning and this is the only driver
> relying on it. Just drop this dependency because it does not seem
> legitimate.
>

switching channels relies on changing pib attributes, pib attributes
are protected by rtnl. If you experience issues here then it's
probably because you do something wrong. All drivers assuming here
that rtnl lock is held.

- Alex

