Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2673328FC
	for <linux-wpan@vger.kernel.org>; Thu,  5 Mar 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703468; cv=pass; b=qav6KMxZ73G17HzR6VLqlpM7LFBRPbc/JXqz+npGHYn/UgXZ/xP80PRSGQemdhjpNfrv/u5twVP+RLn525FSiRA6cf4S8rCzr0K4ZouS83ufLPmLSJb9oRFajAWFq3+a/gvSIg6+Dqq83aLFLE/EUOo8fJxCF8deeCB2v6jUAuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703468; c=relaxed/simple;
	bh=h5eoV1IeSL0UsSKft1SpRtMCq7Z2FCkrGpM+M7P/+dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnKlj7j4Y/c9NZw2yamwBLldC0bqCD2Za2Znn5hi71zM584FW36auvrg/PiJdYmDmh4nCQTu+d+W9wOZ780rGmMuMX/AStV2L+EOkYwxivf1xzKtF+F7mBW2EAUfJQwVfzkTFEDOhuhHbGwDBtC4oCQ7uo3+9gY85zDiEy1pobE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3gUvHqS; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3gUvHqS"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899e87b04d8so81963816d6.3
        for <linux-wpan@vger.kernel.org>; Thu, 05 Mar 2026 01:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772703464; cv=none;
        d=google.com; s=arc-20240605;
        b=evb681ReGTWYZSFJcP59uMlw/N2SytOsUNbG90TmgbHzZDnG27KrFfuPpavCRSEddv
         rDB4tocO7B9L3ebonf6jk6zGTkCetADGqpB5NgVNSJVYzzPEjeXxK5dur6Q2ht3VFBQO
         o6oxYoX5JiNaZXHqR2hgfxGEeadlxk3gGN9j+J2iHxVjmFfA9rC6Qgevj53cYqFoeLq/
         HmHvCJwAhDflswZWL278kWcN6KeSicWCgjIyrcia5sOsr4jOjAvFjhoNtKEtJLbvKGq1
         y6rS7NeSY9R2UcezJDcutYDcJGWi0cJFP8jf1++6EZQetgAhXC2W4f6/e/YEJvoOwszT
         GnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        fh=huhQd/5y1zGmiU5Ol7KRb9pjFc+UVqd/CxU6i6EgZVw=;
        b=UeYTTEVTQtPvjnjEsJaI6rO3PFscFywVlvhHLy12T9SyamZfRpxcg/WXYULkbtewHl
         raFiIQKRAQ6M4LEW+qUitrdQY/20YidA7QgU4UawQC/vt28Yu7asWohEjUdBT9ZLKSnt
         DQgXkFX5K2zHFzjO5IMCvrx7r+hbcmHyyJPGHDbZaWbPE7wpOkEGWZuV/Xi8CxF1J7V7
         LQgegNxJIbBsM6yg5lb1W3AgzcddEOLExF3KRuZUBv35O1Hu/YWi7BRgLTx1r0nh995U
         E3nE4qHizVWjwNCMIV5Bt887UAWCsDdaq2+2znvkqQuoD2M+0mRLSVzEmoM1JKkEUK/j
         nyzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772703464; x=1773308264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        b=U3gUvHqSBhzqNdmlZviD1dZD/dsFUNZC+890FzFRGWopJwNoCncwdLhqyMDxBubHDw
         16JUDPWOT4r8u0XeTN4GKGn8qbyJ5+DS9iVv4+XQ+SH5scya8tkGoILOTL0WdCKxEhxr
         6PXc9cwXTQZ4eNt0KoxQVkYBfIIfyPPkR0CJYr5+0Aw9M+5SchGzcGeDjFC7NpqmvzEK
         Ll08zDb3H4z6P8vKmv1Twthc1Zf5eIeQDCIkzK1hsAm36n+Vkq4Kf0IdVQjCdVxU7c/Y
         TjKtXJ04vVDnoe2329pp8/Xf+pZnmgBRkrRrkjL+lkGURpv+iaxUDnrmpzchEK7uyKYN
         Cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703464; x=1773308264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        b=BBgdlKEwr9vYV2mRdOylRI2Bks86OXHhbble3OrGex1iguEGeGluBBLMRsCGViCWHv
         vX1mHAuNKhVNoyde+UgzasTrgJqp71fb9mlHPPfKV3FD1aZRhf1lN7ymtvOx/J2gH5JO
         YL+uWmYvc/heFWtwzDkKPjeTSH4N/z6atOUfjStBnCoO20fCLPl+xMkUaBJBSlW5ceW2
         rz0Ezz+KpCtWViwJxa6YGDRd4oqmzZ7G4ZrbPoLaxqrCOTDHGpr0oi4DVoF9g97Y7AEm
         HDI+Jmn7mOnKDiSicU5nx7PWVGe9Rn873s/WvQpvpjOFayUDTRgOu53KWVDg74K1SNTQ
         uUVA==
