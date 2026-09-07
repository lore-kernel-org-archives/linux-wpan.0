Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA037E5DE;
	Mon,  7 Sep 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768751; cv=none; b=KGltuTl0Q9i3HaO7xzkW6m9kUxRETXI7GMEsNP8fEN0zZLQIMI58fLgUdNGSoyVjpzYs9yPwh0Wzux3+S2Kj4s2BZ2fOKVsCV3kaq0siZyzlv+AsKj6XOIprjtiEJir067XQ7gYVggbLcFj/diACqEsjiOxPEiautxO/eKYE6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768751; c=relaxed/simple;
	bh=bsUtRBBJyZNJRmHydcAxD93C/4EQEXMHe+HQXEdqUR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKVRMk7wWzwdgjmfXo8IzaJYGAA45l2cZvIFXthxRHFKNoWl1/OPwgwn5aUU6NPGbXYBuVD6sdPGeS/McIq7Rci+mrshqGlynyk3wPUnq1S7N9hfsl6oYm7KK6QLQpy5ImBzs++eZbYJfaY73dkXAo+AUuQj8xqJET93i5XSZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XedbBzyp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XedbBzyp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B75594E4155D;
	Mon,  7 Sep 2026 08:12:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8964360383;
	Mon,  7 Sep 2026 08:12:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 694BE11C79353;
	Mon,  7 Sep 2026 10:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788768741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=u3z5baxYBQVbuUukNZUTET/Fwc46Vz7f8X06+KaYmRM=;
	b=XedbBzypA2Oaogm0cjiitegaHkLrmqxQD83ag4efmwVNpaxpp5gM1Z6Dd9FcHA2Fu1rDo9
	BgPzpNdqQmC4qCiJMy7StecIJLaf1agNlSHzh6uSGp2GDXoaha+pXdDg9O0pfGYK1EeSCG
	fJZkBjkENlfmxo06iTJPOPhbejymlI8jgws1wvaqP6FJ5nBXuGxxytvMxUOfsOz/kyqJr3
	p4OdJr4yD+dEgpS76vrTk+JujSX/7LJRh6cqT+ZcWw1H65D2jtYMWUeCZ835g/M502rtr4
	t0NN6UON57nUaYsJv/6KlP4jU1LepzxAkQlWooR8pPeqos0vQ4aDXyeViAzkHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S . Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fix typos in comments
In-Reply-To: <20260907064346.3288-1-hemanth.selam@gmail.com> (Hemanth Selam's
	message of "Mon, 7 Sep 2026 12:13:46 +0530")
References: <20260907064346.3288-1-hemanth.selam@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 10:12:17 +0200
Message-ID: <874ig1xyxq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 07/09/2026 at 12:13:46 +0530, Hemanth Selam <hemanth.selam@gmail.com> wrote:

> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

The subject prefix is incomplete, nevertheless typos are real.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
