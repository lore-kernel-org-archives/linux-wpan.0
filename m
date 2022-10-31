Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D165FA373D
	for <linux-wpan@archiver.kernel.org>; Mon, 31 Oct 2022 02:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJaCVS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaCVR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 30 Oct 2022 22:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07385B1C8
        for <linux-wpan@vger.kernel.org>; Sun, 30 Oct 2022 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667182818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjafgW3rTkQyfi6E7wSIxq6H/qqptWcpoOjhgbVJRUc=;
        b=PmhyJv30ZLSg09JvY70Rr7s+1LYefWvTmxO+/jDwDI5IT/wBWGReuIQZ5FkflNYEtltqRn
        LrCBHV6MpUw46T8EjCeYHn57LEvSSlb4P2CSH/0DGYXbusfMmRsGr47FGK61l6lZpdIFSR
        /lBN5GRCrR61ewckphtlwauuNzV+WKs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-Ve0l84dMP2yJl5jZU9dBAg-1; Sun, 30 Oct 2022 22:20:16 -0400
X-MC-Unique: Ve0l84dMP2yJl5jZU9dBAg-1
Received: by mail-ej1-f70.google.com with SMTP id dt6-20020a170907728600b007adc3ab275aso870488ejc.20
        for <linux-wpan@vger.kernel.org>; Sun, 30 Oct 2022 19:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjafgW3rTkQyfi6E7wSIxq6H/qqptWcpoOjhgbVJRUc=;
        b=7igRGKN3sBL59x4ZmsSaqtGqfiyk/gUtfsOWIlo83qAR8nVrdHx1AZDzIvdg0MuaSw
         qriqybp4vxZMTq4LvReMSWYw1Cc7c8Q1HWdlYlYK17AheGBus8WhnR0Z2J0O4c57wQuS
         HOUXuU34eu1zn3FmB+AQ7Lcg3wZgXrKl82bivxKtdpQhfyL7JeFpB41tu1ubeky1/ERJ
         +hZLOPqb7hs+f0QIPwtNRmfSc3JDxOWu2BsvP7twG66a1yQTaUkVSRJKlGNghtYZrPu0
         DmLOO3Sg6hvVGQJ/yOLW2ikLdtqzK6xWQolU+kpw2UwzqAo+BgHximTTmf45Ic1QRm5Q
         7H4A==
X-Gm-Message-State: ACrzQf1rmpORKavXMFeKC4YHS1e7FcJ6Iq6CmbhPfabiyGKEwMbPk2xf
        T1IPbUJBlyHsfz4PxbpOWm+g7fxJw82jr9oouFQ/jJK4luanmKc+0jx0Jti7011FV4OWVlYo1i8
        Er1Qa1PLnCSPqYAx3aYY+qbGiaS9NTqPepLj9Uw==
X-Received: by 2002:a17:907:2d91:b0:78d:8747:71b4 with SMTP id gt17-20020a1709072d9100b0078d874771b4mr10784853ejc.545.1667182815015;
        Sun, 30 Oct 2022 19:20:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xU1KHI4idWmAHMlxXdU4BufbnzGj7b7j0AbjuJ3gHXYpGqeb09NigNmoMkcJBldcdamEApf70gIcNgTEaoEc=
X-Received: by 2002:a17:907:2d91:b0:78d:8747:71b4 with SMTP id
 gt17-20020a1709072d9100b0078d874771b4mr10784839ejc.545.1667182814825; Sun, 30
 Oct 2022 19:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221026093502.602734-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221026093502.602734-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 30 Oct 2022 22:20:03 -0400
Message-ID: <CAK-6q+jXPyruvdtS3jgzkuH=f599EiPk7vWTWLhREFCMj5ayNg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/3] IEEE 802.15.4: Add coordinator interfaces
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
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 26, 2022 at 5:35 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
> These three patches allow the creation of coordinator interfaces, which
> were already defined without being usable. The idea behind is to use
> them advertizing PANs through the beaconing feature.
>

I still don't know how exactly those "leaves" and "non-leaves" are
acting here regarding the coordinator interfaces. If this is just a
bit here to set in the interface I am fine with it. But yea,
"relaying" feature is a project on its own, as we said previously.

Another mail I was asking myself what a node interface is then,
currently it is a mesh interface with none of those 802.15.4 PAN
management functionality? Or can it act also as a "leave"
coordinator... I am not sure about that.

However I think we can think about something scheduled later as we can
still decide later if we really want that "node" can do that.
Regarding to 6LoWPAN I think the current type what "node" interface is
as a just a node in a mesh is required, it might depends on if you
want routing on IP or "relaying" on MAC (mesh-over vs mesh-under), but
I never saw mesh-under in 6LoWPAN.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

