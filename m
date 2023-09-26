Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75679E7E652
	for <linux-wpan@archiver.kernel.org>; Tue, 26 Sep 2023 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjIZQmM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjIZQmC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2023 12:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58761B0
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YAyRg25y1ds+4WMOQ2HhwyFuV1Nm/hS+8w3y9qqUyQ=;
        b=ZKerJDtjqwgwk7OOFSz2q/lUaiN7G5diUcDWRF6AO8uOFmLyjwkcnx/7lZIv0EBGcnYsoL
        39TFpfJpUZ/d9+KegKhycJqOgeQyCA2f78khQ9aYijgvm+jYFRwksHTub/KsMnHF4r/GVN
        SVF/mzLuQd69yH+M5cuvWDhz5xGcqUM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Nneqa78oORCr0F7goF7eXQ-1; Tue, 26 Sep 2023 12:41:04 -0400
X-MC-Unique: Nneqa78oORCr0F7goF7eXQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so795822766b.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 09:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746463; x=1696351263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YAyRg25y1ds+4WMOQ2HhwyFuV1Nm/hS+8w3y9qqUyQ=;
        b=CMy+bDweR8r5ayjyqqYx2JjRUmy05comOnSd6cKHaFXx76f+dhq6x/Y+51Ufzx0SQg
         wnlZ7z3v4l8d433Tko00osANgI5Me7ddULGhs7fiX+Z1cTHt5IggdxN9sFtZ48RsN6Cm
         DEUfctuS3J39azhpkfWE1CRC3xnbbnW6VFja+04g5H6vVAx0T75TE7jpdRAJzCJr/8DD
         03/h5G655S1fMey6gVjbb+bW9IWC6U2xpe/V9abAaFBlbzlBhhJkWocAPJEtXGmAH9Al
         h9lfLHqsbbkHy9yXThQaEX+zmnRHhBjSLXD7lh4QTQzS/mUklW3VPpeTKKw9GLjGoZPP
         +APw==
X-Gm-Message-State: AOJu0YyVjQerk6csAVmpwl+Z10Cw0wUoJNGEq3d2gTmLqFvTAH2BQLpD
        sD475ig/zk+FCsCvScKuycpdffCvApXVe3VLRATKA/r3V04ILa7SZyTE6n7w5Mtx4J8dO6qX2jW
        9FnM/sDuKxKooYp2464almSpXaqiDEhnMFBvUXw==
X-Received: by 2002:a17:906:218a:b0:9ad:7d5c:3d4b with SMTP id 10-20020a170906218a00b009ad7d5c3d4bmr9170361eju.35.1695746462968;
        Tue, 26 Sep 2023 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyLnGtjl16ZbEydnXM+tv4CysWF7HTsyNruFiTtg08cjTqOpFUagw9oPsSkwzQbGl91B9XtcGprebhtCWXQ+0=
X-Received: by 2002:a17:906:218a:b0:9ad:7d5c:3d4b with SMTP id
 10-20020a170906218a00b009ad7d5c3d4bmr9170343eju.35.1695746462665; Tue, 26 Sep
 2023 09:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
 <20230926100202.011ab841@xps-13> <adf9d668-0906-3004-d4e8-a7775844a985@datenfreihafen.org>
In-Reply-To: <adf9d668-0906-3004-d4e8-a7775844a985@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 26 Sep 2023 12:40:51 -0400
Message-ID: <CAK-6q+gfN7GtwfpUvOjNsNE9LSMTGrdLE6+-dgUEkVaA6SK1zw@mail.gmail.com>
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Sep 26, 2023 at 4:29=E2=80=AFAM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 26.09.23 10:02, Miquel Raynal wrote:
> > Hi Dinghao,
> >
> > dinghao.liu@zju.edu.cn wrote on Tue, 26 Sep 2023 11:22:44 +0800:
> >
> >> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
> >> it calls clk_unregister() to release priv->clk and returns an
> >> error. However, the caller ca8210_probe() then calls ca8210_remove(),
> >> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
> >> this case, a use-after-free may happen in the second time we call
> >> clk_unregister().
> >>
> >> Fix this by removing the first clk_unregister(). Also, priv->clk could
> >> be an error code on failure of clk_register_fixed_rate(). Use
> >> IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().
> >>
> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driv=
er")
> >
> > Missing Cc stable, this needs to be backported.
> >
> >> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> >> ---
> >>
> >> Changelog:
> >>
> >> v2: -Remove the first clk_unregister() instead of nulling priv->clk.
> >> ---
> >>   drivers/net/ieee802154/ca8210.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/=
ca8210.c
> >> index aebb19f1b3a4..b35c6f59bd1a 100644
> >> --- a/drivers/net/ieee802154/ca8210.c
> >> +++ b/drivers/net/ieee802154/ca8210.c
> >> @@ -2759,7 +2759,6 @@ static int ca8210_register_ext_clock(struct spi_=
device *spi)
> >>      }
> >>      ret =3D of_clk_add_provider(np, of_clk_src_simple_get, priv->clk)=
;
> >>      if (ret) {
> >> -            clk_unregister(priv->clk);
> >>              dev_crit(
> >>                      &spi->dev,
> >>                      "Failed to register external clock as clock provi=
der\n"
> >
> > I was hoping you would simplify this function a bit more.
> >
> >> @@ -2780,7 +2779,7 @@ static void ca8210_unregister_ext_clock(struct s=
pi_device *spi)
> >>   {
> >>      struct ca8210_priv *priv =3D spi_get_drvdata(spi);
> >>
> >> -    if (!priv->clk)
> >> +    if (IS_ERR_OR_NULL(priv->clk))
> >>              return
> >>
> >>      of_clk_del_provider(spi->dev.of_node);
> >
> > Alex, Stefan, who handles wpan and wpan/next this release?
>
> IIRC it would be me for wpan and Alex for wpan-next.

That's okay for me.

- Alex

