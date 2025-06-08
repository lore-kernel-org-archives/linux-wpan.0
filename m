Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9970830
	for <linux-wpan@vger.kernel.org>; Sun,  8 Jun 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398247; cv=none; b=mt0uhYYzF3vd2TepAmUl8nwuwc4lC6tqHGwLNgmgr4Am8z7OhvIxdyrd2FV/CKufZHSmZvQLaKVpyTbFd+VChLumsdv9SmAgRj/0rRck3YumVlp4PTx0WJcvYm923KUVQArv56jcyxUbBljcydD7zW74hGKFp+ZvdpWjqK7Y9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398247; c=relaxed/simple;
	bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeddLrO4SL7gxWVYVsNTm1B1vgza1BAxqj0AhLrqfsVzfQr/XzhQn2IlBXrdgEJCI9I17G/fz/blVpvJUKFA78TGc4pByaeN5QVdXWyiZSD2tpZKVB1t3eIpbUDKe8UzM+qWKkY4ndlufA16LvimPxZ1aZ9djhe6iSKEYntktPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGvJFoK9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGvJFoK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749398244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
	b=IGvJFoK9buaWxQeSNAkqyE3rUtORYEnTgX8ivKLive29ba22Xshx0tSTvGslbjssBmA1LG
	B5e5jikfzRUaLfqYvVb0uFiq73Re/L3PPj0wxnijGKbkEzFISzvvDSTBCEmLi+oRhQi1eH
	AcaY9hgQ7w5ExIi7Nbwnvy1oLNnpwuw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-v9KKkaXBMXq_8o37nuP3sw-1; Sun, 08 Jun 2025 11:57:23 -0400
X-MC-Unique: v9KKkaXBMXq_8o37nuP3sw-1
X-Mimecast-MFC-AGG-ID: v9KKkaXBMXq_8o37nuP3sw_1749398241
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a5ed03b92so19654561fa.3
        for <linux-wpan@vger.kernel.org>; Sun, 08 Jun 2025 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749398241; x=1750003041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
        b=cVZh/MHH3iCrQuZawOwo3UYnJVf/XQAJ5zYlRI1U5iiK67wE3CKMHPrYhReBkHpk0Y
         BfEJRq2AAQMZ1AL81tlkiV413LXLsRrLAdsR3MxMPd0TcdrGXNtMdxt0dK+8PNoziVyy
         pt23wg8RnFid5kLTKHi/m/ArT6iFt6zygHzhBX1hWgI+roZvoH5aVeWOfHNWmKluPwum
         +hQz2/OfUB00hZsT3jnI8OUJ75K+Ly51RZglMFlOrvO9sWhTs191BEZUg9sdddW+5iTE
         sYVxULlygb6waAo7QCrdVv8Tf+3gEuZozQQN12vsS4ChDBKUAG4xP+4zsvQ3jGK4U+nt
         mRew==
X-Forwarded-Encrypted: i=1; AJvYcCWVwKlwX4a8oWqzj4obJuZWM1HiCkVPhc4T/r0R/O+GJKW9IpM44laqJalIelaOluVRz45/IvDdCNa3@vger.kernel.org
X-Gm-Message-State: AOJu0YxOK6eJ4KE00+6UictBKu/Dzcpy7fbeONAGUwnq/N39nLj+N1F7
	SGxHqA1OWfz07wuFK4TrjDpNUF+rATHqE2C3DhLPfvPfCkxaV6JvOfK7LVh/YCCNT2Pd9Mz5Flk
	XjoGSMUX1WZGCurdLE4VkYFN54M9Je7LkDt8eftCuV1StmFLZ/oAO+wJMHjkeyy46HGvRj/9T1P
	q6jqKEZYuxhTb4eSYnDtJCMhm6byt0rCLuRAcYNA==
X-Gm-Gg: ASbGncuD0KWU827JNXF5XZOaGTnfQDgglgktMSLqd50+sLpWCHHzOlm/mPLHwfylb4p
	xxCpXBPwFeCcqWNTnB2QvlOBVNJEKvowIoR1Su0nwD5Wz7vzpFqQz9tVYtkm3IHjbGtWwZRczYr
	UfN4DWsCJjm5XFiXKuZBf5Bp6cQKV5RqozjPW4
X-Received: by 2002:a05:651c:2125:b0:32a:88db:f257 with SMTP id 38308e7fff4ca-32adfc0cc63mr22376171fa.31.1749398241435;
        Sun, 08 Jun 2025 08:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ92pDCTQGVUd+R73ZAPBWMpMSpFvxZRdi0lJDDTAwdZD7T6D5c+yJ74WYS4BOrdyFNAyTdhpXWCX1bHQi7kE=
X-Received: by 2002:a05:651c:2125:b0:32a:88db:f257 with SMTP id
 38308e7fff4ca-32adfc0cc63mr22376121fa.31.1749398241033; Sun, 08 Jun 2025
 08:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
 <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
 <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com>
 <54980160-6e46-4ac4-b87f-41b7dccba1d3@lunn.ch> <CAK8U23aRrvC4wC6WvcBRPA4YuyC1MPvOj8FO=cWfi43_Fdh4Zw@mail.gmail.com>
In-Reply-To: <CAK8U23aRrvC4wC6WvcBRPA4YuyC1MPvOj8FO=cWfi43_Fdh4Zw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 11:57:09 -0400
X-Gm-Features: AX0GCFsqG832Kq3kP_9JJ4OsbpseJv4f7JiSDEeHcFGaDfX1uUo8TfC0qw-LJHM
Message-ID: <CAK-6q+hO7byb-MRSd1U64-CMLrjrDdHfV5WLjK4dscCgxFSMOA@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 7, 2025 at 5:42=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> Ok! Just a last question:
>
> Shouldn't we define a maximum number of supported radios when using
> unsigned? A value like -1 would wrap around and result in thousands of
> radios, right?
> That said, wouldn't it be simpler and safer to just use int instead?

there is no limitation to add some during runtime. It requires root
permissions and you need to know what you are doing when you are root.

- Alex

