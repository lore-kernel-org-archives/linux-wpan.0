Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C090EB64DA
	for <linux-wpan@archiver.kernel.org>; Tue, 18 Jul 2023 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGRJ2L (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 18 Jul 2023 05:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjGRJ2H (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Jul 2023 05:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8810C4
        for <linux-wpan@vger.kernel.org>; Tue, 18 Jul 2023 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689672437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0vyMeOfw7fSC/qxKnZBBj+xlz8lL8pZMksMNnnuzCg=;
        b=Q2+7fGF0YkjJPjxBfiXUIFkyFK5IRcBIC8/xhlL+kpaCbfiCSxwWapD7JXhNS7srOtvUqS
        idSrC9/xzjOeMZ/M8q6XgyTv9hMgFnvyY/sllrd8LeFgIm4k5nuBQ93iP4SiKvPFB6UUz+
        ZN478OsyWDXLgMv7hDKdnoKQ5HpMCPE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Z1vq21maN22beOWKnNneiw-1; Tue, 18 Jul 2023 05:27:16 -0400
X-MC-Unique: Z1vq21maN22beOWKnNneiw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635eb5b04e1so13842206d6.1
        for <linux-wpan@vger.kernel.org>; Tue, 18 Jul 2023 02:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689672436; x=1690277236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0vyMeOfw7fSC/qxKnZBBj+xlz8lL8pZMksMNnnuzCg=;
        b=eADW9xvGWByfhg125LmKxfDmegXRI4KqhbqSa/6m8iCdUxMuN6T6//SODnj03q79xg
         3+NbobNIi1DXCZoUq89qpWRftRKz7CpMAd5vVX1ZINkLknXeMcplmFhwBlUhaWcE9jC9
         809+oHnUgMb8T2hK4cHxbI1rf5wTkLXzdQHRGBYN/6jFgaS1IFa8VDSS3MmuPj1A5FsJ
         YghsLHUllS4EKn65kuF0t0UeWYiiek2rszoa1T1lzDzVK+3U/kX9T1OoAY8Hz0ddgWh0
         RMnNjVM5CNlzhKZu+6GZRNPP2XUjwEZb47BkpFKUqRP/JT2bXH1wF/wDHM9lJOEokPbh
         isGQ==
X-Gm-Message-State: ABy/qLarOeu5IV3atZ9KDLCG2iN7/4bUQBJVQ9vjVFYlGIOVJYO2wHhB
        9YaJ9DbUE12T9d6cnEMVZ80gapKvCGaYxVpBjqiyn+e9XvyyeA6AYf0PFfOq4jWm60AC97rK59i
        KMV+erbxY1mj/y5OKp1C8kQ==
X-Received: by 2002:a05:6214:509d:b0:63c:7427:e7e9 with SMTP id kk29-20020a056214509d00b0063c7427e7e9mr12261345qvb.6.1689672436180;
        Tue, 18 Jul 2023 02:27:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYFNw7x3jThmvZICEe6iXFu0qG+zQql7vEpRKMvc0qVPxJUK7o8zW+ji84Z85dUEkIw+qD2g==
X-Received: by 2002:a05:6214:509d:b0:63c:7427:e7e9 with SMTP id kk29-20020a056214509d00b0063c7427e7e9mr12261327qvb.6.1689672435965;
        Tue, 18 Jul 2023 02:27:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id h10-20020a0cf20a000000b00635fc10afd6sm592785qvk.70.2023.07.18.02.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:27:15 -0700 (PDT)
Message-ID: <ee31215ededd386eba19fb62b0de8d0bad78d687.camel@redhat.com>
Subject: Re: [PATCH] net: Explicitly include correct DT includes
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alex Elder <elder@ieee.org>, Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org, linux-oxnas@groups.io,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wpan@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org
Date:   Tue, 18 Jul 2023 11:27:10 +0200
In-Reply-To: <1c6175fc-496a-843c-c8c5-2173e065eaa8@ieee.org>
References: <20230714174809.4060885-1-robh@kernel.org>
         <1c6175fc-496a-843c-c8c5-2173e065eaa8@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sat, 2023-07-15 at 10:11 -0500, Alex Elder wrote:
> On 7/14/23 12:48 PM, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>
>=20
> (I significantly reduced the addressee list to permit the message
> to be sent.)
>=20
> For "drivers/net/ipa/ipa_main.c":
>=20
> Acked-by: Alex Elder <elder@linaro.org>

The patch does not apply cleanly to net-next. Rob, could you please re-
spin it? While at that, have you considered splitting it in a few
smaller patches (e.g. can, dsa, freescale, ibm, marvel, mediatek,
stmmicro,  sun, ti, xilinx, wireless, remaining)?

Thanks!

Paolo

