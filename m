Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C61537CB;
	Wed, 26 Mar 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743031493; cv=none; b=Q2TS7M909xkBOBuU4GuSmYeL/2yk1O8iIcJbzm+7YUrL0Pkae/D216xSeHvqYG8b2E/eI48H5VO3nns+6J+2eUk8BLQMpsHmRxTOg1HWRVt8FOR+DRVOqQOtwuBzMIoCk+JXz7aqIdVkzK/YbMuIDkvzG2Tu++0sIyZdEme2Pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743031493; c=relaxed/simple;
	bh=PIIdWtyAj4inA4YTOvxkfRz0aC+wXBaEEXAJg8EBuzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0XSSOSvMDf7s6tklbDYSPzNdRRD2fjrlZ+436wQ+On3w5JP4Phpzemh0GYoN1s7OxNFvu+E9ocfDqsi20/XFn5P4z5gT7yzvMgv8d5sQizyelEFE0rgAFgHizjgi8IAItkS74Z+dLJIJ69tnlwCrNtMJQRdkk5IwZsLzTwq8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkHcYsrr; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkHcYsrr"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d69774081so190269241.0;
        Wed, 26 Mar 2025 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743031490; x=1743636290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvBYyj5m6bTFhPpu5G3kmoFiNR4fomHkjxdoYP9tVZQ=;
        b=DkHcYsrrbcACbxKNGT8YIgeBuDysJoDR9rrtpqYFeq138M2HYo/tx6n5v76gnpb/Qd
         E7dAJ7dOdTBUBm4MnM9HMehFsYDVA3DSBfPANjtKAbFWo89/VkpRBPi6IQWwXgKWSk4J
         fTxfaoUkd6techeye9kzRO6Zi3UmDFWiUNyh4MkQwC1uNR03bpkJFRvxwlSNFVFdAMmq
         4hzVI7x5yT6NlOyBcPUaoplk0dmsfyPeigPGAezcSs3WanQLgSwvEaaxFfV/4ybuj9Ix
         6082cnOC3zkkFG/MKvzYE/gL/86f8djvAjiaZMWXNhg01y4SNB00d6BK48Hnk40rA/kG
         H7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743031490; x=1743636290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvBYyj5m6bTFhPpu5G3kmoFiNR4fomHkjxdoYP9tVZQ=;
        b=JCUqmXCYauoHmXj0hEt1cB55qWn5bm44YjpqUIFVRfWI2D/yVbfpjY94cyXFxaOnr/
         Hy8jUCz4tmvlzUJZDnLD9qxoXfCGmwWh16e9lDUQdzCSFR5MXADOCUUAIo6X+SG2Lxu0
         nktf3GuV9A3eeUpXLWcx9yu7UwXi1gOM/UEMl1vaVBwyVuPNUmw2swnp/Q5/eu15RB/F
         6Db983mp1Lhw12dHj6eeIZHVt2GhXzjSMr3seqkCZO+ERibVuf4BhTuLCs9FgglWQNFP
         b76lc89S9/Jpe0sY1kqcxoZ/rrGeGOkm+/2uuxSuCC3xHKZ5QfgzT4Ys0DGcS+WT2Mep
         sfDA==
X-Forwarded-Encrypted: i=1; AJvYcCWJmrdXk4HCJU9ScEwYQhktOAjrVKULlYmgAwxL2Fg3KT+pj8uHJvnK0MYQdlxp+aUdVzYnaVe9bUq+@vger.kernel.org, AJvYcCWjnOqHIhIoHRPr+kb6PvaQgzdI7N6oeB56sYJ10E1ghmCn5hJ8BfL2GJBj+BtjE3e+dm9Y2pO4@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9TCpc9I/YeWq8iXfPf/C8S23oZQTy5n0asgjC8NlgCQH2mwl
	hZRWev3ai8/GuD3WL1lorwbf32vDTPx45ZwpFPAoglosYxt0WHSZb+CsQ89/Iq9eLiIfnY1YSmp
	vJxWiZ0pdwccclsTdPBQUEb3fx/94h12wdo0=
X-Gm-Gg: ASbGncvfU7oEQn9VIbbhjkX/5mDoiUPeG4ROqbL8Asq7mQGj8f9HVh6AahE65MrbWMb
	ntl3y9JvE39O87o/G0r5LrHEc0SKHRbou25szwLSU95QF166hxv7wdLOMc0q2j4KrIwS2Pgc/iL
	vL/GFmS991quE3IQP9zYK7wdYFSA==
