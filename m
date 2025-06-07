Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCC2F3E;
	Sat,  7 Jun 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749318912; cv=none; b=e8esYlsuAhS/TNVfuNJJO+iHrR21oxw9jgyanHAAlcyI50sUnFm2i3JSmb/nNCUAAQEFkAMDlF6Nxht0lZpqFMUbFPmfYIySBqA6qfyUWJIU2sC2VMn8dISFKwl3957TXcQaCvP+cePaAIQCtsSAPNQgnFxhXUQNOn1xeeLmcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749318912; c=relaxed/simple;
	bh=307HdgAOrMYbzzPOyNAuyz0ylfM9pVYJY7j4erDl0j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVTPbiioYeFdWGerpUwhHoE4HnvYysUEI9Jv0Xvg5d9OpGEQ+88EBKoZ642MhShefqK+fOl2pU05hKIGlJQNapCiy2lWhoCjUyvdsJHE1asqV3Ph9rmPbdbiiqqVs1XFggKH+QDwPjeO1LkBSEQkD/yelWVt1BnRUQgb5XPtj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dylXtOPb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dylXtOPb"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5308b451df0so951415e0c.2;
        Sat, 07 Jun 2025 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749318908; x=1749923708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gthmldd6xbFCAiwMP/V+L9OKzYAKqlOR4CgfU1fikEs=;
        b=dylXtOPbplCPh7P3cb7lR8zNXjfUlafqW7RsqVHCflzyXi20dtNYEdLRMKtqavBiVf
         x7jPCncoOihIFtbhAzN8xbFBuYJ4xOJNHDCNJ9+TenkKETrfMDSK6cVWXe2MU3PjFA/j
         GvZcMPlRhgE5QXKeJjIdhJdzMTb029Nw3uN4gSwxzUMVA9OA3PYXFcTT+m6nBXAkEfRx
         6p4FZ9ZLBY77LRVLaE1A9W5lYaICIh7oYZo4XGmHhuxsk4TKAsDogWqvInGaX7dzHOsW
         Y6SyA3f6yfbBFFT9EdOffun5mVeBHxF2iDOUcphiKxelONzNqDlI0huzBnzIDov+h4Kp
         iryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749318908; x=1749923708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gthmldd6xbFCAiwMP/V+L9OKzYAKqlOR4CgfU1fikEs=;
        b=OBoEFNVEiIs4C8xA5xqypZR1P2cyfoz707LqevFJ7qAj1ikkZMBKUFeva2fGXUlTxi
         OVGim0BMhj/XlBkyspvCaUen0JQim5d6/UQuODNdByAOT/sgpHp+yB2Vh9sEFDMYlpHe
         3XYhBJdBHwXNIxntZ4BJJNeoM+1HAVshW09WKx7lC3D0uGgoZhY6Y5Dkpe748I+0vJHx
         zHWTO1wxD72cMBjGON0vqP87oVnEkBp9V6FkFHXny2J/Tjo07/mCPPNag3gfgRMQY6eA
         aBmDeLBxTawAuPZCAOsOOcmOGhxOpv8+7eyqhlxh2QjBDHgnf94uL2TKJbjf7W2/29DO
         HwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5zOhFAsnNkLBtqJZ5Ve9YE9dftkwaUqkCKN0wZQw4W9OpLJ3xxjWwbYIt3gJjC0OejH0HO/cs@vger.kernel.org, AJvYcCWwkEMWHESjgJ9wgN1jhCYbBR4Vibv5zLdFXf7qJmD3XJZOSiLmQ5le2bpvd403PHiAHAEa9bNiGs70@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBhKHlR4QUMV+319Yd/yNNp941eUdBAgCV560+T/900QdYSlW
	rgnOHVv8Rcd6VTdTLiPx/S+rcAv+PRQB0WMWV9klkVSki0WYg7yAkNP5Q1HWyijq2BIVDW9BNvA
	kAvG1HHhKvofIzhstbZlpqL9CqtuXj2c=
X-Gm-Gg: ASbGnctki5XIqywyKS+EuOMEO1ToqCTRijXFQ2iQLdPhhd619GV9YuvbrleeVHn+nnA
	wwD4cNOBEztzNQTWtv7MrWUi0NLssxRXm3E8tXGCs8wcnX5uMg7abXKOBMx2MmYRgFZqTufgDMt
	epBlxCIQs71JAhDXYHA0We7dTD6r0HMtijcsMyF3AblUemKExRqIp5Cg==
X-Google-Smtp-Source: AGHT+IFVRzUrVc9L0rzgaYBvxzafzM2OGWy7FDaOf3W8h7kv362Ja5hRqrC5kbwXCEPQRFTjMpC2EiM3WfZ8xG60k+Y=
X-Received: by 2002:a05:6122:787:b0:530:720b:abe9 with SMTP id
 71dfb90a1353d-530e4875aacmr6866391e0c.7.1749318908350; Sat, 07 Jun 2025
 10:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com> <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
In-Reply-To: <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Sat, 7 Jun 2025 14:54:57 -0300
X-Gm-Features: AX0GCFuRZgGcaGrOTBAK1AzSoHRj-8G__LsbyCDLtwKsNIh_-C4bkBSKiEi6ln8
Message-ID: <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> handle as unsigned then this check would not be necessary?

Yeah, it does make sense. However, I have a bit of an embarrassing
question. How do I submit an updated patch in this same thread? I
tried before but it didn=E2=80=99t work as expected. Should I send it manua=
lly
via email with the same subject, or is there a better way to do it
properly?

-
Ramon

Em s=C3=A1b., 7 de jun. de 2025 =C3=A0s 14:34, Alexander Aring
<aahringo@redhat.com> escreveu:
>
> Hi,
>
> On Tue, Jun 3, 2025 at 2:33=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmai=
l.com> wrote:
> >
> > * Added a new module parameter radios
> > * Modified the loop in hwsim_probe()
> > * Updated log message in hwsim_probe()
> >
>
> no problem with this patch, just a note see below.
>
> Acked-by: Alexander Aring <aahringo@redhat.com>
>
> > Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> > ---
> >  drivers/net/ieee802154/mac802154_hwsim.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/iee=
e802154/mac802154_hwsim.c
> > index 2f7520454..dadae6247 100644
> > --- a/drivers/net/ieee802154/mac802154_hwsim.c
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > @@ -27,6 +27,10 @@
> >  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for m=
ac802154");
> >  MODULE_LICENSE("GPL");
> >
> > +static int radios =3D 2;
> > +module_param(radios, int, 0444);
> > +MODULE_PARM_DESC(radios, "Number of simulated radios");
> > +
> >  static LIST_HEAD(hwsim_phys);
> >  static DEFINE_MUTEX(hwsim_phys_lock);
> >
> > @@ -1018,13 +1022,13 @@ static int hwsim_probe(struct platform_device *=
pdev)
> >         struct hwsim_phy *phy, *tmp;
> >         int err, i;
> >
> > -       for (i =3D 0; i < 2; i++) {
> > +       for (i =3D 0; i < radios; i++) {
> >                 err =3D hwsim_add_one(NULL, &pdev->dev, true);
> >                 if (err < 0)
> >                         goto err_slave;
> >         }
> >
> > -       dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n=
");
> > +       dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\=
n", radios);
> >         return 0;
> >
> >  err_slave:
> > @@ -1057,6 +1061,9 @@ static __init int hwsim_init_module(void)
> >  {
> >         int rc;
> >
> > +       if (radios < 0)
> > +               return -EINVAL;
> > +
>
> handle as unsigned then this check would not be necessary?
>
> - Alex
>
