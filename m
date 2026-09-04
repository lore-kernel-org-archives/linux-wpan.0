Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252D4F55A2;
	Fri,  4 Sep 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539240; cv=none; b=I1TE4+OzP4K4W/JLhj2m9gy0cxNvnAhJbE08aDfx1AN7dY+VtkTG/0hokz45BIjrLi0Ts76uhWCGuKZzDnodttfb2A3mJbnFdS48r+00j1tagNobZly+B3EsIwcO0pwvDkIasodDDWlW0Tc/oek4zqwYoTid6MR7qGIn2smppoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539240; c=relaxed/simple;
	bh=tcK1Sx3A/CgqQXi7lMc9CzKjjKqQl5lJcjHTne3CQ5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZbLIm3oB/+NxMetbUjR+J4URiIfgmYi33ia92yq08zZb0HLzF0Xl/nuyGl43VKFV0/RgxRFp5fOHhrG1p7BBJiIU/bw9wD52qTAyvL2w5YSZZ1SOFhnVPKrGvtTfu/UrUbtturRT24vkovnTdNlIhXLwjrqFyIjKlEYh+BJ2/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a4fbSzMt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a4fbSzMt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B29CE1A19AB;
	Fri,  4 Sep 2026 16:27:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 846846057F;
	Fri,  4 Sep 2026 16:27:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F9C911C79C69;
	Fri,  4 Sep 2026 18:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788539236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tcK1Sx3A/CgqQXi7lMc9CzKjjKqQl5lJcjHTne3CQ5M=;
	b=a4fbSzMtovlKZk0i83+sjZqERhs3qxLjjLyPZ3ODm2FW3X1jlllTrIODuwL6uFJAbFLbtA
	mQkVU+ZwsrPJVJNI5YGQuWa3hAEMwnt/kT9Qtgx7H76gXMrbHRlgH8l7f3eVHpmvW9Plj2
	TcfCY0g5RBUB0abNTohhJ2sp3/86qbFR3LpxBVUBvqzVnCN0gpFMJg8bIqCtkHitqOpaA4
	d+ldqyNvkBV3lfhnVt+KWl8xMHcq5J0Wb+XS3GX4p+yIV2BzJXCAkUopPC8yZG+BnfbYg3
	YpTYjPTwk+iiz9agYIHOTu2iYSI0iiJ98i7e9XneTiVJ4UpYI5dnbx/6eZk3Bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  david.girault@qorvo.com,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  stable@vger.kernel.org,  Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v2 1/2] mac802154: serialize and drain queued RX
 descriptors
In-Reply-To: <20260903123202.60152-2-xuanqiang.luo@linux.dev> (Xuanqiang Luo's
	message of "Thu, 3 Sep 2026 20:32:01 +0800")
References: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
	<20260903123202.60152-2-xuanqiang.luo@linux.dev>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 18:27:10 +0200
Message-ID: <87qzj9yobl.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 03/09/2026 at 20:32:01 +08, Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> queue_work() coalesces attempts to queue an already pending work item.
> The RX workers, however, consume only one descriptor per invocation. A
> burst can therefore leave later descriptors queued until another frame
> arrives, while the final descriptor may remain queued indefinitely.
>
> The RX tasklet, workers, and scan cleanup also access the descriptor
> lists without synchronization.
>
> Protect both lists with a spinlock. Publish each descriptor and queue its
> work while holding the lock. Remove each descriptor from the list before
> processing it and, if another descriptor remains, queue the work again so
> it runs after the current invocation.
>
> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
