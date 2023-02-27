Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A9C64ED8
	for <linux-wpan@archiver.kernel.org>; Mon, 27 Feb 2023 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjB0UmG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0UmE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Feb 2023 15:42:04 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA5CDF9
        for <linux-wpan@vger.kernel.org>; Mon, 27 Feb 2023 12:42:03 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y14so2694986ilv.4
        for <linux-wpan@vger.kernel.org>; Mon, 27 Feb 2023 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5xcEx/bCDxZ7j88RRMfb6Jr3dQiB/Tjcos9TqbJygE=;
        b=oOEnZyYJFzA4fHnCL1DtEPPtFqBmP2+ERCH1+eZQz4Gbok5M4Kma95GdyqTlyOoSuR
         5xsTqQOYZqn+n9hr4GULMlKtSMtJEzCZYyTGwEoOWHH3BVK5h8NSgpudnr93kHto1ij/
         0E5rZ1oz96pWVKEJWJ4+MgXz3UbFEjYH/CAb/YqnAp9oilcHlZxJuEbAtXfjnGBFTf5K
         pSKIu5Vgc5vCUbHbNgMh7K/qmhHaQb48XGYlx+NLRoQHFPaPyDLkaIdGfjCJ6FmWdGtT
         71SBgo5QBYv82xKnMAnrHl/FHi5LkrTafTu69RY+XXqyhL0kQF/53+hxUaKscdOWXf2j
         7TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5xcEx/bCDxZ7j88RRMfb6Jr3dQiB/Tjcos9TqbJygE=;
        b=rBLW/Dt8XxUO6JpnbA9Ewtu1bdZGqN1iysUoFt+F0e9cMHfksdM/JW8uEWKTNmXfRH
         FHDTdLFR/zJsnDJgoJuXzVR46s0XPg7lkIm4MfFf5ZZF641Bcz+p13keeUyCAnHurlPn
         7Zl/raashTdYVmX5X+CxH7GCB9xrb71f5EZXAf9uLXAivCOWFszkuEIgfz8in4sg7cU7
         hiotDxF8t2iSZfnN+T4xHlD17kzwsjQ8+Mj4kamD6h+FwGwV6h/nscjwHFtPSii2Crgb
         2eroAZaKooK6ARbcSWbnrEvesb4zg8IUUsphsZ0d1jQM7FbmEJ0cesxTY7FHnUOnuW7T
         ZegA==
X-Gm-Message-State: AO0yUKVpzETionR3/NpELiIUWuOIRUT1U3IelGlYiOBqaqPYWlXfsEPD
        SxlISVcVV/MJoCiRtI7Xd4eWochEf140Qvw4CEJ1vQKmI8B+9Uq2tb0=
X-Google-Smtp-Source: AK7set9L6tEYB6JebZDylx3TrJruacUJPhnlIjBX6boeXOexwsp8Oif/3mCfnf09VJdNV7v6ULSEcVRYe4qGBBj9zsk=
X-Received: by 2002:a92:750b:0:b0:315:50a4:c5e5 with SMTP id
 q11-20020a92750b000000b0031550a4c5e5mr405192ilc.2.1677530522648; Mon, 27 Feb
 2023 12:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20230214135035.1202471-1-miquel.raynal@bootlin.com> <20230214135035.1202471-3-miquel.raynal@bootlin.com>
In-Reply-To: <20230214135035.1202471-3-miquel.raynal@bootlin.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 27 Feb 2023 21:41:51 +0100
Message-ID: <CANn89iLGLcQKYCTi7Vu3fm7n6v3mgeedeG4sE0MR2WG-dOWsXw@mail.gmail.com>
Subject: Re: [PATCH wpan v2 2/6] ieee802154: Convert scan error messages to extack
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
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

On Tue, Feb 14, 2023 at 2:50=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Instead of printing error messages in the kernel log, let's use extack.
> When there is a netlink error returned that could be further specified
> with a string, use extack as well.
>
> Apply this logic to the very recent scan/beacon infrastructure.
>
> Fixes: ed3557c947e1 ("ieee802154: Add support for user scanning requests"=
)
> Fixes: 9bc114504b07 ("ieee802154: Add support for user beaconing requests=
")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/ieee802154/nl802154.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 64fa811e1f0b..d3b6e9e80941 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1407,9 +1407,15 @@ static int nl802154_trigger_scan(struct sk_buff *s=
kb, struct genl_info *info)
>         u8 type;
>         int err;
>
> -       /* Monitors are not allowed to perform scans */
> -       if (wpan_dev->iftype =3D=3D NL802154_IFTYPE_MONITOR)
> +       if (wpan_dev->iftype =3D=3D NL802154_IFTYPE_MONITOR) {
> +               NL_SET_ERR_MSG(info->extack, "Monitors are not allowed to=
 perform scans");
>                 return -EPERM;
> +       }
> +
> +       if (!nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE])) {

syzbot crashes hosts by _not_ adding NL802154_ATTR_SCAN_TYPE attribute.

Did you mean to write :

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 2215f576ee3788f74ea175b046d05d285bac752d..d8f4379d4fa68b5b07bb2c45cd7=
4d4b73213c107
100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1412,7 +1412,7 @@ static int nl802154_trigger_scan(struct sk_buff
*skb, struct genl_info *info)
                return -EOPNOTSUPP;
        }

-       if (!nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE])) {
+       if (!info->attrs[NL802154_ATTR_SCAN_TYPE]) {
                NL_SET_ERR_MSG(info->extack, "Malformed request,
missing scan type");
                return -EINVAL;
        }


> +               NL_SET_ERR_MSG(info->extack, "Malformed request, missing =
scan type");
> +               return -EINVAL;
> +       }
>
>         request =3D kzalloc(sizeof(*request), GFP_KERNEL);
>         if (!request)
> @@ -1424,7 +1430,7 @@ static int nl802154_trigger_scan(struct sk_buff *sk=
b, struct genl_info *info)
>                 request->type =3D type;
>                 break;
>         default:
> -               pr_err("Unsupported scan type: %d\n", type);
> +               NL_SET_ERR_MSG_FMT(info->extack, "Unsupported scan type: =
%d", type);
>                 err =3D -EINVAL;
>                 goto free_request;
>         }
> @@ -1576,12 +1582,13 @@ nl802154_send_beacons(struct sk_buff *skb, struct=
 genl_info *info)
>         struct cfg802154_beacon_request *request;
>         int err;
>
> -       /* Only coordinators can send beacons */
> -       if (wpan_dev->iftype !=3D NL802154_IFTYPE_COORD)
> +       if (wpan_dev->iftype !=3D NL802154_IFTYPE_COORD) {
> +               NL_SET_ERR_MSG(info->extack, "Only coordinators can send =
beacons");
>                 return -EOPNOTSUPP;
> +       }
>
>         if (wpan_dev->pan_id =3D=3D cpu_to_le16(IEEE802154_PANID_BROADCAS=
T)) {
> -               pr_err("Device is not part of any PAN\n");
> +               NL_SET_ERR_MSG(info->extack, "Device is not part of any P=
AN");
>                 return -EPERM;
>         }
>
> --
> 2.34.1
>
