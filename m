Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5520C433FE
	for <linux-wpan@archiver.kernel.org>; Thu, 20 Oct 2022 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJTXbI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJTXbH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Oct 2022 19:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27339168E5D
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666308664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPieb0tsDLFBeZTiM6Uz+jwJtSKMmEglyuNepcIKOVY=;
        b=fx3V6tflob3a677iUed7RPDeiy5jnrxTApHVziw7GrrdA07Ye8G8Bsh5vBl3NkqJC/SWyf
        sMzxHpdu7UMURpaFFR6yDXHkiIoUquAgWYb3pcxe2+WhqJcUPTBGl1cdYVK3e7fFOjfvS7
        4f+QEwiMt2mhq3Scxg91WS9Xqub3amI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-2ZJskTMkO4mqWZVpegyj3Q-1; Thu, 20 Oct 2022 19:31:02 -0400
X-MC-Unique: 2ZJskTMkO4mqWZVpegyj3Q-1
Received: by mail-ed1-f72.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso782835edd.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 16:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPieb0tsDLFBeZTiM6Uz+jwJtSKMmEglyuNepcIKOVY=;
        b=bEyjV4REEj1MkrBS3FOjj6ZqXfKVTNdtY78czLIs8Qhte9Y/hp1Hy4qtsTu/Yaptqx
         Cq+EaD2Stz92ZOh9ekHpmvE408tsnEzZHAu/oDljNq0rxZln37GI4vYY7llZeRnj0vZE
         lARN0GDHVPHukMDF+K5SnfNvPUHbEUPEPqJThrVJ27xOE892uBWCz+voN5WIBftmrK9C
         egMvl6+PdSY4sknNBCMnZOzqkl1WLdcnWEqznvjg9LSIQj1JapFtVF+T42Kx497DmnF7
         eq0qmdT35sB4h7PGZARa8qR0jZLfI8/7BwycLK74V4WyQApYOijslJ32zYmcSvieK2Ry
         hmdA==
X-Gm-Message-State: ACrzQf3xTS61ybB/ZlOOznBwU/9wARV4xNpJmLPMdmWAo3bexkMsTlM9
        NU25DzP8SO8Kv41/jirKIOiVf1P+21fX8nTtWuS0Flbhu+m547Xk7i8CwM/ESMSNlypnt7zi4Wb
        Uvl4Oj+Z2oIVYjel/3BmNSsI8YdpfR0EUW0yLDw==
X-Received: by 2002:a05:6402:358e:b0:45c:aa8b:f7e9 with SMTP id y14-20020a056402358e00b0045caa8bf7e9mr14550690edc.33.1666308661868;
        Thu, 20 Oct 2022 16:31:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zMBdE1IrhG+4dy7/hpSNpD2HQ7Mx3uBoPyJsAEj7xdtMGAeGiick2hckAkksaFixU8hM0e3rxpQgxOcDL/GI=
X-Received: by 2002:a05:6402:358e:b0:45c:aa8b:f7e9 with SMTP id
 y14-20020a056402358e00b0045caa8bf7e9mr14550673edc.33.1666308661708; Thu, 20
 Oct 2022 16:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221020142535.1038885-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221020142535.1038885-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 20 Oct 2022 19:30:50 -0400
Message-ID: <CAK-6q+g4LMVGVYprX+f18-K=8HxTKtCJJu3YR+QoPVjHP_NpTA@mail.gmail.com>
Subject: Re: [PATCH wpan] mac802154: Fix LQI recording
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 10:25 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Back in 2014, the LQI was saved in the skb control buffer (skb->cb, or
> mac_cb(skb)) without any actual reset of this area prior to its use.
>
> As part of a useful rework of the use of this region, 32edc40ae65c
> ("ieee802154: change _cb handling slightly") introduced mac_cb_init() to
> basically memset the cb field to 0. In particular, this new function got
> called at the beginning of mac802154_parse_frame_start(), right before
> the location where the buffer got actually filled.
>
> What went through unnoticed however, is the fact that the very first
> helper called by device drivers in the receive path already used this
> area to save the LQI value for later extraction. Resetting the cb field
> "so late" led to systematically zeroing the LQI.
>
> If we consider the reset of the cb field needed, we can make it as soon
> as we get an skb from a device driver, right before storing the LQI,
> as is the very first time we need to write something there.
>
> Cc: stable@vger.kernel.org
> Fixes: 32edc40ae65c ("ieee802154: change _cb handling slightly")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

> ---
>
> Hello,
>
> I am surprised the LQI was gone for all those years and nobody
> noticed it, so perhaps I did misinterpret slightly the situation, but I
> am pretty sure the cb area reset was erasing the LQI.
>

probably because nobody was really using those values before. There
were some patches years ago to add them into af802154 cmsg but
probably not well tested and so far it's the only upstream user.

However, thanks for fixing it.

- Alex

