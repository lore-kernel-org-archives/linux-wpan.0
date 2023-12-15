Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9E10E1
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFzEYtFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNMwkvSpfGOxYOmt6Yy419cqafg/NU5jWTTLy6a7dL4=;
	b=CFzEYtFPuSlv+KQfAqQvdCktz7IdJXNlAcCNcMqUSVbLMJWqpJPDCZBqQbYVPX+Db3STDE
	RJNC5Bmp/uMIDV6u/95GHDxEvyMYgsoAZBLTR9YjBW1r7PSCQrAbYfZAsnP7/4KlLTi8f7
	63r+K/yvvxeZ7+LLN9X8USFWEjCDYcY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Q7MsU7rPOTyLGTy9jn0c2A-1; Thu, 14 Dec 2023 22:04:05 -0500
X-MC-Unique: Q7MsU7rPOTyLGTy9jn0c2A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3334549e36cso134546f8f.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609444; x=1703214244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNMwkvSpfGOxYOmt6Yy419cqafg/NU5jWTTLy6a7dL4=;
        b=LhPGCuLnBongbLJbo769VRdPazc5rtWEcZ9KOpptTgdFlFgbE1Kf6aSIO75kI9Ax9J
         NmiE9woUgD9W00IzPmvFmwrWZKhU4otirAkufdGjFWLlcY2sBPYQTIvylysGTDly/kos
         TW6tDhIqtUVgL9BFQKX3hWfcLOz1jLAUQnE4/llXfzfgc2HokMHOhvzc04k/WTGk6arT
         ECJXLl7/+MaJy5gND8q7oQAhNGm6Zy1QWx8I9nOPZjiaf589FREWl77B6w1r+wWwIuJZ
         taaLSxyHnRx+1fHUXAHVMaLLmqbRkOmNV0dbkRrJM6u1MchwDIie5o1oLDAvwBFXpf+T
         NZ1A==
X-Gm-Message-State: AOJu0Yx859f2VetPrupiWvE+abMk8wg85aQWEbP4k8r6vO/ODuImj0gS
	3yHCBpMwJAYY+GGYF5bMA9YfsXv2lmqGLDRCkVyz3nxjjLhfLPMOcvxreVHRA3F8jBibcYt0n1d
	ETqbeiJd9ay7Sm3z4/TmpkTGatDpA1atCKwmOXw==
X-Received: by 2002:a5d:548d:0:b0:336:3f68:2cef with SMTP id h13-20020a5d548d000000b003363f682cefmr1686257wrv.37.1702609444107;
        Thu, 14 Dec 2023 19:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwNdN8/8witGXTjHx1RjofY3zB/56J/MtQS4QrJstmI32ipkrrfMW1V4kViMIiYcKdMOAwxvz5EZ/yMhg1VnU=
X-Received: by 2002:a5d:548d:0:b0:336:3f68:2cef with SMTP id
 h13-20020a5d548d000000b003363f682cefmr1686242wrv.37.1702609443815; Thu, 14
 Dec 2023 19:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com>
 <20231204095718.40ccb1ee@xps-13> <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
In-Reply-To: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:03:52 -0500
Message-ID: <CAK-6q+gSiEfMs5vP6-9hPUeW13xknBuomh10=YLNjUV+5-1Qvw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Zhang Shurong <zhang_shurong@foxmail.com>, alex.aring@gmail.com, 
	stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harperchen1110@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 10:01=E2=80=AFPM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Mon, Dec 4, 2023 at 3:57=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
> >
> > Hi Zhang,
> >
> > zhang_shurong@foxmail.com wrote on Sat,  2 Dec 2023 22:58:52 +0800:
> >
> > > The syzkaller reported an issue:
> >
> > Subject should start with [PATCH wpan]
> >
> > >
> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154=
/header_ops.c:54 [inline]
> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee8=
02154/header_ops.c:108
> > >  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
> > >  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
> > >  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
> > >  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
> > >  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
> > >  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
> > >  sock_sendmsg_nosec net/socket.c:725 [inline]
> > >  sock_sendmsg net/socket.c:748 [inline]
> > >  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
> > >  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
> > >  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
> > >  __compat_sys_sendmsg net/compat.c:346 [inline]
> > >  __do_compat_sys_sendmsg net/compat.c:353 [inline]
> > >  __se_compat_sys_sendmsg net/compat.c:350 [inline]
> > >
> > > We found hdr->key_id_mode is uninitialized in mac802154_set_header_se=
curity()
> > > which indicates hdr.fc.security_enabled should be 0. However, it is s=
et to be cb->secen before.
> > > Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains=
 uninit-value issue.
> >
> > I am not too deeply involved in the security header but for me it feels
> > like your patch does the opposite of what's needed. We should maybe
> > initialize hdr->key_id_mode based on the value in cb->secen, no? (maybe
> > Alexander will have a better understanding than I have).
>
> I can't help yet with a better answer why syzkaller reports it but it
> will break things as we using skb->cb to pass additional parameters
> through header_ops->create()... in this case it is some sockopts of
> af802154, I guess.
>

Maybe we just need to init some "more" defaults in [0]

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c?h=3Dv6.7-rc5#n474

