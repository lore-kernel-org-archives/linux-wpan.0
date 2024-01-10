Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDE656
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jan 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b39AtV00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704848723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDuMstrISFSfKQKJSfyzZh7RGQR46ElR13WcY4pdUew=;
	b=b39AtV00QEqWYh1yjynbu+xd2BBpvrAO00aBXEiutAHKvFx/SOiuzJAqnNsPQ1FZOFxJfH
	fPLRYBab6rcPDVY5M/jTWVnwV0LFZTXNHy9EYJ1skWu6eNKX+k4tEU4UemQGXZxAG+/nVa
	KbU+wllj1Y9C66R5C7DQAzNl8FKQCrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-qwAZSW83OiiQPp70TRcVsg-1; Tue, 09 Jan 2024 20:05:22 -0500
X-MC-Unique: qwAZSW83OiiQPp70TRcVsg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d6e7334cfso33146945e9.0
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jan 2024 17:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848721; x=1705453521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDuMstrISFSfKQKJSfyzZh7RGQR46ElR13WcY4pdUew=;
        b=K6ah6ABHms0UH60vVte4bU5BmueZDiPeEbwTiAQv9abIUNSGeyPeaKclEcIGHDGhLY
         RYfkTrEBe/0FyUyRUYhZuqYIqenjpz/EzTroSHMVxwAZLG5F7DCL+X+/GA9SqnFdcXsw
         94G4By+l2ZJatbYhkRXgyQohigejq8UlrmNCeIrWInqQ+J84x3WRhne8XvrznCwtIUxa
         es2YRKieIYQxV2UwiQzDBq6Qse3cNLynoDN4s2VtPH3SG3u//j2cyZiIYdGRkCOdBnFG
         ZCsxskL7i2jfXUBqK2Lw/VhZhdPq/tVIQUmIWRKjHjf7jUxIJNKFWX4NGlU7sta3No+w
         0g3g==
X-Gm-Message-State: AOJu0Yxa1ForSRsbm7tlcZxUD8mT0W663gdZnoxCxDhckk1gmTMNqokv
	wS880cUsePBZBRBU7tLVdjU1vUmdEdqhud448b26gVaz4U/Y3yRFNAe6DU3DWOLVBpTRWh+wsF4
	HFKY61RaHxX60svtY0n14atdrTo2kOg0mrZ2LmfE+cIDK7w==
X-Received: by 2002:a05:600c:a007:b0:40e:47d1:5929 with SMTP id jg7-20020a05600ca00700b0040e47d15929mr90341wmb.194.1704848721435;
        Tue, 09 Jan 2024 17:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO/oKaTYNEjGYuCr6C67mnkh30/qw8eVG3XHpGebumEk5NYxM9UWvntMr2Xi5gnxWSmx+sY1pCCHDJ/5lLErw=
X-Received: by 2002:a05:600c:a007:b0:40e:47d1:5929 with SMTP id
 jg7-20020a05600ca00700b0040e47d15929mr90334wmb.194.1704848721095; Tue, 09 Jan
 2024 17:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108181610.2697017-1-leitao@debian.org> <20240108181610.2697017-8-leitao@debian.org>
 <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
In-Reply-To: <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 9 Jan 2024 20:05:10 -0500
Message-ID: <CAK-6q+iMkVKQZjkhFussJ-f62Yza87u3Ep8rtukP_kPk3Ebz4w@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-bluetooth@vger.kernel.org>, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-wpan@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 8:04=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Hi,
>
> On Mon, Jan 8, 2024 at 1:21=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
> >
> > W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION()=
.
> > Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/6lowpan/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> > index 7b3341cef926..80d83151ef29 100644
> > --- a/net/6lowpan/core.c
> > +++ b/net/6lowpan/core.c
> > @@ -178,5 +178,5 @@ static void __exit lowpan_module_exit(void)
> >
> >  module_init(lowpan_module_init);
> >  module_exit(lowpan_module_exit);
> > -
> > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network=
 module");
>
> Here is a nitpick as well. The correct acronym [0] is "IPv6 over
> Low-Power Wireless Personal Area Network", otherwise it is okay.
>
> Acked-by: Alexander Aring <aahringo@redhat.com>
>
> - Alex

[0] https://datatracker.ietf.org/wg/6lowpan/about/

