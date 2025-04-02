Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37C42A87
	for <linux-wpan@vger.kernel.org>; Wed,  2 Apr 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628402; cv=none; b=NqNf/9Xt6jQptto+h57AukQot9G2fdygdNfwpm6oHRrEo1gZ85AT9bm6ywY+pbRZ+ziulwlLsWPedEH9xiwHRHxyQh5sAbjP8F3xaO2uAJHpqXuPyCRgviBkamf//YuZQp5ILlRXBqB9S9n1+Pa+7ZHXJ0Ltqonj9VmGCDPGUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628402; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj3HQMoNYPaSMTc8/NPRqmtzJq/40lETI+/WYESs84kG9dBbeT7AoO65B4PLWnmUTtj4wvHeX3UGd2A/CiAKFD1u9GFqFGgApaV/f8BPToY/Fw21FFqMdlyziuPs1ml13f2HrKiOUxWC8LUqpypwLETyUv5b6LKSlWwqB2x9QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BfY0meL9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfY0meL9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf3d64849dso27766566b.3
        for <linux-wpan@vger.kernel.org>; Wed, 02 Apr 2025 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628398; x=1744233198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=BfY0meL9/V2kVWlJOpPQNIyq5EtpGvHuflsg6mCVS+kQopzrMRSCB41S7aciRzmui7
         1/dp8diqKK9ERHZztxWM7JjPLya2ii+UE8TCfqHVBl87AA3vd7zmpcqLgoXOU8Q/QyMz
         OBM7BW5rT6rFzSYTTHEGFpjN8LJJabnRbE9tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628398; x=1744233198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=aGK5+lnzD0/vCi4RGA4IJmBUU+h2zZ/7fnJRHRu+ioXTiT3oSnqK5z7XK2vjIGO+RB
         dDJ85hKCkltDTbC6k4sM+c6PqFGg/nCBJos+xfuxyZgS6E/Pt2xSVwrz2rPaptBa8qqZ
         8ueCTGQ2vhaYjICEBqm9eLQnDJ13EywWOxJrKeRudJS1Rwiq+nnU95QSmZ411cpB7dDi
         yqu/nt8dRTIvZzK02yXe1mTM4OOM0RsAgtopvkbJggQen8b8OuInhuVg0s7u3RM67utK
         K4VESwgmHojtEUQBriu/Sov5szgB00ToYNj9+Bbvj+uUeRpMIBYWksOtApStcGTPYzPm
         2Mlw==
X-Forwarded-Encrypted: i=1; AJvYcCWyx4ddRZzORJQTBSiYsBVtco/Y9vLFuffHrxma2keeqBxX4bw8bbOPGrVIxopbT7mUpRjo5gPUwoJd@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEAnZkH1mVrZ8Ulom81WwNABZsfXYbwWBuTOefEMzznyIiOhr
	pdSi+/dWbIpBE+bPAKPhn9priWCQVq1J39Y8J/XdtjZvaaVEIoBXPcUJjOLKUXPIKLfH8YTyCSn
	D34xoVg==
X-Gm-Gg: ASbGnctFJVHUrC1GNx0oP2sDERBqsnHxh/RlCI16kIKAvr+M6C/WpP9k19+nDLd7mPr
	Wj2BVQYo5hkyoJSw4YMxiO7u+v7S2K1trda9iH3GSKFBfSgMxRumdoVqRL4kJ/8vtXBVOOoOCOv
	i+o0V76mryEwEH13sLALc9EQP5juPuqj75+D81jkVZyRrDAY4wqFNtE4/nWlL8CL7W6i1jL8Xns
	90um3ibiglZQlYHhfblhzEWMTcpurju/Im9Q4GXBTdO6+Nfyjx05njxJ20i5eYZlO6eIV0H2KFJ
	Y/w0+VFPS0UWZMSm1Xhv4yarTowdy8KUObgfEJPadbzmLXuZVthiqFZ9ZgcIPa0es5uA1bvOOb3
	dvu6wM4h4pHLVmNWOnn4=
X-Google-Smtp-Source: AGHT+IF9wuvyZ/ad/jPynkgzv7QectIDz+CFHnx02Aohe5VyogCo1PKvR6UqxsE/L8Nv2hG86Baybw==
X-Received: by 2002:a17:907:7f04:b0:ac2:9841:3085 with SMTP id a640c23a62f3a-ac7bc134216mr17486766b.30.1743628398277;
        Wed, 02 Apr 2025 14:13:18 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196ddfebsm954715666b.164.2025.04.02.14.13.17
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:13:17 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so430836a12.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Apr 2025 14:13:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXMC47XFt6mFBAdRsEg3/diLvbeeiSb5Ywe+/ZqVfETJMyogo8XaWNqrg8xpfJ8b0kQ+vRMP5dR55s@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
