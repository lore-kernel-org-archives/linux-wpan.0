Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802125672
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdcM1b+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU6XR3jlZFj9LBTMMxQsE/bFIXz44r7Zm39uegVLGgU=;
	b=PdcM1b+bauzCzdxg/R2KKrrW6qWs41jkW87ACYKxWLbbx9beyVpnyY9NKmI6c0/KHI0Su5
	y1ITQjq7NZFwaOyFzQbYVR4sWps4UN796UHhPkxrxcW9uxfvkW2bui83ZJYG2SjtiKw4RI
	ExFFfkROJHSnS8cvG7IXbTP8d6XhWGw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-_1hoSoGQOj6ML7ex2IAJfA-1; Thu, 14 Dec 2023 22:18:13 -0500
X-MC-Unique: _1hoSoGQOj6ML7ex2IAJfA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55262d6782bso1506448a12.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610292; x=1703215092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU6XR3jlZFj9LBTMMxQsE/bFIXz44r7Zm39uegVLGgU=;
        b=knGR8UyzOGqpNjVDsCUao0Zy/T08xzIwD8mE58nFXOWeARqF8SZ8g5FeWMtPHQJwJe
         tYWxtRBBxP+VUJfBi9nrWvqJbFr5IJ6u0lxYdFj9FBn7pJUBz7HJ6DrkSs2zb+NiVpkZ
         /IHjTowNhilpQhPHqVOSs8LdhHs6oNbUOfUqGXrWdwDm382Qy+Fpt3+bk/hq220Y/gNs
         sIzUY+kk6m9kcMjYBCylSWNsGBPgC/c0DX5LPkXD0qaVjuYGD9Wi/VxtekHmcNqexcVv
         WF+au8tGa/tW02wD1XUpBZSp5aQSjRbO5+UXKd7S+fk9RaOgjs76yhyHd/XyC5wMpE9a
         V2Hg==
X-Gm-Message-State: AOJu0YzzGwgNec9rgBK2Tm5+0+YlZVmc2Pucs/UnxpwHs9v/Pj1hET7A
	egPqaX9Kjo6xvc7rHMP1KHzsdIPjFpOVfFSUMyZNH0qk9zX0INj2+eCumz6OxingOeKNUbBDZs1
	tBHYosPWLoWPi4NQGreIOx9TovQLxSlxSpmx4Yg==
X-Received: by 2002:a05:6402:324:b0:54d:d0c5:4f53 with SMTP id q4-20020a056402032400b0054dd0c54f53mr12331616edw.11.1702610292113;
        Thu, 14 Dec 2023 19:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEwmS0vcN1VG7p2MzdbnRZT2VT7sNeOOxpCkPhbzjD+VkiECTLviq6iTxQSJAE2rXbfhZy7m96f3Y4Fer/J3c=
X-Received: by 2002:a05:6402:324:b0:54d:d0c5:4f53 with SMTP id
 q4-20020a056402032400b0054dd0c54f53mr12331612edw.11.1702610291991; Thu, 14
 Dec 2023 19:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-5-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-5-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:18:01 -0500
Message-ID: <CAK-6q+gd20PfRQdyLHHCdwqOsUMThm2_V6HW9VqUpzhisHdF4w@mail.gmail.com>
Subject: Re: [PATCH wpan-next 4/5] ieee802154: Avoid confusing changes after associating
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
> Once associated with any device, we are part of a PAN (with a specific
> PAN ID), and we are expected to be present on a particular
> channel. Let's avoid confusing other devices by preventing any PAN
> ID/channel change once associated.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

