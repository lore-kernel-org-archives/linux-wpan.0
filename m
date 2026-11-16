Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811972;
	b=auStABVOWGnTnR0QGsSWZ5UFQetJ8teYtKhVjrAFU+FTUKTMAN+Rakd03TU/8aDAEUKC
	 RXbKWPx2lv214nsfs1Gmj0cenrrwjxBtiaoNlgBpZWurdXJ39DvNLNUsPeOJHZTCeIwGc
	 Jwiq6Tq4dUE1jhE4noC1dU7Ts8Hg3CPQpk1dVrPGyLScD5gfIkh+Kc4x10raHGinao4wd
	 V556D4Qs0YVwy/zn1Qg/vGi4xBMUG1t2OH+3QIxznNGHwq86m2UTIH+l4A49ZD8TaNmQR
	 e/SD7LEk4sFkvp6dQSimOKzgobQlPvLGSKNKB0A39f6QaIda/0Q/C0P6xqNgN5bvXUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cjhcJXXCSoPUURtlLlIneNXvDxbgE0VczhsVYg4OWeA=;
	b=wwdiI1ZLFWjKjHLxKIXjZfZk3fPOtFjZdDtwQcn6TEBviWjk4jLqi2Cg2tO5HjVik1d7
	 VSpOEMcSk4ZshDprNmoV8r9GjtSaWygh+Pt4MJ59OWf2mzHyvPjjVqPSFWB3KtWCI41Iz
	 mfbVJ0saQFRb/LRMbpCdu4fntJA5glEhqOpVX6ZjATXYtgJ386ogH5SD5HSav76nj312N
	 gkGAnT08ou85F7Ig74CNeLmd6VoeGsgaimQOTP8VhAz0T3EnClRmO24/7qPueExBij33a
	 zW1lkLPHuyIh783aK/neCLz6TV+YjLQ+zmW3eTiHyLZPmM1kBQjk4ucLLAzN3jdDaAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3H+UGzl;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD59606A332
	for <linux-wpan@vger.kernel.org>; Mon, 16 Nov 2026 06:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD59606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3H+UGzl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e10a70540so1626563f8f.1
        for <linux-wpan@vger.kernel.org>; Sun, 15 Nov 2026 22:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794811970; x=1795416770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjhcJXXCSoPUURtlLlIneNXvDxbgE0VczhsVYg4OWeA=;
        b=q3H+UGzlRUdmWHbUPd7t3HR5eKwNDbaFWW84LlpilKC0Bmwf+p8Qj822BX83el6jq0
         x97fSwmaPxrNovwx7gS79U6KbORn8lKnRVysFSFqxpm6Q0NWG5V0gm2gN025OB4hAx0U
         MxQRjIpSJ9RYdqEbZ6nNKCuD0f4TA2h2nssetnqFFnQ3+uLZ/eByv1m5s1MQ4ZzJB1nn
         27rKZDqHMauhvfY2iHIWBRxfdArVVwjBmh1AvkauVXRu3PzvtyPsuVHQkryoYcP2kVk8
         ov5YzEupC6YOSRgvymDeHVgQ2vU59tY7GHqk6QOGNW78yk2qVvb6ytRx8gcL0rF0zsFR
         VA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794811970; x=1795416770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjhcJXXCSoPUURtlLlIneNXvDxbgE0VczhsVYg4OWeA=;
        b=Ud6s+sj3hV1u3YMGQhBcPo5qvIUO0yF+TTWUBlll0GbrFK5+orIAHlMxE3fJb2Oscu
         ZQQySuo+CGF9o1nO2f0LqgcXg7VGWJje1WP7A/tLYkEWJsAUgQnTKQuRNIsSW0WLiPjc
         NdvnDthAaLXU1ohrEEhNyM4SvBuVFa3PQuPSlpUU+528XFHNQKj4fSzLURbsXD55VjHf
         3Mll3hNuIyyP/WV1FfmhW6KscCPj+yJ8tY7dGQB4pxS39YL7+xgnGbcK3n1MISGlquSs
         iKpkImI8sZ/WsqblKVNatqD3Vk5zZrOGcE6eQRSeCgJI5ShypHGErDbAy5ZVg62mqR6J
         L25w==
