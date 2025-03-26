Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260818BC2F
	for <linux-wpan@vger.kernel.org>; Wed, 26 Mar 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029360; cv=none; b=LewtgBPlviYvsHHRZ4mVupc08kGelsIg/CjczLhyvosuUpG3My0As7AXqF2+CHvBRrp+xUCNJXDP+Ezq4R5bHeqLZvBELXoP9Iycnh1eR6sLTyK8xkkj+Wl5BzkKMBvDA/FbOz/vOkEDf3+z7jWseG14f4QMsp0/QQ1lp26JD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029360; c=relaxed/simple;
	bh=pb62k3uPmcrFUbNnneW6CR+k/UDgFy/e/C8H10DakC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwR/ucKLwwQuU8aAET4Obq8tVg1Lfim201JnFPwB1X/sMwLHhIJyH4Rf4n6GPD1LstSUmYAfPkNzUkbetfzzopZo8Lvslo19Ku5FSEPr3gIEzG8oabWzJshqXT2Blf3h4VFDn2FwCNyS6dyk3kJu5dXkQRj6ywAQpt1rzmr1sTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD9KEe58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD9KEe58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743029357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qi8wdhM7rmWkvLOlU6keCbGUfSvgCk1Wxsh4f3EOl8Y=;
	b=bD9KEe58TqXlL1NTKKsDohpe16dzJDDPtPiWfb5WUcodsgBk8xHT35hzipZ7jzT61zf5WS
	os/S4dFSbdRuwiV1+/c6vh2d/4gTLI1yR+C8nKPyejfyrU8fgX8YGsmbeF5DpWCd2piAMn
	bMxW/ercXFabafAIA62v/CbMqfd5dOE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-bEt7K-SnOw-ctJ650ek_EA-1; Wed, 26 Mar 2025 18:49:16 -0400
X-MC-Unique: bEt7K-SnOw-ctJ650ek_EA-1
X-Mimecast-MFC-AGG-ID: bEt7K-SnOw-ctJ650ek_EA_1743029355
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c2d4271c7so2057881fa.0
        for <linux-wpan@vger.kernel.org>; Wed, 26 Mar 2025 15:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743029354; x=1743634154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi8wdhM7rmWkvLOlU6keCbGUfSvgCk1Wxsh4f3EOl8Y=;
        b=D4+Ir6mDPNjrqB7+hYoYhFt8piAlRFTy+gyRXnJQd+WqEr5eki0L9ax8t4BhIYP9wq
         1qQLf9FWKqctBOavA2MNFVJWtqp7XN5DnY77AGGpPQAjNJ8mbexyQ5zJn2VN705GLutf
         Tk8dN9jzXFPjWAC042OD7Bv+BHy2sSZuFnMRqjWIDaoWMlnyU/gn1DsWAWvElLJUiw6U
         oUV6TJ2pJpHaO22Je1Lb3gbG1r1pEURvnVhVon+CRXuleHx4r4DFHWQQuTVBsrdAE8IL
         CD4kO2CELiM7vptpjZfijJPUV0CNavURAsw/LRlUpal+3YGrFrisf0TjnZl6/etlrmiF
         dZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWXyu3tE46+RaRYc2/sbmYI6Py//WQmaxsWjIYp/bnl+qrPoeN47HK0G9UT6xwEnrjctvrDyU8ygZdp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8T0fVnRx2DxELYt7tOrUaoBjgR3gzARKM784/c9Gqovim26+e
	79qm6l+haqV2KEuCKpDQd4eborF+xTDpEXJlqwWyffU+q0SKp4HItvp/dQotKL4DExDlat7pfp7
	4U0+rG3La1U0rr5USD63uK/35Y4kTvVkbvXfjGiWpX3DHAPhKIDODH+bOVI70gywqwCCpcprWoS
	XExlITCqoPOOOEyvBrheoCQ0dHA6+40qcHhuIm+UqsNJCS
