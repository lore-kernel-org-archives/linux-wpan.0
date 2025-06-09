Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115DC255E27;
	Mon,  9 Jun 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465374; cv=none; b=B2C42Sqb39IpERNV/DBKeVhWu2KgEnvFjEs+f7egQVcxc5oXcU2xg53936dce2NjYZyJgcqE0cok1Nwj46vcBByAe8huva7vykY8KZ0OyJYcbiMnakbDzL35kf1RAtYf0Bd+hJx+Ycc2RGqtYz4KfEyRGAqlDCuovXltWbPAAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465374; c=relaxed/simple;
	bh=npMVXxHMPKw0K4pl8YSzdq62rI6pAxWfW19zNP8+gnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my2poZ43elplU1ByvgG+ggFY6PkyMxR9PziuZpBlONsaWTazHsaOej2+SKHXZHwRawg83ONOCsXwSja7R2LH019J6Fh6GweaCxIPKJDajoBv1kcgespcep2a71QWgbgbJF/2oI3E1YhGxFR2JkTN8rJxQMcYmp9pgCegBAPHe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz4qchAz; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz4qchAz"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-530807a856fso3709827e0c.0;
        Mon, 09 Jun 2025 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749465371; x=1750070171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npMVXxHMPKw0K4pl8YSzdq62rI6pAxWfW19zNP8+gnQ=;
        b=Iz4qchAzejx4cQI0QcR/RWEHKOH132LygOrJkXaRvDQgVmIOnBu+5n1pImTQ/Meqaj
         HClDML4ZxqN5Zn+PWchg1y2bIAUpOaScXUWAiikYSLmsIj5GbN6QjN/+8rNQC5rtCi+p
         NVx5k5ym8CqP49Rpe/ntDy5JZ6Yi3c7n5pzZ/nmjqdDXmnO29VaXPKuDkw8Dn9dXaAr3
         +hk8sTAiR9cQLRHpWCA9AroPQGknavAw/GmFrT+SzCchyOdcGLB8qrknKnEF+9chlACe
         EMcba5iETPqpe91J4ig/FvXhg5xJGbZySuR90VcZx/HKFnZGq+3w/NN4m9Ee+ROxStet
         BFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749465371; x=1750070171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npMVXxHMPKw0K4pl8YSzdq62rI6pAxWfW19zNP8+gnQ=;
        b=UdMVH6tFDnpWlZW301mn7vp8ev32xUtJ9EP73xKTuFr1Dq89VZHO1MMqCx8iFCyjTn
         jspG1KPPblnXV5+fjjXTy5rYK2fpgb1ljOBd1ZqoHznMFtOq8qaM8od4lUKRCO0TN9yr
         DIMimRoHC3ceZfQUCpJF91LgczzvKFuo4EzyFs2apQMO92ytT1rgnsrr26ni7zGXqbPK
         LJWmgFHUykv46B9UGM2d+xQ5+nA4wW4zpMkVsRyVpzqztCjKY/csTNRl0MQBUa3nTcUd
         YcaB6TDllnuEjJmq6oBfvqdU9ekFVVfVmZbkcLVYafJIe18i4shPGPdDfFm4Xdhl4PUG
         E8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWPIE64bj9ocggdKEiajD+S9tkwzQb+T5bHcDZDZE2OcefsllQjxyBFGfLWC0yrjFjzaGfu+tPA@vger.kernel.org, AJvYcCXAQtxsJ3/D8QoCosL6pYMyPYy0iSCPAnyg0HimlVW7udwJQWkpd/DmGZAhqPMN+h2V49nliju47bS1@vger.kernel.org
X-Gm-Message-State: AOJu0YygOdMJn3A4e686pW4b7To1Z13hb+rPthShevl3F9LF3fjK6udp
	0mjd+IYLpIhhdNx1KfFrLlN0xiGN7sG8MVXC7DHNDaTKkVabPlyZ/QMEmMlImv7nuRX0ChyZSTu
	/z1fBfhonkiijAynympJIlhahTvPvfa8=
