Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFC49A3DD
	for <linux-wpan@vger.kernel.org>; Tue, 13 Oct 2026 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914067; cv=none; b=IUJwhClcC81pUXseVmFc+/cfMmvYQbXTYJtZGtzo+vooj9UAAkGRdtZCiggU5eESq2OoB4g11oQkTxQeYvmGpGOFU/RPGDZhkpHLqqI+XEZl09p9t1hDq3wjUT5/lETNyXUvivSuiPC9EXSBoJZZVfA7uUhzjX58TWYVg+mqugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914067; c=relaxed/simple;
	bh=YHRxEnhISzYbhxdYgROze8JOSodjmfiGqLyBf+tRR8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUmw3uMhB5OGomFu32I077QW9754xOja+Oyuzk2isRfRzapolsiLypusXdsyp22gvYb6EFrMSiiOKH1BToE34QBkFLoL+eu4/YrimVMrQOJcmqV1QVX4cwtxZvc9duBoQ60hU855+ZgcEadXvuUZ/POUQSsu2+iFhaAm2bzM76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YueKTQcO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YueKTQcO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 29F0B1A1215
	for <linux-wpan@vger.kernel.org>; Tue, 13 Oct 2026 17:54:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F292660362
	for <linux-wpan@vger.kernel.org>; Tue, 13 Oct 2026 17:54:23 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 435BF11D703F4; Tue, 13 Oct 2026 19:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914063; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YHRxEnhISzYbhxdYgROze8JOSodjmfiGqLyBf+tRR8k=;
	b=YueKTQcOneJj6vdXXZ4cKBeIrQsqzkL8mHfv7LU6zyV7JOXXIhpSiLXyXMxRbkzLx6mYxl
	Fn0pn6Ray46rY4kHWSBdNmLsdcFUU2bHbhyI28nOHpr/3P4umF+B+M6pcvtkTTxz9KCit3
	b8IAybJUynGRNpTRH+9Lmp46rNcu60qnRL98graHxzfiT1mxBQTgfCzkk41Evc5vy5CGhT
	m9P2lMQup51vKUO/4sEpBwTa4pf5yTa4KNPtUuIt79gyuBR6rhvk1BGafa0GW5PWVNFg9F
	ISVR37u4OMF7C+wtFOtkKbMSmoHWiEGVjbqRXRzwbo6hl8feaXROEA3hSXmsng==
Authentication-Results: mail.galae.net;
	none
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aryan Arora <aryanarora.w1@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  David
 Girault <david.girault@qorvo.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during
 hardware teardown
In-Reply-To: <20261012120934.64632-1-aryanarora.w1@gmail.com> (Aryan Arora's
	message of "Mon, 12 Oct 2026 17:39:34 +0530")
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Oct 2026 19:00:41 +0200
Message-ID: <87v77626rq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TUID: yusUmhSyE7w+
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 435BF11D703F4
X-Spamd-Result: default: False [2.29 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[24];
	BAYES_HAM(-0.61)[75.95%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[19cbce4cc656ecd4febc];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[appspotmail.com:email,bootlin.com:mid,bootlin.com:email,localhost:rdns,localhost:helo,syzkaller.appspot.com:url];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,davemloft.net,google.com,kernel.org,redhat.com,qorvo.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[]

On 12/10/2026 at 17:39:34 +0530, Aryan Arora <aryanarora.w1@gmail.com> wrote:

> Scan cleanup uses cancel_delayed_work(), which does not wait for a
> running scan worker. The worker can requeue itself after cancellation,
> leaving an active delayed-work timer when the PHY allocation is freed.
>
> Cancel scan work synchronously before destroying the workqueue.
>
> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Reported-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=19cbce4cc656ecd4febc
> Tested-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
> Signed-off-by: Aryan Arora <aryanarora.w1@gmail.com>
> ---

I thought this had already been fixed but apparently not.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

