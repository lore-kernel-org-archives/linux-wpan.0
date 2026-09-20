Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F8B44236F;
	Sun, 20 Sep 2026 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909311; cv=none; b=J7elffdHdLuzzdqfcFsIHwj70FKSf+PIMszljqlCZO0KA2BIKG1i0OWB+sXAhHOe2Yx3W9SCx/8lGjBma3HgrqGZPWPTVYjrAaBfVH4zArP4Vs4wU6hK1r9ZiVpERyc15s36PvxWsUqjtiTno+Wl69JcKoh7I6kdmYaQ3U5uEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909311; c=relaxed/simple;
	bh=NRPSdmAxs42vuKkUCkWoekBy34b6+JlJs8n7dne7H4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEXs1EwKtqdK0ecGyLYdBQ3r7yBhbjssM8niDtjHEzoBr/y4sQEDLktB6Mv9mI3OQyXfE4cUZIqBkpKE5mnbCh+ZQiE9uFLKVmOXYxMIQZQd4Wcs0SIleaSDFD0U/FFaiMQ3/5/mqUZB9+St72zCqqMpbmlcyecgHgDOTu2M42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GvceU5c4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GvceU5c4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D48891A085A;
	Sun, 20 Sep 2026 13:01:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A9330604C9;
	Sun, 20 Sep 2026 13:01:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69EB11032829C;
	Sun, 20 Sep 2026 15:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789909291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NRPSdmAxs42vuKkUCkWoekBy34b6+JlJs8n7dne7H4I=;
	b=GvceU5c4KTnMX4PzxP+CKRHc2m4KjfXkpI8U+H7cZfuG19pUoq8MrreX+Bmoaeia3ZQUV4
	2L6LsN8zD7+vUD2G2o/+S7nfFpWZKU2wfug6p32I429nOby+EYExokiqj2a9CpIY+HKc5y
	Dc7As2nwf80BFqG/74ZlEhU3kw5cJojnsCsxbonve3lCog1vpw3604j8rfo9WUuncvIiiQ
	XQ70RdNxnOsDmcOdCpejfr2ttwbLo/faHEmRh+5R6oe2jlyJHgr1QPfDhnHY6TQwqM1IVx
	/BfUl9G5cO/mvlQmEtoasxd5+bpHDUZuoVWt7j3QZO6sYVH2/uckzaWH9gu3Ug==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: hwsim: fix edge allocation leak and netlink
 attribute validation
In-Reply-To: <20260919223434.3882824-1-benquike@gmail.com> (Hui Peng's message
	of "Sat, 19 Sep 2026 22:34:34 +0000")
References: <20260919223434.3882824-1-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:01:29 +0200
Message-ID: <87v7809ivq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 19/09/2026 at 22:34:34 GMT, Hui Peng <benquike@gmail.com> wrote:

> In drivers/net/ieee802154/mac802154_hwsim.c, clean up allocated edges
> and phys on error paths and validate netlink attribute bounds.
>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

