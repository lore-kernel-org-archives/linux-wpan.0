Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841497;
	b=gGl+S/rqLJYUcEBBFT+gCsw7IzwTzgZmJ0E5OmI/tmUj4lBISwt8pj0mMwZ/Wuedgmj5
	 aog49l5ZPwEd5gGLPmiBzLeLFRocX/HmYrgPsVrZFkfNL6K7GINtSh7ollSTasnxQe3y/
	 nNvjyuoz5yWD4zhPyJDVyTNnlFHHmWThCQdGjRiqA+cundWqLcRFmnA1RcKkCpHN3TW+q
	 u9v7QbiniAV7kt7Bmxr4g0QstNFhFyJgeOMLRocHlZyA2BGU2aVSAj7/FqF74apJgVypj
	 r4DRIAkA2s8tY9F3UvE+a7Yv0i9ZJ+a1NNJVPNrPPPh416UC24LKRyZBDxhQQGB0B6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841497;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=hS2mlsRX7vR2gya912wSbaDcuwZlM7TZjUS9hCdfuB8=;
	b=sPXQ76xhyD+Sk28pePlRjqZr6QpINHErKSRJypLP2AT7awRmJKCi9wWP4mZ9ixCaAhzL
	 I0P3KUwgTNMlRMFcbPtESlieztAVKWnSZNPAKJrULM2QSroKEH/3uuXjHj2G5H+7O0WHa
	 qRcDyuuJqHPFMgVJNgR4RuTThV9EP4J/E+VVl8wSVc6HuHMIO+/Pazwpcck5DJWB0DVHD
	 nzCIMEj/jtAglaxa7y61HiaoxfYb0EdPf9K7UICeQ3mYD6NKG6rwhTB2VbnNcEm6VLlX9
	 4O3FA7iV0M+ibj/829W1yifW7da4laOJm0WG7s3aMrSmxwsqpHsf+PyQ1odgYaXQ3ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UW27Knme;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F3606A896
	for <linux-wpan@vger.kernel.org>; Mon, 16 Nov 2026 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C04F3606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UW27Knme
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 38BE21A1688;
	Mon, 16 Nov 2026 15:04:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B6756023F;
	Mon, 16 Nov 2026 15:04:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D40511BC146D;
	Mon, 16 Nov 2026 16:04:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794841485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hS2mlsRX7vR2gya912wSbaDcuwZlM7TZjUS9hCdfuB8=;
	b=UW27KnmejuONG95BDLRyME8YoHfOW6pnHBw5A+/7MXd2VVOGymGXkqPPJQdhyGnvTuvN5T
	wsvCEg8qSWSuV7EJBwha3C5rkuOnMnEVrHV1HnHpUeS0GDLOJlyXRsj7v/lPd2CzcCxOYS
	VfY3QEDuN0oC/8VGR2wmNVtXvoy2jO6rfx/zVEYKsGzbuW55BtQ7inOoMEXa0OISWyb4Og
	IbmlpEr9pLxnRjmeAiJLqapoaS+mN6BVj2+D+Cr1sYRncD7Nk1y5N1Qli6G1vIMUhJ1Ik7
	RXgwR5+YI4S0Ogh9TMp0CqEoRJrcdxYEiYIDhSWLxAgNaZko/ixQJU5KogmAEg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: drop the extra phy reference in del_iface
In-Reply-To: <20261104022809.1484165-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Wed, 4 Nov 2026 02:28:09 +0000")
References: <20261104022809.1484165-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 16:04:42 +0100
Message-ID: <87ld6srf5h.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 04/11/2026 at 02:28:09 GMT, Wentao Liang <vulab@iscas.ac.cn> wrote:

> ieee802154_del_iface() takes a reference on the phy of the interface and
> then looks up the phy named by IEEE802154_ATTR_PHY_NAME, which takes
> another reference. When the optional attribute names the phy of the
> interface being deleted, phy and phy2 are the same device, the lookup
> reference is not dropped and the function later puts the phy only once.
> Deleting an interface while passing its own phy name therefore leaks a
> wpan_phy reference.
>
> Put the lookup reference in the matching case as well, leaving only the
> reference taken from the interface.
>
> Fixes: bb1cafb8fc41 ("ieee802154: add support for creation/removal of logic interfaces")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
