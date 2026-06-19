Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2D3C3C00;
	Fri, 19 Jun 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902739; cv=none; b=VMEpMg52QNy28pYsSNrHkN52gbF1T4uKkYB4F6HOyK3wt2nfPbYQgMXuEa6IgFGVaJtrVYsRnC6BIYrcbujhgmcRfiI2phVNipdziwB4kQVBM27TW9O2i/KakaKOVKATMkHmNMQWlmBKWw2VnGOitdghiZAvYgyC6OpY8bU+T5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902739; c=relaxed/simple;
	bh=oooXo17agqt59WPLk3K1n2OhubOgja7s+KkLia3OLv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXJYqCBhLujql9CdYB63c6wPUY4M+p2bWoqnnP53I8AOdsYV5puR4BnE8jH3a7rGT1HYx73mdBlWSpt5/atLk/EHp81E5tuFyGTVbV4/rqjm0S+YTN0YNVOxIFHWX+AJG3TlEXFxnJJb2ByGCOUc7MAv9NfYYmx+AVxz6qjXPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 041FEC0879;
	Fri, 19 Jun 2026 22:58:54 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in mac802154_perform_association()
Date: Fri, 19 Jun 2026 22:58:49 +0200
Message-ID: <178190268127.829220.6513673834040282671.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com>
References: <20260602054133.470293-1-robertusdchris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Robertus Diawan Chris.

On Tue, 02 Jun 2026 12:41:33 +0700, Robertus Diawan Chris wrote:
> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
> 
> This is reported by Coverity Scan as "Unused value".
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] mac802154: Prevent overwrite return code in mac802154_perform_association()
      https://git.kernel.org/wpan/wpan-next/c/649147cb3f8b

regards,
Stefan Schmidt
