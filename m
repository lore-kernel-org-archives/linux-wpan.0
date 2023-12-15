Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAB10FD
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/XGRh4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLyeXI6IfJc+fASECf3zMo4is78Uk23MBbPT3av6ivU=;
	b=N/XGRh4C8hWhqWudDTuhUCxHoA9K3CBZ5icOuMnswWzxABUrHPz+cHg8SifI2VJmybO4O6
	Jc2jgQnTr/vhAw2mBzOMLhZcUdw3a4LFAP9v0Y2RpfmWpcfBzx7SvXgjm7vI/RZiVHXmZR
	ASX8EHpIBNShP+nlcjjG1MqWC5DlWEE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-J1QFYDNePga-u0CAsLLgBQ-1; Thu, 14 Dec 2023 22:06:13 -0500
X-MC-Unique: J1QFYDNePga-u0CAsLLgBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1da829c653so13839566b.3
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 19:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609573; x=1703214373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLyeXI6IfJc+fASECf3zMo4is78Uk23MBbPT3av6ivU=;
        b=v5rIvD52AgBw6ce6BUiRtH1TIh4ys7IgvnaNM2RmW8rfgKEMivJsx4vhKMFkhMzHeK
         sWc0SPfUO9zvRxMimlMsvM4388JdruX2MQCf93sa7AarOnFbDw+CP+TyqKaGP6024sme
         UcjJH6Mp/wfEv5LhLO1Ulba4hD5DOFwHQxQGXppkBYi/ZSBDw+sbzWPDJR8hs4UT/1Of
         c8cDVCxoP6+yVoD5Z6mS954eGnW1iry2szPdhqhcN5T8ik69SB5EeZ/wzIwaKro1YEz/
         mpELfI//3BxM9fDtI+0LUW8X6hy2hw2QFD3DovBjvYFZxxhsLJjaIhsjbYuCvXsuBwx+
         QLoA==
X-Gm-Message-State: AOJu0YzVHjhNtsVSmWJCRGcaINz6/Yo79Sigws+oxYvv28hvBT3su2uj
	yvauaPEpbDYgf5I/emRNEPysHhqEjNC2XD5iO7vpyN0elktfU6B4u3YCRY33yf3Lpi/IhmFvq8s
	4uao/5Jn4FhkJUbOtgLZObqB2fvz241dj9w4KtQ==
X-Received: by 2002:a50:858d:0:b0:551:1861:1c47 with SMTP id a13-20020a50858d000000b0055118611c47mr2032248edh.67.1702609572940;
        Thu, 14 Dec 2023 19:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNE6nZcFlIOZHgwqroui93FL8SZNxtDtzVDg3pz5u6tWYJ3fFnA7mF/k7PxS8UGZT2GnHMojimj8VkLlntfq4=
X-Received: by 2002:a50:858d:0:b0:551:1861:1c47 with SMTP id
 a13-20020a50858d000000b0055118611c47mr2032239edh.67.1702609572655; Thu, 14
 Dec 2023 19:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-2-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-2-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:06:01 -0500
Message-ID: <CAK-6q+hWSnhtqX5JmsPHH8Psz=MVs3cuXYwfvmt80=a0Gwj_=A@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/5] mac80254: Provide real PAN coordinator info
 in beacons
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
> Sending a beacon is a way to advertise a PAN, but also ourselves as
> coordinator in the PAN. There is only one PAN coordinator in a PAN, this
> is the device without parent (not associated itself to an "upper"
> coordinator). Instead of blindly saying that we are the PAN coordinator,
> let's actually use our internal information to fill this field.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

