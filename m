Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3062D5925
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762595; cv=none; b=QlYwK4b817gX39w6wMcIL09bGbIrJMsXkmBk0/VPqJiORhOQgIk4V15YYhp6etUAut/GAW52LZHtDjcLGHyuGY2k7kFdfnk4YEuwk4xIZ2b6e1gxG7GEPoaiKTb5yn2MHcbMJPlzaLQJsq7vsjRtNII7WPfoccOkMBeZjZKtAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762595; c=relaxed/simple;
	bh=h8yBW128kC6yX0Mbe0qpxQPEOQyOQSKaauQlDCSUrqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgsuRFtx0RVoaU2m4fK4Wxg6dY4hrfys/loZNwfqiuez2jfkvtyDQNd1bjKuG5yeLaKkFXsd3pjbuCzIQzEpKG8MSKK/M8WrSs9ucHbZKF6byAObh9aWHiTEJIe+rMw7xepcFfj3YmLfYfnBwaTTtSXZCExLEve/JAe0U+kA7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kix/HcDH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kix/HcDH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 53B634E41559;
	Mon,  7 Sep 2026 06:29:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2787960383;
	Mon,  7 Sep 2026 06:29:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB5F311C79D5B;
	Mon,  7 Sep 2026 08:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788762577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h8yBW128kC6yX0Mbe0qpxQPEOQyOQSKaauQlDCSUrqE=;
	b=Kix/HcDHk+iqZ8Vbfc6dAHUsZ7xAd+BYxwolWi40wLloAG3W7JVb83LbBfKwm9ve2It9kg
	ttzW1LHOl+PfxdZMa2Qx1ZiJ6Iu3fNG0JJ2Cjv2oguRsA2fIu3uTVO4rvuXURPzSe30ynZ
	o3vyScJ9Pjwwm1PiIDmzoldBH6jXwMd+fyefpDZHbZwNJWSJ2THKi9HQ/8tWT1n1Dks//g
	vzjZLAJZmQd0CIhozqQUK5gSx+DIu21aUuYB72mvfr7L1rJpHxMr+zVz6zMCIxTm7WIAqd
	1YdgyiqR8mXZcurh/toAsiViONCD+6FtFZHzAEvjvRT7XlObRz6K1mYytXwPww==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] ieee802154: register a device type for the wpan netdev
In-Reply-To: <20260905212007.304875-1-adrianox@gmail.com> (Adriano Cordova's
	message of "Sat, 5 Sep 2026 17:20:05 -0400")
References: <20260905212007.304875-1-adrianox@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 08:29:35 +0200
Message-ID: <87y0ddy3ow.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


On 05/09/2026 at 17:20:05 -04, Adriano Cordova <adrianox@gmail.com> wrote:

> The cfg802154 netdev notifier never sets a device type, so wpan
> interfaces lack a sysfs "type". Mirror cfg80211 by calling
> SET_NETDEV_DEVTYPE() in a NETDEV_POST_INIT case with a new
> wpan_dev_type.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
