Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B91EFFB7;
	Sat,  7 Jun 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749330026; cv=none; b=JxR7XIl8Hj8Fje0qteHlOmCuyhCplgk/D9J5+yvAT7ZU0ydJcF5ZKHwA453J9yU6wVaD526aXDBum8O2fB6PAUPA6M8uezGUMX0wn/wIrf0nHeyyqdRX6cEmzyP8Xg32P67MPXvCT1nC8iAzLHLTXYSr/+uvwnNRzVqREpbZu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749330026; c=relaxed/simple;
	bh=4dqDAAVvsuOWGlyn+0xiU62bAwgcv4wXpaHtFvItnZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug/9bAHfZUdUAYkLY9PnAiOCci08/NsIxWiGJM/H9p87x+HFff30CLiV4N23C+hvX4CQTxSOJ0utWHYVJvpVrOMP4WI5ltmU1IRuUETE1O8NpaVo09R/lut9ulBvIe9xpr0Johk/XLPWz0UINSE+2TAr+d001o7oM8+71+Qixm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBAfxO1t; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBAfxO1t"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e5962a0f20so930467137.1;
        Sat, 07 Jun 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749330023; x=1749934823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dqDAAVvsuOWGlyn+0xiU62bAwgcv4wXpaHtFvItnZE=;
        b=eBAfxO1tJl46SqJvdINUi+EnByMr9bDQ5KNdAELn42TQnWQFdv+p11AMqEi0vq9K88
         jtp+dTildXjRSkTT1yksor80ln6thGqBvaCoQt3ylkxjzuvAEAJfD5fuwO2Jnxaajiai
         D5bIQEdJS2WXtWVBEpW1Z5rl3WL/CFDk0n7o0GeBld+yeSriF8IuoNJ05hLEyZJwwkbB
         7nImkN3EgdvcYXoEtcnJa5cid7wAAPVt1fld9HjzgAYzfCHq3hqyFSzEswnLRve3ysNV
         USs+4yvifBfNEc/1HY+Q3AOxKBHzI6Md9CoVjyfIPFz7X0HBkxYtA0WJC/e2JIl3QB3b
         +PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749330023; x=1749934823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dqDAAVvsuOWGlyn+0xiU62bAwgcv4wXpaHtFvItnZE=;
        b=Q40ZWkcARXG1g9zTNSA+3oIlnHmuW20k2jcLaIIA8o0RCsUYLWi9JHfC7TchIAg1bw
         zFJDmuiVAhUhn3ed1DK+LMvSI6JLNsmnbfXF5UEVI7UCItKK8tgwJjgGGLAYSSvHs0xh
         dLmx88NdBVHGTeifAthvK+5nTu6CstIkCUKnkLTc1qg5c8gJyzYKVqeQwkLf7ou5tudp
         8Dsub+DkKudiUkl0Qo58ilf4gASQwFAmNsmE46Vs4ix3qN/4KYO8F2YJrDgyXFc3/suI
         iDaZSyJXYn0sbxqBLPWYq4bMmDtzUQD+SXcgjXnge6SzN0aeNpEKUJMi4iyH6fS/gusq
         c7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDKms7dRvfXzxemY71CPNLrElEStfgAjZfYSThqY4rlQFhXpfHqGs92XtkKLu+W5RuszlxLt7x@vger.kernel.org, AJvYcCWgfIfL+GjByNyJd7/9C68qWZqg9+emspRdG7um7YwklgKRDOpfWuLuElVdN49sPSQoMOhHbpfiBqU9@vger.kernel.org
X-Gm-Message-State: AOJu0YwsquzdWsHtOsjajT2LM9KSKF7kJIPNVqnMFF9SLZ7CLKISFVfY
	47D7Ln3DpFii4SSYDhAnW2w5S7fI2ya1xwJXX6289cGcmgKR6pF+/CUJNAPBc+c/CxE43PDOZmY
	XhymyipjMPCsdHOcaiJYInii6zoKJsRo=
X-Gm-Gg: ASbGncvyP5KhsZqGGetJo9XhSWOaXT6opwPISuZfp2yb9H6ncB7VD8ImqnF/+lb5meQ
	myuXO5S1g7wh7Md/6yUIXRL6v3RaylPfom6wRSY35o6T4c1TNyFyPKvHVfamUJDuJv7SPImqpLO
	P1vLNTNAKLrbYrh8DBVz1VRheK9e+1A+whKMUNHEYKtlM=
X-Google-Smtp-Source: AGHT+IFdToe+TpajY/CBdhu5gy5SigYztQhVYCj1QUb14v9HZuCsJG2F6Ly8dA3IIJo+GI7HCi2Z7U3gCm1mMpo7rCs=
X-Received: by 2002:a05:6102:2c19:b0:4da:e6e1:c33c with SMTP id
 ada2fe7eead31-4e7728863e5mr8002473137.3.1749330023116; Sat, 07 Jun 2025
 14:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
 <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
 <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com> <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com>
