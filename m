Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175331;
	b=Zjz/BYzifINEn0iSdn68rCNQN98UU8rNX0GmXowdziUMLLKLx+c1832HgQJfAHSerQMa
	 pb92TPmchXFjLfyrOfuUgrAwT40TBP/ZHPe+tbLcD0QLSEetDYu0oxQudP4DEC3Xw2vUc
	 rBS3Rfv098uJ974fM9EEcLPmn+9ZmKLZnL42mTwUeXhFkbvVMH2fR4yal3Q9CIeUMuR5Z
	 44pge3p2G+mfMAs5ZerM2bJ/fmqLYb1Sncinyus/MLs2FHVVptg0guWOsyFIh1ebLNZx7
	 GMX65ZuD40YwztVzsRBDE2tAKi+QF5gaGLn1T7EpxLCW2CBK/INmBt0xLPqRsqHQYVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175331;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=URWKpJ6HmrczuDEeC0jFlmtc48kwYZUsDhx0/fYhj3s=;
	b=p3gTyB7aWIidyhI0LKFlPEtJ36uA8r9uHNWpKUrUjFExmLRvSrjPobDaHQDx2po4ttYj
	 hkN+UtV9XutZWsesTzQy07Bo6zaNLs1piJp/+Ew8b9Je6iq/41HQojE2qQ7UzB66jQNLs
	 FMnc5CPyTxvvdMtGXc3Tj9ObjMCxFUL5H7U8Q9JqfyltbyqmCO/ZihUE1rxEzWa4rTRTb
	 zFj137xCIUcTyGSAxhOuL6Rt9WX8r6HdYQroaV/YHK3HLqzl9ZceVvA3SV1Z43oisaXU6
	 N6W6VwGAHu5oAbsDfBVptPCS8RumN6lrITwOOxzVymJ03Kzw9oLC9DfZbq+S05QhffA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="RVVw/Fwn";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AB606A31A
	for <linux-wpan@vger.kernel.org>; Wed, 28 Oct 2026 08:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RVVw/Fwn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 500134E41363
	for <linux-wpan@vger.kernel.org>; Wed, 28 Oct 2026 08:15:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C39E60769;
	Wed, 28 Oct 2026 08:15:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F1831032906B;
	Wed, 28 Oct 2026 09:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793175326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=URWKpJ6HmrczuDEeC0jFlmtc48kwYZUsDhx0/fYhj3s=;
	b=RVVw/Fwnvt/uSMyK6/w5JyUYfJLALyo4189l0o6anO8SHyFhpDSb8FdmeAPTbacMBbAymj
	zU5xTIwCOxLHJKhDXlQu0+kn4s+lXMAiKbVTkEmBaPxXQfaJITorb/cz2b0B6/H90Gtns7
	xcQqn9e3cgLSfygoV0gYEXPmSp11GC7SPpRMeHBb5JQtph2oYlt3E9E+xpYRsg0Fse1P4J
	A//adbOh0OagG9706H+8NTHB52m+3gHz3PScLU/GwNCkMPkBJiN/c7aitH+KuiU7zWmV1s
	QrX9cJjGOXl9wy0oQQMIW6IbMF1mFR1+nYe//VDkmv1r5FJypj9RQFOogvuTcA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?B?5byg576/5Yeh?= <yfzhang23@stu.pku.edu.cn>
Cc: linux-wpan@vger.kernel.org,  alex.aring@gmail.com,
  stefan@datenfreihafen.org
Subject: Re: [BUG] mac802154: beacon interface switch can cause a netdev
 use-after-free
In-Reply-To: <ANsAVgA2LKxNoDvLnlQbwqow.1.1793115430251.Hmail.2301111981@stu.pku.edu.cn>
	(=?utf-8?B?IuW8oOe+v+WHoSIncw==?= message of "Tue, 27 Oct 2026 23:37:10
 +0800 (GMT+08:00)")
References: <ANsAVgA2LKxNoDvLnlQbwqow.1.1793115430251.Hmail.2301111981@stu.pku.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Oct 2026 09:15:22 +0100
Message-ID: <877bj2gs11.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 27/10/2026 at 23:37:10 +08, =E5=BC=A0=E7=BE=BF=E5=87=A1 <yfzhang23@stu.p=
ku.edu.cn> wrote:

> Hello,
>
> I found a use-after-free in the mac802154 beacon transmit path on
>
> Linux v7.3.0. KASAN reports a read of size 8 in

We curently receive many fixes of this kind and do not have the time
to process each reproducer and fix it ourselves. Can you please write
and send a fix?

Thanks,
Miqu=C3=A8l
