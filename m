Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FC51C338
	for <linux-wpan@vger.kernel.org>; Wed, 16 Sep 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580614; cv=none; b=Vt7fgzdpq8a3XN+m3RSjB2p+FiDbGKy0ZuPZXCrkZJ0V8CaQ+UpLWdA7EZYhSgRGPitnx43++1caoaKV6r419G8Jjfe6Rv3k3xpghjxrFQft/vNPq6L8MGk5kd5fC34WWVii+a6gfKg4zPSLdpcFbDMY9LbZR4e+nWJ4MPbHo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580614; c=relaxed/simple;
	bh=/EQmlTpPWabY3NIR14EHBnf/GGPLY/Gd8xk8Z8Tii4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Qcniqmi99zbviu0nQoRy7Yk/oZv0Cl3FLiuL1IlZRzFpIK22QlBmaqAF5GFndJWXt/AxV+dZXRYseOyvGAirB3YpD288dL+ahYZtM8kXpszwUuG+ygZKjjKNAyvSxvmpQchhP8IKj1wMn//YmtBK5UsjmlzlPiEIFTG6jDUPkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4xNSpuX; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4xNSpuX"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8631d0023daso842563b3a.2
        for <linux-wpan@vger.kernel.org>; Wed, 16 Sep 2026 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580594; x=1790185394; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZbW+4m7Ckt5T3Vp0i2qlknolTY3jp+RjMzIv0/DlDJ8=;
        b=b4xNSpuXwmkzbsZ28awrx3a9n1EIPa+llNW8kvJCGPnDmKCHETbeohmM586vr+jBH8
         5gxI/Ob0Hx4vTDFDTLD9ica7af62Q9dZcbXceIJhu5ewU+4A1ovkPkVFCJ47HSj2yzx0
         6hY2Q0K3uSEPviQttYxhBnoZ7Ydk3yWvPVbn/QX/po4jLmSFubWZWaeOZwPLBjk7pLWG
         54Jz6wN2EXSsKtMEqrL2IMlIf6RJiyNakQZjliLs2vod6uIA3TQlgphITZAXx4YiYVnE
         pOfWgmYe4++elR77Hy8S7Ul2Pazi0qfcawN5fRN/DrY36dySh/p0WK6UXNXBaXkHMZUt
         hNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580594; x=1790185394;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbW+4m7Ckt5T3Vp0i2qlknolTY3jp+RjMzIv0/DlDJ8=;
        b=btcB7JvUU2z7EkLM/QVmar/M5yuh1ec2KAncovh3HE+b4LONJVWWEzayosAwjXX92Z
         LxgSTFLyNdGYK1dZyiLOW37gXpgkAPIr/TWpKJmD4RPZWypEv1WrLIzgyxXR5anL2cV1
         046DtpYXbbuW4k7Ssa/2v+awIeJIasPQrTHk9hTBfbsFXQFzGC5lwX4BHYjttFe/CQ4o
         LER92yDfVedCCZmPqwYc7tjLk6Auor+/cU/AkFcpBBihJCSXotwEdxJUPyYF3QjzStG4
         jEfxMfApa3Orxt6yjX+tXikaE79JlNNmENIk+NXN6sR57J+/a8XRVOYaGE0wMnWF9SOy
         X4/A==
X-Forwarded-Encrypted: i=1; AKwUvBznMqRthgsbS75NrZ8WfPGUKSnXtuXIDSRGkr2YIUDrw8Cvqi0as7IHAgigeAAPnxN1sGcXdWmvNKDT@vger.kernel.org
X-Gm-Message-State: AFuF++lQPHezJ4WQ72/Q1QJQ45ZeNqfmwqF6Wj1UMJNXx+DlrbILmbi9
	odGhzrtrLyMNLuj5ezVkJWxfHzzZhQ72q9BkGfbB6vsoexB43cpFGuff
