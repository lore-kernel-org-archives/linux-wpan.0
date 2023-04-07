Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57992C6FD1D
	for <linux-wpan@archiver.kernel.org>; Fri,  7 Apr 2023 22:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDGWVe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 7 Apr 2023 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGWVd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 7 Apr 2023 18:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB97ECB
        for <linux-wpan@vger.kernel.org>; Fri,  7 Apr 2023 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680906046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sh3HFtUiIveDO9geaO+OZn8WlGzmk7g/J+bfhfYbiM0=;
        b=UJK5DK6w7dRF/cRbQF0MYx2z/SfPYh2xyN3AZEtSMNTTUDDlkmOpCtPlrtEqUr7Wy1Uv+z
        Pz/V8vWzidckXnF7W9cwVxwfrdW8Ktn5tDMOFT+EWoTgSHHoKk4gDMEw19gr2QaD6nrCf6
        9tzIgt7MZ6CfcaUhyjWTQtQOXQpubYE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-4uk8xFdbMFu_BA3hMBY7pw-1; Fri, 07 Apr 2023 18:20:44 -0400
X-MC-Unique: 4uk8xFdbMFu_BA3hMBY7pw-1
Received: by mail-ej1-f70.google.com with SMTP id vg10-20020a170907d30a00b0094807746cebso1901741ejc.6
        for <linux-wpan@vger.kernel.org>; Fri, 07 Apr 2023 15:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680906043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sh3HFtUiIveDO9geaO+OZn8WlGzmk7g/J+bfhfYbiM0=;
        b=tpof3A+aMHT5Lt2AtFkg1+h7AV8qbEuPnN3xaZENCCo2rNgvbbuzYjNSjjeSJIaLRo
         F1DrbxA98O7wsbG/XHCfyhQxP0yQtVmM2UK9Mqrj6nYeUl6vuAXaFek5hUco179Ffgqr
         EA1NSSqXg7ijytRWal6/oRvi3xc9B5DEVJuyBSJVoJlXr+nHACSnyVhyCr+ZgWC/wEZY
         TQyDPIkcwBtYDfC/G8f05sNjPdsD2c3QRRJadslat3FDhjBDcL/BMJab1ff2SfTM72xv
         b6HuUnT/lW1XOkeUyoLqgIstDbBwjXVAzJxuPOkpsLpIY07jp42jjWZcKA+LnHMFYqny
         q0pQ==
X-Gm-Message-State: AAQBX9e30s3emegRLoDD+aMmO5Lj7CwSSqII9jkyJ2uzvgMKu7f/AJoI
        Jc/Rn6xLrf5WjtbGIJJyCN9iKLWpaDJ3RcEpjAkwszZfVS81ycWE12qhR3z5bFwZG/WY6WUNa8Y
        XJT0N9Ln8ublKQeV1FOrFGLDitku5nsGn9lMsCA==
X-Received: by 2002:a17:906:4690:b0:930:1178:2220 with SMTP id a16-20020a170906469000b0093011782220mr95632ejr.40.1680906043580;
        Fri, 07 Apr 2023 15:20:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdjKda8XASC+CGeDn5cjd4gS1Y/aghaO307w7qLJjZRB6caA9JHIcZMQpdfghKjBDxdNH4Y7CosJWEoPZL8sM=
X-Received: by 2002:a17:906:4690:b0:930:1178:2220 with SMTP id
 a16-20020a170906469000b0093011782220mr95627ejr.40.1680906043336; Fri, 07 Apr
 2023 15:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230407095301.45858-1-chenaotian2@163.com>
In-Reply-To: <20230407095301.45858-1-chenaotian2@163.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 7 Apr 2023 18:20:32 -0400
Message-ID: <CAK-6q+gpRPxquCSCfPB+9Ym+1PTu9Z+qzC+PHj_K94nSGUbTWA@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: Fix possible memory leaks
To:     Chen Aotian <chenaotian2@163.com>
Cc:     alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernelorg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Apr 7, 2023 at 5:55=E2=80=AFAM Chen Aotian <chenaotian2@163.com> wr=
ote:
>
> After replacing e->info, it is necessary to free the old einfo.
>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Chen Aotian <chenaotian2@163.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 8445c2189..6e7e10b17 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -685,7 +685,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, str=
uct genl_info *info)
>  static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *inf=
o)
>  {
>         struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
> -       struct hwsim_edge_info *einfo;
> +       struct hwsim_edge_info *einfo, *einfo_old;
>         struct hwsim_phy *phy_v0;
>         struct hwsim_edge *e;
>         u32 v0, v1;
> @@ -723,8 +723,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, s=
truct genl_info *info)
>         list_for_each_entry_rcu(e, &phy_v0->edges, list) {
>                 if (e->endpoint->idx =3D=3D v1) {
>                         einfo->lqi =3D lqi;
> +                       einfo_old =3D rcu_dereference(e->info);
>                         rcu_assign_pointer(e->info, einfo);

nitpick rcu_replace_pointer() can be used here.*

- Alex

