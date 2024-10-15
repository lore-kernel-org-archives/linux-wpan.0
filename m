Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235331B85E3
	for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979634; cv=none; b=KsE6f8iDSx72iZ5QSJJmDFyaVpFiFjh5NYoGJk9DkUz+IvyS2f605onLTqZG4V6S03CWRftpjfDEJUuhC9X2WOkFi3Fzxut8SntHdhB+vkbDY4uA/v2naJtOBLQKolVZgTwtWQuRpJGbvWMQIJIwkfRs18blsv2FKNgxfGSFnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979634; c=relaxed/simple;
	bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd0sMji3izUWznVinWx1NtId/4d9aRJpWCX78DsZeUJJ/gMo9gkab+hFQT/238gZbQw/n6R+2WuQ9syOFHOlJ6r9qjqpmg07QyfNlOM82CPFtFcPGCJ+FmasPr4z7BYm4QcJM+U9a463EABIv4XpSqKmFNYiVO5WrAl9WZiuR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBf8oYZV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBf8oYZV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so22522241fa.3
        for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979631; x=1729584431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
        b=lBf8oYZVU2x0O7TH4LDNj1wIZr05Ce4aKwOyF6w/+Cr5ohBeMIWwamGc0X4xRbgmg/
         mk/AGobg+odjj24HfSyye7Lx3zhjDJGwAzlP0Rp91uE0wf9eBsEqP/yk8CBdMbxdy+lB
         gVV5CcXhjgob2PiunhlqtCh7QL1BB0cH4KPFURrF2w+7hXTk/yyIwY5mAuv2Nd0U8OKA
         yBOWXxWABeJ5eiqywg/+XbUoESRGOpx6z7nbxg8c8eVHocK3tOmVVnbFn0K6FYJEvIkL
         d/khi3pukT/hW5ZzA0X/gJLNkoTYr4aw6ubJ6MyjR7Srwu9LUnLbMhuzvGdZGei03PRU
         QAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979631; x=1729584431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
        b=XdjzaTk/RbE4vojzJROCE8SCJ2vuALr2hbHD32xUBAq5c6YV2dXmg3W8v9av9QrXyU
         kn+F9NWdg653jKhQv6nZIe9IR5wS0prGRFR/hpQbYf3jE6KFQI9e0Vfsec9nZeL1NGhb
         AiJzWiaQl7nsTBs8utjpjINbtcJfHAqs5UwwWs6UY37WJvYR5o6LPEH+VMoTgrG469oH
         2hbwLJryLYJIfoJCFatGT3rFsdctqdKRlU7CEkgMVOIdzhigvQ77demMTWda5WNAUH6N
         YKHhE0zHxa/lwBkqepN5ouEcSmhc7Cb7ss1eazOqutqVAd+dsK8XaYUrZBO+3N8GapAd
         rASQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1LXhkho26L+8aB3bFVKryaPmgYSeI4uH7zQcA/ttaSFNog+8ewBV+ScboNMgh2LC9Af5p2N/Y5gEA@vger.kernel.org
X-Gm-Message-State: AOJu0YxndXomE1JSm5qSNbCr/P17ZikXsH+cm6ELiHuXs1inz14DocFz
	UHG5kUKmWcMyKDFUuwt+wswhJ2vseyqjvawC6eL2Xc+gzVm+lEYTNQ12mseol4sDfQq/JCom5eP
	SbEniNyDgkAfHAqPDjsKErJ6vTXkAGHNqPJRT
X-Google-Smtp-Source: AGHT+IGFuuMUaSu8sjkPV5hjsvFW85eickmkDlzq49hYmSEqD3ddm2UZJ3ZSEYU/LNXlLSVoWad9QtYE4tkFfCZVVtU=
X-Received: by 2002:a2e:1309:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2fb32729553mr44948811fa.17.1728979630968; Tue, 15 Oct 2024
 01:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-10-ignat@cloudflare.com> <20241014214236.99604-1-kuniyu@amazon.com>
In-Reply-To: <20241014214236.99604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:06:59 +0200
Message-ID: <CANn89iJiic+opREJ3Q1nC6orXhJkSgAtSssOJeKip4ADYEsWPw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 9/9] Revert "net: do not leave a dangling sk
 pointer, when socket creation fails"
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:42=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:08 +0100
> > This reverts commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2.
> >
> > inet/inet6->create() implementations have been fixed to explicitly NULL=
 the
> > allocated sk object on error.
> >
> > A warning was put in place to make sure any future changes will not lea=
ve
> > a dangling pointer in pf->create() implementations.
> >
> > So this code is now redundant.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
