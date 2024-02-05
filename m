Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61864F217
	for <linux-wpan@vger.kernel.org>; Mon,  5 Feb 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162584; cv=none; b=iWjCXrwHkfxK71fH1nOGNJoK8033X0DHR+xMU4Nek/W6WR0LFp+zIGaW2Rgt93Cvg76n9CRN7kt8hoR96U4SxtuRRqSQnBOcE3RoB45rOYjo3DQPFhGccxVRRLUqidcHvysdsFfB5/xGjua79c9MasBub83AGvWDA2LtX2qAJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162584; c=relaxed/simple;
	bh=XtlAVK6YDcvQ+pR0/3RJq86cSBgtfjV822+OPR5KgHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9ceP9/fN52VsrPlPISP9YmUnKB6EoqDiTxMlZfTTTPfPXSM/uypQvgQT1d6M0g/mAk0M9pjrOnQLwIUJKdqYsYp4aZiAhec/O0HBtsEl32ID6IEMBLcnPE+lv5Kb8hY5i4D6dGhFVNgTa6CMvAHWZKNp4s3eTxyV6UvohqTJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0znJbR+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0znJbR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
	b=K0znJbR+vbaLijgLx5xAwJiyh9KVwnRYyrUGRvoDLbi5cmHko3s6Srlk+DbtIoiNqZh/X3
	w+BnH6LOBJHFHmEM2POcA1sqNQZAYMzgGgMBVprxvOxQx98l3GFsVKvaL0f1bofb9J0ETC
	AjBtbsTfobiXvnUbyHzpEh3s2XHaM3s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-rlA7MKkSOpmnoOeB1Gw0ow-1; Mon, 05 Feb 2024 14:49:38 -0500
X-MC-Unique: rlA7MKkSOpmnoOeB1Gw0ow-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56001b47349so1820717a12.1
        for <linux-wpan@vger.kernel.org>; Mon, 05 Feb 2024 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162577; x=1707767377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
        b=UEst2J7pB3GldQjRTTuYW28Z3SNj3zb4en/Z2Cz5X1dDwhHP4rFc6D5v5/k/Ouvmkk
         y9Pa5KS6XcIv1bXC4Fdd/i1H8i+LpyKuDy1fNWHV2Sq+uCPwghqMInHFkKwRpu4p6eAI
         1CoOnJu7xBzHG5Y/Cya84TJuopl6I1az/+uqgNsfzB+p/40IywYtx/MLaMv4nw7JKXCk
         JJn1v8NG/rkoKUMKMRqX5tKyBHF8tDspV+mmdtiIL242f2KvZkjYfdqB1SuwT2DUn1j0
         t5CSR8iA/4p4VdwkSPBcNZYIWzcR/qTsyaG7dvCcJF1wn6tGTRLSCaOejl4Ss76CzWo1
         +U9g==
X-Forwarded-Encrypted: i=1; AJvYcCUk2GdI6E68xduJwvf7u8gSMgy8976lhiM/D1ohK7gc7ynPgnO/1Tr05EEFcXYRJ0ARv9+YP/uWMdpRV/IlnOqBz/BoTomvmkI9lw==
X-Gm-Message-State: AOJu0Yw86Np3P2K+siNfNddYXQVtPaV4j43yHXbRO1wF9tgWgeEQHRAR
	ruT/iYomuFzPU4el6u43gqwroiAXJCXic4pXkaC1Tizq190gLDwJa0QdvhrAUE0lYClf8fGofUN
	ggN94+yCiCJjv15g4Rl8MLILHCrzzR4Yg7+/GnnePHwWkCO29rzOK2wsqWcAf1U/jZ9oT4BvuhK
	kWQuOXCwyqZ6d9cJXoviAt2fIq2ENH9CAhvQ==
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id w12-20020a056402070c00b0055ff5d2ef27mr26673edx.41.1707162577424;
        Mon, 05 Feb 2024 11:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBlSYwIisgeeQLdSLhQ5yBMT9FQ2Ei+kgu73drD6ctuVLS3E+BlVQEjgFpzoHQ+6IW9efo8m2HvcdOR1MzrqA=
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id
 w12-20020a056402070c00b0055ff5d2ef27mr26660edx.41.1707162577159; Mon, 05 Feb
 2024 11:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru> <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
 <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com> <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
In-Reply-To: <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 14:49:26 -0500
Message-ID: <CAK-6q+gEjqCrnFkpKSuQiuhpx9zyuWr6y0tQpJOLquoz2pnmzw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Zhang Shurong <zhang_shurong@foxmail.com>, alex.aring@gmail.com, 
	stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harperchen1110@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 18, 2024 at 8:00=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
...
>
> I was curious whether a smaller change would suffice since I might be
> too green to see the full picture here.
>
> In all honesty I am failing to see how exactly it happens that cb->secen
> =3D=3D 1 and cb->secen_override =3D=3D 0 (which is exactly what occurs du=
ring
> this error repro) at the start of mac802154_set_header_security().
> Since there is a check in mac802154_set_header_security()
>
>         if (!params.enabled && cb->secen_override && cb->secen)
>
> maybe we take off 'cb->secen_override' part of the condition? That way
> we catch the case when security is supposedly enabled without parameters
> being available (not enabled) and return with error. Or is this approach
> too lazy?

I need to see the full patch for this. In my opinion there are two patches =
here:

1. fix uninit values
2. return an error with some mismatched security parameters. (I think
this is where your approach comes in place)

The 1. case is what syzbot is complaining about and in my opinion easy
to fix at [0] to init some more default values of "struct dgram_sock"
[1].

Then 2. can be fixed afterwards.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n474
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n435

