Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29449C7619A
	for <linux-wpan@archiver.kernel.org>; Sat,  8 Apr 2023 15:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDHPGF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 8 Apr 2023 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDHPGB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Apr 2023 11:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FBD524
        for <linux-wpan@vger.kernel.org>; Sat,  8 Apr 2023 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680966313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9sryqDLxXFtiPfudnwB2Hm3EkTYwVipdp4/U/AgJig=;
        b=RcOPCeKgx8JjcoOFSF1luYPGl/HTMvhAhhamhjwJ6/EhPfDkniaDRvYA79NUwO8TQ/euo+
        w5dnoTijSfV1pAlXlXlrddTcrkfsQRHFGdl0NhK3cwZLEo2b/xrADofevtmCcK87qeenY1
        FXApBzQO/C2ZwMNn0weJCYJgRsnT2/M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-g9ewHl6cP2-0L667FgNalw-1; Sat, 08 Apr 2023 11:05:11 -0400
X-MC-Unique: g9ewHl6cP2-0L667FgNalw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34a0f35fso17539966b.1
        for <linux-wpan@vger.kernel.org>; Sat, 08 Apr 2023 08:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680966310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9sryqDLxXFtiPfudnwB2Hm3EkTYwVipdp4/U/AgJig=;
        b=bwjsc5B1kWiE7AKpQ0hBpdvtsZBByDI8TthRDDj4a4balnX42MRoZ03fAGCuqFmuAy
         Jc77qsP6TZfA+X8tObx7D/m/EqNpI5tBs5zBX8tKurXc8ApA/Tep26TnHc/8Vg/ppFeb
         X/6KWf763GHSYIJOU0cvqkudKzeE5ku4IiMAtm0MGf1k6JsbXlTLqECucBHQ8wvIzEvg
         eBzcyTGvVmX9EFMj0VUOlrXYn612jcPk/DsiBmhIbwJ7tXJgCWuYuufFFuaNk910BcEZ
         tm1zs0tLnidCNLfxUMDKKP9dEzSCdHCilvJhXQLF1txp+4xiEYK03jYgmfLuLwUMyDti
         KBlQ==
X-Gm-Message-State: AAQBX9egH6XbTQ52u6Xa78qqa6Gsa1jwpy8Ck5DiTVgFvCncZ+5E0qk7
        2lHUzMioyZjmL9irxXY8ZT6RQj0m4+7RYBeq4CB71rjJ24HGTV0xB6t3eVEsuVh+HeqaDm1Ow1Z
        DnIbFe3iR/ataWJTtst5e7OBr/oeD8Dm3GMi1vw==
X-Received: by 2002:aa7:d590:0:b0:4fd:2675:3785 with SMTP id r16-20020aa7d590000000b004fd26753785mr1389707edq.22.1680966310623;
        Sat, 08 Apr 2023 08:05:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350YEXZM04gfrG0zUHYkHUTtzon3Nz0PuH2lQDJcHf0ICTIe5pJAzOGzTF1m/FMXP9xJ9r7stdvgILRdsVA9Ke24=
X-Received: by 2002:aa7:d590:0:b0:4fd:2675:3785 with SMTP id
 r16-20020aa7d590000000b004fd26753785mr1389692edq.22.1680966310343; Sat, 08
 Apr 2023 08:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230408081934.54002-1-chenaotian2@163.com>
In-Reply-To: <20230408081934.54002-1-chenaotian2@163.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 8 Apr 2023 11:04:58 -0400
Message-ID: <CAK-6q+j4aDoA2KG3Qzxg2XMu6nPxUuExuBw=sQ3+VqJuB5cj0A@mail.gmail.com>
Subject: Re: [PATH wpan v2] ieee802154: hwsim: Fix possible memory leaks
To:     Chen Aotian <chenaotian2@163.com>
Cc:     alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sat, Apr 8, 2023 at 4:22=E2=80=AFAM Chen Aotian <chenaotian2@163.com> wr=
ote:
>
> After replacing e->info, it is necessary to free the old einfo.
>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Chen Aotian <chenaotian2@163.com>
> ---
>
> V1 -> V2:
> * Using rcu_replace_pointer() is better then rcu_dereference()
>   and rcu_assign_pointer().
>
>  drivers/net/ieee802154/mac802154_hwsim.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 8445c2189..6ffcadb9d 100644
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
> -                       rcu_assign_pointer(e->info, einfo);
> +                       einfo_old =3D rcu_replace_pointer(e->info, einfo,
> +                                                       lock_is_held(&hws=
im_phys_lock));

I think lockdep_is_held() should be correct here.

- Alex