X-Gm-Gg: ASbGncvrhcbOq6CmiT1bKRtlFYCsrhXA7DUiImKfOBBcRbzy2tWwg6bWGU9czAr92g2
	aNllMN1wqf6NDu+f1NjRQtDlCH4YopdePjzEHLf/kg6AW775yWzUwJtP1kfpD0HTvzp+lku9VyT
	Tndf2T7MnoBDwL+GKpkESt6HTs9FmrZO8p
X-Google-Smtp-Source: AGHT+IFvWqrPkS0nRrxPnH7t0NlKShekyJjkvIDMBJ/RVTKzyp5c/8F+x/2gQyMeh6bu3EXJdwLYJXA7uZ80qmFfiY0=
X-Received: by 2002:a05:6122:35ca:b0:530:56e2:1e00 with SMTP id
 71dfb90a1353d-530f34a12c3mr4322269e0c.3.1749465370674; Mon, 09 Jun 2025
 03:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
 <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
 <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
 <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com>
 <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com> <CAK-6q+g-A4T4RBg_BiRxR+G2k0_=Ma9nPZ1y=H=-F2FYDCUTMw@mail.gmail.com>
In-Reply-To: <CAK-6q+g-A4T4RBg_BiRxR+G2k0_=Ma9nPZ1y=H=-F2FYDCUTMw@mail.gmail.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Mon, 9 Jun 2025 07:35:59 -0300
X-Gm-Features: AX0GCFtfkMaj7VE505KSzOnsCEQ66HiElw_iTSiO2MdlMqWU8Gl7SbnDGu6jmOg
Message-ID: <CAK8U23bj0jqA5KNPN8oZxxf5gN7M2Acp3_qpeDz+uxk6kbmRUA@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That's why there exist addresses.

The addresses are really important here. However, that still requires
the entire emulation logic, including per-link delay, loss, and
interference modeling to be implemented and managed manually in user
space. The approach proposed here aims to offload this complexity by
providing an integrated solution at the PHY level, before packets
reach the MAC, where interference and delivery decisions can be made
consistently and transparently, without requiring user space to
replicate the entire logic. In that sense, while addresses do help
identify the destination, they are not sufficient alone to handle the
broader scope of realistic wireless emulation, especially when
topology-aware behavior and MAC feedback are needed.

> Teach netem to deal with addresses on a generic filter hook.
> Maybe you can ask at batman project how they test things because they
> use 80211 mesh functionality?

I'm familiar with the BATMAN project, as well as IEEE 802.11s, OLSR,
Babel, and other mesh routing protocols. In fact, I authored a book
chapter in 2022 specifically on these protocols, focusing on their use
in wireless networking. That work was centered on wireless network
emulation, where I provided practical examples of how to deploy and
test these protocols in Linux-based environments.

That said, all the netem-based approaches, while useful, are not
sufficient on their own to address the broader requirements of
realistic wireless emulation. They lack integration with physical
layer behavior, cannot model per-link dynamics based on distance or
interference, and offer limited support for topological asymmetry and
MAC-level feedback, which are essential for accurate and reproducible
wireless testing.

Book chapter ref: https://digital-library.theiet.org/doi/10.1049/pbte101e_c=
h1

> I looked more closely at the patches and there are a lot of question
> marks coming up, for example why there is virtio handling, when this
> patch should not do anything with virtio?

I agree with you. That's actually something I had been thinking about
as well. I believe we can remove the virtio-related handling for now,
as it doesn=E2=80=99t belong in the scope of this patch. If needed, we can
revisit it separately in a follow-up patch that properly addresses its
purpose.

> Why do we introduce a second data structure to keep registered hwsim phys=
?

The second data structure, in this case, (the rhashtable?), was
introduced to allow efficient lookup and management of registered
hwsim PHYs based on attributes such as the portid or virtual address.

The existing hwsim_phys list is sufficient for basic iteration over
all PHYs, but it becomes inefficient and cumbersome when we need:

- Fast lookup by a unique identifier (e.g., portid, ieee_addr);
- To support operations like remove_user_radios() efficiently;
- To associate radios with specific users or namespaces (net),
particularly when cleaning up after NETLINK_URELEASE or network
namespace shutdown.

