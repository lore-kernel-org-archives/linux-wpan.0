Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B901AC420
	for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979464; cv=none; b=b+9i4QOGe8hxd622mypf1U0U+OjFlVuEU7DMhznapFi3AUiTiev4X0aK1AhHG9+SxgbrfB20lqSUxCFynBW6prGT1bufzrRpf81ianYIo9//2gdVKv27fXEyjxUhNLrNU49ClQNeqGZU/UNa9XCfm9AfZpc749ZhJrovr3Ybuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979464; c=relaxed/simple;
	bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSISC6D+oolz6LBOB04Yeycn9OzM+QihIwXkVRDeeFk0Si54L8qZ5Ts9RcuKLSczTW5mi2WvCRQPtyElDL2vKLCsH8RHWzrZVxE8MCEGNfe5MP5FnBarjrjUSTbGbQXeMQ8p4KhtSrCvxlAWtxfj9XBLZN+kJz9HIkK17Ph+olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnQu98/6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnQu98/6"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so9651260a12.0
        for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979461; x=1729584261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=hnQu98/6K8SfIZ+dZFCoVE4e3xhktR+KfmU5DsMYkyCurs6E//JqSiMA2A789KPzpe
         BG7ka08xP3QYQ4vgIhQNXCzJr+93S2xq9YTll6CfXlktnSbaKnQNn2pFS+nWPyk6k3hG
         Em65NimtywSQ34dbgDVQ/hYVA8K7ugXXPtSboyZyt/qEOQJposkJO5qAAq+4ADq0t7aD
         38EXzUyZEW+4D+SlhNZ5RrnaUzx9JZfl2sV2sHwRK469n8kHWM5TNydQi/z47zkysnI9
         jBea0/FDWp/BL0wVA1b+4b7Yl3pE14YOBqUFiCUKOgYJrjZ7EWJPvaexBhq+diT69fKt
         7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979461; x=1729584261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=pCZ+q5fr7etPTRuxkl0sOnR2fHvct+hMbR0oOh/vlnVYqNnB+F58ya3uSdYHnFJoOG
         FoF1nikpk2+hSaROVj3YU/93DbeRSQer5CB7LzwMvmEuve47K2bQcTggSba4VFVtLBfe
         HHV7emLYOJGwAfP+lCmvQzXt+7xMpyBUDw+rqVR8rsSEZNMrK+DBEGg4sKfXc5g0RgVP
         YQssL1uJShy5OkArM5psn06042CCkV7Id6v5BvP+ZkBQiroFxFJUFPgC2QB4MOug1vmr
         KIlGgCdx0YF4fge+XeL4VkrlcW0V9+edNYT4DHqJRyRTtcyguTGxJ+m+9qii5U+dv+us
         2auQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPs6S3ZMVYw1iWNrqXNX9oUZOTccrfsOurwbnr93seQbLspEb9NIQem9JsLBjOQtaBF0lEpsrNpd+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4sfc04YtGsl8wUTk5wR+gt/jjehlK+5YYQuQnEy7/E4BfQKv/
	AhWupVNoYkr2F97EMHvu9e2cDTZKZfyW1esExxa7kC/Hv0hljJmxvH8+sZX+SXurUZ3JCkonlpj
	xFWR6XAX58NyarHVfEB8parSr0+Y/LsnU85a+
X-Google-Smtp-Source: AGHT+IFVLMYXDjozz3EMts1UX9Vb6aOFr9R871a4tPL9AtIGRY0LFuArOfvBuHL22PThUNhjYOA3RaMjZm6fTzoit6o=
X-Received: by 2002:a05:6402:1ed0:b0:5c9:87a3:628f with SMTP id
 4fb4d7f45d1cf-5c987a3637dmr2709862a12.10.1728979461246; Tue, 15 Oct 2024
 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-4-ignat@cloudflare.com> <20241014212956.98604-1-kuniyu@amazon.com>
In-Reply-To: <20241014212956.98604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:04:10 +0200
Message-ID: <CANn89iL7tdEr6_gpQCsLncNW4d2NonTVR0pTgxY4-O556ZQiJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling
 sk pointer in rfcomm_sock_alloc()
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

On Mon, Oct 14, 2024 at 11:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:02 +0100
> > bt_sock_alloc() attaches allocated sk object to the provided sock objec=
t.
> > If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
> > dangling pointer in the sock object, which may cause use-after-free.
> >
> > Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