X-Forwarded-Encrypted: i=1; AJvYcCXLWR+n+G7x3YY5nf3YOIMx77X3cnyk/01jL4/okHrTVflfRMoo6IDPSBP8yp7wPbPhEmbqNYpd+yKd@vger.kernel.org
X-Gm-Message-State: AOJu0Yztw0MLRe4kwdN475STTss65TojUpr1b9dJV5yRNFGoSrgx4q7o
	VOdx5mEtHmIvBgKbhH45C20vfTRCeUbnNt5S8lyyhLtr/kVkOsvI8ZX1w2fyxsKEmWcbDAz1f+q
	8qV09V8SdszWOrohfe6UevzTSkaHrmn1dO43tZl/A
X-Gm-Gg: ATEYQzyF5gZsoTWwhPQ2lC9i6IeeVWVVVHDdzjwZ4M5eIeZoshcGFWd6SpHi2jBnXZt
	iN8pA9LidRtDn4ThzWKONDjj8Iu4hx5DujMmI1M9Yww9AiqVlefQ+udOC7VeUIy8WjJAVWdJnJS
	KOxuMTzPhXQLFyFpH2kofbWJH9wh6cvyHfbVwhAc3XR6wQOVuCajIunf1JxU3j0Yb2+yyNmT28E
	xxjjvk/xhkVwCazyn4EKBlt7CTYi1cERyohBXStI0z/mXbGnC3bMoVi3VpsiAQFgCDbsDgwoIhC
	N6vqk8w=
X-Received: by 2002:ad4:4ea6:0:b0:899:f2ba:9d7e with SMTP id
 6a1803df08f44-89a19d21b73mr75406456d6.38.1772703463816; Thu, 05 Mar 2026
 01:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com> <20260305092706.145085-3-kota.toda@gmo-cybersecurity.com>
In-Reply-To: <20260305092706.145085-3-kota.toda@gmo-cybersecurity.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Mar 2026 10:37:32 +0100
X-Gm-Features: AaiRm53Vdi26l9lPKD76G6HoI6f1DRss96jaPlzjG_Zyxqxv7PCKBasLiGDqdXY
Message-ID: <CANn89iJtpHAXZevL4b3X2CaEJvcM-fVJRQe2wUYfDrLzbuSKAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: add READ_ONCE for header_ops callbacks
To: Kota Toda <kota.toda@gmo-cybersecurity.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>, linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:27=E2=80=AFAM Kota Toda
<kota.toda@gmo-cybersecurity.com> wrote:
>
> Use READ_ONCE when loading header_ops callbacks
> to avoid races with concurrent updates.
>


Same remark than patch 1/2.

Add a Fixes: tag, or explain why you chose to not add one.

One line changelog are ok for really trivial patches.

Here it is unclear why we have either of these pointers being
dynamically changed.

I left further comments, please read them carefully.

> Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> ---
>  include/linux/netdevice.h | 28 +++++++++++++++++++---------
>  include/net/cfg802154.h   |  2 +-
>  net/core/neighbour.c      |  6 +++---
>  net/ipv4/arp.c            |  2 +-
>  net/ipv6/ndisc.c          |  2 +-
>  5 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 77a99c8ab..f50b0a4e8 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3150,35 +3150,44 @@ static inline int dev_hard_header(struct sk_buff =
*skb, struct net_device *dev,
>                                   const void *daddr, const void *saddr,
>                                   unsigned int len)
>  {
> -       if (!dev->header_ops || !dev->header_ops->create)
> +       int (*create)(struct sk_buff *skb, struct net_device *dev,
> +                     unsigned short type, const void *daddr,
> +                     const void *saddr, unsigned int len);
> +       create =3D READ_ONCE(dev->header_ops->create);

If dev->header_ops is NULL, we will crash in the above READ_ONCE()

> +       if (!dev->header_ops || !create)
>                 return 0;
>
> -       return dev->header_ops->create(skb, dev, type, daddr, saddr, len)=
;
> +       return create(skb, dev, type, daddr, saddr, len);
>  }
>
>  static inline int dev_parse_header(const struct sk_buff *skb,
>                                    unsigned char *haddr)
>  {
> +       int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
>         const struct net_device *dev =3D skb->dev;
>
> -       if (!dev->header_ops || !dev->header_ops->parse)
> +       parse =3D READ_ONCE(dev->header_ops->parse);

Same error here.

> +       if (!dev->header_ops || !parse)
>                 return 0;
> -       return dev->header_ops->parse(skb, haddr);
> +       return parse(skb, haddr);
>  }
>
>  static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb=
)
>  {
> +       __be16  (*parse_protocol)(const struct sk_buff *skb);
>         const struct net_device *dev =3D skb->dev;
>
> -       if (!dev->header_ops || !dev->header_ops->parse_protocol)
> +       parse_protocol =3D READ_ONCE(dev->header_ops->parse_protocol);

Same error here.

> +       if (!dev->header_ops || !parse_protocol)
>                 return 0;
> -       return dev->header_ops->parse_protocol(skb);
> +       return parse_protocol(skb);
>  }
>
>  /* ll_header must have at least hard_header_len allocated */
>  static inline bool dev_validate_header(const struct net_device *dev,
>                                        char *ll_header, int len)
>  {
> +       bool    (*validate)(const char *ll_header, unsigned int len);
>         if (likely(len >=3D dev->hard_header_len))
>                 return true;
>         if (len < dev->min_header_len)
> @@ -3189,15 +3198,16 @@ static inline bool dev_validate_header(const stru=
ct net_device *dev,
>                 return true;
>         }
>
> -       if (dev->header_ops && dev->header_ops->validate)
> -               return dev->header_ops->validate(ll_header, len);
> +       validate =3D READ_ONCE(dev->header_ops->validate);
> +       if (dev->header_ops && validate)
> +               return validate(ll_header, len);
>
>         return false;
>  }
>
>  static inline bool dev_has_header(const struct net_device *dev)
>  {
> -       return dev->header_ops && dev->header_ops->create;
> +       return dev->header_ops && READ_ONCE(dev->header_ops->create);
>  }
>
>  /*
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 76d2cd2e2..dec638763 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -522,7 +522,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_=
device *dev,
>  {
>         struct wpan_dev *wpan_dev =3D dev->ieee802154_ptr;
>
> -       return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
> +       return READ_ONCE(wpan_dev->header_ops->create)(skb, dev, daddr, s=
addr, len);
>  }
>  #endif
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 96786016d..ff948e35e 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1270,7 +1270,7 @@ static void neigh_update_hhs(struct neighbour *neig=
h)
>                 =3D NULL;
>
>         if (neigh->dev->header_ops)
> -               update =3D neigh->dev->header_ops->cache_update;
> +               update =3D READ_ONCE(neigh->dev->header_ops->cache_update=
);
>
>         if (update) {
>                 hh =3D &neigh->hh;
> @@ -1540,7 +1540,7 @@ static void neigh_hh_init(struct neighbour *n)
>          * hh_cache entry.
>          */
>         if (!hh->hh_len)
> -               dev->header_ops->cache(n, hh, prot);
> +               READ_ONCE(dev->header_ops->cache)(n, hh, prot);
>
>         write_unlock_bh(&n->lock);
>  }
> @@ -1556,7 +1556,7 @@ int neigh_resolve_output(struct neighbour *neigh, s=
truct sk_buff *skb)
>                 struct net_device *dev =3D neigh->dev;
>                 unsigned int seq;
>
> -               if (dev->header_ops->cache && !READ_ONCE(neigh->hh.hh_len=
))
> +               if (READ_ONCE(dev->header_ops->cache) && !READ_ONCE(neigh=
->hh.hh_len))
>                         neigh_hh_init(neigh);
>
>                 do {
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 7822b2144..421bea6eb 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -278,7 +278,7 @@ static int arp_constructor(struct neighbour *neigh)
>                         memcpy(neigh->ha, dev->broadcast, dev->addr_len);
>                 }
>
> -               if (dev->header_ops->cache)
> +               if (READ_ONCE(dev->header_ops->cache))
>                         neigh->ops =3D &arp_hh_ops;
>                 else
>                         neigh->ops =3D &arp_generic_ops;
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index d961e6c2d..d81f509ec 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -361,7 +361,7 @@ static int ndisc_constructor(struct neighbour *neigh)
>                         neigh->nud_state =3D NUD_NOARP;
>                         memcpy(neigh->ha, dev->broadcast, dev->addr_len);
>                 }
> -               if (dev->header_ops->cache)
> +               if (READ_ONCE(dev->header_ops->cache))
>                         neigh->ops =3D &ndisc_hh_ops;
>                 else
>                         neigh->ops =3D &ndisc_generic_ops;
> --
> 2.53.0
>
