Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1B79CC
	for <linux-wpan@vger.kernel.org>; Sat, 14 Sep 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273854; cv=none; b=hnjmydtwDdHVQwVAZbq43xxqo9LVPSy2QBMfpVWCYIIB25pqdEuf0lZFKNM4Fodmgg7aRUTwewUCZgkxWUf5Gk9EuNpTOh7t4+XbUYMOoawEo0bz36XqEO6wQdl+o2zKsueILn9h4Du4sRRgUfF0KB98DBWMBK802ZXGpaTpS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273854; c=relaxed/simple;
	bh=k4YAmmg1pQMjIUxIATwur13dEEfIgBafdOXmFWCqspc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2BcHXygCGDHlvcCEtdhM79yrV2Eo0+SX+2DATg2n3QBRkaS+0TiFbViFlmED9ko3e0jSV2wr+TllEvOQtUdQ9K+1A1dbcRVTW89AMsh9wwh3eXRtnSVDyVVpKAS/ZxZJCZ0e9InytsIdS8vAmlG6fjg45pyl4xC+mwDov10WLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DX3f8gmJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX3f8gmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726273851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHu0E3915VZc7k8b5iDDKfSwz7c23iq2LTgz4JKa4RA=;
	b=DX3f8gmJKUTuHsMaRx2dyspiv1vVyV5+FjPuDYe9CHFJiLcSgZMLr8rz8PE0Nza7w4bK1O
	pIXep8QkUmJMML6r3gGX01P8U4xG6x80zhWoP2+IwpIDGerujOKGv61UjfVcsB/FKW4KOn
	/oE2XEo14J6kbf/eYYTcPOo8gVqzIdU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-4JRBRgzJOQWqYVWxMKMuBA-1; Fri, 13 Sep 2024 20:30:49 -0400
X-MC-Unique: 4JRBRgzJOQWqYVWxMKMuBA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f75b13c2c5so20922471fa.1
        for <linux-wpan@vger.kernel.org>; Fri, 13 Sep 2024 17:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273848; x=1726878648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHu0E3915VZc7k8b5iDDKfSwz7c23iq2LTgz4JKa4RA=;
        b=eqZT9II6UCuG4qd901Hw/aGrw9in7Tsz7j7Cs6upbRW0qO6iFengGNj9s6OzFfXqN2
         v9HDgVdGTSPHcGu9V2HJVk3R8j9bbqu/Kom7s+pTF/kHYoxtUe7fkxaUav7rdIawRhIX
         uNSz892Ny3oMNkmE2JTyFVVNPyY/8zPQCO014Pvqz23dEskqfCaFyR9BH8aNFEsXzwPf
         jUPWcETdPFrznSniloyR2XO3fqyRq6JzUhVXkK2lz4uRPbBwWWKcZrVY750cDXO2DMfa
         0L3FAWATIoKB7MHj4Qdy3SkxKrM31FF+InJE9+o4PdbYNgAR58UPEZ82+JhyCdswAIJr
         GL8g==
X-Forwarded-Encrypted: i=1; AJvYcCU6LGIg5ublhToE9IckbAXEa3BRtFAqz6zsBx0QmJPhAOQ63V0wL0E4BNE4SIW7aGHuP6GIijtZ9yM/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxetjq4Dhb4UaiIuN4HMPXrM0FBc8QoFEI1hhJfyAQ7LzkYKkOd
	fHyKO38XYmEPKHGGTXbyJriq9QTDsJL7I9FZYlRsUweTSyl9RNr4Ap4v4DcnesiISWGb3HpG0tv
	uy9zUeYLP1wqCGNrAn+tWynd10WT5gvqexeTJxrH+61YiT8aaXsU2ZBI2fce+WivRwG0UQhRYdT
	FtrbBQilGzehdMagYg6rKsr7/JzSlQQh6bmXJeaK4jWs2xUGs=
X-Received: by 2002:a2e:b889:0:b0:2f3:fa99:4bab with SMTP id 38308e7fff4ca-2f787dbf520mr55371561fa.15.1726273847553;
        Fri, 13 Sep 2024 17:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR74E2TdnCv2Af7MA6B76Q46yZZuM8g/cRXAOgZ55E7BaLNzyFNnXvzQQrLT6b187xSpL2EOAqZr5VJR898kE=
X-Received: by 2002:a2e:b889:0:b0:2f3:fa99:4bab with SMTP id
 38308e7fff4ca-2f787dbf520mr55371341fa.15.1726273846960; Fri, 13 Sep 2024
 17:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A99422D6-46AE-42D1-852D-85D3EC3AFD53@dgtlrift.com>
 <CAK-6q+jqJ=xaLH_G08hU0qNVXqoeqaA+_u20s4H+aiqt_70sFg@mail.gmail.com> <96117fb8-0f2c-4bd4-ae0e-6e4b3034a7c9@datenfreihafen.org>
In-Reply-To: <96117fb8-0f2c-4bd4-ae0e-6e4b3034a7c9@datenfreihafen.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 13 Sep 2024 20:30:35 -0400
Message-ID: <CAK-6q+izp6ykY4XT0MjYzzVXvj6-QknP5aNEDPR8ex=Ret9+5g@mail.gmail.com>
Subject: Re: 802.15.4-2020 PHR field changes
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: James Hanley <jhanley@dgtlrift.com>, linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 13, 2024 at 3:53=E2=80=AFPM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello,
>
> On 9/13/24 12:59 AM, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Sep 9, 2024 at 8:19=E2=80=AFPM James Hanley <jhanley@dgtlrift.c=
om> wrote:
> >>
> >> Has there been any effort to understand the changes needed to include/=
net/ieee802154.h and associated files within drivers/net/ieee802154 to supp=
ort the ratification of 15.4-2020?  One prime example is the "Extended PHR"=
 bit which was previously reserved to now allow extend the PHR of 2 more oc=
tets giving bits 8-11 to be used for "Frame Length MSB" and bits 12-15 mark=
ed as "Reserved" - this in combination of the legacy PHR bits 0-6 labeled a=
s "Frame Length LSB" now allows for a frame MTU of 2048 octets.
> >>
> >> The 802.15.4-2020 is available individually free of charge through the=
 IEEE website through the IEEE Get Program. https://ieeexplore.ieee.org/doc=
ument/9144691
> >>
> >> Is there a way to prototype these new changes to the spec with the mac=
802154_hwsim driver?
> >>
> >
> > mac802154_hwsim driver uses mac802154 the SoftMAC implementation.
> > There are quite more changes necessary as the whole mac802154 stack
> > deals with static 127 bytes MTU defines, etc. Unfortunately, it isn't
> > just a driver change.
>
> I understand it the way that James actually wanted to try prototyping
> stack changes and verify with hwsim. James, could you clarify?
>

Why shouldn't this be possible? Of course it should and I would
definitely want to see it when adding any support for that for the
rest that's being involved. The "rest" is probably most of the work.

> To answer your question, we currently have no support for any of the
> newer 802154 specs. :/ Bigger MTU was brought up before (IIRC in the
> subGHz context) but nobody started to actually work on it.
>
> We are happy to take changes in, but currently we have no plans on our
> side to get this going.
>

yea, just send patches. I am open to starting with hwsim to support
kind of such a "bigger mtu" phy "type" as long it doesn't break the
kernel and finding the spots that need to be somehow changed.

- Alex

