Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E244F566;
	Sun,  4 Oct 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125173; cv=none; b=Jkc+1VcjR3dZ50CEkT+XlaGZIULOaGk06/OImaLlCOHJofEbYOx4uO083Y/HjTSWsR7A1EZLNr7D+PEIef4nLMy4qXdLkmgbBbshsm634sS7TOo65hM+2MqrTJFNm4OqSha6D6Prjna/H2yx2QpkShPast4lyomGOizB9WmVffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125173; c=relaxed/simple;
	bh=wvwz/du1Hh4yJYVTJsrFrUzkB/WG3sl+qJrrbGrAsXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=piS17bTwr6jGGcjfg+dvJICGozoL3x6Qie5fdxOevFwcZeCeT8mVkuW/fO96GVnYoq622oSlDlqXmoxmIQtGZbnOyMwIvhjcFMaq4QzPT4UAQfDzdI6f6TKGtVhhlVH3iptmOF+dy6xUvJqy3IeTqGuFCOYIaXjbUwGHmIAEAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1Cu3lbZH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1Cu3lbZH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 67D2B4E41161;
	Sun,  4 Oct 2026 14:46:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C39A8604FE;
	Sun,  4 Oct 2026 14:46:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF59B1032817F;
	Sun,  4 Oct 2026 16:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791125167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wvwz/du1Hh4yJYVTJsrFrUzkB/WG3sl+qJrrbGrAsXs=;
	b=1Cu3lbZHjiWkRSd+TjrFlF2qWsg5n70COQSDOhAATO+Y58CSy8RQn3v4q5mLbj3HUSeH6e
	7s4G7hmoAVYucyeXh+ZMBzeQidiojWmG2ifr4cvBEcXAaPOuI0yIKUrF23kWm342FDxiFB
	/NIDy23OhgGuUfEENtw73uFuq9EMFtvH2krUy09f5cFdVjc3MRkmkmjX3cuykQZpMbnmvA
	El/FsJMxt1WZppA6rnsf95OcRryTjdG3Y2ZQLjj5dI7Q5jE7iXqQjAT+Q8HToLQ1OfQe8l
	uZjNs5w3+BHz3OqzHHkCqWWmeIUShXtHR8ms60omwm2GgpzoBhzIlhLk43bpOw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adi Prasan <itsadi2409@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mac802154: fix race between slave_close() and
 in-flight async tx
In-Reply-To: <20261002144827.3479-1-itsadi2409@gmail.com> (Adi Prasan's
	message of "Fri, 2 Oct 2026 14:48:27 +0000")
References: <87ik3tn1nn.fsf@bootlin.com>
	<20261002144827.3479-1-itsadi2409@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 04 Oct 2026 16:46:04 +0200
Message-ID: <875wzhle1f.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 02/10/2026 at 14:48:27 GMT, Adi Prasan <itsadi2409@gmail.com> wrote:

> netif_stop_queue() prevents new packets from being sent to the driver,
> but it does not wait for a transmission that is already in progress.
>
> drv_xmit_async() can still be running on another CPU when
> mac802154_slave_close() calls drv_stop(). Stopping the queue only
> prevents new transmissions; it does not synchronize with an already
> running tx operation.
>
> This was checked against mac802154_hwsim as well. hwsim_hw_xmit() is
> synchronous, while hwsim_hw_stop() only sets a flag, so there is no
> pending work or locking in the driver that needs to be synchronized.
>
> The race is in the core between stopping the queue and an in-flight
> tx operation. The fix therefore belongs in the common mac802154 code,
> using the same handling already used by ieee802154_suspend(): hold and
> synchronize the queue around ieee802154_stop_device().
>
> Signed-off-by: Adi Prasan <itsadi2409@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
