Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E81AE005
	for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979293; cv=none; b=brArDr9OvfjlnaM//9pXSKuHu8GIG61XEoRbRXJwmcJWWwa773U9dp+IBfBZKwFmUbaTyqTVFMzU2ECpry6dCqj3xCmtKECubSiUbrfyZcRiQ9Un92ab0QAPgFsmuoypQIfQBi8fdl8Trm5OrDCq7s6iaiHxpgFNUxTzbA4Jvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979293; c=relaxed/simple;
	bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0WwuS4BjXK6sEieiq+aQPAtI3Z8WUsHNZv42v7kUg3XLOqY/2AUFpvkxpmuLRqHc6Yg6T3JF2zGMRWplraqILnnA4X4vdf8Rch90VQKIi7Yk640Co4Ab1xdau2khVEeaRZ7Sr0FXjD2+b3sBXS2ALu7c+MLdH4tnmWo+neips0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24ONfwvG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24ONfwvG"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so13112411fa.2
        for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979290; x=1729584090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=24ONfwvGusBgTukIUqDsH3q9nrDCulnhtj6nXAVVSHCv/aM4/+1jMA9V6o7SYNCcqe
         Tk9Wnm6PU76DlL7fo6ZXpYnsjofjEMoAI70ZHho5TQSXUulvJfYj+nRCim57D4p0Yc/5
         Tl/xf+J5G5LwvhVuuoMGKrapftuEuZnYXQrhewzHWAoY0M/uFGbilBpJamYESYRJtShe
         QsujcChyFdiwBq9uLUfWnX9JNKdzxVUwCKT5Dn348ttEkcnpaF8NzE3RhLBHwNYqdpw/
         pBWDfOWoIorjxkCQ/qO4phrDc+v4iy8LkanmWU9MpHD9yMTJahdD2fTvb7GH2kRtK9hc
         MQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979290; x=1729584090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=UAZMPdx2N+RsfwTHG/FzxWLEQViUC3YvdKI5Nek0HQd2+dPXzZwRGvNKZQLut8de1k
         r7+ZPLQPUj69roakGsJx+QZaYLsSq9k29vL2EHXODvGRCB33zQ7UBivayVrmBaCcCF7i
         8+sfd3SvufLpZFN5fCM4jZYIdFiFRZOrlqaoe99W/IVFW9BDOTj+IcVnoQGdpLVdOh5k
         V4qCcHA0J9a/7wVfxjOKtoZOcnvYkARUtAT2G3EUhGMbCW0XvUUaSgfEB3uF9YQ9kLHf
         DNZafKYXhtHueNHAAdWseHvFePBnGJ6KHhxjy+LmnIXIAecleITuJ7xL5kQk9WTreKh1
         59BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSFCXOpTKTPejGBmnejgs5GtRIy+Iv2F3ZEtU3FRIEDqsboJ+2IQp2TLPygRama9xVslqyF7lu8Tsb@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMfxhkfEuHwYb2B53m+YLpSm0bhBglDSXpURiXO13RX3DfQuy
	4vtJd0dOjYwmdH7QoyqGlT2MwUy2Jm5Botuds9+BiQfaAp0fcbOd4fZH6NmT4MIkA+rA0SejpII
	2hLNuTbH9bREjgqHWVlepL1k+6TquQ3xay47S
X-Google-Smtp-Source: AGHT+IHxfKaPProiszu4hPKA2JsWyWKW8QC7WkdMfm3qCN+vO+7OHhDa8OoE6YIicZSOeQRLIab3tjlWn0zyThhZ2QU=
X-Received: by 2002:a05:651c:2120:b0:2fb:5d8a:4cd3 with SMTP id
 38308e7fff4ca-2fb5d8a4f7cmr6486501fa.0.1728979289048; Tue, 15 Oct 2024
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-1-ignat@cloudflare.com> <20241014153808.51894-2-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:01:17 +0200
Message-ID: <CANn89iJ0i+k_wHn-aoafY1V+mJ8TAS1DzQKnu1KkjusAWLNuyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:38=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> After sock_init_data() the allocated sk object is attached to the provide=
d
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
