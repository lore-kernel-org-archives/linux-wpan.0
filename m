Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875EECAAD4
	for <linux-wpan@archiver.kernel.org>; Wed, 31 Aug 2022 19:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiHaTV0 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaTVZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Aug 2022 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D14DF08C
        for <linux-wpan@vger.kernel.org>; Wed, 31 Aug 2022 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661973683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yF8xpIjbJkDyLQ9AyWpEptq6gDkUAvO7MhTPbwPO8UA=;
        b=SgNYFYIKGWZUafw8CcX3icB3DH9GkqMsnszELzYuCnA7CY2DKKugE6u0hTxyb4RUgceaCE
        2rFQq6OfR4OE1cMhiY0KN1O/yw9gRPtlKGNNjemlb4Dj/mI8n0XXcNuDNBfgt6DWUgMWut
        GBewSmnb8tyYQlJGb5Z0uWkFu7+mrLo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-G9OD_qWDPd-InHYXsquyZw-1; Wed, 31 Aug 2022 15:21:21 -0400
X-MC-Unique: G9OD_qWDPd-InHYXsquyZw-1
Received: by mail-qk1-f199.google.com with SMTP id h20-20020a05620a245400b006bb0c6074baso12405549qkn.6
        for <linux-wpan@vger.kernel.org>; Wed, 31 Aug 2022 12:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yF8xpIjbJkDyLQ9AyWpEptq6gDkUAvO7MhTPbwPO8UA=;
        b=G36GcSLueCTeRG4UMNECyVg9m+CpjtPvBU7PSNI9aKZOjjlaMMU9ZTFUMYnrt86KTe
         B/uonDo+AmnhjzUfhtbOhx/IrT5SOZrrIHX+MIno1qkGYVMrk8x64JEoHQmzcm+dFjNE
         v/4abfhdY5xQ3htstkrL7LYUv+wLelAJxuRA4OmHglucadBx9wHU4SfWq5TVe/GW5sD6
         cggQYUUriyJ3P4nL9RKbv8HAgldYu0UpKmbL9UsAGsrJBcg0NDeMmSjbwHypxMRmi+gU
         h++auOi8pTjwL1CGCEZFQ7LES9Xb1kY3n68G8xaFgZOH/zzFKdA5u9tKYzznCKhIoqCX
         lTSQ==
X-Gm-Message-State: ACgBeo2ooAZzksTEcV9qHlijiNVss59SneQV7SrXLiI5hWAp43jc/Slu
        mFL7mS9QiHHIsHwKv7b/C2I7IYCSJ0Ei+EAkXqMb85MlIe/emloXuHfhdsJVnvskt3MdJdr4LWL
        7fviUqlW/IXSk6Rn76KaHGfQcSMMqIEH4DDc5AA==
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr20107333qtx.526.1661973681281;
        Wed, 31 Aug 2022 12:21:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xIQZCuzjEBO83EeqZPPeoUkm4TcOBb1dvuDkO/uFIWmg1CB7aBIW8LGO6MCvW95DUtT5IJQNTv1bIfu0qSqM=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr20107318qtx.526.1661973681112; Wed, 31
 Aug 2022 12:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220830101237.22782-1-gal@nvidia.com> <20220830231330.1c618258@kernel.org>
 <4187e35d-0965-cf65-bff5-e4f71a04d272@nvidia.com> <20220830233124.2770ffc2@kernel.org>
 <20220831112150.36e503bd@kernel.org>
In-Reply-To: <20220831112150.36e503bd@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 31 Aug 2022 15:21:10 -0400
Message-ID: <CAK-6q+jy5f7PSAh1pZe3M6LM-ySLfUpBAjqS48mBKEVKgXPCUw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ieee802154: Fix compilation error when
 CONFIG_IEEE802154_NL802154_EXPERIMENTAL is disabled
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Gal Pressman <gal@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Aug 31, 2022 at 2:26 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 30 Aug 2022 23:31:24 -0700 Jakub Kicinski wrote:
> > Hm, let me add 802154 folks.
> >
> > Either we should treat the commands as reserved in terms of uAPI
> > even if they get removed the IDs won't be reused, or they are for
> > testing purposes only.
> >
> > In the former case we should just remove the #ifdef around the values
> > in the enum, it just leads to #ifdef proliferation while having no
> > functional impact.
> >
> > In the latter case we should start error checking from the last
> > non-experimental command, as we don't care about breaking the
> > experimental ones.
>
> I haven't gone thru all of my inbox yet, but I see no reply from Stefan
> or Alexander. My vote is to un-hide the EXPERIMENTAL commands.
>

fine for me if it's still in nl802154 and ends in error if somebody
tries to use it and it's not compiled. But users should still consider
it's not a stable API yet and we don't care about breaking it for
now...

- Alex

