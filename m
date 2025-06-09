Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034ECEAC7
	for <linux-wpan@vger.kernel.org>; Mon,  9 Jun 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749432870; cv=none; b=lh181XcE5BlIeCva4TtNIWE+hOmP62Upa6iun4FUzWS25YVaPFMa4kSAs7xuRAu/loyeNpRfkutyC6/58Qiy8/tSHqS4iNv/zw36uRVGSGkhycTGc/AWv3KbHYIFOfV21wA98fWdU2fvBp7mSNivnJnIaVXIvHmJQOMxFV7AHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749432870; c=relaxed/simple;
	bh=xTdHJZd2Xwctjcehy1yhu09ha3blTAVii5lobiEHbWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyLsf/uQ83duE4A8Q3saG6Qh7YX8b6WjWYaPIAqY0wwwlri4x/lsuVUqaAuZEjBe5fpHOhjWVxpty9HVlhnetw0atvmZPixohT1g1AHWwfve3xxakFLUgJwyaScbPr9uP433rO80vGki62dh4UPUQhjZPhtd7BiaeWvrzZqZgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0RFfbAj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0RFfbAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749432867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIXozl9i22f1l5b4YXx/XsCGXqFA1sz1MPal6Mu+QO4=;
	b=F0RFfbAjdaZdWvBKfjjvOukfrkXTDinuC1uxQfuzjJ2ImH1DoSBFLaftrZMa2Go8GJpFcc
	VkWKmDw2zokMbRlaeG6F/3YxULeMGsHr4AJHwWN170tPNXeGl608WvMnLcp/yPTBPaLUIX
	7g9Gw8BeE2hlmUlasTkMwA5teo389RE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--K-kzZq3NnuPIQeWAkv8EQ-1; Sun, 08 Jun 2025 21:34:26 -0400
X-MC-Unique: -K-kzZq3NnuPIQeWAkv8EQ-1
X-Mimecast-MFC-AGG-ID: -K-kzZq3NnuPIQeWAkv8EQ_1749432864
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-55338ad830bso1558506e87.0
        for <linux-wpan@vger.kernel.org>; Sun, 08 Jun 2025 18:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749432864; x=1750037664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIXozl9i22f1l5b4YXx/XsCGXqFA1sz1MPal6Mu+QO4=;
        b=GjemX0Ei1wIKiXmt6IDLF1362hbBJ3E82AbTqLnvoIu0Twg1j/a4gfwGs2HJf/dOJD
         gi+9TGF4LMe5kzbvOVHZThfqAsLcPIFT/jfNdWVHLSF3fZxsx/IxBBw9zOR66PQBcyVz
         rZanonJKwjPgU4br86H4iaRDpJtgti2NdHy2UG4Op3spBULq09g0i6DL5chnSjP0TSDN
         KvYjtqkWdlg82AfPGQCygyeCcii2PQ/GGXUKL3cIbVnCJV9o5FtC7dDoH5vsRZopkanj
         1arojclk5E+xz0LDK5yYnseYeq/e+qVo9PiOytMbz56SSzUXmOq5FeHV2zQYCyA/oXr8
         HXWg==
X-Forwarded-Encrypted: i=1; AJvYcCUto6Ba4pgSVYCq0DneU2pfRHWm/VWmHA6MzGK9ThEOzF5B11DWTVFcwTQLQvFM//fa4vU2Y3Pqb5Mb@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlNpxYctWe2Bm5XAlbcP6NFRuDGWbWhFEwv8zkPb9uwiOLgxO
	v+y/KrksG4XE3Dd6kmn84pbofWzG87qybn+XuG1VBl6lKxzZKQe5PloSKzvYEOASkWWCwKiTGFH
	/RDd4N+1HdgMF0GnKowdyk9NEGHos9WZtEK/GORLTVhAkeNVOPxcrmmOogpdzge/2Y8MGySRib5
	02iOdERviqqv7gnO50QCnxbPHv3lMPcGxMup/Rag==
X-Gm-Gg: ASbGncsypDqGqGN43TtFST9Ai9LoTHsiBk021ABYfJHsFJk0971CP8ScZnw0EF8TYuQ
	8FEYBL3Ohcs+k3CG81Nuw9krh9M8Kcs4t6ZIAOOEhWYJBthw5xRlUqFcMyegTGpCTrDWJNqTwOZ
	GXxYmxevFGFSxfuYkIP1QkvxIX9eEk/1Op92F+ZQ==
X-Received: by 2002:a05:651c:1a0a:b0:32a:9a0b:4697 with SMTP id 38308e7fff4ca-32adfb4a3aemr30083101fa.21.1749432864365;
        Sun, 08 Jun 2025 18:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5pTuxyNyzvC9lrWI0UvhIiyp0TcZueIavNYcRIZ+PjdvK2gwjGIBMYUxKqZFqZoEFcvuZUb06180+AYR6W80=
X-Received: by 2002:a05:651c:1a0a:b0:32a:9a0b:4697 with SMTP id
 38308e7fff4ca-32adfb4a3aemr30082981fa.21.1749432863938; Sun, 08 Jun 2025
 18:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608164724.6710-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250608164724.6710-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 21:34:12 -0400
X-Gm-Features: AX0GCFtx4f9miKgxpJ6-L9HGx8wJe5tmQHbP_mngKaZoGAgnWWQgfuWjkCKB9vs
Message-ID: <CAK-6q+i+Feb9+_S_yF9h1+bezyfkCh-qrNXcQjsiXjrLHnwLmg@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:47=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> Add a module parameter `radios` to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter `radios`
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
> index 1cab20b5a..8fcf8a549 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, uint, 0444);
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

%u ?

- Alex

