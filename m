Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF80C7EE24
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Jun 2023 11:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjFCLbK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Jun 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCLbJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Jun 2023 07:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B20180
        for <linux-wpan@vger.kernel.org>; Sat,  3 Jun 2023 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685791820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jA+L302X21aYxkqH9/lHcodK1vnGG9Vy5qTtHkhY9oo=;
        b=jWMG3evUhDDa2fP4l5ueuyS62O0Jr4d8CqWUgiAd8B/lj2TQno6o6EjEvyoLVbiE+/xtpa
        Yv5L7YMY2u6twh3foSyhEO8Sz/ZpnqhAEgmJWH8BhQF13mcKabUDdH9Uq6shNDkffl4tIO
        kKYK4IxM3G95BiTFjiMtsb1VxAP2LzE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-ab1RsxVdN6qAZrtycsgMVg-1; Sat, 03 Jun 2023 07:30:18 -0400
X-MC-Unique: ab1RsxVdN6qAZrtycsgMVg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so2006133a12.3
        for <linux-wpan@vger.kernel.org>; Sat, 03 Jun 2023 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685791817; x=1688383817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jA+L302X21aYxkqH9/lHcodK1vnGG9Vy5qTtHkhY9oo=;
        b=QqfC9aMt3a2m421/gugLxQT6aIJHauW2ayD1JK8Lb6VZ+jWqpuZGneJi9Ivs2iWNzO
         X3ymPkANVh73n9EflqVlycXJDvwcEHECkK6+W6ziiDFVnduZwcBaUXqeQY8MmgthDekV
         OZpFMPthG2V2XFhGZdjQNa52lUKLkr6oIBEzQ80mBIjd94QylfIbIsjBI8+qrlVa8nvQ
         lettOdBJ7jV1s9ZsFRoTNmLt4VOEIfTKZ2rzNWzDeuuIXjizymBmg4J+jpam+YA/uPZQ
         8hmbtCsWVX1EppN+F8X2mUZzm7C64HiPfVBwNvBC2DAJgfIQXYYjCmw4OXa4oucH962Y
         tTBA==
X-Gm-Message-State: AC+VfDyyjwE+SCEao9CxtQD7lqTS2dT8jLtvqw0OR2QaH0SlsWXy4Ft/
        LTnbT39PwS6vDEtx/6C//KODPoQ///ozHjaAqIDSdXloQybnKce9rk/vIPj9zhh6Q8TDPyuY1c/
        5+RaIb+dc0CexBERQw/u2cCf1MX8uDTVGgJN0lw==
X-Received: by 2002:a17:907:7fa9:b0:961:800b:3f1e with SMTP id qk41-20020a1709077fa900b00961800b3f1emr1632129ejc.73.1685791817309;
        Sat, 03 Jun 2023 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LKGHHL+GwPFvOn9syVGUBc4afwXAkSmSvesI9G5o5xS3cD7y8xUuPxBXA3YH29jFLQ6Lzy8aCc3Va6wrFP1A=
X-Received: by 2002:a17:907:7fa9:b0:961:800b:3f1e with SMTP id
 qk41-20020a1709077fa900b00961800b3f1emr1632115ejc.73.1685791817015; Sat, 03
 Jun 2023 04:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230601154817.754519-1-miquel.raynal@bootlin.com> <20230601154817.754519-7-miquel.raynal@bootlin.com>
In-Reply-To: <20230601154817.754519-7-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 3 Jun 2023 07:30:05 -0400
Message-ID: <CAK-6q+hWR9cLt2+nbGY9KbtwLSJkN+NF+Q651aPDLCaO1mk1=Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next 06/11] mac802154: Handle disassociations
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

On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Devices may decide to disassociate from their coordinator for different
> reasons (device turning off, coordinator signal strength too low, etc),
> the MAC layer just has to send a disassociation notification.
>
> If the ack of the disassociation notification is not received, the
> device may consider itself disassociated anyway.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/ieee802154/pan.c         |   2 +
>  net/mac802154/cfg.c          | 102 +++++++++++++++++++++++++++++++++++
>  net/mac802154/ieee802154_i.h |   4 ++
>  net/mac802154/scan.c         |  60 +++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> index e2a12a42ba2b..477e8dad0cf0 100644
> --- a/net/ieee802154/pan.c
> +++ b/net/ieee802154/pan.c
> @@ -49,6 +49,7 @@ bool cfg802154_device_is_parent(struct wpan_dev *wpan_d=
ev,
>
>         return false;
>  }
> +EXPORT_SYMBOL_GPL(cfg802154_device_is_parent);
>
>  struct ieee802154_pan_device *
>  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> @@ -64,3 +65,4 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>
>         return NULL;
>  }
> +EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 89112d2bcee7..c27c05e825ff 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -386,6 +386,107 @@ static int mac802154_associate(struct wpan_phy *wpa=
n_phy,
>         return ret;
>  }
>
> +static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
> +                                             struct wpan_dev *wpan_dev)
> +{
> +       struct ieee802154_local *local =3D wpan_phy_priv(wpan_phy);
> +       struct ieee802154_pan_device *child, *tmp;
> +       struct ieee802154_sub_if_data *sdata;
> +       u64 eaddr;
> +       int ret;
> +
> +       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
> +
> +       /* Start by disassociating all the children and preventing new on=
es to
> +        * attempt associations.
> +        */
> +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
> +               ret =3D mac802154_send_disassociation_notif(sdata, child,
> +                                                         IEEE802154_COOR=
D_WISHES_DEVICE_TO_LEAVE);
> +               if (ret) {
> +                       eaddr =3D swab64((__force u64)child->extended_add=
r);

Does this pass sparse? I think this needs to be le64_to_cpu()?

- Alex

