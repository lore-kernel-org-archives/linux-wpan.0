Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260763B810D;
	Mon,  7 Sep 2026 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762607; cv=none; b=FHcg11q5iBJjxIe63m1rTEZ7gO2ogtqFrh25c+0vBiz+M7R6mJ/BaXrx24boq+pIpqMzWMznANk0DHecvRiMDVvWaRurFEZYh483CgVyspE5OljHUOlAufkIBAE05a71SarEvsiJKNzPHtqcKIhAbl06P5GqK2Gogn1hPG5YURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762607; c=relaxed/simple;
	bh=XIdFeViXGLgb9+qyAiusxSvZPYTUiIt0+kTETG63yTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YfguysWDI3AlHTb5/Zh+7BJOyWRDVRP4Svi1eumQ0KYYjJxEtA45ZAEf3FerWqu4V+HLclDT4XKYWxnXicPbdS5ECSioJSw8s3d4p1kAWNcWqyqKPXXPYcosU0a4mgwv2lfNJeWy7yTAkwqgzsr7r831wdfQN1TUWolAnhntFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=opJYTIUp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="opJYTIUp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 702F71A1A19;
	Mon,  7 Sep 2026 06:29:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BF8660383;
	Mon,  7 Sep 2026 06:29:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EA6611C79FF0;
	Mon,  7 Sep 2026 08:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788762594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XIdFeViXGLgb9+qyAiusxSvZPYTUiIt0+kTETG63yTE=;
	b=opJYTIUptPSlAaH/ERhrPbRu4l4/JAGiaeUjtxg0JYPEyq4nJnPCfNf+DIU4wfueDsE+qL
	U52y/yK/rwpLaiBOCUi+4vvsrNABzf1EuQCwv68lXmTOQhBHmresg/PqmbWs4x12Wkmraa
	hBvz+fGEkas/6chniE42Ct3ds8rbWkTuoRDVjALSCAZFPbEjHq1P8/GfmM6VOBXIjMOCCQ
	M9+nqrLumzoAwzmXP2UcixPqNY5XHYWqSWz6nJ+A605gCgbthMg4GCIhPeSWB4fwpxoKkS
	hytZ1Nj4I1bnf1D+YjIu1XKHGFjFcUKr0kGuQRuRX+svlImcNwEu1XVJZt7C6A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] ieee802154: warn on unspecific wpan interface type
In-Reply-To: <20260905212007.304875-2-adrianox@gmail.com> (Adriano Cordova's
	message of "Sat, 5 Sep 2026 17:20:06 -0400")
References: <20260905212007.304875-1-adrianox@gmail.com>
	<20260905212007.304875-2-adrianox@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 08:29:53 +0200
Message-ID: <87se3ly3oe.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/09/2026 at 17:20:06 -04, Adriano Cordova <adrianox@gmail.com> wrote:

> Add the unspec-iftype WARN_ON that cfg80211 has. The iftype is set to a
> real value in ieee802154_setup_sdata(), so hitting the warning is a bug.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
