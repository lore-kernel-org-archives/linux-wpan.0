Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41613A0B24;
	Wed,  9 Sep 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940350; cv=none; b=gbTC7frvE5w4YBxZkbOio22GuwOIw4ByvTi+MtFJb6sgA7tFoGlIYjs98siq5dNGSymmjU9hnb5kI3AbhNr6EOteLwSfa1OozaH27TyGuBIqXMWCUVeaNwHS7uzGooWEfoGaHMnblgtoSfBnaAXvYngSOiZZwp/DEgpqHISsxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940350; c=relaxed/simple;
	bh=VK56naPTqPrtgsF25m3E+Fv5JbhwuquLuIhx/A7VneM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUKaBJVbkej1ZSphRan+bwNud+W7RCCjJ09PGLImyCwG+IYBPH7ff61P1wMzfGOnrWbwX6nc0AgyB3/crhS7kL3l2jmdHe06UK3FwetbYS0BUlkxM7KtIswL5BOZCqOmVlg30V5TDDBU19RrFzRPIam9FvA2agA/DhZaxNUri5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cTorz92V; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cTorz92V"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4308A1A1A73;
	Wed,  9 Sep 2026 07:52:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16DC460448;
	Wed,  9 Sep 2026 07:52:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C777111C7AF5E;
	Wed,  9 Sep 2026 09:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VK56naPTqPrtgsF25m3E+Fv5JbhwuquLuIhx/A7VneM=;
	b=cTorz92VOTcridZGAfPep77gwng7PIt/IUdklLYAnForLkT2irhU6DmlDszIXaRmEMbmyV
	1YBLxib8yjmf1tj7DTRBZHbhc1zfnG2EruCHv4VjPd+a5n6c13IwjZlhx/WuKW6lnNI4hW
	77pRIo5bxPL1jbCgyLfAwZ6W8y/7Im7EFmVHnUHiYAYj3j+mv/iVl03IIKbNuM/u7yMRhN
	lNlhKKwrptizTW8J8tBbUbvy/yNrT86Ijrm+AmwWbdEtvZjXeK7V61YJBO4r7bvbzs5Lrj
	s/NSc5l2pVqNauVP/FN9xi3WCPGvferXFy38L/LSSXGsbiwkmo8NZybo+xqTuQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v2] ieee802154: register a device type for the wpan dev
In-Reply-To: <20260908203533.102378-1-adrianox@gmail.com> (Adriano Cordova's
	message of "Tue, 8 Sep 2026 17:35:33 -0300")
References: <20260908203533.102378-1-adrianox@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 09 Sep 2026 09:52:25 +0200
Message-ID: <87jyousvye.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

Hi Adriano,

On 08/09/2026 at 17:35:33 -03, Adriano Cordova <adrianox@gmail.com> wrote:

> cfg802154 never assigns a device type to wpan interfaces, so their
> netdev uevent carries no DEVTYPE key. Mirror cfg80211, which calls
> SET_NETDEV_DEVTYPE() from a NETDEV_POST_INIT case, and set a new
> wpan_dev_type so the device is typed DEVTYPE=wpan.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---

Diff is identical, why didn't you kept my Rb?

