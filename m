Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110567DA76;
	Fri, 20 Sep 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831300; cv=none; b=YY0ETDOUyn50lKfHV3Sy818Fc+R/YpYCqjmfeuuKISe3joo4lSAaLXaRXeohjIDYIDN/COrnDf6XT1ui7t4ZZwSBzez3PrbVORtWDrlyQcg/vSQKU6FwWjuOj1VTGBak9vho7wYGyPt63fIRMHuXzT2cFZwLXikGNzUCpc725qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831300; c=relaxed/simple;
	bh=bxKEtC5qNY3zXEqd9y537CZSdz2DNen+N/WtzqreB2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxk5xU5gnUBQicX6ekIs3prpJgBi7p4jJvtivLQzF25Obt003A5pvTZB5SpVHdUqWkUsmliu6boY8YV6cmBCkId5atoHmICcmWZ7oALdMy5+P5wBOY2E+jDKdt1g3EpuSp7xvGPh7XyAgzaENrecIWVZ8bUjln6cs/EvbciYHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MelgKL6t; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MelgKL6t"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89F51E0008;
	Fri, 20 Sep 2024 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726831296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxKEtC5qNY3zXEqd9y537CZSdz2DNen+N/WtzqreB2o=;
	b=MelgKL6tLbVlCpObozi14FKQTJ6qZaJN3mRyPjBiVPNQzwaz9LREICMpoYfqKAoq+Xn08J
	ioImy9WpCg7Xujh/gGhA+anPd2UQaEhPgamnYjVnHaidRuuK92JBJHsob9pRvBm+NcUvpG
	Cq6K89ZmRuUeqRqd3gdzzlY77ITOJciVjXuD0CDEnKuvNZGsGpxK3/jZeulkb3IHknkcrp
	5CTNUvcmDUX09bTvkOEqj6dzM98m0aFwutY4ePlcNxUjlYaypM2FRhToTPBRqgZX3pkpyi
	bRTrR5K5n/m6nlTUqBcf6GaQBA8kP7/2C42bVuqkoYc3BrKxGWH6Lt2yWtmcQg==
Date: Fri, 20 Sep 2024 13:21:31 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: przemyslaw.kitszel@intel.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, david.girault@qorvo.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mac802154: Fix potential RCU dereference issue in
 mac802154_scan_worker
Message-ID: <20240920132131.466e5636@xps-13>
In-Reply-To: <tencent_3D3535F93CE8BC48A50E29D1CF7A25E93D0A@qq.com>
References: <tencent_3D3535F93CE8BC48A50E29D1CF7A25E93D0A@qq.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jiawei,

jiawei.ye@foxmail.com wrote on Fri, 20 Sep 2024 04:03:32 +0000:

> In the `mac802154_scan_worker` function, the `scan_req->type` field was
> accessed after the RCU read-side critical section was unlocked. According
> to RCU usage rules, this is illegal and can lead to unpredictable
> behavior, such as accessing memory that has been updated or causing
> use-after-free issues.
>=20
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
>=20
> To address this, the `scan_req->type` value is now stored in a local
> variable `scan_req_type` while still within the RCU read-side critical
> section. The `scan_req_type` is then used after the RCU lock is released,
> ensuring that the type value is safely accessed without violating RCU
> rules.
>=20
> Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>

I think net maintainers now expect the Cc: stable tag to be put here
when there is a reason to backport, which I believe is the case here.
So please add this line here.

>=20

Please delete this blank line as well.

And with that you can add my:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---

Thanks,
Miqu=C3=A8l