X-Gm-Gg: AYBFou1BKOnOzXBlW0hV1w49Sr2i1UdNG74ryAGadGfbXD40gPP2U/BckyqMQerzGku
	GGeNiDHKGL9HJ+911/1uF0+yyAyMaF5UCMm1u63Fic1lqSa6OuEJzwroS4i+3EvyP4LGoeA1Ouj
	R5VLCHa6+Dmvg1MSTV+5TEC+sdUj5/IqyeUxcCCPKXbMuVJmP5dAQFOya287h0FTyI6IXyfajCD
	Kun1n7vUuGeGM0uRBNdqhQLEq9o2s88Og6V3D9vQ7CtvyEAsUUJfmQoCCAp+Gu86Oj1f6qNF9CU
	cVY0/k3Y9Gee8+kCJ3Qxz0ErPvrYUZX10gt4XT4ON0Mf1fxKrPu2/6fTFajag0Norf5P9KnJ8RA
	BqyI+IA/vUfUY0W7MWcUD5a+CAKIweynZUI2lrwpGp58Dr8uzxu1dLUfXOwTKerg497GIVBNRmX
	HeqstzLMDH563teXDx2sKesH/q/c7fCHUJXUsoQZgOAxiwRswZByz39QtEVNQKNXjKdkUbpOeup
	huAkw2g371AHbiOpooeW+86ow==
X-Received: by 2002:a05:6a00:6088:b0:857:73e2:9106 with SMTP id d2e1a72fcca58-87239aa08b2mr7833547b3a.22.1789580594131;
        Wed, 16 Sep 2026 10:43:14 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-871febde2f7sm1700356b3a.6.2026.09.16.10.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 10:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 17:43:11 +0000
Message-Id: <DLGXDIB879EO.IDZNAIRY0VFJ@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: "Ido Schimmel" <idosch@nvidia.com>
Cc: "David Ahern" <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 <netdev@vger.kernel.org>, "Arun Ajith S" <aajith@arista.com>, "Roopa
 Prabhu" <roopa@nvidia.com>, "Jaehee Park" <jhpark1013@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Alexander Aring" <alex.aring@gmail.com>, <linux-wpan@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com> <20260916120202.GA935660@shredder>
In-Reply-To: <20260916120202.GA935660@shredder>

On Wed Sep 16, 2026 at 12:02 PM UTC, Ido Schimmel wrote:
> On Tue, Sep 15, 2026 at 05:01:31AM +0000, Lawrence Lee wrote:
> > Transition a FAILED neighbor entry to STALE upon receipt of an NA
> > message on routers when accept_untracked_na is enabled. This extends th=
e
> > RFC 9131 accept_untracked_na behavior so that FAILED entries are treate=
d
> > the same as non-existent entries. In the context of RFC 4861 which
> > introduced NDP, both non-existent and FAILED entries are considered
> > untracked since they do not have a valid neighbor cache entry.
>
> RFC 4861 didn't introduce NDP (RFC 1970 did), so please omit this bit.
> But if you're going to mention RFC 4861, then cite 7.3.3 which says that
> "If address resolution fails, the entry SHOULD be deleted". The fact
> that Linux keeps it as FAILED is an implementation detail and treating
> it as untracked is correct from RFC perspective.
>

That's my mistake, I'll update this to mention that 4861 is just the=20
most recent NDP standard and will cite 7.3.3.

> >=20
> > Trying to resolve FAILED neighbors via periodic probing (e.g. using
> > NTF_EXT_MANAGED) is more work compared to this approach which uses
> > information in NAs that the kernel may already be receiving. Note that
> > because this behavior in IPv6 is dependent on the accept_untracked_na
> > sysctl setting, this approach is more conservative than IPv4 which
> > transitions FAILED neighbors to STALE by default upon receiving GARPs.
> >=20
> > Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail=
.com
> > Assisted-by: LLM Sashiko sparse
> > Signed-off-by: Lawrence Lee <lfqlee314@gmail.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst | 28 ++++----
> >  include/net/ndisc.h                    | 15 ++--
> >  net/6lowpan/ndisc.c                    | 15 ++--
> >  net/ipv6/ndisc.c                       | 94 +++++++++++++++++---------
> >  4 files changed, 96 insertions(+), 56 deletions(-)
>
> The RFC was:
>
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
> I'm not sure how this ballooned to this size...
>

