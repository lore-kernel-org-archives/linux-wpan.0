Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678166;
	b=OkeBohRYo09vD6hARoapoihZFHe0Gw09JVvJ7ffGk93rhdkojQ/7o5izMIjiRSQpDIDo
	 /X603B8QOM/UxXB9mQIf3jTeqiSzBLPK9xVbO2ox6Px2o1UJo87kaNl1SDmyOcLdELNDn
	 FGH7ktqDRaoIAbvT3Maesm9wc+WUiub7mrT5m0SGxdFe9T2nUoUiWpxAvCh19nSth0RLY
	 vVHFfqAu+UsO58NXENdjTkxJezlAAlBTg9z+D8YzjUIn9SRpfU/zwPFRTeZSCw01z9EFN
	 1gLC66cNvjOyRlwhDEq5UewHkn+tvMop70PNHUyKeyWpfpxffqXiv1V29mTyABBBeeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678166;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xDKtb53WKmS6drwILREpafailbq/5rEf/8BZgYqOl/A=;
	b=znfC5koOWCoYb60J+0gGzCcc/jFZGRm87JslqDppLhY2QfMS2hQWj+OG+CkRBE+m/ThD
	 TjRyEJAcV7kjIKjqZyNf2UgK4UHOlTQpw/oxvFFh0Lrp5/iCvGKye8QPrs6GcEb3VXUPj
	 +n3eSCsRMnLsRtHcZKv6kh2Cc4hMxKIm+uU4zp6cB8kGd5i5AynLhDlKV4RNzBF6hjndT
	 FRmhWC2zbce93BJAHeWNlSckQ/QW4fgj415vkGup/TLuTQfPJC5RF6NoQDrYqqGRMXStc
	 P/hQyLyiWBiNSY6eEGAFG09TeFJ0HDtMpfvMDuIjk5mgUo6HUvE6XBND3UOFNVndgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534F606A31C;
	Thu, 26 Nov 2026 07:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5534F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 86812C0270;
	Thu, 26 Nov 2026 08:29:24 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Adriano Cordova <adrianox@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ieee802154: register a device type for the wpan dev
Date: Thu, 26 Nov 2026 08:29:17 +0100
Message-ID: <179567814824.1873149.12087212260540181458.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260908203533.102378-1-adrianox@gmail.com>
References: <20260908203533.102378-1-adrianox@gmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Adriano Cordova.

On Tue, 08 Sep 2026 17:35:33 -0300, Adriano Cordova wrote:
> cfg802154 never assigns a device type to wpan interfaces, so their
> netdev uevent carries no DEVTYPE key. Mirror cfg80211, which calls
> SET_NETDEV_DEVTYPE() from a NETDEV_POST_INIT case, and set a new
> wpan_dev_type so the device is typed DEVTYPE=wpan.
> 
> 

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: register a device type for the wpan dev
      https://git.kernel.org/wpan/wpan/c/1e277fce233c

regards,
Stefan Schmidt