X-Google-Smtp-Source: AGHT+IEsQQMt8gitdBLnl/0w5gq/Nsc6vtr9ogoz6eLE8IKe8VR4aQF9YhMbwJAMNEZhxJSnWGafZeXeKVnWdBhlfMI=
X-Received: by 2002:a05:6102:1498:b0:4c4:e414:b4eb with SMTP id
 ada2fe7eead31-4c586fa2324mr2094400137.12.1743031490142; Wed, 26 Mar 2025
 16:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180909.10406-1-ramonreisfontes@gmail.com> <CAK-6q+hkHByFK2hWkrbZqFT5=h9U9nXuZJNF+_LhqmqeEC+Sng@mail.gmail.com>
In-Reply-To: <CAK-6q+hkHByFK2hWkrbZqFT5=h9U9nXuZJNF+_LhqmqeEC+Sng@mail.gmail.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Wed, 26 Mar 2025 20:24:38 -0300
X-Gm-Features: AQ5f1Jp0Azqb5K7EaxmMbHhobiCsizAD-Mz8tigmPzQaIQ1NMzOy8TBP2akRh9s
Message-ID: <CAK8U23Ydy8jC+7ZUfHaa+sQzECo3MYiDFwFY=MjP9z3GBjtQQw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:49=E2=80=AFPM, Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Wed, Mar 26, 2025 at 2:09=E2=80=AFPM Ramon Fontes <ramonreisfontes@gma=
il.com> wrote:
> >
> > This establishes an initialization method for perm_extended_addr, align=
ing it with the approach used in mac80211_hwsim.
> >
>
> that is based on the phy index value instead of a random generated one?

Yes, that's based on the phy index value.

>
> > Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> > ---
> >  drivers/net/ieee802154/mac802154_hwsim.c | 18 +++++++++++++++++-
> >  drivers/net/ieee802154/mac802154_hwsim.h |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/iee=
e802154/mac802154_hwsim.c
> > index 1cab20b5a..400cdac1f 100644
> > --- a/drivers/net/ieee802154/mac802154_hwsim.c
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > @@ -41,6 +41,17 @@ enum hwsim_multicast_groups {
> >         HWSIM_MCGRP_CONFIG,
> >  };
> >
> > +__le64 addr_to_le64(u8 *addr) {
> > +    return cpu_to_le64(((u64)addr[0] << 56) |
> > +                        ((u64)addr[1] << 48) |
> > +                        ((u64)addr[2] << 40) |
> > +                        ((u64)addr[3] << 32) |
> > +                        ((u64)addr[4] << 24) |
> > +                        ((u64)addr[5] << 16) |
> > +                        ((u64)addr[6] << 8)  |
> > +                        ((u64)addr[7]));
> > +}
> > +
> >  static const struct genl_multicast_group hwsim_mcgrps[] =3D {
> >         [HWSIM_MCGRP_CONFIG] =3D { .name =3D "config", },
> >  };
> > @@ -896,6 +907,7 @@ static int hwsim_subscribe_all_others(struct hwsim_=
phy *phy)
> >  static int hwsim_add_one(struct genl_info *info, struct device *dev,
> >                          bool init)
> >  {
> > +       u8 addr[8];
>
> why not using directly

Yes, we don't need it.

>
> >         struct ieee802154_hw *hw;
> >         struct hwsim_phy *phy;
> >         struct hwsim_pib *pib;
> > @@ -942,7 +954,11 @@ static int hwsim_add_one(struct genl_info *info, s=
truct device *dev,
> >         /* 950 MHz GFSK 802.15.4d-2009 */
> >         hw->phy->supported.channels[6] |=3D 0x3ffc00;
> >
> > -       ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> > +       memset(addr, 0, sizeof(addr));
> > +       /* give a specific prefix to the address */
> > +       addr[0] =3D 0x02;
> > +       addr[7] =3D idx;
> > +       hw->phy->perm_extended_addr =3D addr_to_le64(addr);

I think we can replace everything with only one line of code:

hw->phy->perm_extended_addr =3D cpu_to_le64(((u64)0x02 << 56) | ((u64)idx))=
;

This does the trick! What do you think?

> >
> >         /* hwsim phy channel 13 as default */
> >         hw->phy->current_channel =3D 13;
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/iee=
e802154/mac802154_hwsim.h
> > index 6c6e30e38..536d95eb1 100644
> > --- a/drivers/net/ieee802154/mac802154_hwsim.h
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.h
> > @@ -1,6 +1,8 @@
> >  #ifndef __MAC802154_HWSIM_H
> >  #define __MAC802154_HWSIM_H
> >
> > +__le64 addr_to_le64(u8 *addr);
> > +
>
> This is a uapi header for netlink which is not yet delivered through
> kernel-headers installation.
>
> Why do we need this prototype declaration here?

We don't need it.

>
> Thanks.
>
> - Alex
>
