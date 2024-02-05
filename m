Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB760DF6
	for <linux-wpan@vger.kernel.org>; Mon,  5 Feb 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162145; cv=none; b=DhtxP8JpqNKzCvIBiZuZq54Qg12I8qrQGKImg3gBIM2LkZeU26xSh0nyCMqcejNw2sAbd3nwPS4skKO0JTRXJXuiSW0K6WFcSXb7BhUtEPHJBz46gt9ZuPE3b9vFsssVJs8JD6SorvRmQot16RI0cNopl5uVzCxFJ5Tia44Md5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162145; c=relaxed/simple;
	bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8WxBGaPLpqsvnWbiwEbxPfEH7njtNq/UVM5kTxkIkx+9k6f0gcUlXR1Gt/piboCAXu3/5uywK0lZy7TPOecJGgX/2++hZ3A5S1aTKoucdWlBhQPoUKnLT2uFZaqHJ057RYV22rWYN+JLK6BM94YKKQGVXLkQi+DBQ3DALTDuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+E2+kkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+E2+kkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
	b=b+E2+kkcXXkO9cFlc37XLh0ckla5pGINizKWGH+qeKOGqZ21Tozp5E5wmCesx4K4a0JiRu
	9zjPo0Ko4Z3/IOpiTon3Wj2FtL/OaqG8VP4jg7QW/Pi5mOkKfs9FUUHI4OWsEp3w3J7lcM
	h1NYpQJycSmeKZJaqNfMfLopFQIas08=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Ody9-OPANVOPezj398FruA-1; Mon, 05 Feb 2024 14:42:21 -0500
X-MC-Unique: Ody9-OPANVOPezj398FruA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55fabc6adefso5217938a12.1
        for <linux-wpan@vger.kernel.org>; Mon, 05 Feb 2024 11:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162140; x=1707766940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
        b=pITmS49fpwjrqrYFojZAgJv5KXj1eo6J8jzyKdFEJVYcWXpjk4ArCiM78IoiBwmVRf
         bWqvdbKmVo0bRjP2lbGEBkZNB2bdWQNelM5t9WhBMsUQUSuh2+6AAcvM7VILfrvSotfI
         TliNubvTog9I+jeDLQ573V6pNEeS9WtS6bNN2vDDaRFkpe+hOgXokSy1SAAWCRSvq0x2
         GBh1GTaSVUoBZi/YyaIaurmJnLKBAZtx5HIAVkYoOMtptXV6/3sTvH0dnqxi03a80G1t
         yIc274IhMx6VpvQNfQmfU7+9OKm0gIS4bx4OdpC+ZkLWNwpdlKWP0LQayeq9O6klo1Pr
         UCWA==
X-Gm-Message-State: AOJu0YwgfYVEt2OxVeXk6t1vq8r4FpqAX3oTXNdmXsT2kJsAwCbb43Qz
	Bnv30Pgv8r2uN21Xcyu6uh92y/uwzD2X+739mJjbGIKwdbiqfEzUTYJ4aOivW3HPYfTD6HWCqg7
	Vi1L87cOeZtmAI3/n8riHq1phgWGkSLj3gRFt8kuoGTpzFthhWrI6JLJwOKUPyePEXRXoSsTaxr
	xmVXXyzAh0y5/JMhon3piJlQ2UkRxlyqt3sA==
X-Received: by 2002:aa7:d893:0:b0:55f:e543:b006 with SMTP id u19-20020aa7d893000000b0055fe543b006mr689422edq.13.1707162140578;
        Mon, 05 Feb 2024 11:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrKHN+f7FGpriqh0DUpVTEJoFk6gp1bibeEGrhZ3Z0mW7IbHPTLkTvDCIiZ5rH1Tk1sf5oIM7QHRmM+sb3QmA=
X-Received: by 2002:aa7:d893:0:b0:55f:e543:b006 with SMTP id
 u19-20020aa7d893000000b0055fe543b006mr689407edq.13.1707162140360; Mon, 05 Feb
 2024 11:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202064512.39259-1-liubo03@inspur.com> <20240202085547.46c81c96@xps-13>
In-Reply-To: <20240202085547.46c81c96@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 14:42:09 -0500
Message-ID: <CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com, stefan@datenfreihafen.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 2:56=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Bo,
>
> liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:
>
> > The maple tree register cache is based on a much more modern data struc=
ture
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache=
.
>
> What are the real intended benefits? Shall we expect any drawbacks?
>

I doubt it has really any benefits, only the slowpath is using regmap
to set some registers. Maybe if you change phy setting frequently it
might have an impact, but this isn't even a path considered to run
fast.

- Alex