Additionally, this follows the same architectural pattern used in
mac80211_hwsim, where similar per-radio or per-user management is
needed.

So the rhashtable is not a replacement but a complementary structure
optimized for use cases that require fast indexed access or
conditional cleanup, while the existing list remains useful for
ordered traversal and general-purpose iteration.

Honestly, I chose to keep the existing structure to ensure I wasn=E2=80=99t
changing the current behavior of mac802154_hwsim. The intention was to
maintain compatibility and avoid introducing any regressions, while
extending the functionality in a non-intrusive way.

> Why do we have a lot of wording of "wmediumd" when this is the
> project/process part in user space?

I should probably reconsider the title of the PR, especially since
mac802154_hwsim already supports user-space interaction independently.

As for the use of the term "wmediumd", I chose to reuse it because the
new functionality aligns closely with the goals and structure of the
original wmediumd project for mac80211_hwsim. Since both
mac80211_hwsim and mac802154_hwsim serve a similar purpose, enabling
kernel-level virtual radios for wireless experimentation, it felt
natural to extend the naming convention to indicate compatibility and
continuity. I didn=E2=80=99t see the need to reinvent something new when th=
e
existing model worked well and was familiar to the community.

--
Ramon
Em dom., 8 de jun. de 2025 =C3=A0s 22:49, Alexander Aring
<aahringo@redhat.com> escreveu:
>
> Hi,
>
> On Sat, Jun 7, 2025 at 5:00=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmai=
l.com> wrote:
> >
> > > There is a generic way by using netem qdisc and using AF_PACKET
> > without PACKET_QDISC_BYPASS, should do something like that.
> > If you really want to do something else there or only act on 802.15.4
> > fields and you hit the limitations of netem then this is something
> > netem needs to be extended.
> >
> > Let=E2=80=99s say I=E2=80=99m quite familiar with netem - netem is inde=
ed well-known
> > and has been used extensively with tc/ifb. However, it is primarily
> > suited for 1-to-1 communication scenarios.
> > In 1-to-n topologies, such as when node 0 communicates with both node
> > 1 and node 2, it becomes unclear which peer should serve as the
> > reference for applying delay, loss, or latency.
>
> That's why there exist addresses.
>
> > This limitation makes netem unsuitable for scenarios where
> > link-specific behavior is required, such as in ad hoc networks.
> > In such cases, a more precise per-link control - as provided by
> > wmediumd - becomes necessary.
> >
>
> Teach netem to deal with addresses on a generic filter hook.
> Maybe you can ask at batman project how they test things because they
> use 80211 mesh functionality?
>
> > > With that being said, however there are so few users of 802.15.4 in
> > Linux and adding your specific stuff, I might add it if this helps you
> > currently... but I think there are better ways to accomplish your use
> > cases by using existing generic infrastructure and don't add handling
> > for that into hwsim.
> >
> > Back in 2016, mac80211_hwsim had relatively few users. Today, I
> > maintain a community of approximately 1,000 users worldwide who rely
> > on mac80211_hwsim for their research - industry and academy.
> > The need for a realistic experimental platform is not a personal
> > requirement, but rather a broader gap in the ecosystem. Addressing
> > this gap has the potential to significantly advance research on IEEE
> > 802.15.4.
> >
> > > but I think there are better ways to accomplish your use
> > cases by using existing generic infrastructure and don't add handling
> > for that into hwsim.
> >
> > Honestly, based on my experience so far, there=E2=80=99s no better appr=
oach
> > available. Well - there is one: integrating all the wmediumd
> > functionality directly into the kernel module itself. But I fully
> > agree - that would be both unrealistic and impractical.
> >
>
> I looked more closely at the patches and there are a lot of question
> marks coming up, for example why there is virtio handling, when this
> patch should not do anything with virtio?
> Why do we introduce a second data structure to keep registered hwsim phys=
?
> Why do we have a lot of wording of "wmediumd" when this is the
> project/process part in user space?
>
> - Alex
>
