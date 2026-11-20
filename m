Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182098;
	b=Gvc2uKvOUHyLjMbPhzV+CS0OLDrJN5P57D4iTptNxdarbQlhx+bXz9i6IapzO16LUSVa
	 kDMHyuFTfVWOK2kS07MmMFlHt8+jXrx+1pNLSFWxZtNkq5/Yz6vfooypx+1cPgyHrYABO
	 BKZQyFmwmVE0NcG1UQgurbXoRoVnlxWIS8jvHvW25KZn2UaucEXw/XnLCou/fqLPqzpx4
	 NTuZ8SZ7q8prjZo/PwmCPe/P+HsveMslVO7IAIs5sIiO7WZpCHSSQd2MMEB4seGD/ahwa
	 N0fyWIpZKPSbELylS/OIuHKdVfariu2ZAMKf8z8/xj6j/b/2Npd5AGJ6AojwqhnvnHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182098;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=G0kPPdNTzeRCcZm0NzcTP3e6FuzOTd+f7at7BqtBxS8=;
	b=nTinWq0rBB61zpN5ve+qn++QQvGL/Pp6S6LlI8tNILMOO1dapVtFhwc346QjxU+0SvOr
	 DLyFC88s8LA5Eu7jp3Nu/s/gBxMRmHViPUy3kBaRAW9ZHPz09Jecnu67fsU9wRIRvMux7
	 zYtba1bYhy+JzxosLKCp3TCrbRrjUhQzCWq1T+mNy+o/pPXpTg2jsK+QsQdHbh5ClKKrQ
	 BksoSl2paDIJlQdtc7JLXU91KVg1+i5k6qa3XwkrJqERlshH9REFEXpwKFrAZyP3hPXtJ
	 EvByRxyYwUda0zyZlnyOG0y9egFvYOBUYg1PGbPZcRG1uR4HH+mSaeYSaQjLkbuVrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYscEoj9;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFA60A2602
	for <linux-wpan@vger.kernel.org>; Fri, 20 Nov 2026 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEFA60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYscEoj9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9010BC6221D;
	Fri, 20 Nov 2026 13:41:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2899601B9;
	Fri, 20 Nov 2026 13:41:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5554011BC01FA;
	Fri, 20 Nov 2026 14:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795182091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=G0kPPdNTzeRCcZm0NzcTP3e6FuzOTd+f7at7BqtBxS8=;
	b=EYscEoj9YGnxqlJHMKsG6JZw95F1h+t2njcdESsHryNpDYMN7mkPyFtwVd0rnT4pSiRCXH
	Qs02vV6kGG5IRBy/26ighiaZbkvSX7cQf1ZeuX72BDUwvqWBlosmatNayyhKz651iB+S/5
	tgoTi5i9ta6xaUr0aJ/+1fPaX6TqxYhNwVvZJ7k2vrDvNHPUNZMtQdb9KcKvyJyS8pDftz
	pFQFO4aF1CYn2V0wxDdsGdWiqg+Hdrd30GHoxjWCNMVXVdUIj8BSnSZj1zrbLjtXbeAQ0y
	TffZmtSgHyQlIgxBxjmSR8Jsir+MgtIpdSKCQry2YX6uj40diKkzo/mhAl0KkA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Petr Vaganov <petrvaganoff@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  phoebe.buckheister@itwm.fraunhofer.de,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 net] mac802154: fix uninit-value in
 ieee802154_header_create()
In-Reply-To: <20261120084537.31991-1-petrvaganoff@gmail.com> (Petr Vaganov's
	message of "Fri, 20 Nov 2026 15:45:37 +0700")
References: <20261116065235.27348-1-petrvaganoff@gmail.com>
	<20261120084537.31991-1-petrvaganoff@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 14:41:25 +0100
Message-ID: <877bi7boxm.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 15:45:37 +07, Petr Vaganov <petrvaganoff@gmail.com> wrote:

> During fuzz testing, the following issue was discovered:
>
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>  ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
>  dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x2f3/0x360 net/socket.c:726
>  ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
>  ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
>  __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
>  __do_sys_sendmmsg net/socket.c:2751 [inline]
>  __se_sys_sendmmsg net/socket.c:2748 [inline]
>  __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:308
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:51 [inline]
>  ieee802154_hdr_push+0xa5b/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
>  dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x2f3/0x360 net/socket.c:726
>  ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
>  ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
>  __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
>  __do_sys_sendmmsg net/socket.c:2751 [inline]
>  __se_sys_sendmmsg net/socket.c:2748 [inline]
>  __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:310
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Both ieee802154_header_create() and mac802154_header_create() declare
> struct ieee802154_hdr hdr on the stack and clear only hdr.fc via
> memset. This leaves hdr.sec uninitialized.
>
> There are two ways uninitialized hdr.sec fields can be read:
>
> 1. ieee802154_header_create() had a pre-existing assignment:
>
>        hdr.fc.security_enabled = cb->secen;
>
>    This could set security_enabled = 1 from a stale cb->secen (e.g.,
>    after WPAN_SECURITY_ON followed by WPAN_SECURITY_DEFAULT), even when
>    mac802154_set_header_security() returns without initializing hdr.sec.
>    ieee802154_hdr_push_sechdr() would then read uninitialized hdr.sec.
>
> 2. mac802154_set_header_security() never writes sec.frame_counter.
>    ieee802154_hdr_push_sechdr() copies it from the stack into the skb
>    before mac802154_llsec_encrypt() sets the real value. If encryption
>    fails, or via AF_PACKET taps in dev_queue_xmit_nit(), the
>    uninitialized bytes are exposed to userspace.
>
> Fix both issues by replacing memset(&hdr.fc, ...) with
> memset(&hdr, ...) in both functions, which zeros hdr.sec entirely
> before mac802154_set_header_security() is called. The stale
> hdr.fc.security_enabled assignment is also removed as it is now
> superseded by the full zero-initialization.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
> Closes: https://syzkaller.appspot.com/bug?id=23f21e76e9d2d1ed587cb5e71515260d6d025b63
> Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
