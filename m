Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C11DD0F6;
	Fri, 28 Mar 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743129048; cv=none; b=JtGtfBeNTxk0noLYAwnVl4HvUK+QF8TbHTQQ6afVW8htIJTrhHZ9O/8OCVcYOa1qcZwbtZIEopwGXVgiQCOy2Z6tCQIH+Y3Q1YSnWHmtl1g2KQnfehHMceFBTJhE9Tn9FHpDRez3hZD5avbIEre3iU3Aec7gqwrPlk4dxA0ZP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743129048; c=relaxed/simple;
	bh=SzZGuMa6O49QtkMtvYLA+m6rqUUJ8TnCsKUMX/PQ1fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBlzkHOCXHtCAL/N8dx5jddHf2hMVWYS/vLUlFO77NTHPV7rfZ0EGSHlZViznRaxxzb6MqreVT3cBku1BjucVMf7ZT0o526QCabaHjAQDXsAV7lfdyZm9h9BrgCEPzl+wt6+lFkBxaTPJzUgGlzRP05aKHe6in9aQT1fLALt9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hPO/7+Kp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hPO/7+Kp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743129048; x=1774665048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuyC9tRIyCHv9mGz4HeexQdHyItb9SPLN1QQARs1t9s=;
  b=hPO/7+KpKCwgbGumbnN1OK2nX5nxks09cwF233ar8fQxHpFgk/+QT7IC
   kwcC0reVLXZT5o8eGyIc0juuJsK8L99FnTl87pT835Dz1gBW4CA03yEBs
   IW9uRgJL1U7CTd3TOwDDctkpgOtDucdikqMW7LLqq+42gmg5sFmbz087i
   k=;
X-IronPort-AV: E=Sophos;i="6.14,282,1736812800"; 
   d="scan'208";a="708865167"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 02:30:43 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:45012]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id 5067ac5d-06a6-43df-9352-1023f4a4f172; Fri, 28 Mar 2025 02:30:41 +0000 (UTC)
X-Farcaster-Flow-ID: 5067ac5d-06a6-43df-9352-1023f4a4f172
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:30:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:30:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <i.abramov@mt-integration.ru>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stefan@datenfreihafen.org>,
	<syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
Subject: Re: [PATCH 2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
Date: Thu, 27 Mar 2025 19:30:02 -0700
Message-ID: <20250328023029.14249-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328010427.735657-3-i.abramov@mt-integration.ru>
References: <20250328010427.735657-3-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ivan Abramov <i.abramov@mt-integration.ru>
Date: Fri, 28 Mar 2025 04:04:26 +0300
> It's pointless to call WARN_ON() in case of an allocation failure in
> dev_change_net_namespace() and device_rename(), since it only leads to
> useless splats caused by deliberate fault injections, so avoid it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I suggested using net_warn_ratelimited() so this tag is not needed.
The patch itself looks good to me:

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>

Reported-by: syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000f4a1b7061f9421de@google.com/#t
