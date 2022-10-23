Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB239C433FE
	for <linux-wpan@archiver.kernel.org>; Sun, 23 Oct 2022 23:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJWXPu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 23 Oct 2022 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJWXPt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 23 Oct 2022 19:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138A69180
        for <linux-wpan@vger.kernel.org>; Sun, 23 Oct 2022 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666566947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nyv5Hncvb1stilpHTQMnrnE2heePDDJ+kgmXY4LCHNc=;
        b=Uo9birv2/6JDcWgLoBMwzzE0JlB4J0Y53jCBgeil/eYSmsOSlLcpY9Shi0BDGn+ER/jYLh
        pg2ZMx0HnZYVoJeQp5ruCu6nDcGitPJWIYnqooA4A8bWHI+p24OwPoVywNOgMsz0mOS6xn
        6jfp+6/yBP2aKLO12VrP1nM/zhEc3NI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-PJ9o74QTN36NMnxEziC6HA-1; Sun, 23 Oct 2022 19:15:45 -0400
X-MC-Unique: PJ9o74QTN36NMnxEziC6HA-1
Received: by mail-ed1-f69.google.com with SMTP id z7-20020a05640235c700b0045d3841ccf2so7648857edc.9
        for <linux-wpan@vger.kernel.org>; Sun, 23 Oct 2022 16:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyv5Hncvb1stilpHTQMnrnE2heePDDJ+kgmXY4LCHNc=;
        b=PgJQyPFenggv1CzD7QMdfSp37codnRB8BT5sCe+FuDu2fzb33/tJxBpZROg4d0sqgT
         8rCj0m8UU/MagcCZTvtVDijEEX8sVfcofLe4QZ4TfbvtWBGs8xPxmk+25F85NWLwpP9W
         e4zpVKZM4t/3NZnU5fC1MyFNQmOpUSAUI+8kO0qe9MSig4l3UvYJ5OVyL5LCSRiAFts5
         ywtiga8ftiVvGaMhdVC2iCUg+bQ2xWXqmp8JhHKCHxf97clttpcqVTGicD59HDNLdnP+
         Xk0lRr/HKJsJOaNZvwfwdiaMdhgosuQPo/H/RzuLO9io+8Q6Q4K4VX78ZbZTGuOCNOL9
         Wg4Q==
X-Gm-Message-State: ACrzQf3YIZM44atSNfAwmzCqM3rG/CFlbYxzts3/j2KY8YJHLrrSwBe4
        ha76hbfHbcrgc2bZWSS+e0cLAOM5msYZ96l9v4Z581fuFk672+OCf+6KxAWfZ4b6EH9cGGO8BwF
        DKJLnAPwTwChFioZ4ILws3TgNmD2EQ0RI6mAsew==
X-Received: by 2002:a17:907:78a:b0:78d:9ac7:b697 with SMTP id xd10-20020a170907078a00b0078d9ac7b697mr24587523ejb.457.1666566944117;
        Sun, 23 Oct 2022 16:15:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7B1WgK/1cPBCckn8xj35VFzZwQZGGu3hKiJ3ERZTkNZc4B19245m++1MMJvj7F1UBBvOamqKqDG7oEH8ZKlgw=
X-Received: by 2002:a17:907:78a:b0:78d:9ac7:b697 with SMTP id
 xd10-20020a170907078a00b0078d9ac7b697mr24587514ejb.457.1666566943979; Sun, 23
 Oct 2022 16:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221019134423.877169-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221019134423.877169-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 23 Oct 2022 19:15:32 -0400
Message-ID: <CAK-6q+hphyOZKLgxM3Ez2O8Fj2j0jeuxVMPaekoGBrcphHyySw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v6 0/3] IEEE 802.15.4 filtering series followup
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

On Wed, Oct 19, 2022 at 10:14 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> The filtering series v4 [1] lead to a discussion about the use of a PIB
> attribute to save the required PHY filtering level instead of accessing
> the MAC internals, which is bein addressed in patch 1/3 and 2/3. The
> last patch has been sent alone as a v5 because of a debug message
> needing rewording. Actually Stefan wanted me to rebase on top of
> wpan-next without keeping a patch sent as a fix which conflicts with it,
> so here it is.
>
> Once these three patches will be merged (I don't expect much discussions
> on it to be honest?) I will send the next small series bringing support
> for COORD interfaces.
>
> Cheers, Miqu=C3=A8l
>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

