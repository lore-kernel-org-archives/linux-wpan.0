Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C390C54EAA
	for <linux-wpan@archiver.kernel.org>; Fri, 27 Jan 2023 01:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjA0BqN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 Jan 2023 20:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjA0BqL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Jan 2023 20:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419240BCC
        for <linux-wpan@vger.kernel.org>; Thu, 26 Jan 2023 17:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674783931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDHoyOIbGQ1AMtpykgf34aAsw8zvrgKY4crUtTJZMM4=;
        b=d45xDElAaGtkhDXrS+edR9pTxg0YgWXAamAN1u/jhlhyJI18d8faXtOYlj/lsKfCa6T649
        B01p1GtkSR3Qvz0lKuUpVaRPe7s+V8BfcxH8AcDIaVy7+CVM491fRybf3NBeg2Qr4uBtRv
        TZd4umXAufmRals2tDUF8lL1AbjahyY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-Nii__hHjN7Sg_xSx7EX4wA-1; Thu, 26 Jan 2023 20:45:27 -0500
X-MC-Unique: Nii__hHjN7Sg_xSx7EX4wA-1
Received: by mail-ed1-f71.google.com with SMTP id y2-20020a056402440200b0049e4d71f5dcso2602892eda.5
        for <linux-wpan@vger.kernel.org>; Thu, 26 Jan 2023 17:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDHoyOIbGQ1AMtpykgf34aAsw8zvrgKY4crUtTJZMM4=;
        b=zEIN/ywxxTJez2F9wG+lTU4cdoRHqV9zP/4P6JlsrfQ5thoKZrEFtnpENd50lYAHfl
         1GHE4LR1wcl+GhPiMQe3xggxeIu4uzzRXnngWxMhR+f9Jxr2HC3AVIUSHVhBlcTjp46z
         jv97cEiAg7dFzZ8ye91s2Bey7f3aYRw3k736sGyvyS4D4Ww7R+lAX7+8KId/2/Rswgg9
         9/RwPGYu3P/eqEj+1nu5rwHd7f6EC8V8dke3dWVE+/0r7qZvdMv2xAC7ckVgX0oib1xp
         1VNCo4jE9PeV3QNQ8fK04PN/rQ9jfxl7xSo1MYwK6MsQIiuYEf0vfPEhH1Cowul+eqs7
         ULfw==
X-Gm-Message-State: AFqh2ko3XCz+QR/HiadwdwZHweygiLfvBK3IK99RMKkb40FfHUv0wMdT
        fNWCP2tDQa+Lz1VptjWuatpbwHDgmMnBbxm8CQZKKa5CkvR+gKJ4pN1v7MLLN/Feoc7/XfaW5hO
        YnmnnsZxDb3KmYNb/coIKK6maKz1AA8NEuy8dwg==
X-Received: by 2002:a17:906:4988:b0:871:e963:1508 with SMTP id p8-20020a170906498800b00871e9631508mr6387500eju.185.1674783926241;
        Thu, 26 Jan 2023 17:45:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXva3WypSSBaBKAZ8gx6hfQFBdh/vpYS+eXqxUlJGBg3nC413yrNyWv3AUeYH79bSGCNfvdKeSu+jnXx5CS1ZYQ=
X-Received: by 2002:a17:906:4988:b0:871:e963:1508 with SMTP id
 p8-20020a170906498800b00871e9631508mr6387490eju.185.1674783926054; Thu, 26
 Jan 2023 17:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20230125102923.135465-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230125102923.135465-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 26 Jan 2023 20:45:14 -0500
Message-ID: <CAK-6q+jN1bnP1FdneGrfDJuw3r3b=depEdEP49g_t3PKQ-F=Lw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: Beaconing support
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Jan 25, 2023 at 5:31 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Scanning being now supported, we can eg. play with hwsim to verify
> everything works as soon as this series including beaconing support gets
> merged.
>
> Thanks,
> Miqu=C3=A8l
>
> Changes in v2:
> * Clearly state in the commit log llsec is not supported yet.
> * Do not use mlme transmission helpers because we don't really need to
>   stop the queue when sending a beacon, as we don't expect any feedback
>   from the PHY nor from the peers. However, we don't want to go through
>   the whole net stack either, so we bypass it calling the subif helper
>   directly.
>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