X-Gm-Gg: ASbGncsOQ5PuDD+1Ihbcpl2AcQnF9IDhJqoWF3Ycng3qXbS6tCLOhauEWMhqn8uXeoW
	cxUoSR1zY/uE5l6YU2LkFwTrhn6OdyEeanPh0d/y4CelzdeibQZMc3nFcYcjbDv1pU/6TCxluKo
	Ab3n9Jz63eFYzsH935Uk42uQbdZmnFWg==
X-Received: by 2002:a05:651c:2050:b0:30b:bdb0:f09d with SMTP id 38308e7fff4ca-30dc5f515bbmr5510351fa.32.1743029354115;
        Wed, 26 Mar 2025 15:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8cMCyuMwWy76IQjJTWRHtr9mD0i57Aua495nDnRXXsLw6FXvJjoQX0xrXHm47p5VgTZevUnfzjDqhw/Un7Cc=
X-Received: by 2002:a05:651c:2050:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-30dc5f515bbmr5510251fa.32.1743029353699; Wed, 26 Mar 2025
 15:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180909.10406-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250326180909.10406-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 26 Mar 2025 18:49:02 -0400
X-Gm-Features: AQ5f1JpGqx_OPjvXDypDk2rq6InmEg7NNHY5U7uN3dc0VBCMkBBj7u5F0xqSZks
Message-ID: <CAK-6q+hkHByFK2hWkrbZqFT5=h9U9nXuZJNF+_LhqmqeEC+Sng@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 26, 2025 at 2:09=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> This establishes an initialization method for perm_extended_addr, alignin=
g it with the approach used in mac80211_hwsim.
>

that is based on the phy index value instead of a random generated one?

> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 18 +++++++++++++++++-
>  drivers/net/ieee802154/mac802154_hwsim.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..400cdac1f 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -41,6 +41,17 @@ enum hwsim_multicast_groups {
>         HWSIM_MCGRP_CONFIG,
>  };
>
> +__le64 addr_to_le64(u8 *addr) {
> +    return cpu_to_le64(((u64)addr[0] << 56) |
> +                        ((u64)addr[1] << 48) |
> +                        ((u64)addr[2] << 40) |
> +                        ((u64)addr[3] << 32) |
> +                        ((u64)addr[4] << 24) |
> +                        ((u64)addr[5] << 16) |
> +                        ((u64)addr[6] << 8)  |
> +                        ((u64)addr[7]));
> +}
> +
>  static const struct genl_multicast_group hwsim_mcgrps[] =3D {
>         [HWSIM_MCGRP_CONFIG] =3D { .name =3D "config", },
>  };
> @@ -896,6 +907,7 @@ static int hwsim_subscribe_all_others(struct hwsim_ph=
y *phy)
>  static int hwsim_add_one(struct genl_info *info, struct device *dev,
>                          bool init)
>  {
> +       u8 addr[8];

why not using directly __le64?

>         struct ieee802154_hw *hw;
>         struct hwsim_phy *phy;
>         struct hwsim_pib *pib;
> @@ -942,7 +954,11 @@ static int hwsim_add_one(struct genl_info *info, str=
uct device *dev,
>         /* 950 MHz GFSK 802.15.4d-2009 */
>         hw->phy->supported.channels[6] |=3D 0x3ffc00;
>
> -       ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> +       memset(addr, 0, sizeof(addr));
> +       /* give a specific prefix to the address */
> +       addr[0] =3D 0x02;
> +       addr[7] =3D idx;
> +       hw->phy->perm_extended_addr =3D addr_to_le64(addr);
>
>         /* hwsim phy channel 13 as default */
>         hw->phy->current_channel =3D 13;
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/ieee8=
02154/mac802154_hwsim.h
> index 6c6e30e38..536d95eb1 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.h
> +++ b/drivers/net/ieee802154/mac802154_hwsim.h
> @@ -1,6 +1,8 @@
>  #ifndef __MAC802154_HWSIM_H
>  #define __MAC802154_HWSIM_H
>
> +__le64 addr_to_le64(u8 *addr);
> +

This is a uapi header for netlink which is not yet delivered through
kernel-headers installation.

Why do we need this prototype declaration here?

Thanks.

- Alex

