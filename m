Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3F3FE6
	for <linux-wpan@vger.kernel.org>; Fri, 15 Dec 2023 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBii8/Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702608380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6MvzYJ+Tuc25iOuYxEw7osTduMdwqYG2WLkbzsMfI8=;
	b=jBii8/YnRZRGnoju8/UzNkl3xsUYUnrXucswtbYlaHYEoyU+t24VKqitM8tLH8KoiZdNjg
	gwFaAxNZZ4uweDsIWEOFnXCFMGfmH45z+D2KVikEv+7otc0rBsL2V65mG5Rd2yGMY9k9ML
	w9lgaiuiuemlqw9hpzJb9ubF9T5OOkQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-5RBmFcRHMsGUxKQhx0WGKA-1; Thu, 14 Dec 2023 21:46:19 -0500
X-MC-Unique: 5RBmFcRHMsGUxKQhx0WGKA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55239b77a2dso186577a12.1
        for <linux-wpan@vger.kernel.org>; Thu, 14 Dec 2023 18:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702608378; x=1703213178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6MvzYJ+Tuc25iOuYxEw7osTduMdwqYG2WLkbzsMfI8=;
        b=HdoXy6vufWmegs82r0lbqhWtt6VHMxVtOAIUIkCsxPvNz8HzJ8Q+KFOQzWi7FlVVY+
         eBn2o+hwNH7kHrKEJx+hIsnkZDpfJGRrSmEfueL4gYFcGmNJS7u7rlvQr7q7OSirJMjZ
         35RBFgto699kEBRHbhI8wrMYUv6jYdkLR2rkprWkMYIALONgZ80M7x9xHCatfwacHf06
         TTEC/Yryg2EGKlO1zObHMGfX9kEFn2eUvLNjDwHdJM9Jm/Yv2xBJRKRiqrj2iPl7q59X
         99ZQtz025l2KdU6JV8ZE1oqcxg+lFq24wybWeDcEqcnvtNQk7RS9vPmOOrvNjRhCz6/q
         mkew==
X-Gm-Message-State: AOJu0Yx8oSQOkrsSFAID0kxiAB3ojXa1OUMLstJgj2raKYB5iCkk9Tg/
	RzffSkUi0Btd2+oNVw3OdExKW3tFRkp7fOF4PqBodUBSxi2tkMIuj6Rxj0WHJSLYwFnX1szIUd0
	nptADF9oUfQxrO2J4REhpydnD0CB9N1YOCC9Dyg==
X-Received: by 2002:a50:ccc1:0:b0:552:1317:20c9 with SMTP id b1-20020a50ccc1000000b00552131720c9mr3410093edj.6.1702608377936;
        Thu, 14 Dec 2023 18:46:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgkai9nX9g/iyGVSVklLMquI+ZTR0oK7PxeFT8KOSnBE/feZxtGHFWvqOUajCR0D6jlJ6VUtqmexSbolbImMc=
X-Received: by 2002:a50:ccc1:0:b0:552:1317:20c9 with SMTP id
 b1-20020a50ccc1000000b00552131720c9mr3410079edj.6.1702608377631; Thu, 14 Dec
 2023 18:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-3-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-3-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 21:46:06 -0500
Message-ID: <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> ACKs come with the source and destination address empty, this has been
> clarified already. But there is something else: if the destination
> address is empty but the source address is valid, it may be a way to
> reach the PAN coordinator. Either the device receiving this frame is the
> PAN coordinator itself and should process what it just received
> (PACKET_HOST) or it is not and may, if supported, relay the packet as it
> is targeted to another device in the network.
>
> Right now we do not support relaying so the packet should be dropped in
> the first place, but the stamping looks more accurate this way.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/rx.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 0024341ef9c5..e40a988d6c80 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -156,12 +156,15 @@ ieee802154_subif_frame(struct ieee802154_sub_if_dat=
a *sdata,
>
>         switch (mac_cb(skb)->dest.mode) {
>         case IEEE802154_ADDR_NONE:
> -               if (hdr->source.mode !=3D IEEE802154_ADDR_NONE)
> -                       /* FIXME: check if we are PAN coordinator */
> -                       skb->pkt_type =3D PACKET_OTHERHOST;
> -               else
> +               if (hdr->source.mode =3D=3D IEEE802154_ADDR_NONE)
>                         /* ACK comes with both addresses empty */
>                         skb->pkt_type =3D PACKET_HOST;
> +               else if (!wpan_dev->parent)
> +                       /* No dest means PAN coordinator is the recipient=
 */
> +                       skb->pkt_type =3D PACKET_HOST;
> +               else
> +                       /* We are not the PAN coordinator, just relaying =
*/
> +                       skb->pkt_type =3D PACKET_OTHERHOST;
>                 break;
>         case IEEE802154_ADDR_LONG:
>                 if (mac_cb(skb)->dest.pan_id !=3D span &&

So if I understand it correctly, the "wpan_dev->parent" check acts
like a "forwarding" setting on an IP capable interface here? The
"forwarding" setting changes the interface to act as a router, which
is fine... but we have a difference here with the actual hardware and
the address filtering setting which we don't have in e.g. ethernet. My
concern is here that this code is probably interface type specific,
e.g. node vs coordinator type and currently we handle both in one
receive part.

I am fine with that and probably it is just a thing to change in future...

- Alex

