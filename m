Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA603594C
	for <linux-wpan@vger.kernel.org>; Sat,  7 Jun 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749317674; cv=none; b=YVelpng4YvTOAAfr+SO4dT8lW1KS8+KJxNXrQeuKTyUw4pQhjWJbtzR0OlGakhIIfapJ8AAtolJsTJ+LZwYuLkNiMToKv80KFKrxW+LNUsWxYr3oybhfJlq6bDhwSa+XUl8Z8xwBgjKeHCoIhmlkOYwQRznv/XCZUqN2tA28SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749317674; c=relaxed/simple;
	bh=Khy63nd1RGiALdVp3OZyYI1Xjdnf94tL0g0gM86xV24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Scx+oDwt96YwCVvUPzZvLLWVPVUKenzQY3Ewt239yjU5QpcdV5EhQpGpW9hiETW9YoygKlRguEDOgs/UWqJdmlsuZxCjFTyA/oWxTOIMTzYLkpstUw5TOK5PTK9fe2GfEDbSP0b8oPhabmLjAaeAnKfl2ktBPGC/xZy48YG2JRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+64PQlc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+64PQlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749317671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnUegQI509/idcGeE7W1jddXf341qwR1ZMf5fTzdFVA=;
	b=i+64PQlcFvCjg6CSSRfS2TKuagEYAAWYQhW6KUoRvSrfaysgcIEaJPcGZhkUUmS/R0N4FW
	F++skXGFDbcqPvNk+8dnn0TeM5ARaZAhsufB75Q4X2AazablQDhzLcxBBpp3eM1UerjN1C
	a2nej9rRqL6Zj9egZjB0QiOsu1CPqCc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-SmaB08qmMLSreO6w-pB3BQ-1; Sat, 07 Jun 2025 13:34:30 -0400
X-MC-Unique: SmaB08qmMLSreO6w-pB3BQ-1
X-Mimecast-MFC-AGG-ID: SmaB08qmMLSreO6w-pB3BQ_1749317669
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32a7009e242so13972961fa.0
        for <linux-wpan@vger.kernel.org>; Sat, 07 Jun 2025 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749317668; x=1749922468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnUegQI509/idcGeE7W1jddXf341qwR1ZMf5fTzdFVA=;
        b=i0bEqrKFf/mhXY1ucfxV78OZ8PzH3dqHXwbneKDDIUO66W+n7liSsrmt1P8bTgIeAL
         Dl4e+yR8NOEhJiCPE7SL2K9wiKmwhm1vlJItwUY8pAMY4BmbbeDb+c6ozYo8EtYCr0MX
         nwU13FbhCphmWZVO94wf2kqogBrlLRyOCexC/shou9bzGgeQgYklvx4zvDHMzTGgLi0J
         osIy19lE5yP8WPXjCY8BtDuRjhwO2yqadA6gvEOiBR0e6M2CF2zN9OrlSvCElAuk9tkQ
         3PpmEs3zWD0119ZGHeNieYeLUcLru5br7DZMheXLULiE9vLkVRw544d82QNdwvBM1wCp
         NrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/H1N7s/k6+4akVGMNHiprhILS5hgfEkraEyt5IE1HNv5qr2m10sy/W+MYHBmY8cXotUbT/R7b2o+w@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLbJHYiYEXepFOlCNSSiw5vlD2RQEFyNsCBcVC0G/whNvHJju
	LVLpwl3BJnQIWxfIVoDjzRrhEzHiWOWA1XQnRK/nHYlC4yBhvhtKy7oOm9PUUTf0PZT4SfBFtZM
	64iitSKz+/8qgQYrLVFW6o9YIkJDrUKKexNlZE8IzQAz9v8AlDJ1jsakjhy5uUUv8gOfqDV4tJW
	jg9XFzkFvqEzsx1M7Cd3ZOBTcgKNzDmP4U7elH0Q==
X-Gm-Gg: ASbGncvyFQjcTddKEJDCpmNJ+KG1Y/DUOcbiTY4jp/MydlhfLK9eXr/lb0+HauS0hoo
	uaEddkNFSUWzIfix39JyqTd247O0epgryl6KX9TTnKZgCkr5yhb+xxteLOHNlws3QqhsoMxAi9i
	wdJHJJQJy5no6l9N4EsYQ/C5RwxGY=
X-Received: by 2002:a05:651c:a0b:b0:32a:82d7:6d58 with SMTP id 38308e7fff4ca-32adfb42ff9mr16779001fa.12.1749317668565;
        Sat, 07 Jun 2025 10:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtC3c93aA7ULuZgbCwIO/dGKD+fgOTRSOTT0EmvA3/tCTSJg/zgm8NZrjrYEwlOXupRC69VDK+VG5Uv3CJm7U=
X-Received: by 2002:a05:651c:a0b:b0:32a:82d7:6d58 with SMTP id
 38308e7fff4ca-32adfb42ff9mr16778921fa.12.1749317668128; Sat, 07 Jun 2025
 10:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250603183321.18151-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sat, 7 Jun 2025 13:34:16 -0400
X-Gm-Features: AX0GCFuAPUGHT9bEhzv0LiVRX1BItG95qelZs8iFBI33oWtprASD4D0WSvG0igw
Message-ID: <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 3, 2025 at 2:33=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> * Added a new module parameter radios
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>

no problem with this patch, just a note see below.

Acked-by: Alexander Aring <aahringo@redhat.com>

> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 2f7520454..dadae6247 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static int radios =3D 2;
> +module_param(radios, int, 0444);
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
>                 err =3D hwsim_add_one(NULL, &pdev->dev, true);
>                 if (err < 0)
>                         goto err_slave;
>         }
>
> -       dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n")=
;
> +       dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\n"=
, radios);
>         return 0;
>
>  err_slave:
> @@ -1057,6 +1061,9 @@ static __init int hwsim_init_module(void)
>  {
>         int rc;
>
> +       if (radios < 0)
> +               return -EINVAL;
> +

handle as unsigned then this check would not be necessary?

- Alex

