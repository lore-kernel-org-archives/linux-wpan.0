Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14792226545
	for <linux-wpan@vger.kernel.org>; Mon,  9 Jun 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510272; cv=none; b=uzatB8/rcVV6vVPRktaMY1yebPPNQkyaxfE8izukIhlcmvQOGqGtR40tNrRFv9PRPSRxZAuCeFsCCYwtFDgZWHJG2CiFRxuGer8nrAgvqLXgtdMvU3d6iYf6pNi7n+HDzZ+v3McZU8Jvj9pv/TAkdnVRoFiq1tbdSf91Uxtq9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510272; c=relaxed/simple;
	bh=PcBDmqXyBhXKkjWPy1J7wSgj1WZqkZ+VKxDTSGH0MJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXShSDKS9xtj18WDdSmnrz3xIBX83JenytUfPnZ8Oqn5K7DzqK2FCHmA7yrSV5jMVn7q5ytZ/KnmaSEs8RKGWbwONeXUW8Bw080oP6MSXbVuOrrNWUKvMe9CVEk1CYgeTHji7ovn8F7dB6DaHwQBasJhnKYSrj+6rk4ZxEVLLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj9TfvTF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj9TfvTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749510267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMqPz5T5ms2+Vuv/P7AkLmCC+Jeyi+hIZycmP47qQCI=;
	b=Aj9TfvTF0R6LYeZPh4rqvAvSHkeNk67THl9t7gFSF5UeptUiFGkei5Wxtz41tLI9nDZE7V
	03NEsyykRzx2j4SZBJ04B58fKOfECBpsgHPh8w8N0LJgq+9rhb46BSrrP1HV9a5pz0s6uD
	a3bAPoggYOxUXwnBdo4Gpk+6cdBFRjI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-z21JTRTYN6m6QUhGVe9J0g-1; Mon, 09 Jun 2025 19:04:23 -0400
X-MC-Unique: z21JTRTYN6m6QUhGVe9J0g-1
X-Mimecast-MFC-AGG-ID: z21JTRTYN6m6QUhGVe9J0g_1749510260
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a9a0b495dso14789371fa.0
        for <linux-wpan@vger.kernel.org>; Mon, 09 Jun 2025 16:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749510260; x=1750115060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMqPz5T5ms2+Vuv/P7AkLmCC+Jeyi+hIZycmP47qQCI=;
        b=r8hYBMC2gl1mDMENqyq2TDECnXTrE7Nl5Q2VYLzte2ZvzAyqWPIZMKJ+TjUsvk1S1f
         UkjvgmZXdYgGe8OBx8z/YfUqMB1+JdI2ohF0xr+DVCOXc30oslSgxHtWw3jxVmD6HQ2F
         NvPuylFZ6tTH9+psmd4aTmZwWUaIDDKmqzA1vyksH1DHpPbt3iBEgVtSTjHK06Yl/3Ps
         c9rtde2n9YGpqCPqtopaMo0lUy9gmbJTPh9qdpZBsH5HK2Mj7OHig9oWcm/k3F4GqwjP
         0OboHqAQqKDD26AZlItlhdlnsqM626Wk8zYzqKvE2yf7fVuw5ff4l5qIDK/FOEY7P2ur
         6WnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKBEmN9H6wJHK6J4L55Wu3qPkD9q3FHZftCs3TEX8NWUJQF4H823qooin9vyWx4FWRJVPy5z5EOCei@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6sYMwKWYfwe9K3B4AjN/F+8h5hg2HfvtDUM7Ke0QP14vt2fX
	kjGvxffVVeEqHgDQ/13g5VRqsp6Xbs9E6AszsavGvk+fGQBAi07gNILobP4vbYGdN9UCGX/hsG4
	wbshHJQH6myhDdvs7bYQ6rW9/OsYlRMM8XGQVfJEFXGNnWdjE+lTGkftBjSnP8cBAPx5mmYsaGW
	oo4CTfwavo55VRMvZsVqz/0MyakqTC/iXjGwAb1g==
X-Gm-Gg: ASbGnctj7cfINABQkRakMe/ApDm9fta/NTLzEuvXQpKWmMywSNtQMQB4RPa60cn+/WS
	jz8eS7bVNlWrNU21MEePGfO6vA2n4KIevhcXr1siax6pN4zVUSfEkIUJ0u+KK3RhTjDgLNI1sPF
	EXLf2JLhNdOsL/QBA1XPipfq1qBapLYgaOwLCHbQ==
X-Received: by 2002:a2e:b892:0:b0:32a:778d:be86 with SMTP id 38308e7fff4ca-32adfe270f1mr37092621fa.31.1749510260231;
        Mon, 09 Jun 2025 16:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMfqTSlst8c6suWs1k0ndLs7U+aVZ5OFmK6rcE8gYx6tuiEl6hKJ7ceS8cdacI2w9LKaXptFQyHzlKjkLaOZE=
X-Received: by 2002:a2e:b892:0:b0:32a:778d:be86 with SMTP id
 38308e7fff4ca-32adfe270f1mr37092581fa.31.1749510259818; Mon, 09 Jun 2025
 16:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609094628.6929-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250609094628.6929-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 9 Jun 2025 19:04:08 -0400
X-Gm-Features: AX0GCFu1jQFWpnoMMyFRZstITGxwEgNzEuhvf1aY2fE4abY6GozoHKv5DIDedbE
Message-ID: <CAK-6q+g3ns4BvZhgtzH6a6gDrEGpPmpugQki86fmbKxgHi51Aw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 9, 2025 at 5:47=E2=80=AFAM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> Add a module parameter radios to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter radios
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>
> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..1740abe1a 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, int, 0444);

uint? I can swear I saw that in an earlier patch.

> +MODULE_PARM_DESC(radios, "Number of simulated radios");
> +
>  static LIST_HEAD(hwsim_phys);
>  static DEFINE_MUTEX(hwsim_phys_lock);
>
> @@ -1018,13 +1022,13 @@ static int hwsim_probe(struct platform_device *pd=
ev)
>         struct hwsim_phy *phy, *tmp;
>         int err, i;
>
> -       for (i =3D 0; i < 2; i++) {
> +       for (i =3D 0; i < radios; i++) {

The iterator needs to be unsigned now?

- Alex