X-Forwarded-Encrypted: i=1; AL+hErGxEu9av2Pbdm/HzHzS7cdxp77VmsPjLgZSNkvcNGtn6bkgOaDQfmkMJgg4+EimN45Jr4nFDyYmtWP2@vger.kernel.org
X-Gm-Message-State: APuU4Z8vfK2ppE8P2eOYu4UmI3r0AUarEajgTxPZZzMibApzYMRoiArG
	fn8Pt9xOmvAswvJXFAMEKvBe6hxDGaJiUtMZJoNiwFW1XLBHjFb5wSCw
X-Gm-Gg: AYBFou0ZHsJ74ZoBS0Xj2ZCA6MuYcfzrZG7wsDVFIMCvOFYdVMHUFc6vsNs28WHnk/a
	E8fAVNisq2xmHSZzaO1s9TWGbGadgq1ltOxRFYiDwDYeCahcuG84MgL4Tmrg8Kzcfd3ALvLt4i+
	0rHBGGL5GjvQ4K35mFts9bf32D6dwWGOa4FbnZ/Ccwhwk3MIPdjFQvfdfMRxSl+um47qNUR5MVm
	xhhKOgEYoiLEMdC//k05M3nzQrwTvTNU2kok4n5/jwPZL5/n83DnNmxG7O8Oe7B44MnhXOPPOol
	Olv4dT8YOwxGanoUyD8y6zv5j0D6Egd7LfE0nW0sH3HoEopr0KlSveLtD4Z2lKt53YQPls+E60D
	togiFkPoKt45V+YaAd9gf3BRkPXMiG/DMG9tmeO/2umUuxx55ZBbL9rNQ69s14buuRvxfFe4CP9
	F3b+wKh9X3hv8V5OD/T/XBZfz0T9nUwP5FtY7IiIPWj8KFQzXwqiXlD+8TLeNFxCDdMhdq93XaQ
	3e6UkGwwz1iLBUGw53GoTmjg9sD74BsqIQUgTZCs67iw+8a+/6+CkRneZDPkrX9atAqwQbcktyG
	Du+p/h82R+Hd9PGJJ8vL
X-Received: by 2002:a05:600c:8b4c:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb55ab56ffmr208709665e9.28.1794811970223;
        Sun, 15 Nov 2026 22:52:50 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6caae30csm86848945e9.2.2026.11.15.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:52:49 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net] mac802154: remove redundant security_enabled assignment
Date: Mon, 16 Nov 2026 13:52:34 +0700
Message-ID: <20261116065235.27348-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fuzz testing, the following issue was discovered:

BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
BUG: KMSAN: uninit-value in ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
 ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
 dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x2f3/0x360 net/socket.c:726
 ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
 ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
 __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2751 [inline]
 __se_sys_sendmmsg net/socket.c:2748 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
 x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:47 [inline]
 do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:51 [inline]
 ieee802154_hdr_push+0xa5b/0xb20 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
 dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x2f3/0x360 net/socket.c:726
 ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
 ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
 __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2751 [inline]
 __se_sys_sendmmsg net/socket.c:2748 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
 x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:47 [inline]
 do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Commit f30be4d53cad ("mac802154: integrate llsec with wpan devices")
introduced mac802154_set_header_security() as the sole function
responsible for enabling frame-level security: it sets both
hdr->fc.security_enabled = 1 and initializes hdr->sec together,
maintaining the invariant that security_enabled = 1 implies hdr->sec
is initialized.

However, ieee802154_header_create() was left with a pre-existing
assignment:

    hdr.fc.security_enabled = cb->secen;

This assignment can set security_enabled = 1 (from a stale cb->secen)
even when mac802154_set_header_security() returns 0 without initializing
hdr.sec, violating that invariant. ieee802154_hdr_push_sechdr() then
reads uninitialized hdr.sec fields.

The stale value in cb->secen arises from a specific setsockopt()
sequence: calling WPAN_SECURITY_ON (secen_override=1, secen=1) and
then WPAN_SECURITY_DEFAULT (secen_override=0, secen unchanged at 1).
This undocumented combination likely explains why the bug was rarely
triggered.

Remove the redundant assignment; mac802154_set_header_security() is the
only correct place to set security_enabled.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
Closes: https://syzkaller.appspot.com/bug?id=23f21e76e9d2d1ed587cb5e71515260d6d025b63
Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/mac802154/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index f437b8daa00d..7b7332805ecc 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *skb,
 
 	memset(&hdr.fc, 0, sizeof(hdr.fc));
 	hdr.fc.type = cb->type;
-	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
 	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
-- 
2.55.0
