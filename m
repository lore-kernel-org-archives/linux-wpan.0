Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A411D54D1;
	Mon, 31 Mar 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414017; cv=none; b=LMXlOVi/2DmfP18OAy4e06WRoo0GJGUZIZJv2/Gyt/R3JIFB51X2yMKOiwrefMtl6WTYNvbEArR9Z8JBUFtgc0XmyD2r7aeEONLONoLKtbzBR3B5781xwDz1BINEYLoRv6UOElllVTjZhdB/ssysvPLF/N3eYx81V2tBCpaxyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414017; c=relaxed/simple;
	bh=k12UreuXo3c2JZybYH8S+QjjIyzKPYmnZPgIgntFsyI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxuNuLhp/ALmcOVob3JthWI1+tCCfeCoiun60M3Yhy8qfsKWEaYpEOz+lBC7xc0UMgvu6+IGhKumAaE7o3mABWcNguKMAgKsPd4jeZ5z/8eMFfCLaUnglXvwrjTOWDv57OQfdu8tPKRwHClspRH/MOQxPspPo5IpxoxHhQ48PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=JurAxeJM; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="JurAxeJM"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id F1948C0003;
	Mon, 31 Mar 2025 12:40:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru F1948C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743414011; bh=7pkwmy/zVFndknwnlEjCwbF0G9iiLvo3J6N4X7M2Cgk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=JurAxeJM1SL6KnY3YR5lz4Qg9UcnJenmb0WBb1j2BdwFq9q5WFFXD+QSLz6Pj5rc6
	 0u30ptxeGz8vWgH8hSD+A/jiSycdIyBlo89TCy2kReRq0NddhugpCXwYSqflDhcWg8
	 3616R7RAMzhdAYOirqQXRrJCkWU9iTZ4pDKFFjq3skRHCODU2rT0DunXDJqhPo/oUk
	 6qwNsmKwmCsldwsbUG+25GZEOHiXqYhHl8sztt2FDlJNdufJMsxGqWhyMwuXgLY7mh
	 O1x9DOwlfDO9Mm7+FaKj9xdPI9l+l+V2D1z5B8cV4nAZpo/cuf7okYv4frRkZ8wjIM
	 /uzYR3d0Q20/g==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 12:40:11 +0300 (MSK)
Received: from ws-8313-abramov.mti-lab.com (172.25.5.19) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 31 Mar 2025 12:40:10 +0300
Date: Mon, 31 Mar 2025 12:40:25 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stefan@datenfreihafen.org>,
	<syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
Subject: Re: [PATCH 2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in
 cfg802154_switch_netns()
Message-ID: <20250331124025.7bb7c82e688ee244b2c45895@mt-integration.ru>
In-Reply-To: <20250328023029.14249-1-kuniyu@amazon.com>
References: <20250328010427.735657-3-i.abramov@mt-integration.ru>
	<20250328023029.14249-1-kuniyu@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/31 08:25:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;mt-integration.ru:7.1.1;81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192233 [Mar 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/31 06:14:00 #27842604
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/31 08:25:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Thu, 27 Mar 2025 19:30:02 -0700, Kuniyuki Iwashima wrote:
> From: Ivan Abramov <i.abramov@mt-integration.ru>
> Date: Fri, 28 Mar 2025 04:04:26 +0300
>> It's pointless to call WARN_ON() in case of an allocation failure in
>> dev_change_net_namespace() and device_rename(), since it only leads to
>> useless splats caused by deliberate fault injections, so avoid it.
>> 
>> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>> 
>> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> I suggested using net_warn_ratelimited() so this tag is not needed.
> The patch itself looks good to me:

Should I send v2 series with fixed tags?

Thank you for reviewing the series!


> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
>
>> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
>
> Reported-by: syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000f4a1b7061f9421de@google.com/#t

-- 
Ivan Abramov <i.abramov@mt-integration.ru>
