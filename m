Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F321547C6;
	Mon, 11 Nov 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353782; cv=none; b=O1zvkvE/r9kr8oiGueXotGY3suKDZFuFvXpIKRwBvcpgseiJkR3pdHi+euVhNFGhY9a2xA81C+UlMOUR0g7N6Gu1GexUBIg6SuEdmjRrp7YHnMDEh9NwzBnMUfPnWOh6TjpzSuhAbr6UmWtspVVtaGzNMQUYkCiCgk8b6eEYL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353782; c=relaxed/simple;
	bh=LnkuvdD0+r7N3sZkQwtrXzagH/HtIkKyubxpFKob8RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usmYMxfHmzj4uLxiaL7OoU7mrfpEYP7+AUJYmjqndDq28Q5RD/C56slhfXG5X1zyFarZTXT+imVKuqfgD1uyi7Xbzg82ozRYtUvrKiyn3h8+ZJ70tLM6SYu+aKT5Z+eVfIsv/dDrQfdqcBT5+abTJkqipxysZMCygO8qPZPaY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WTW9Qgm6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WTW9Qgm6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10E7640003;
	Mon, 11 Nov 2024 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731353777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnkuvdD0+r7N3sZkQwtrXzagH/HtIkKyubxpFKob8RY=;
	b=WTW9Qgm6YjBnGCGsfvhxhnQ1JZtj9w4Ouv7kGviu1+vhs57Hr44kapYO1UHDlmb/2nrpzh
	IsOZ/gG66308+Y2hQXdVnuLmV/ypq/DTzIrUaiD2JenEJuvTmC0Zw0dOHzERNcmo/X4AD/
	4n6kmH0DcRZeOwl32NCCSfu2Ej2/EX3KKbWhVKHip8O4RMKWeRPoQzf4JUdY5CNLG4GqWq
	M9nAgi52fxkUV/n7M9PTg7rNvS6367F2pm2KbkTfWFfhuJswhS9ip1lc/dmK3UNhFuyJun
	OQjG+AThdS42qJHeAO0kIdt2V+0n6ajYjUVsmq0JUY1x3PcsWhfqj6DUTd7XVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,  Marcel Holtmann
 <marcel@holtmann.org>
Subject: Re: [PATCH] ieee802154: ca8210: Add missing check for kfifo_alloc()
 in ca8210_probe()
In-Reply-To: <20241108133901.GD4507@kernel.org> (Simon Horman's message of
	"Fri, 8 Nov 2024 13:39:01 +0000")
References: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
	<20241104121216.GD2118587@kernel.org>
	<e004c360-0325-4bab-953d-58376fdbd634@inria.fr>
	<20241108133901.GD4507@kernel.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:36:16 +0100
Message-ID: <874j4dr2a7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> > On Tue, Oct 29, 2024 at 07:27:12PM +0100, Keisuke Nishimura wrote:
>> >> ca8210_test_interface_init() returns the result of kfifo_alloc(),
>> >> which can be non-zero in case of an error. The caller, ca8210_probe(),
>> >> should check the return value and do error-handling if it fails.
>> >>
>> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device dri=
ver")

Stable tag missing.

With this fixed,
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
