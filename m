Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900283D3B7
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0WQNPJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704829441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6mR+9SL9QG885yBOOeygrNdvHoPQ+gcxDs/w36x2vM=;
	b=I0WQNPJIaObLcS+hibe1eS4TYDPq7EjNPW80TyMjBke8tXiaq20rStgMzedgZYggRuHtQ8
	e1coFdUMRoo72SwAxR1Dsi+2tT+PVmUPvGVP5Uw+BwaZTgoWeFh5Mr2CHNezSd07eNWb52
	zlBNgVdJoCAj4rB3oQMVj8BHsMA7Zsg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-7do9JY8WPwKVyyN4wmteJw-1; Tue, 09 Jan 2024 14:44:00 -0500
X-MC-Unique: 7do9JY8WPwKVyyN4wmteJw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54554ea191bso1886781a12.2
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jan 2024 11:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829438; x=1705434238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6mR+9SL9QG885yBOOeygrNdvHoPQ+gcxDs/w36x2vM=;
        b=IIHi7YRvkhixVf+gG7wKQSBBTn6+7L/2UUrILAsfkdbPjSV8HpKoTwatvWZm0inP+r
         mCIRbtKq/cZVbCBBHoHawzc3P8+z/Zg8mlJ8bjyh50WSbQZciG9ydvx4GbCMtE9jQcM8
         JBOBaLjYkftyUgjOlwtPZR1Y3dTihNeWk+lCsKTgyGC4CjM97gLgr61nh+yWlYyJR3KN
         x8M4dcWG1LMkWvTGfzWWvzZAtIYAPiz6HPHzyRYeD5NLTytXJYNVN36NMutvHMXN3lTB
         hM+Xqy7XE+bbPjG5vSRnbliYEuWpRGGnqa8Rz8criljZxRnEJov2QCQ6WxjhqfXTLIvC
         dfBg==
X-Gm-Message-State: AOJu0Yy9xyrUVFqLIb15gQuiP14WqfhvdIEHK3n+7nx/kfIiCHWx6KNW
	kKoDHBbUP1ZhRZtPkssV9T7un2Mx1NCUsw+KafFOtzUFXXZ+6iIoMZcfOJIVGYkzM22f8j6U//Y
	k/CwphnrmWXEOCVtcN+h9m00+/HyyG1QZN7TCM5W6vTO+xO1mRbtvxg==
X-Received: by 2002:a50:fb07:0:b0:557:41c4:cbdf with SMTP id d7-20020a50fb07000000b0055741c4cbdfmr3647653edq.49.1704829438599;
        Tue, 09 Jan 2024 11:43:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1ZPkndcCFqRcbxpYgkpvM5v/fUVlg5GKJn3dBbuqid4trbvGSL6W2MGwgKqi8DyUMon6c8ShNqj8OddwSGYI=
X-Received: by 2002:a50:fb07:0:b0:557:41c4:cbdf with SMTP id
 d7-20020a50fb07000000b0055741c4cbdfmr3647650edq.49.1704829438347; Tue, 09 Jan
 2024 11:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108170928.2b1d0fd9@ciel> <26711.1704808629@obiwan.sandelman.ca>
 <20240109183549.13908ccf@ciel>
In-Reply-To: <20240109183549.13908ccf@ciel>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 9 Jan 2024 14:43:47 -0500
Message-ID: <CAK-6q+iPF7dUXM=Uvu9Uh+ux36A3nf1t=kA92fT5gOJCnK82Ow@mail.gmail.com>
Subject: Re: Linux WPAN and Contiki NG
To: =?UTF-8?B?TWFyZWsgS8O8dGhl?= <m-k-mailling-list@mk16.de>
Cc: linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 1:36=E2=80=AFPM Marek K=C3=BCthe <m-k-mailling-list@=
mk16.de> wrote:
>
> On Tue, 09 Jan 2024 08:57:09 -0500
> Michael Richardson <mcr@sandelman.ca> wrote:
>
> > As Stefan said, you can not yet run TSCH on Linux.
> > Many of us would like to make it happen, and a few (Alex!) are writing =
code,
> > but there hasn't been a resources to allow anyone to spend real time on=
 it.
> > Typically, people combine a Linux host (like a openwrt router) with a U=
SB
> > connection to a Contiki or RIOTOS (or maybe Zephyr now) device that act=
s as
> > the 6TISCH device.
> >
>
> Thanks for the answer! However, when I create a new wpan0 interface,
> `coordinator` also appears for choice. Is this not TSCH related?
>

no, it's not TSCH related. You can probably have a tun interface and
speak with a contiki co-processor to forward raw IPv6 from/to a
contiki device. Google keyword is "slip", but then you don't use any
of Linux 802.15.4 or 6LoWPAN functionality.

If you use 802.15.4 contiki without TSCH or what we at least support
"legacy devices", be sure you disable ContikiMAC which is an
out-of-spec duty contiki specific duty cycle thing.

- Alex