In-Reply-To: <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Sat, 7 Jun 2025 18:00:12 -0300
X-Gm-Features: AX0GCFv7od7ZH20T1Xou3Gna-DdmRMeAlqWhMslWK0Cqm6esLHgCUfeVJdp-jq8
Message-ID: <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> There is a generic way by using netem qdisc and using AF_PACKET
without PACKET_QDISC_BYPASS, should do something like that.
If you really want to do something else there or only act on 802.15.4
fields and you hit the limitations of netem then this is something
netem needs to be extended.

Let=E2=80=99s say I=E2=80=99m quite familiar with netem - netem is indeed w=
ell-known
and has been used extensively with tc/ifb. However, it is primarily
suited for 1-to-1 communication scenarios.
In 1-to-n topologies, such as when node 0 communicates with both node
1 and node 2, it becomes unclear which peer should serve as the
reference for applying delay, loss, or latency.
This limitation makes netem unsuitable for scenarios where
link-specific behavior is required, such as in ad hoc networks.
In such cases, a more precise per-link control - as provided by
wmediumd - becomes necessary.

> With that being said, however there are so few users of 802.15.4 in
Linux and adding your specific stuff, I might add it if this helps you
currently... but I think there are better ways to accomplish your use
cases by using existing generic infrastructure and don't add handling
for that into hwsim.

Back in 2016, mac80211_hwsim had relatively few users. Today, I
maintain a community of approximately 1,000 users worldwide who rely
on mac80211_hwsim for their research - industry and academy.
The need for a realistic experimental platform is not a personal
requirement, but rather a broader gap in the ecosystem. Addressing
this gap has the potential to significantly advance research on IEEE
802.15.4.

> but I think there are better ways to accomplish your use
cases by using existing generic infrastructure and don't add handling
for that into hwsim.

Honestly, based on my experience so far, there=E2=80=99s no better approach
available. Well - there is one: integrating all the wmediumd
functionality directly into the kernel module itself. But I fully
agree - that would be both unrealistic and impractical.

--
Ramon

Em s=C3=A1b., 7 de jun. de 2025 =C3=A0s 16:51, Alexander Aring
<aahringo@redhat.com> escreveu:
>
> Hi,
>
> On Sat, Jun 7, 2025 at 1:47=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmai=
l.com> wrote:
> >
> > Hi Alex, thanks for the feedback!
> >
> > You're right, using AF_PACKET raw sockets on a monitor-mode wpan_dev
> > is indeed sufficient for user-space access to the raw PHY, and we=E2=80=
=99ve
> > also tested that setup successfully for basic communication.
> >
> > However, if the use case focuses on evaluating realistic wireless
> > scenarios, where connectivity and interference vary across links. For
> > that, we rely on wmediumd, which integrates at the PHY level
> > (mac802154_hwsim) and controls per-link delivery based on configurable
> > SNR values and propagation models (e.g., log-distance, shadowing).
> > This allows us to emulate asymmetric topologies and partial
> > connectivity, something raw sockets alone cannot provide (or can?),
> > since all virtual radios are fully connected by default.
> >
>
> It sounds to me like you want to do some specific 802.15.4 things and
> the raw socket interface is too generic to do your tests.
>
> > In this context, wmediumd becomes essential for simulating:
> >
> > - Packet loss due to weak signal or distance;
>
> There is a generic way by using netem qdisc and using AF_PACKET
> without PACKET_QDISC_BYPASS, should do something like that.
> If you really want to do something else there or only act on 802.15.4
> fields and you hit the limitations of netem then this is something
> netem needs to be extended.
>
> > - Asymmetric links (e.g., node A hears B, but not vice versa);
>
> You can do that already with mac802154_hwsim, it is a directed network
> graph. A->B and B<-A need to be there so that A<->B can talk to each
> other, you can drop one of the edges and it is asymmetric.
>
> > - Controlled interference between nodes;
>
> netem again? Or any kind of tc egress action with a ebpf script.
>
> > - Link-specific behaviors needed for higher-layer protocol evaluation.
> >
>
> That can mean anything. I need more information.
>
> > Additionally, by inducing realistic transmission failures, wmediumd
> > allows us to test MAC-layer features like retransmission (ARET) and
> > ACK handling (AACK) in a meaningful way, which would not be triggered
> > in a fully-connected environment.
> >
>
> There is no ACK handling in mac802154 as it needs to be handled by the
> hardware, but I agree that there can be something similar like netem
> in 802.15.4 that only fake reports about missing acks, or failed
> retransmission to the upper layer. (whoever the user currently is and
> there is only one I know that is MLME association).
>
> > Let me know if you'd like me to elaborate further or clarify anything
> > about this.
> >
>
> I am not sure about this as there exists generic network hooks which I
> believe can be used to reach your use cases in e.g. tc. In combination
> with a ebpf program you can do a lot of specific 802.15.4 frame
> handling and do whatever you want. If you hit some limitations in
> those generic hooks then the right way is to extend those areas.
>
> Maybe the "fake" ack reporting is something that hwsim needs to
> support as this is usually implemented by the driver to ask the
> hardware for.
>
> With that being said, however there are so few users of 802.15.4 in
> Linux and adding your specific stuff, I might add it if this helps you
> currently... but I think there are better ways to accomplish your use
> cases by using existing generic infrastructure and don't add handling
> for that into hwsim.
>
> - Alex
>
