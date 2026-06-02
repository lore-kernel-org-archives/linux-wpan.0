Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDF33D6F7
	for <linux-wpan@vger.kernel.org>; Tue,  2 Jun 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396523; cv=none; b=f+zupoeu7C4eZwnzywSE4cqJr1q6jPJFJdhkGt+qMFTvMQT64SuBFtKZBIxUpkzM7tBGoDH2zX7D3eniC+iB2SOKIZx2883Ekur6F21uUHnzZ59+CGoL9gLHtSuLqHCZuEVvjlQOSGMNnh+taSrif3IliO4MNnQhJmQwYdkpbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396523; c=relaxed/simple;
	bh=7fs/Ea2xnzRuG59u8rGS1g7Z3TJFNLOo7lJohh/sZWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPxKvwhbk9fgJhqyZJG1eTSB2yCZWW3xzP8IwNry8aMtHaoZqG2/bcjArdCIZA3L3LM3BzDuHuZROnchfIo8zMk0X/L5LUVqcj04aw8OgQuWWjMVknefKQtd1BXkm/PP5Ax2Pioj2Ww3oSJjjlXrHhjr6NEVLMkgUCoxnBzfIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uu56T2d5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uu56T2d5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0F7D44E42DCC;
	Tue,  2 Jun 2026 10:35:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3F45603BC;
	Tue,  2 Jun 2026 10:35:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206C11088838A;
	Tue,  2 Jun 2026 12:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780396518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7fs/Ea2xnzRuG59u8rGS1g7Z3TJFNLOo7lJohh/sZWI=;
	b=uu56T2d5YgNJVXUPff3eP585cqUQLhOxT2qCEPxRjavLP7bnKePVomqANOhLXHIhL1U3sY
	Ho+JgdHH8q8YJo421XNOeygddbsv+uD3e3k7n6kDOlO+VEzVNJn5P5luXwUymxETNnB4C8
	TeRiFEDs2HM1rDYvobbwNHjJn6iujBf05zfw2ILIfbx34etJA2ITdRL8qHMJsFx++yj4i0
	+lBfI9G0nzZRPyAHolNhVVyT+Uw2pjV2hQR16rmPviXm9ltIIWMU62wI1jzUBiA/9PTNx1
	MvbZunzeY6p6vQMdq/AIOpyQ6HcIDQM+/iLhJxpVS6f1HlXcInvbdfYTYpzdCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org,
  skhan@linuxfoundation.org,  me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in
 mac802154_perform_association()
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com> (Robertus
	Diawan Chris's message of "Tue, 2 Jun 2026 12:41:33 +0700")
References: <20260602054133.470293-1-robertusdchris@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 12:35:12 +0200
Message-ID: <87ik81mdr3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 02/06/2026 at 12:41:33 +07, Robertus Diawan Chris <robertusdchris@gmail.=
com> wrote:

> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
>
> This is reported by Coverity Scan as "Unused value".
>
> Fixes: fefd19807fe9 ("mac802154: Handle associating")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>

This is correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
