Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCB38B14C;
	Mon,  7 Sep 2026 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775668; cv=none; b=QrlJox8mMzIyfqsq0iDFvjPQ6+ZdnvQD2XxLPC4doCeaFsMoqaK3CAYhq5VmUq8EivBpHiDV9aJhjCxW9n3fqAawv+ZBlXektNdUZj6kvNml6hGd7r/TbAnFCbF11WFTyQmNPPz5iPmz/bhjDikKFHJ6m+I7qPWXrJzHJGEBcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775668; c=relaxed/simple;
	bh=53jZywzoNU/K25Xnc/tRtDjNw981PmXbT/AiIlE+dcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mS8bkHu7Eq2WAcCypDQpPHHGGGGOXrDQAzYV/7oQh9vd/sKpqv2Xk/tCQeklPfmn3ReJFdFfJb6YVqeTbWCE55myQumXOX98r06L8q8uOOYv4ZHL2xInFSPj3Xz8Dxk7YWkj4/ZHUa0C4QdY7rBER9CpjsXAzmbn8tn5dTzo1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1rOfrNt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1rOfrNt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C7F5E1A1A35;
	Mon,  7 Sep 2026 10:07:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99E2B60383;
	Mon,  7 Sep 2026 10:07:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 005A211C79353;
	Mon,  7 Sep 2026 12:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788775661; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I7j3oAHw/B4dCzxV/5pbXaPGc1Ezg57gKDg6dATeVHI=;
	b=L1rOfrNt1fIzzzql6ZJUWRzVsw+uQNZiZb2NswJqPFqHWTLK/n6GYgvQhEQ1pwahFlRIVJ
	9zFv990jC8KS5qrLgIiuS+NKlD9oLEdkrEvcjnyYxpdVAuzdf7eoMLC1y60YccxoXH3xlE
	bfUU/rQlQHdLoTjmR4Q+0Hj8b8J8dG1Zhz//Cj1axhD08m6PnHj6ysLKxtb4iqU3i0geZd
	bt0dsJtA+SDy9tE0wcavSyHIm8K5elFMcNiHyVDIW9QCrS4TYsgIB6/GQUxHG9Prk+NnZ3
	OnpibYC7HrQ/SB9EKWieB71r8zya2afUqRjXcMAUMFXNO6O5n5Hu97NcXZxfew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: fix typos in comments
In-Reply-To: <20260907095132.21244-1-hemanth.selam@gmail.com> (Hemanth Selam's
	message of "Mon, 7 Sep 2026 15:21:30 +0530")
References: <20260907095132.21244-1-hemanth.selam@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 12:07:36 +0200
Message-ID: <87pkypwf13.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 07/09/2026 at 15:21:30 +0530, Hemanth Selam <hemanth.selam@gmail.com> wr=
ote:

> Two comment typos under 802.15.4, split per component.  Found with script=
s/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
>
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.

I didn't ask for a split, we can abuse the prefix in that case.

You should not have dropped my R-by tag though, given the fact that the
diff is strictly identical.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

No need to resend again though.

Thanks,
Miqu=C3=A8l
