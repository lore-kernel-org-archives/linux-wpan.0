Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6917E016
	for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979523; cv=none; b=EwKAXsNVCWMyASZxsYxC8imDXajBZD3YZKDGu0WutVPUmDQnHNjObSq18W2no6AO9nnfoAAqZONOZGG+SxKLOnHcU94eTNdEyZvseds60ZbIkw7znKWTk4kcjzjwvPkiSfFFFNWDEnf8LLvCnNx3QdHqgeny6uX99DDbI/qJ1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979523; c=relaxed/simple;
	bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsJpEzvLNeQLk6KMnJ99Ng0qUe9o94McnpNce7CMXi5lcn14i/Bvx1Vqypzh0CDGiCl9PuWdiXboGqBLmY+Zk5gOmj2C+FOO+umhzkylaCO4+eum5PQS9NR9pQmAYIp3ujbsQG57unB6H8Fh+sUG4valcwGfI2e+gMXeJ2/nEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhVzr2A9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhVzr2A9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9625cfe4dso4218151a12.0
        for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979520; x=1729584320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=LhVzr2A9It71YnFnO/lZTidFk5WmLGfHKa4KH/Ckgl3F++ctFCTb04TTOyBQooxVsL
         yEwCPtDz0BtWiOfKPce9a7rP38owkGvBKdmgu5uQ+/qDMGHHA9PIB1K1/X2a57xdv55B
         F3RiCmCfh6Sw79XVNWcr7hm1WE7KouHTQFEG3hWHBldemauacOtwefwkOc/lvK5C5JRz
         F/jmHWBVifdgVP1gqVSUBGDV55c6WkdvuMP6exX5fVNtUyjjL/pRz5xLpRKsQ5HO7BnI
         wvwy0CzhApmAGpc9Y4YRo/r+CvWp1FcdT2fMV2yFu04QyoD9tcfzK7FBB1WRZ3S7+6Zi
         DjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979520; x=1729584320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=BxY/yOtXgVJnbckqrbK0UwjVuUZvVx4P2vMWjaDsUemP0WFI5AyljF+/b31vIKWxO0
         Y8bMyhwtXX2kY6DdFlzTBUJ9fstGyihDVUzkjhR+xVUGIfbR6f1riFv9AILoq9cu6eX8
         vyCs07fyYJT7IROUPJYrVYNX+yd/VtKpZlN02w6VYci70Ot/CPxsZYuqHI6UxUXf3QvW
         J0QjTPfQWF2ZISjaIltBbyBDfxeslAWqsfHzn0V1CiFe4tgRdPyfiLOWB6GWF97+bL2a
         GEdqVYUOk5rBX6jL8TpXkhctJGbGWutKGx0SJX0V8ZdBib1n5oPZztSuFac285kaj9Nl
         kyPw==
X-Forwarded-Encrypted: i=1; AJvYcCWxfVUwv7V0J/+77wMKebtod4/cqi7eihYeXDFOa96fH/WuKO0gc/q65i3gNaf03xvxr5B18g3MW9ha@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfKz2q9I6dxLM8J65XM+e3eqvyP3dnv45eQnagRaZrjToSk9b
	FtqA5M6MHwgPgHJclySRnhg1/9vwGZcX0ZkS/WsZjszcHmt7aibBmLSC/OqpGsvG8RdWz1L016I
	z+pp4FAyRM13QTEL2KKBM9wLMqkkOioZ3Eftk
X-Google-Smtp-Source: AGHT+IGhXaZt34jHqjOXUdH0Zm4cm5o6e/qM4AoXLZ89WM8Mb4hUFPFZtihXBdV2SHb1Q6OTW0ryALy+WWGkbtzvcNY=
X-Received: by 2002:a05:6402:1e93:b0:5c9:845f:25fd with SMTP id
 4fb4d7f45d1cf-5c9845f2752mr3195903a12.23.1728979520189; Tue, 15 Oct 2024
 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-6-ignat@cloudflare.com> <20241014213503.99078-1-kuniyu@amazon.com>
In-Reply-To: <20241014213503.99078-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:09 +0200
Message-ID: <CANn89iJ49HQGuZikfz_56jUpdUDHfO_1QPGSrnN_OA6PxZdK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling
 sk pointer in ieee802154_create()
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

On Mon, Oct 14, 2024 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:04 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If ieee802154_create() fails later, the allocated sk object is
> > freed, but the dangling pointer remains in the provided sock object, wh=
ich
> > may allow use-after-free.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