Some of the additional size can be attributed to doc/comment changes,=20
but a lot of it comes from changes I implemented to address issues found=20
by the local Sashiko review I ran. It was definitely an oversight on my=20
part to not mention these in either the commit message or comments,=20
sorry about that.

> > diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> > index 96e3bb6e83af..7fb3f10eca6c 100644
> > --- a/include/net/ndisc.h
> > +++ b/include/net/ndisc.h
> > @@ -154,11 +154,13 @@ void __ndisc_fill_addr_option(struct sk_buff *skb=
, int type, const void *data,
> >   *     option parser will take care about that option.
> >   *
> >   * void (*update)(const struct net_device *dev, struct neighbour *n,
> > - *		  u32 flags, u8 icmp6_type,
> > + *		  u32 flags, bool failed_recovery, u8 icmp6_type,
> >   *		  const struct ndisc_options *ndopts):
> >   *     This function is called when IPv6 ndisc updates the neighbour c=
ache
> >   *     entry. Additional options which can be updated may be previousl=
y
> >   *     parsed by parse_opts callback and accessible over ndopts parame=
ter.
> > + *     failed_recovery indicates that ndisc accepted the packet to rec=
over
> > + *     an entry observed in NUD_FAILED.
> >   *
> >   * int (*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
> >   *			 struct neighbour *neigh, u8 *ha_buf,
> > @@ -197,7 +199,7 @@ struct ndisc_ops {
> >  				 struct nd_opt_hdr *nd_opt,
> >  				 struct ndisc_options *ndopts);
> >  	void	(*update)(const struct net_device *dev, struct neighbour *n,
> > -			  u32 flags, u8 icmp6_type,
> > +			  u32 flags, bool failed_recovery, u8 icmp6_type,
> >  			  const struct ndisc_options *ndopts);
> >  	int	(*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
> >  				  struct neighbour *neigh, u8 *ha_buf,
> > @@ -227,12 +229,13 @@ static inline int ndisc_ops_parse_options(const s=
truct net_device *dev,
> >  }
> > =20
> >  static inline void ndisc_ops_update(const struct net_device *dev,
> > -					  struct neighbour *n, u32 flags,
> > -					  u8 icmp6_type,
> > -					  const struct ndisc_options *ndopts)
> > +				    struct neighbour *n, u32 flags,
> > +				    bool failed_recovery, u8 icmp6_type,
> > +				    const struct ndisc_options *ndopts)
> >  {
> >  	if (dev->ndisc_ops && dev->ndisc_ops->update)
> > -		dev->ndisc_ops->update(dev, n, flags, icmp6_type, ndopts);
> > +		dev->ndisc_ops->update(dev, n, flags, failed_recovery,
> > +				       icmp6_type, ndopts);
> >  }
>
> All the changes in this file can be dropped. See below.
>

This is tied to the lowpan changes below.

> > =20
> >  static inline int ndisc_ops_opt_addr_space(const struct net_device *de=
v,
> > diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
> > index 868d28583c0a..8fedfef93740 100644
> > --- a/net/6lowpan/ndisc.c
> > +++ b/net/6lowpan/ndisc.c
> > @@ -47,7 +47,8 @@ static int lowpan_ndisc_parse_options(const struct ne=
t_device *dev,
> >  	}
> >  }
> > =20
> > -static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
> > +static void lowpan_ndisc_802154_update(struct neighbour *n,
> > +				       bool failed_recovery,
> >  				       u8 icmp6_type,
> >  				       const struct ndisc_options *ndopts)
> >  {
> > @@ -87,20 +88,24 @@ static void lowpan_ndisc_802154_update(struct neigh=
bour *n, u32 flags,
> >  		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
> >  		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
> >  			neigh->short_addr =3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
> > +	} else if (failed_recovery) {
> > +		neigh->short_addr =3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
> >  	}
> >  	write_unlock_bh(&n->lock);
> >  }
> > =20
> >  static void lowpan_ndisc_update(const struct net_device *dev,
> > -				struct neighbour *n, u32 flags, u8 icmp6_type,
> > +				struct neighbour *n, u32 flags,
> > +				bool failed_recovery, u8 icmp6_type,
> >  				const struct ndisc_options *ndopts)
> >  {
> >  	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
> >  		return;
> > =20
> > -	/* react on overrides only. TODO check if this is really right. */
> > -	if (flags & NEIGH_UPDATE_F_OVERRIDE)
> > -		lowpan_ndisc_802154_update(n, flags, icmp6_type, ndopts);
> > +	/* React to overrides or accepted FAILED-entry recovery. */
> > +	if ((flags & NEIGH_UPDATE_F_OVERRIDE) || failed_recovery)
> > +		lowpan_ndisc_802154_update(n, failed_recovery, icmp6_type,
> > +					   ndopts);
> >  }
> > =20
> >  static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,
>
> I'm not sure why you added these lowpan changes to the patch. They are
> not described in the commit message. Given that lowpan_ndisc_update()
> already has a TODO comment about only handling overrides, I suggest to
> ignore it. If needed, it can be modified in the future by someone who
> can explain the use case and test the change.
>

I added the lowpan changes after my local Sashiko review run identified=20
an issue where a FAILED neighbor can retain an outdated private short=20
address if it's moved to STALE by a non-override NA. Happy to drop all=20
lowpan-related changes or update comments/commit message to reflect the=20
changes, please let me know your preference.

> > diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> > index 90cd5d852569..84d70c09205a 100644
> > --- a/net/ipv6/ndisc.c
> > +++ b/net/ipv6/ndisc.c
> > @@ -778,13 +778,23 @@ static int pndisc_is_router(const void *pkey,
> >  	return ret;
> >  }
> > =20
> > +static void __ndisc_update(const struct net_device *dev,
> > +			   struct neighbour *neigh, const u8 *lladdr, u8 new,
> > +			   u32 flags, bool failed_recovery, u8 icmp6_type,
> > +			   struct ndisc_options *ndopts)
> > +{
> > +	neigh_update(neigh, lladdr, new, flags, 0);
> > +	/* report ndisc ops about neighbour update */
> > +	ndisc_ops_update(dev, neigh, flags, failed_recovery, icmp6_type,
> > +			 ndopts);
> > +}
> > +
> >  void ndisc_update(const struct net_device *dev, struct neighbour *neig=
h,
> >  		  const u8 *lladdr, u8 new, u32 flags, u8 icmp6_type,
> >  		  struct ndisc_options *ndopts)
> >  {
> > -	neigh_update(neigh, lladdr, new, flags, 0);
> > -	/* report ndisc ops about neighbour update */
> > -	ndisc_ops_update(dev, neigh, flags, icmp6_type, ndopts);
> > +	__ndisc_update(dev, neigh, lladdr, new, flags, false, icmp6_type,
> > +		       ndopts);
> >  }
>
> This hunk can be dropped.
>

Tied to the lowpan changes above.

> > =20
> >  static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
> > @@ -972,14 +982,18 @@ static enum skb_drop_reason ndisc_recv_ns(struct =
sk_buff *skb)
> > =20
> >  static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr=
 *saddr)
> >  {
> > +    /* For any given neighbor IP address, consider it an untracked nei=
ghbor if
> > +     * it is absent from the neighbor cache or if it has a NUD_FAILED =
entry in
> > +     * the neighbor cache
> > +     */
>
> Redundant given the comments in the caller and the sysctl documentation.
> Simply modify the existing comments below to mention FAILED case.
>

Will update.

> >  	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
> > -	case 0: /* Don't accept untracked na (absent in neighbor cache) */
> > +	case 0: /* Reject NAs for untracked neighbours */
> >  		return 0;
> > -	case 1: /* Create new entries from na if currently untracked */
> > +	case 1: /* Accept NAs for untracked neighbours */
> >  		return 1;
> > -	case 2: /* Create new entries from untracked na only if saddr is in t=
he
> > +	case 2: /* Accept NAs for untracked neighbours only if saddr is in th=
e
> >  		 * same subnet as an address configured on the interface that
> > -		 * received the na
> > +		 * received the NA
> >  		 */
> >  		return !!ipv6_chk_prefix(saddr, idev->dev);
> >  	default:
> > @@ -1001,6 +1015,9 @@ static enum skb_drop_reason ndisc_recv_na(struct =
sk_buff *skb)
> >  	struct neigh_table *tbl;
> >  	struct neighbour *neigh;
> >  	struct inet6_dev *idev;
> > +	bool neigh_failed =3D false;
> > +	bool neigh_untracked =3D false;
> > +	bool accept_untracked =3D false;
>
> Try to maintain reverse xmas tree:
>
> https://docs.kernel.org/next/process/maintainer-netdev.html#local-variabl=
e-ordering-reverse-xmas-tree-rcs
>

Will fix.

> >  	new_state =3D msg->icmph.icmp6_solicited ? NUD_REACHABLE :=20
> >  	NUD_STALE;
> > -	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
> > -		if (accept_untracked_na(idev, saddr)) {
> > -			neigh =3D neigh_create(tbl, &msg->target, dev);
> > -			new_state =3D NUD_STALE;
> > -		}
> > -	}
> > +	neigh_failed =3D neigh &&
> > +		       (READ_ONCE(neigh->nud_state) & NUD_FAILED);
> > +	neigh_untracked =3D !neigh || neigh_failed;
> > +	if (neigh_untracked) {
> > +		accept_untracked =3D lladdr && idev &&
> > +				   READ_ONCE(idev->cnf.forwarding) &&
> > +				   accept_untracked_na(idev, saddr);
> > +		new_state =3D NUD_STALE;
> > +	}
> > +	if (!neigh && accept_untracked)
> > +		neigh =3D neigh_create(tbl, &msg->target, dev);
> > =20
> >  	if (neigh && !IS_ERR(neigh)) {
> > +		u32 update_flags;
> >  		u8 old_flags =3D neigh->flags;
> > =20
> > -		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
> > +		if (neigh_untracked && !accept_untracked)
> >  			goto out;
> > =20
> >  		/*
>
> This can be simplified to:
>
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 90cd5d852569..7d114bdb263e 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1082,19 +1082,21 @@ static enum skb_drop_reason ndisc_recv_na(struct =
sk_buff *skb)
>  	 * Note that we don't do a (daddr =3D=3D all-routers-mcast) check.
>  	 */
>  	new_state =3D msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
> -	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
> -		if (accept_untracked_na(idev, saddr)) {
> -			neigh =3D neigh_create(tbl, &msg->target, dev);
> -			new_state =3D NUD_STALE;
> +	if (!neigh || (READ_ONCE(neigh->nud_state) & NUD_FAILED)) {
> +		if (!lladdr || !idev || !READ_ONCE(idev->cnf.forwarding) ||
> +		    !accept_untracked_na(idev, saddr)) {
> +			if (neigh)
> +				neigh_release(neigh);
> +			return reason;
>  		}
> +		if (!neigh)
> +			neigh =3D neigh_create(tbl, &msg->target, dev);
> +		new_state =3D NUD_STALE;
>  	}
> =20
>  	if (neigh && !IS_ERR(neigh)) {
>  		u8 old_flags =3D neigh->flags;
> =20
> -		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
> -			goto out;
> -
>  		/*
>  		 * Don't update the neighbor cache entry on a proxy NA from
>  		 * ourselves because either the proxied node is off link or it
>

Was originally unsure if I should modify the existing logical structure. =
=20
Thanks for the suggestion, will implement this. Is it appropriate to=20
credit you with a commit tag?

> > =20
> >  		if ((old_flags & ~neigh->flags) & NTF_ROUTER) {
> >  			/*
> >  			 * Change: router to host
> >  			 */
> > -			rt6_clean_tohost(dev_net(dev),  saddr);
> > +			rt6_clean_tohost(net,
> > +					 neigh_failed ? &msg->target : saddr);
> >  		}
>
> What is the reason for this change? It's also not explained in the
> commit message and I suspect it's not needed.

This was added in response to another Sashiko local review finding. =20
Let's say we have some FAILED neighbor T with NTF_ROUTER set. If we get=20
an NA from source address S with target address T and with the Router=20
bit clear, existing kernel code will cleanup routes with gateway S, but=20
IMO we should clean routes with gateway T instead since that is the=20
neighbor which was updated by the NA. I can either update=20
comments/commit message to reflect this or remove the change entirely,=20
please let me know your preference.

