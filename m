Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FB6AB7
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJC/K21K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xoVNAc3uN7zDhUP5/XuZ9lvsG13QS+0NjaofDIv+A=;
	b=fJC/K21K5gUow8YKpi9gUPvNw35TSo9zTpZx9924J8d22bgE+isLvCHfNLMh00sP9d+aRc
	kTGg4EvuL8TfULSvBzUshdnwll7MZkRTmeWK8UX648AnrD+flzSVaVVeb+vnTsx14XHV6T
	hSSsXO+8FnMqO95abEbfp1CYNgjWlao=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-N3l4h4hXMjaw__fsIiHuUg-1; Thu, 14 Dec 2023 22:17:29 -0500
X-MC-Unique: N3l4h4hXMjaw__fsIiHuUg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55223c5b428so83395a12.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610248; x=1703215048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5xoVNAc3uN7zDhUP5/XuZ9lvsG13QS+0NjaofDIv+A=;
        b=po5eH5ReAt7pqdYU7Ihqc/ynMk32/v8eDVFA9l7tnZ4ElXo3ABSkAFjL4XST/+Jz+P
         2V4ec/r85FssTh57dXDNFre92krZ2dyBtnChoZC9qfhU5f/4rMipg+XnFQMcuphc19LT
         cKn4loQFIB/Z+JdSjvkgOe1vlyje5drQm2QQZefh59kmDSVcG+81mm9tNuqnztUACrij
         EVVBkz9hla+Y/M4AsuoOd2aamQU1dFrIrImG+J0rqPKoqClBeGkSnVP8BNW2CSmIshXA
         z9Snzk6qpW+jEl2s8BbU54R6vaOY37zPGeEWMttTZOU5fVjtXMuGZ/GP7KwVSDlVgtwu
         VLSg==
X-Gm-Message-State: AOJu0YxUZSflQyLKqAtwQICXeXtzVbP7EKQ/dZigu+cYovkr/xG3M1yJ
	0GtIguQE/rOoPENKQmKVpbIRDFFOc8y2EyTi49UE4j9fW6j422Uc9RaqMaY2c+FpZwF6PSiLw+g
	NGrFTbjpWUFOMCsBt5eN27vK8keeKwuoho6OPNA==
X-Received: by 2002:a05:6402:2051:b0:54c:5f17:1163 with SMTP id bc17-20020a056402205100b0054c5f171163mr5362520edb.58.1702610248404;
        Thu, 14 Dec 2023 19:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYodYhdQRjwTPKLzEFZ/TKE0p3OPU7KHSXvbX5fsSIF4Lkasnl2mVXc2fCW1tS1Gcpf2YF5YJ462UZHLzptwE=
X-Received: by 2002:a05:6402:2051:b0:54c:5f17:1163 with SMTP id
 bc17-20020a056402205100b0054c5f171163mr5362509edb.58.1702610248119; Thu, 14
 Dec 2023 19:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-4-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-4-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:17:17 -0500
Message-ID: <CAK-6q+jThrZJBK4qRknODnNoaPMxrDp2rwWETi2SJV=Di1VQGw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 3/5] mac802154: Only allow PAN controllers to
 process association requests
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
> It is not very clear in the specification whether simple coordinators
> are allowed or not to answer to association requests themselves. As
> there is no synchronization mechanism, it is probably best to rely on
> the relay feature of these coordinators and avoid processing them in
> this case.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

