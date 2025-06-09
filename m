Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799513AA3C
	for <linux-wpan@vger.kernel.org>; Mon,  9 Jun 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749433785; cv=none; b=ijgYKd52f8FqO3rcy/XI2mxdVvSzNZkCsuiAfRqk4CdPfbKwxDVH2Eqvcjw+MKYVVOD36yOxXAarR3R+NKnEq6HeeRAHy5JWss8lsZx/I8l1nhh71fUgdBU96wi8wEtwHU9CpJqAnNVApkV0mhGwwLbGb+qj0IA3OJAlyXQmqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749433785; c=relaxed/simple;
	bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNc9TwZGRyIH8eCFu/PLl4FlJ42PhO3f7M6ShmYXFlh8nrRWIwn7F32HQI3ih0j4Vg+563PuQOx+xmDJeqnfWAfYrdTCBMR/BIPOLaREgFICdd8RiBwn+OWMMZE7tiRBpv/i3WGDev12Wy/4UiX4EJqfaYsVr01ANE8T7g6sFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL7W55dW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL7W55dW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749433782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
	b=TL7W55dWki1rqYIfCLhvgmaF10fub7KIEwurHRKucIJa+rlBxMNpHT7p/CWHh+JRYdpHg7
	dDaKQChTWc6LKVLWZ95H35wu2x7XiWtjJCbhkdT0E2JKkgQwU8hQI8pakk80vpgadEMs0w
	vJglpzRCImb8vKHI+ElooAiey8RfnNU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-SWn8uSrDO0-XhDAB7dbsmA-1; Sun, 08 Jun 2025 21:49:41 -0400
X-MC-Unique: SWn8uSrDO0-XhDAB7dbsmA-1
X-Mimecast-MFC-AGG-ID: SWn8uSrDO0-XhDAB7dbsmA_1749433780
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-552215e6d77so2203470e87.3
        for <linux-wpan@vger.kernel.org>; Sun, 08 Jun 2025 18:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749433779; x=1750038579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
        b=fxeCV9sTSFvW92L956DgN6ulXlSs20Fvi2XSkv3QPt34v6L58s+KcyT7+gIkVujauj
         6Ev/Dxog3LcknhZ8peGKe67Yo6xepeEdxjLB43n8XBDNl1DfSiBS9dbXZs/e6AItD9A3
         J3inow+HIhAaY4pkHML3b4l+VG5bCX5Y+e0W7uawx5oxkMcfD9Hqp8jeLzyhbRvxtpCr
         gZu4PruWrumTHGxj8apX+rpi8jLCeOHK0BJVl/+m/9uB7qI4BfNG6um07kkjeuQhyukt
         I8cUxh5MIGis8BABtcQ5/t17ngERl1se3zIkWDZwjom3BUsKoFlBpT2FgOp/SRD8+Sb0
         imfg==
X-Forwarded-Encrypted: i=1; AJvYcCUaKAQemW/cf5ngKIZSK2mDR+A86ohnLtmakwYd5lwXTAeton4SrfyHXCiiM3Ch8YUEADTPyUV41hC1@vger.kernel.org
X-Gm-Message-State: AOJu0YydpOlRJ9ksIOCkpciWT0I55J+5A4ykV0q3Xbl6FrIX5jVb/sQv
	v5u4vWVvjdE41TBcsd8IqZtoT10O9Dzq834uCYOGrr0KL8HR0WwDkrdtvYa1XwGhqLaTSYSN3nG
	P2o0aGa9Lfdsmkfu2k+NdelA/E8FKirmFf79oJl25mS51JbuuAFSIxhLtJRizT/7wBoyRkuIim1
	ZiCdD0klMpCiNUtAq2MFoBS9g+Q0DCKG5maoVtgw==
X-Gm-Gg: ASbGncstNjZ1a239IbNtQ2wysQNS8n82AmEvIZICvuwopwTs1yBIah9m+ZPxH58o5Wt
	a3cZzpYqy4Iig/XRwfi0MFbKiOEdIaarCpSbn99QGFbWtIFUQp+pMm1RkQfBwXYe0MXjcrGKNRZ
	0IeFo6IjDVmGLl1jALdUWqc/rLDBxj2P1/1VXn7w==
X-Received: by 2002:a05:6512:3089:b0:545:8f0:e1a4 with SMTP id 2adb3069b0e04-55366c365fdmr2633621e87.45.1749433779516;
        Sun, 08 Jun 2025 18:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfNwt/Fdhee+MMgVrbbbGoawo+KdN6xrs4P3/qqKW5OdykwRxeZMMwEan4KykfI5EDnvSbPeiuEYxjNZr5/U8=
X-Received: by 2002:a05:6512:3089:b0:545:8f0:e1a4 with SMTP id
 2adb3069b0e04-55366c365fdmr2633613e87.45.1749433779096; Sun, 08 Jun 2025
 18:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
 <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
 <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
 <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com> <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com>
In-Reply-To: <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 21:49:28 -0400
X-Gm-Features: AX0GCFuZa3U1ri2yAkD3r0XY18bDGjMKa3k4OIzi1n49a0ZBB-bCif_XXkyW1qY
Message-ID: <CAK-6q+g-A4T4RBg_BiRxR+G2k0_=Ma9nPZ1y=H=-F2FYDCUTMw@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 7, 2025 at 5:00=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> > There is a generic way by using netem qdisc and using AF_PACKET
> without PACKET_QDISC_BYPASS, should do something like that.
> If you really want to do something else there or only act on 802.15.4
> fields and you hit the limitations of netem then this is something
> netem needs to be extended.
>
> Let=E2=80=99s say I=E2=80=99m quite familiar with netem - netem is indeed=
 well-known
> and has been used extensively with tc/ifb. However, it is primarily
> suited for 1-to-1 communication scenarios.
> In 1-to-n topologies, such as when node 0 communicates with both node
> 1 and node 2, it becomes unclear which peer should serve as the
> reference for applying delay, loss, or latency.

That's why there exist addresses.

> This limitation makes netem unsuitable for scenarios where
> link-specific behavior is required, such as in ad hoc networks.
> In such cases, a more precise per-link control - as provided by
> wmediumd - becomes necessary.
>

Teach netem to deal with addresses on a generic filter hook.
Maybe you can ask at batman project how they test things because they
use 80211 mesh functionality?

> > With that being said, however there are so few users of 802.15.4 in
> Linux and adding your specific stuff, I might add it if this helps you
> currently... but I think there are better ways to accomplish your use
> cases by using existing generic infrastructure and don't add handling
> for that into hwsim.
>
> Back in 2016, mac80211_hwsim had relatively few users. Today, I
> maintain a community of approximately 1,000 users worldwide who rely
> on mac80211_hwsim for their research - industry and academy.
> The need for a realistic experimental platform is not a personal
> requirement, but rather a broader gap in the ecosystem. Addressing
> this gap has the potential to significantly advance research on IEEE
> 802.15.4.
>
> > but I think there are better ways to accomplish your use
> cases by using existing generic infrastructure and don't add handling
> for that into hwsim.
>
> Honestly, based on my experience so far, there=E2=80=99s no better approa=
ch
> available. Well - there is one: integrating all the wmediumd
> functionality directly into the kernel module itself. But I fully
> agree - that would be both unrealistic and impractical.
>

I looked more closely at the patches and there are a lot of question
marks coming up, for example why there is virtio handling, when this
patch should not do anything with virtio?
Why do we introduce a second data structure to keep registered hwsim phys?
Why do we have a lot of wording of "wmediumd" when this is the
project/process part in user space?

- Alex

