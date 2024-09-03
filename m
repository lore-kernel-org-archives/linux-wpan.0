Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C015574F;
	Tue,  3 Sep 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388979; cv=none; b=EIxOyo+yo66vZDZMcIWoS/5fKhKmBEUw5+ticLriASxfjaJgbFLztlP8MeNQa5OQOCbnVAQdxrzxgSm5HvuJH18Uialn+ntAwAfPCWYdQ4oehFofD2HijWAjKnztUl7sZJ6KXMOlfwBx+RWtRvHEeLfdEzImioUk84gMqciYNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388979; c=relaxed/simple;
	bh=nyaB7iBlc36IhwMs3yAlRM1OHMBbN1LH0WFI83yEy78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn3iqDwD5bgX17YyvsPXen6hwpybZv+Zgm8H8h4A9d6OO9R9eXAQOW3q1g0J8FwULboYVqcHCsSPd8rA7HvxpMjyAIfwNzlnYLOSn/46R+bBlmf44FIB63hAVPGTBH4qWKY0RyvfL9WI/s75tBDK6sJ+1iGMzBTgO42g7aFtuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF4My5JS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF4My5JS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149D6C4CECB;
	Tue,  3 Sep 2024 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388978;
	bh=nyaB7iBlc36IhwMs3yAlRM1OHMBbN1LH0WFI83yEy78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lF4My5JS9KgFHIjAFwCTFcj29sbb3zam9Oy7WTUZuCElkcQsLQ798hpx1C0QViTwf
	 6GE94r1Go5AiTCHaYk9CIzzuTD2hSMnXZ1AkG8MMeWdXU0/5w3jytn5A2GlWhtNe0a
	 PVB0DImky6z11GXIp8tK54XOR16EqP+aELMjZA9+FVgb86S6c9RSL2vBnQewbhoanJ
	 nN7irAQUDCBRBJmoA3qRo40BHMYOw7my/LGuo5MFKmD8lcDiYMZcpNBiJdi/43NMJf
	 H8hJTvyMssXyBfg3uzngt0Ko9NsfNJ4uwrqNaydw7vIMd0X1W0H/4FSsHiE4zDQuEu
	 icBchEWik7KGA==
Date: Tue, 3 Sep 2024 11:42:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2024-09-01
Message-ID: <20240903114257.7b906da2@kernel.org>
In-Reply-To: <20240901184213.2303047-1-stefan@datenfreihafen.org>
References: <20240901184213.2303047-1-stefan@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Sep 2024 20:42:13 +0200 Stefan Schmidt wrote:
> Simon Horman catched two typos in our headers. No functional change.

Is it okay if we merge these into net-next ?
On one hand they are unlikely^w guaranteed not to introduce
regressions, but on the other such trivial spelling fixes are
not at all urgent.
