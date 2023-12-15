Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC817C1
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixYWv5gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSCdKl5IjfrWspr8I8Dc/FxsnqwF+3Y8862VXGQQBSk=;
	b=ixYWv5gnJqg67hPvmOBhde1+rz9XuvkYXVPO0p2hareRoug131wmgAMkGXPLtHV6GA6f8M
	6p4TnodlG+pEHiFETd4+W+ERhxrIV7aaYkBT1L6pOgEdwE7QNnGfkPQ6jWyJc6lNpg+q2T
	lj9AYLFTt6k0wvYJBJee+kzXkVX77mw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-sR6olYYDMqiaURlJkQzI9g-1; Thu, 14 Dec 2023 22:19:23 -0500
X-MC-Unique: sR6olYYDMqiaURlJkQzI9g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-551d89a8646so81584a12.3
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610362; x=1703215162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSCdKl5IjfrWspr8I8Dc/FxsnqwF+3Y8862VXGQQBSk=;
        b=p6B0SG3K39FIGl8cTVlID0ve1dllS6I2FGkkVaoL93oHihfMxQsIMtscvDYPHs4dE0
         qFU9JyyhtBlQR8k3Kuz/O0lym2FBa/5iCQEZSKcu7V2URBoMOcg3anE3287sYDiZPlod
         1xKeVQ/hUdSPRWsJ+nLSqB/NYXtmMFme6eDC7dV0dt/HDNCBoNaUdtmNIiUePQ81pXGg
         xdzm3efGqagyf9UszwDOICZdIcr4+H1Q4f58up/Amn/whWO+4eIGGi0DIBLTDf/fKAry
         w5qvmF3t17c0xtzZwK6Mx9OX0vOcVZ0WZ4rf6BgXaIbPZSlwu0u1Nm7FkNG2XePYlv1Y
         gopA==
X-Gm-Message-State: AOJu0Ywh/fn9hrb77Ae1n0aVoHksFE+wjHzZf+XlhzdYtKrqTHGdS5xY
	wFRHsSZ2unGk3r8iklrZz/lcoDh85BDrzJLRF7rvI5X6sLiqmOet0EOjg3/MWzGNiBrqmkcqcL6
	F8t0wX2Y0w/uY32GhqCotaxegt4iE5tjtCUO3mCjX+QRBQdRn
X-Received: by 2002:a50:875d:0:b0:551:bed4:b613 with SMTP id 29-20020a50875d000000b00551bed4b613mr2409563edv.81.1702610362309;
        Thu, 14 Dec 2023 19:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUOXBcBRgK59ieROrGIkoUvJVYo57oHH2Lr3hQ7e9ZqkF9uzeUoyJeDcaR+M2SerjjD0saWyDWdI/QtedqPk0=
X-Received: by 2002:a50:875d:0:b0:551:bed4:b613 with SMTP id
 29-20020a50875d000000b00551bed4b613mr2409546edv.81.1702610362027; Thu, 14 Dec
 2023 19:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-6-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-6-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:19:10 -0500
Message-ID: <CAK-6q+js4OH8HP-T5+U0yY-cH=XNHFJyRZOxc8sOLLR8fctxrw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 5/5] mac802154: Avoid new associations while disassociating
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> While disassociating from a PAN ourselves, let's set the maximum number
> of associations temporarily to zero to be sure no new device tries to
> associate with us.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

