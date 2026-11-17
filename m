Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910156;
	b=VzjLxsyI6A32+NNgBwfHEOej5DrfQ+SNtuWUf3dT8z7Fxi1oDalasjNeC31qxw8hRagW
	 lTLk9h/9PHMhl0XSiCmFCDBDmW75aTibhpS8c8EKbFkmQMvsr1EuK8WaqXPLWqRZb+Ii1
	 H/mIdBc+WK1ko4Sn5vCLE01zFWYevJFfZeeJAATxa1ifUAV4bZDpWci6RrpG3SW1DxJfe
	 jfov/u8kMoqs9g7u/tcm6Pt/e1b6GmQevhf3/SmArdvWVABUqc2UYa188kAkUTTftb/LY
	 U2baT9hapmcpMMzIkcluh0egVKs2aIaXXc4YrQad0qFP1ao2HODijbhAhm5lZnQTbVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910156;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=efFy5qzGhOXzdl7ha+UrFef5foRsVEqpNLPg/lX46CI=;
	b=wM6m+sIEzFX93Jh6DfUFRnEAF/dG0bFzrWjofCfXAMiZcHrCDG6zy28s5N9yAyxGVu0g
	 8/sCFYHen3DGj4xwjlouHa2Nk93bjvJZYWW5UdnSBNU7oD++jMbEABPZVjJLvFWo2NKxM
	 pdan8o7uI9W9l5P2dm9B3CWI8xNvUkTrEf5aNil18Ql5PzdMDIRywBscqX0HjMelxhSdi
	 E7XG5ka4TBwJ+lDPWA1nSsXZZOagP4NTgBdGbso1UynQAOs9yCyUcaKPs8ZY5jQLw0AZb
	 hruehVkddTbU4A5azUqghhIS+UaPkwGr+ZaG8jmlPTeZt+OCAdtMSsS0Ph0cutISsdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fXAjJXt7;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E7606A323
	for <linux-wpan@vger.kernel.org>; Tue, 17 Nov 2026 10:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208E7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fXAjJXt7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 735574E41473;
	Tue, 17 Nov 2026 10:09:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 481AF5FC81;
	Tue, 17 Nov 2026 10:09:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6857311BC0493;
	Tue, 17 Nov 2026 11:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794910153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=efFy5qzGhOXzdl7ha+UrFef5foRsVEqpNLPg/lX46CI=;
	b=fXAjJXt7VgwfXDE9fcErcMBB17TbLufQtAQy/aQ9huR1Xx/tvA7Ehrim4GFW1ZfMKUmQUc
	dTJc468izwMk+bSY/cE1gXkXsiUe7zqBjItFxy5WpELyXhJBQLg4qqRleg9gk+7iYdznKa
	rrS9Qr//iVini/YPirHennlVFH+6nbDrJORNyv1hbkTUqHsmZA5p4fPcN+BCGUSTZyrDv+
	VBwZJTYUT9R6fwzia4Z/OS+pMQ8AT1cFWU1dirOkFkElSncV5rdEtL7lqQxFDTP6Etx1Yt
	OBg7MCMxQCY6Si2GeH5zunVH/Gl88WyhLaTpBqpfi0R6Nlc1nq2VhmNdtCEbig==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Roshan Kumar <roshaen09@gmail.com>
Cc: Yousef Alhouseen <alhouseenyousef@gmail.com>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering
 hardware
In-Reply-To: <CANphZRNSXy4tQ9jO7RT5g2X69T-CapR3-sSood1qJfYTRUE8ag@mail.gmail.com>
	(Roshan Kumar's message of "Fri, 6 Nov 2026 22:06:37 -0800")
References: <CANphZRNSXy4tQ9jO7RT5g2X69T-CapR3-sSood1qJfYTRUE8ag@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 11:09:11 +0100
Message-ID: <87wlqbn514.fsf@bootlin.com>
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

Hi Roshan,

On 06/11/2026 at 22:06:37 -08, Roshan Kumar <roshaen09@gmail.com> wrote:

> Hi Yousef,
>
> I independently reproduced and tested this issue on current wpan.git
> (2b4707a149a5). I also prepared the requested rcu_access_pointer()
> update. It passes checkpatch, targeted W=3D1 allmodconfig/allyesconfig
> builds, and 200 KASAN teardown rounds without sanitizer findings.
>
> Are you planning to post v2? If not, I can forward it while preserving
> your authorship and Signed-off-by, adding my Signed-off-by as the
> forwarding submitter.
>
> v1:
> https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.=
com/

No v2 sent by Yousef. It is the fourth time we receive similar patches,
can you quickly send a v2 like you offered?

Thanks!
Miqu=C3=A8l

