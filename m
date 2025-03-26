Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F591B21A7;
	Wed, 26 Mar 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985268; cv=none; b=ayHQTgZl1p6S6ApXblIm+PoOjFRp+xljftNqWtFJWjhpwKpYbZY7cIvjuUIutToQPJghWBx/N+l6DszcTIg4NpXA3tWJQl1DdS0JqEQgxgnhlA4uXcxBwIn73gBTlWRw1WDflUqmYr3+oOx+535CUf28SV4oOr+nhHr9LDnm7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985268; c=relaxed/simple;
	bh=XVhx+0xc2df5xaZYfBfdVarl+QdD3rFpi2tF9uDlvGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8sotgxYOn8XYf7B1gtXgG7XKM3M61a2mwJvNhsXn2N1ry1m5w1L1Tl2Ei1Ypf9PejHu6RuQvyoOaVE+hBWvBz0nTbDkr6pIFEr476+SOJIFx4YET1I0SNGJFJ92xDZ/XXZYOZ97ixAK2+nR7p2+NAyXFGQ8K72ppk1CtuYg8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcVqKpjI; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcVqKpjI"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so2841570241.1;
        Wed, 26 Mar 2025 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742985266; x=1743590066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVhx+0xc2df5xaZYfBfdVarl+QdD3rFpi2tF9uDlvGE=;
        b=RcVqKpjI/MRfovGqpneL2+Tq0y74zmlnq5sxH8DIUWeck/Pu/xwMsAD1THTORMmnS+
         TOyMMMe922qOxSz+XksCSMWC2I/sWqK/v7/adl2sPvHt6KdFnh41UHG+i3w0FUuUA8TS
         7UJ411ax9gHehsNwySMt7gFXAJHaP1qoPHCHsTjUKh+rkcCnZWvQ3mMXRBbDsyD+H5uw
         Uaz90IRdfD4CeacDufEK5TrMxv7wpc/Jo1XUlPahYoIANjiw7NbPPuCTpXIRXqq3puSt
         p3nQScejx8mMXNObbryz+IF6rX47TGjuvR0ZuJa2oThsSdXVDNjJDP2tYzwEdUI8Coyh
         J5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742985266; x=1743590066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVhx+0xc2df5xaZYfBfdVarl+QdD3rFpi2tF9uDlvGE=;
        b=fgnvKFu88FK/JQPblJZrz5BL94ydvzbtO5/CiT6tt8X18pR/1AwNe0dOiVpNN3akcw
         RewWSB8U0simCMyMmq9I0SieurzfwsV5TpkOxdtXAtPnrNlov+UqU4dQTRUdhMwm697K
         JhJNgtWDB6RG39h+IVh/4mJC4UB40vfKHF/ZmSIhWJB7vg6p741s6nFzt86CV3dOgDjI
         zrIxm5CEF6LIOxEm7dExRuK/lnhD5lUmLmfm3IcuVPOLGk27jXRjaIIHVw/LWVcACiPM
         Xc1zgQ+La3mkmychz7gT1wpyEw3RfJZCr+3CqcWwGxzr3Lj2podvb6otCjUetOnzXiTX
         hVow==
X-Forwarded-Encrypted: i=1; AJvYcCUIMY59+8oYzlUfrciSSuE3dgbMkSd+DVmcbbjn13Xcv8QuW4tY+43FOQbgEs9XmAu91bfJuh1C@vger.kernel.org, AJvYcCVhNynfJFPeTJSknoJjvI42R/6IQQxIcbIimY61X4KY4t1tY+NAY3Qtb4IP6MqEwqcZJlJPW53hAYcc@vger.kernel.org
X-Gm-Message-State: AOJu0YzphRaWlhhmCjIUIpFiRkThb601wqyDMFLjdnbVFnQPcxseaMP5
	x++EECiX/qeMTe9Y1n9QC+9cHHg3LiS9RdX73AaMhFPlNxfQbt7NAWFzuCJzOLxa/fuXc15xmv2
	6ddavCqpLedbEmdHa9OumabND8Ko=
X-Gm-Gg: ASbGnctknJA20fILhtVW7tOLyWiPP3NEfU/04Acvi9qO+DLqwhsVQMDNWESRDcq7poD
	u/JQ5plvQ+NQsQCEVqD0IcdXqu0H6Bwy/Z48Z+rXta01XvE11WZSwzw5nr3ZaPVXmBxvBk94nxC
	2hq+Xz3zBa/unQvF0dH0wCFBFChQ==
X-Google-Smtp-Source: AGHT+IEDPOHxt/s6wfWgziJqDs4+9yS59pv7JdGN6azVFRYtzqVO/xo5kZ1ubzaKKbSu2ky2Vw6yhTVhOMneze8RCbA=
X-Received: by 2002:a05:6102:d92:b0:4c1:801e:deb2 with SMTP id
 ada2fe7eead31-4c50d4c95d4mr15469496137.7.1742985265782; Wed, 26 Mar 2025
 03:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325165312.26938-1-ramonreisfontes@gmail.com> <87cye4qexa.fsf@bootlin.com>
In-Reply-To: <87cye4qexa.fsf@bootlin.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Wed, 26 Mar 2025 07:34:14 -0300
X-Gm-Features: AQ5f1JrfPd7dKYF3jJjV8bbJ7EUTKhsoXUTcPlW5GITdeGDwzlP28-QFAwOvJb4
Message-ID: <CAK8U23Z0fpJ7ogsGvdWjnQV7kEwdgEW8pSQwbjT9UPVzn3LXoQ@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Miqu=C3=A8l,

This PR aims to replicate functionality similar to what is implemented
in mac80211_hwsim
(https://github.com/torvalds/linux/blob/master/drivers/net/wireless/virtual=
/mac80211_hwsim.c#L5223).
This approach is useful for testing wireless medium emulation tools
like wmediumd (https://github.com/bcopeland/wmediumd/blob/master/tests/)
and I plan to submit more PRs soon.

I've started developing a wmediumd-like framework for mac802154_hwsim,
which you can find here:
https://github.com/ramonfontes/wmediumd_802154. However, it's still in
its early stages.

Indeed, I'm responsible for Mininet-WiFi
(https://github.com/intrig-unicamp/mininet-wifi) which supports IEEE
802.15.4 emulation via mac802154_hwsim. Having a wireless medium
emulation for mac802154_hwsim would be highly beneficial, as it
enables controlled testing and facilitates prototyping.

> Also, please wrap the commit log.
Apologies for any confusion. Could you clarify if there are any
specific changes I need to make in the PR?


Em qua., 26 de mar. de 2025 =C3=A0s 07:12, Miquel Raynal
<miquel.raynal@bootlin.com> escreveu:
>
> Hello Ramon,
>
> On 25/03/2025 at 13:53:12 -03, Ramon Fontes <ramonreisfontes@gmail.com> w=
rote:
>
> > This establishes an initialization method for perm_extended_addr, align=
ing it with the approach used in mac80211_hwsim.
>
> You are now enforcing an (almost) static value, is that the intended
> behaviour? If yes I would like a better explanation of why this is
> relevant and how you picked eg. 0x02 as prefix to justify the change.
>
> In general I am not opposed, even though I kind of liked the idea of
> generating random addresses, especially since hwsim is not the only one
> to do that and having a simulator that behaves like regular device
> drivers actually makes sense IMO.
>
> Also, please wrap the commit log.
>
> > Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
>
> Thanks,
> Miqu=C3=A8l
