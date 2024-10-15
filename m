Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EA1BFDF4
	for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979913; cv=none; b=T7IhBvcIPoZc4sVOytRsG7WfSu8CDXxOY7IQ/Yj20kXB18T3Z28voNycBv9hV4YTXvOPFDVM5uDjzCTLY1CpqMhf26d4J1KUVGYCvX0xK6egXxlXQ1gKWrFFEyHR4PdcYTersdPYRz9s5I36ufSRqUXcTOaS/5fdikIA1Omc95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979913; c=relaxed/simple;
	bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ8D6HGWbigkqqKTZmhHyoLkGs+witgTKVG4bBAhsoaZuRVZcsjieyOPw8g5UbDLsm36wyscfm3B6ClpSmue/zzGjtUvW2zPXJ7zbmGNlX7g0ldkWk+P24f2fhNWkZaKqYTQzO/XKENWrrnASX+i2vF/ZqEeuJz1Iqth4FUue4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjeQi3FA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjeQi3FA"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so22414461fa.0
        for <linux-wpan@vger.kernel.org>; Tue, 15 Oct 2024 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979910; x=1729584710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
        b=gjeQi3FA1LPuIM9vKeLAPPz8FeCHW5chgYoutX887TPlfwBaFr6PFgE5Qh99SPunQO
         5e9noCgl4IDCfG6etdfnf1bF2tiUuiVqQr6LU9GV8uLJY3AWZBAGEqfu5ECzgtpn/idD
         YWPsSLKLMv3yVQDN9sPmrj50t/Y8RAFxZBHyX43/1sb0NdVLq5Y5YPgFmonh3usJaxGi
         ntUbcZtA7dFyqBNRT/2GWqGE1XCcxooSF6480H3b110sFgKLvviu8iAkTnwans0WM0XF
         qV++aCBee5vUGpL0NEtLmr0OTTS6IWwGx++DMe90KOoZcGgcI+/mA2CVl1iX32M5Z/5C
         NtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979910; x=1729584710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
        b=E7KZLi9iBWN5CRdO/stax5qe4myVFJR/iRO/X4Qw9di7gOvspzpg6d75zjUYtF8U68
         ZwruRCoYZYmhzQgVRYXrxcDudh/ItmOyHlZCrafl88zzebcTXaOGGrKezs+DL81WBEM6
         2o6m1IYJ+z0BfFKC27vqQjRw8Soe2bbH05CqxRveGOpoQo2Sr0hTHHwmJTLzVTqk+EcX
         y/rndpvXhRd3WQPXo6ymTdkp0h8o2Y83qTvLIOsiP05WslrExh4i/dr1uni3u7ADUnL5
         Yego3T88MnDMuJnVWnWWa3uiqDJFDGm+SzRDPBUbo3YM1T0W7CpdEtQyMU4QfoZALhOg
         E3kA==
X-Forwarded-Encrypted: i=1; AJvYcCUBzmqvk8VYXVTFKhtf7TDQzMOZtpAPbXcT0y7JsYgvQQhg7ZjqllPICCc6IW6ilRM6MXvYW6AzzO/3@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwSrCs1nfk6sgCCwY+t+BW+gcQVYVK6P07BmPh5XZ+JwXtz4I
	ds6CnP9GE7GNSwyEYVKqLEh93snoL2qskgxtCM29lPfN8mjcpgOFDCfEfOQrOf+EO6fjNd8ClWJ
	y+Zt7WFvm7ym1ShlLC1xeCVy8RlrprHFmPHss
X-Google-Smtp-Source: AGHT+IE7U1ZYMuHbOPDHIlOennm7tEkVNs4JgQdtOjRQ9FAo6Y4X7PA4zb2GEV3g2QArJvnXo+KXR6rAxY9lnX9/hZk=
X-Received: by 2002:a2e:be9c:0:b0:2fa:c5d9:105b with SMTP id
 38308e7fff4ca-2fb3f16fabcmr64166371fa.2.1728979909944; Tue, 15 Oct 2024
 01:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-8-ignat@cloudflare.com> <20241014213848.99389-1-kuniyu@amazon.com>
In-Reply-To: <20241014213848.99389-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:11:36 +0200
Message-ID: <CANn89iKhpjhwAqD9PXs2fw5PUDXejRz8S9VOn7Syubo1EQq9+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/9] net: inet6: do not leave a dangling sk
 pointer in inet6_create()
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

On Mon, Oct 14, 2024 at 11:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:06 +0100
> > sock_init_data() attaches the allocated sk pointer to the provided sock
> > object. If inet6_create() fails later, the sk object is released, but t=
he
> > sock object retains the dangling sk pointer, which may cause use-after-=
free
> > later.
> >
> > Clear the sock sk pointer on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
