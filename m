Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170353A0
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMGTTjPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rdlNcO/JWYksYB1jcKo0fPtS6Vss5TqjF5nT+vHiAA=;
	b=RMGTTjPRvbd8xCh/opLheOmDgnPnInotHHwEdScWdfNlhbNVHtD9KuRbE9+yffSQzaZJAR
	/EE++//Md7fSXnXEjq31WqYpKKg/4mIU/+1Ml7w3ExxTSCjLRKTq/dP9luU5Yt71ZLTXAc
	vBpUgLd9So+gRvOPXnF3d3vj2SMkyZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-WZaYDc0DPBSbVJhKwiy8-g-1; Thu, 14 Dec 2023 22:01:23 -0500
X-MC-Unique: WZaYDc0DPBSbVJhKwiy8-g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c49cb08fcso1345725e9.2
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609282; x=1703214082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rdlNcO/JWYksYB1jcKo0fPtS6Vss5TqjF5nT+vHiAA=;
        b=kr5Yj5Mrcq5n1SIH/v+RRuRPRABB8fsQI+hkzOZ0X/Zo/yHijDRjC8nE6ArB28qBh0
         IjWLSmi+FieLWsKy+VnQeiTXT/BNczt2wHYyYhM8HK6/9oudKQHOQgJgY1ABmprCYUiH
         nJAKnQRWzPbZyp17r3ORCaFkxl8y/DTD+OO1UopmbuN9EWENx3ToEXIvDRUxgLpU6vrO
         2tfU7hapdfzVgFIj2glioxdFkHzBIXEJXt/ytKAA4mcHrrWAyIAumLiWrzhjJ4ZHDsCn
         wxdKaJSMpkEHmFwsxaDDpeuEdL4njhrQO/PnSQhw6qXXozgEYe97TFE0G8ZkHzp8mzyL
         Rc2w==
X-Gm-Message-State: AOJu0Yw6hRh/Cb+Nwug2+XQmphrFXQmRg+vYbfuPPi8Jkyv2hg4j9d4v
	3CyVFsaLb0VHJOv04nkNTTBaqrRsGgldZtPh37R+0ws8lHEMoDrb87fKfK2gt86hTEJ9YYSUcSl
	a7bv5ZUpnCfYQ2DT62ZGkw04c6zGCjYRTmzGCRQ==
X-Received: by 2002:a05:600c:2184:b0:40b:5e59:c559 with SMTP id e4-20020a05600c218400b0040b5e59c559mr5913414wme.131.1702609282595;
        Thu, 14 Dec 2023 19:01:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrpNJr0/F3OqeFp75QF7xFP1iMDXIr63AKRWXIeGZPp4quZ+IVEFnm0fP4y9WmifH9K7YrvDp2pNwoa9mH1PQ=
X-Received: by 2002:a05:600c:2184:b0:40b:5e59:c559 with SMTP id
 e4-20020a05600c218400b0040b5e59c559mr5913408wme.131.1702609282310; Thu, 14
 Dec 2023 19:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com> <20231204095718.40ccb1ee@xps-13>
In-Reply-To: <20231204095718.40ccb1ee@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:01:11 -0500
Message-ID: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
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

On Mon, Dec 4, 2023 at 3:57=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Zhang,
>
> zhang_shurong@foxmail.com wrote on Sat,  2 Dec 2023 22:58:52 +0800:
>
> > The syzkaller reported an issue:
>
> Subject should start with [PATCH wpan]
>
> >
> > BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/h=
eader_ops.c:54 [inline]
> > BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee802=
154/header_ops.c:108
> >  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
> >  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
> >  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
> >  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
> >  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
> >  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
> >  sock_sendmsg_nosec net/socket.c:725 [inline]
> >  sock_sendmsg net/socket.c:748 [inline]
> >  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
> >  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
> >  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
> >  __compat_sys_sendmsg net/compat.c:346 [inline]
> >  __do_compat_sys_sendmsg net/compat.c:353 [inline]
> >  __se_compat_sys_sendmsg net/compat.c:350 [inline]
> >
> > We found hdr->key_id_mode is uninitialized in mac802154_set_header_secu=
rity()
> > which indicates hdr.fc.security_enabled should be 0. However, it is set=
 to be cb->secen before.
> > Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains u=
ninit-value issue.
>
> I am not too deeply involved in the security header but for me it feels
> like your patch does the opposite of what's needed. We should maybe
> initialize hdr->key_id_mode based on the value in cb->secen, no? (maybe
> Alexander will have a better understanding than I have).

I can't help yet with a better answer why syzkaller reports it but it
will break things as we using skb->cb to pass additional parameters
through header_ops->create()... in this case it is some sockopts of
af802154, I guess.

side note: we should stop doing that with skb->cb and introduce some
802.15.4 specific header_ops callback structure and not depend on such
generic callback which does not fit here (and maybe somebody does a
wrapper around that and reuse skb->cb for their needs, etc.)

- Alex

