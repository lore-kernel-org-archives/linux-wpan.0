Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE835663
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atD99iDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9uC6ryckwgkjdiCz+BBk3Y38k+wG6P2U1aM9PzOevk=;
	b=atD99iDKWc2+RETWgMeurEMhmR/4vXKgwp4lkYHuBzD+90YZU59vgCP4bFvviJ8aCz+XpE
	YIdqqsu/DH9eWbMkeILZ//L4hK4aZeog4fyvLVmfxyBOxJNaJ/5xcgmmnfvh9EiWBfC/7x
	v0EMLzeNozX4gc+Qduwm8t/JgU1np00=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-L2EPsej1NEmvgqoUkVSqQQ-1; Thu, 14 Dec 2023 22:05:35 -0500
X-MC-Unique: L2EPsej1NEmvgqoUkVSqQQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-552853497acso84119a12.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609533; x=1703214333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9uC6ryckwgkjdiCz+BBk3Y38k+wG6P2U1aM9PzOevk=;
        b=t7jDzXJXlT2Hun7F9eLIX44yHKSxSRjeo8Zc4vAh/MT51LB03TGmcLYpG/0iiwGK7o
         oDUPQHDnkDK5aLqvpkAInzAirPjQHJt1KqBF+Ih9w+fAu1m/uIVZB+iJy+1t9B57PrzH
         4um0T4KnBdb0Yg11SVnxBK9OH2w2toYxckGN9TnqnPsPf9MGkfntdklzG6mR69uaVgY/
         m5KOMMePJ+xZn5+9dkB1+DijdoU/1/FVynjo9OcTs6zVO3uhYROr4UIKB1Xm8r4rjGnw
         5pqIZIn7tccT0miKQzyLjHJ0896E3yW2qiWzlVQ0H2hZhOXFhMYPt+M2FBlvJdqIeGL2
         7+3Q==
X-Gm-Message-State: AOJu0YzhG7l/Nw2942ivb+60XW2kFxm0KMdZQPeZOw1VifuXePe0jrE6
	pKEdpZiPNxMEHEKrkmZN5/aGTNxrJ/luBmhr89nw5O8sluD8I3TRfkTbZa1e5X0wJnzAqj483J/
	aZQ1fhPQiwwJcnYKzQT5yCgENpZWo/DItbdJXsg==
X-Received: by 2002:a50:f696:0:b0:552:81fe:8858 with SMTP id d22-20020a50f696000000b0055281fe8858mr903560edn.10.1702609533348;
        Thu, 14 Dec 2023 19:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU7lu4l3r2Us7r6+r2mvMBEd8VPuCUg7LwwGWNLAA+lH54vPJXQZ5goqUn/HRyVLR8Mpl8NFkObOEn0e7M2KU=
X-Received: by 2002:a50:f696:0:b0:552:81fe:8858 with SMTP id
 d22-20020a50f696000000b0055281fe8858mr903549edn.10.1702609533097; Thu, 14 Dec
 2023 19:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com>
 <20231128111655.507479-3-miquel.raynal@bootlin.com> <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
In-Reply-To: <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:05:22 -0500
Message-ID: <CAK-6q+h8wFD6Phq51fau9t-L7f9vH89OkbS2p+LLSZRNA-LbPA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator
 parameter when stamping packets
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

On Thu, Dec 14, 2023 at 9:46=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > ACKs come with the source and destination address empty, this has been
> > clarified already. But there is something else: if the destination
> > address is empty but the source address is valid, it may be a way to
> > reach the PAN coordinator. Either the device receiving this frame is th=
e
> > PAN coordinator itself and should process what it just received
> > (PACKET_HOST) or it is not and may, if supported, relay the packet as i=
t
> > is targeted to another device in the network.
> >
> > Right now we do not support relaying so the packet should be dropped in
> > the first place, but the stamping looks more accurate this way.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

