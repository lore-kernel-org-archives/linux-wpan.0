Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385C15624C;
	Tue, 24 Sep 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172074; cv=none; b=l1++Dddd/OZyYpY0T3qEDxpA8SVsYIHbPHjr2GcOoXPPaT5xv6iBxiMoLs7FawfRVIpjh/DlJbDzq2Wnw9sRH4hRXx1vUjiveCbI/2AIAUEBrGZVQPA1EzawM+gqys9l47Uu1hsdBP/HRKe2aZEMK2WpFgkUq0WCzrMT+g1woMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172074; c=relaxed/simple;
	bh=lXodk2MXvxPraZRmssIQ5FJJdSMd0JgYfi6RvY8ziAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHiqPwfdglYiOAi6z8OGiKL828An/gpvHfx7Iwc/Hs74SL1lL7eeYmQDzEBoXPcOJu9oio8W5zOLnnxreKVs46iJbw8iCKfnCx5tT5ckbXAoAvO511mLNOzAnSte+mIM6cGGqDdOuuLcJCgzC7McX2QBeMBjQplz4NLoMzAb+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id B6E03C0525;
	Tue, 24 Sep 2024 12:01:04 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	alex.aring@gmail.com,
	davem@davemloft.net,
	david.girault@qorvo.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Tue, 24 Sep 2024 12:00:39 +0200
Message-ID: <172717177514.3057794.16241311556115087833.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com>
References: <tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Jiawei Ye.

On Tue, 24 Sep 2024 06:58:05 +0000, Jiawei Ye wrote:
> In the `mac802154_scan_worker` function, the `scan_req->type` field was
> accessed after the RCU read-side critical section was unlocked. According
> to RCU usage rules, this is illegal and can lead to unpredictable
> behavior, such as accessing memory that has been updated or causing
> use-after-free issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
      https://git.kernel.org/wpan/wpan/c/bff1709b3980

regards,
Stefan Schmidt
