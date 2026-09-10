Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170F30C164
	for <linux-wpan@vger.kernel.org>; Thu, 10 Sep 2026 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002368; cv=pass; b=Cku5elFZSeY9I9LXyIhUydKmwnTNKMXGMCS2ePuHIMcHZlnYRSaWdFNBBz6CoNKdYqqGyOBvNcRn0TH4G8WlqoFnLAqCK5Ettk5z5M7mRXvS1cW/BInErwVCJynTfOW1iuzqrJNDzyjTP9y/UXjrbtJPQsHTvw7gOaKVjxY/Z8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002368; c=relaxed/simple;
	bh=5RWqYmnIfwjK4pAhlnnbe/ntAHz+yAo0yCWaDayhfY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XuawIr4R41mT52tYJX/me8ldNQL27vPjL7mpY/9dvJBkf7kBL3FWkOecUY+jiwK8Q9/cbhW4G8YC7MDQpH9fm4jNRnhmp7zVmRzHXhBY6jfPbxdsDN1WvgOSNN+xB348kLWyMSTOWONjGbt9pHn8F0wqpBfFVzlb8ZgWQa1hxIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=K+AuMBeZ; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="K+AuMBeZ"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97cc20c05d3so1994935241.0
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2026 18:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789002365; cv=none;
        d=google.com; s=arc-20260327;
        b=Fv3FcQW/Hy14ULzAL+XJwU9RREn3hRBauh+83mrG/OKT97ffVZ2Z77lMijesAJ/rN/
         H2Bi/EiFtykMvYC/qPfWJ4jInOAXdmEZqso9KhZ0HBlsiRnIXFz40Ju/aGOkLZ+/00jQ
         J1WmpiyD5naBhOgVErqA8Usta/lY5iRqnPYNYOtRGSPyY8Zmi3odZTHSKuNWMl700+oj
         uSFUdhzZJnj2Wh5lmLbY9Zt78aWGr+7BkKntVwvt3PXw7K/V2hKXFkTB2VAYg+1ebHNk
         tAJUKxRO14O76D3zHXcia9KUlm04mxSYoz6QwH5XzP3IRKqNNeUeTF2MX2p7zOMekUBN
         p96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OjDIC3NAZQLazccvFe9lyZc7TW9SyOV91vH6HZ1yPek=;
        fh=P9ZFYHwv8YcIPBylBVjjFLmsDxkSK8VRIXv+T35oEjY=;
        b=KbcsNYhMNtpraG1vd9MWFr5oEsLN7+ElmrvYKAjLNNzROibmWb7D6o8ejziqtNUrT0
         uDgguIIF4HAAqGxrpGcHdmQWa1jfQK8RXLkAoiHw2mdGZHECPBybHSN/At+DLg+I+Rfz
         G/JgYufTgQi8kIl3IGUR+Nfb2GuQaYQzPj5Q8q6FUYR7JpudMcHpWpSTD18042bJrUAD
         jJkHkfkaKFwA78qyEd0QMUeDbTjfp75gDlpv2aJffddxV1a6xBJ9u+tCz5xuQonRmXMU
         uuH2zqDyhkSVUvRwWPa8e8nktqxVs2LoNpIDz3kyVvitJeZ+oV2hQbguPYLuq648tTm7
         h5gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789002365; x=1789607165; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjDIC3NAZQLazccvFe9lyZc7TW9SyOV91vH6HZ1yPek=;
        b=K+AuMBeZJtywTTYHqMyLJlC+6yBiS5ORvM8w01Z40gD/TizfdomLmLnDugEkLhfw93
         RV2KCSHopX6C8InU2Pi4Htc5e/ggmzUxr2o2oY3Wx+JZIlxOd/u/Rvs+G+WFJHWLN+Ay
         +GrdVA1IpkhTSxjLLlqgvEIamrmxg4Jo+ELHpuDk0rLule3yhBRuCfZl3pnYNVyj9SYd
         8jCxd03cmzkhxpK4ttvF0ELTiDWhDrbSDBpnYpY6seve3UbbaDoyX1Lb2lhohWy7CpzW
         CMoZkTsQuxfET30I6SSGR1ybDlv3YjzbkjPO/bDM0NK1Pc+4rrGGqa8BApwqyds877lS
         hNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789002365; x=1789607165;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjDIC3NAZQLazccvFe9lyZc7TW9SyOV91vH6HZ1yPek=;
        b=lBgLvUx9sW7zCa82JkCptCFRCBonCKhkEzx+rGfAxp0N8chYEVtFwV2WLi2Yfx6SgV
         C6e76ZxkAT/u86oVyiYxPoGVS42Sw48nFbum90NEj7PD+X88dnmTEEeAuaTCPt9IBpgo
         wXCyz0xzgFW68TgW70Rsd+ySV2wNQUJ0Wgba0KMIokg5kwm6yUVr7lpCCbtkud2offsS
         wIDEh8hLzi53IilUBwYecl8UlpSfxoSGi8wn5c2Dp2QENIU+Hw0+dS8qAuT66WaI3L7L
         p5KkctkwtGFaUqQHW8edEAfKHFxeifAwXcBZRR/Qon6x5HDbEOU9XsFW5aMfk96+yMHZ
         Kk6A==
X-Forwarded-Encrypted: i=1; AKwUvBzVp+4WjXfXTXfHa5L6B1A7epebMWgfpPPpA8vYSfv7D6hnvcQ2CGTN8IAp7D/x7pOnEEoJ6oXVS+b1@vger.kernel.org
X-Gm-Message-State: AFuF++nL9nv/PQTCY4J5GbT/1HZb2G60Ot2EY1WjmJISu+qyX/NMvOKz
	KQSU+KvT/w/qgoGULh9xwEy+i5QF/Yj6G6gbTtEbDeUdwmT1EbNiLtUgv+ueM3h0rIuz4SvOYus
	VLyA2FLgLv26L3yDt/q86ywf/8V/WmrLHHiW9DSgx
X-Gm-Gg: AYBFou1OXWq2A1xpsm1WPbdwaB5xzxfBj0xmZY2Vz49EnyNAyzSN7XT2hm0v9Bneo6r
	E9jGnuWEeKqKp3DQXy8tcoIEk/1aqSi9xfCRQKdtXvpfezyXGeDusHw5KQ0lkgRTEI5L5SdZ89m
	/njFJSunhorz0D3O99l/5UcS/nJkEPOJbvzEN77kS8z86kW5sn+o7IQdbqLd0iTZMPJZo0L9+Ey
	X1/PTDkYcYwYXXCSvUF4MYpXCW9Kt4U3Vs/7XMhMgAv8V0wxK+mrySHFosrohQRzJa7Wd7CoFcc
	KoZvIfrZ+PADpCdZd/pyvuyAxX3Bl+OP/WpWywzURTBN5TEKalnX87OG5925iky1kQMz2yeglHk
	QUQKwVCt7GbZpOr+jX5Ri9JrDdA5RCJ0CvkhLnWw=
X-Received: by 2002:a05:6122:4f82:b0:5c2:ac92:eb18 with SMTP id
 71dfb90a1353d-5c7ed3f6d2bmr17036533e0c.7.1789002363872; Wed, 09 Sep 2026
 18:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Wed, 9 Sep 2026 18:05:52 -0700
X-Gm-Features: AcwNN1WigG3frIb0Du8Kqbbc1dX2Q9K1KjLA5txlIBvvNEfRlr76MtisLROeHog
Message-ID: <CA+0ovCjTsygN76s2o=TZqPqW8v2gBhmRnz+q6G-NaB3Cq-YPqQ@mail.gmail.com>
Subject: [BUG] kernel BUG in lowpan_header_compress
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Farhad Alemi <falemi@asu.edu>, Simon Horman <horms@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000680912065b1692d1"

--000000000000680912065b1692d1
Content-Type: text/plain; charset="UTF-8"

Hello,

We are reporting the following crash (reproducer and a proposed patch attached):
Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   50.238797][   T56] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[   50.241338][   T56] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[   50.241848][   T56] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[   50.245626][   T56] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[   50.245912][   T56] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[   50.754952][ T9494] skbuff: skb_under_panic: text:ffffffff8b7fa50d
len:64 put:28 head:ffff888111738000 data:ffff888111737ff4 tail:0x34
end:0x180 dev:bt0
[   50.755855][ T9494] ------------[ cut here ]------------
[   50.755867][ T9494] kernel BUG at net/core/skbuff.c:214!
[   50.755943][ T9494] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[   50.768411][ T9494] CPU: 1 UID: 0 PID: 9494 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   50.770445][ T9494] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   50.772451][ T9494] RIP: 0010:skb_panic+0x157/0x160
[   50.773445][ T9494] Code: c7 c0 a8 01 8d 48 8b 74 24 08 48 8b 54 24
10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 84 f5 ff
48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
90 90 90 90
[   50.777065][ T9494] RSP: 0018:ffffc900071b6ea0 EFLAGS: 00010286
[   50.777983][ T9494] RAX: 0000000000000084 RBX: dffffc0000000000
RCX: 4ccd4c5bba686000
[   50.778782][ T9494] RDX: 0000000000000000 RSI: 8000000000000201
RDI: 0000000000000000
[   50.779550][ T9494] RBP: 0000000000000180 R08: ffffc900071b6c07
R09: 1ffff92000e36d80
[   50.780352][ T9494] R10: dffffc0000000000 R11: fffff52000e36d81
R12: ffff88810804e290
[   50.781105][ T9494] R13: ffff888111738000 R14: ffff888111737ff4
R15: 0000000000000034
[   50.781865][ T9494] FS:  000000002fb9b400(0000)
GS:ffff8881da588000(0000) knlGS:0000000000000000
[   50.782727][ T9494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.783410][ T9494] CR2: 000055f09acf9258 CR3: 0000000022ecb000
CR4: 0000000000752ef0
[   50.784188][ T9494] PKRU: 55555554
[   50.784546][ T9494] Call Trace:
[   50.784881][ T9494]  <TASK>
[   50.785181][ T9494]  ? lowpan_header_compress+0x11dd/0x1ee0
[   50.785759][ T9494]  ? lowpan_header_compress+0x11dd/0x1ee0
[   50.786308][ T9494]  skb_push+0xc3/0xe0
[   50.786705][ T9494]  lowpan_header_compress+0x11dd/0x1ee0
[   50.787246][ T9494]  ? __pfx_lowpan_header_compress+0x10/0x10
[   50.787822][ T9494]  ? lock_acquire+0x115/0x350
[   50.788284][ T9494]  ? skb_copy_bits+0x8a/0x8f0
[   50.788745][ T9494]  ? bt_xmit+0x283/0x2280
[   50.789179][ T9494]  bt_xmit+0x12c8/0x2280
[   50.789603][ T9494]  ? __pfx_bt_xmit+0x10/0x10
[   50.790100][ T9494]  ? skb_network_protocol+0x23d/0x400
[   50.790623][ T9494]  ? netif_skb_features+0xdf0/0x1480
[   50.791135][ T9494]  ? lockdep_unlock+0x5c/0xd0
[   50.791595][ T9494]  ? __lock_acquire+0x25db/0x2db0
[   50.792082][ T9494]  ? __pfx_netif_skb_features+0x10/0x10
[   50.792620][ T9494]  ? packet_sendmsg+0x3039/0x4d00
[   50.793108][ T9494]  ? sock_sendmsg_nosec+0x13a/0x180
[   50.793635][ T9494]  ? __sys_sendto+0x408/0x5a0
[   50.794103][ T9494]  ? __x64_sys_sendto+0xde/0x100
[   50.794599][ T9494]  ? do_syscall_64+0x155/0x510
[   50.795065][ T9494]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.795654][ T9494]  dev_hard_start_xmit+0x2cd/0x830
[   50.796153][ T9494]  sch_direct_xmit+0x251/0x4c0
[   50.796624][ T9494]  ? __pfx_sch_direct_xmit+0x10/0x10
[   50.797135][ T9494]  ? qdisc_bstats_update+0x110/0x1d0
[   50.797652][ T9494]  __dev_queue_xmit+0x19ef/0x3980
[   50.798140][ T9494]  ? __dev_queue_xmit+0x2b6/0x3980
[   50.798637][ T9494]  ? _copy_from_iter+0x21b/0x1670
[   50.799132][ T9494]  ? __pfx___dev_queue_xmit+0x10/0x10
[   50.799653][ T9494]  ? sock_alloc_send_pskb+0x896/0x990
[   50.800221][ T9494]  ? __pfx__copy_from_iter+0x10/0x10
[   50.800733][ T9494]  ? packet_parse_headers+0x2e6/0x790
[   50.801250][ T9494]  ? packet_parse_headers+0x5dd/0x790
[   50.801772][ T9494]  ? __pfx_sock_alloc_send_pskb+0x10/0x10
[   50.802340][ T9494]  ? __pfx_packet_parse_headers+0x10/0x10
[   50.802906][ T9494]  ? packet_xmit+0x68/0x320
[   50.803358][ T9494]  packet_sendmsg+0x3b14/0x4d00
[   50.803852][ T9494]  ? aa_inet_bind_perm+0x6b6/0xca0
[   50.804360][ T9494]  ? kasan_save_track+0x4f/0x80
[   50.804838][ T9494]  ? kasan_save_track+0x3e/0x80
[   50.805310][ T9494]  ? __kasan_slab_alloc+0x6c/0x80
[   50.805811][ T9494]  ? kmem_cache_alloc_noprof+0x2bd/0x610
[   50.806355][ T9494]  ? __lock_acquire+0x74c/0x2db0
[   50.806847][ T9494]  ? __pfx_packet_sendmsg+0x10/0x10
[   50.807352][ T9494]  ? aa_sk_perm+0x713/0x900
[   50.807801][ T9494]  ? update_triggers+0x320/0x4d0
[   50.808282][ T9494]  ? __pfx_aa_sk_perm+0x10/0x10
[   50.808760][ T9494]  ? aa_sock_msg_perm+0x144/0x210
[   50.809251][ T9494]  ? apparmor_socket_sendmsg+0x95/0x390
[   50.809793][ T9494]  ? __pfx_packet_sendmsg+0x10/0x10
[   50.810343][ T9494]  sock_sendmsg_nosec+0x13a/0x180
[   50.810833][ T9494]  __sys_sendto+0x408/0x5a0
[   50.811275][ T9494]  ? __pfx___sys_sendto+0x10/0x10
[   50.811769][ T9494]  ? fd_install+0x94/0x3d0
[   50.812202][ T9494]  ? fd_install+0x309/0x3d0
[   50.812647][ T9494]  __x64_sys_sendto+0xde/0x100
[   50.813112][ T9494]  do_syscall_64+0x155/0x510
[   50.813567][ T9494]  ? trace_irq_disable+0x3b/0x140
[   50.814057][ T9494]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.814644][ T9494]  ? clear_bhb_loop+0x30/0x80
[   50.815101][ T9494]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.815675][ T9494] RIP: 0033:0x4527b2
[   50.816062][ T9494] Code: 08 0f 85 e1 df ff ff 49 89 fb 48 89 f0 48
89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89
5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa
55 48 89 e5
[   50.817904][ T9494] RSP: 002b:00007ffc7bf0a438 EFLAGS: 00000246
ORIG_RAX: 000000000000002c
[   50.818725][ T9494] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 00000000004527b2
[   50.819496][ T9494] RDX: 0000000000000024 RSI: 00007ffc7bf0a4c0
RDI: 0000000000000003
[   50.820334][ T9494] RBP: 00007ffc7bf0a460 R08: 00007ffc7bf0a4a0
R09: 0000000000000014
[   50.821106][ T9494] R10: 0000000000000000 R11: 0000000000000246
R12: 00007ffc7bf0a618
[   50.821873][ T9494] R13: 00007ffc7bf0a628 R14: 0000000000000002
R15: 00000000004cba40
[   50.822631][ T9494]  </TASK>
[   50.822957][ T9494] Modules linked in:
[   50.823408][ T9494] ---[ end trace 0000000000000000 ]---
[   50.823952][ T9494] RIP: 0010:skb_panic+0x157/0x160
[   50.823964][ T9494] Code: c7 c0 a8 01 8d 48 8b 74 24 08 48 8b 54 24
10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 84 f5 ff
48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
90 90 90 90
[   50.823970][ T9494] RSP: 0018:ffffc900071b6ea0 EFLAGS: 00010286
[   50.823976][ T9494] RAX: 0000000000000084 RBX: dffffc0000000000
RCX: 4ccd4c5bba686000
[   50.823981][ T9494] RDX: 0000000000000000 RSI: 8000000000000201
RDI: 0000000000000000
[   50.823986][ T9494] RBP: 0000000000000180 R08: ffffc900071b6c07
R09: 1ffff92000e36d80
[   50.823991][ T9494] R10: dffffc0000000000 R11: fffff52000e36d81
R12: ffff88810804e290
[   50.823996][ T9494] R13: ffff888111738000 R14: ffff888111737ff4
R15: 0000000000000034
[   50.824001][ T9494] FS:  000000002fb9b400(0000)
GS:ffff8881da588000(0000) knlGS:0000000000000000
[   50.824006][ T9494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.824011][ T9494] CR2: 000055f09acf9258 CR3: 0000000022ecb000
CR4: 0000000000752ef0
[   50.824017][ T9494] PKRU: 55555554
[   50.824024][ T9494] Kernel panic - not syncing: Fatal exception in interrupt
[   50.834454][ T9494] Kernel Offset: disabled
[   50.835002][ T9494] Rebooting in 86400 seconds..

Regards,
SEFCOM Lab @ ASU

--000000000000680912065b1692d1
Content-Type: application/octet-stream; name="207.patch"
Content-Disposition: attachment; filename="207.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtutskgh0>
X-Attachment-Id: f_mtutskgh0

LS0tIGEvbmV0LzZsb3dwYW4vaXBoYy5jCTIwMjYtMDktMDkgMTc6Mzk6MzIuMjQ2OTk5MjIwIC0w
NzAwCisrKyBiL25ldC82bG93cGFuL2lwaGMuYwkyMDI2LTA5LTA5IDE3OjM5OjMyLjI2OTUyMDk1
NiAtMDcwMApAQCAtMTE0MCw2ICsxMTQwLDEwIEBACiAJaWYgKHNrYi0+cHJvdG9jb2wgIT0gaHRv
bnMoRVRIX1BfSVBWNikpCiAJCXJldHVybiAtRUlOVkFMOwogCisJLyogRXZlcnkgZmllbGQgY29t
cHJlc3NlZCBiZWxvdyBpcyByZWFkIG91dCBvZiB0aGUgSVB2NiBoZWFkZXIuICovCisJaWYgKHNr
Yi0+bGVuIDwgc2l6ZW9mKHN0cnVjdCBpcHY2aGRyKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKIAlo
ZHIgPSBpcHY2X2hkcihza2IpOwogCWhjX3B0ciA9IGhlYWQgKyAyOwogCkBAIC0xMjk5LDcgKzEz
MDMsMTEgQEAKIAloZWFkWzBdID0gaXBoYzA7CiAJaGVhZFsxXSA9IGlwaGMxOwogCi0Jc2tiX3B1
bGwoc2tiLCBzaXplb2Yoc3RydWN0IGlwdjZoZHIpKTsKKwkvKiBOSEMgY29tcHJlc3Npb24gaGFz
IGFscmVhZHkgcHVsbGVkIHRoZSB0cmFuc3BvcnQgaGVhZGVyLCBzbyB0aGUKKwkgKiBJUHY2IGhl
YWRlciBtYXkgbm8gbG9uZ2VyIGJlIHRoZXJlIHRvIHB1bGwuCisJICovCisJaWYgKCFza2JfcHVs
bChza2IsIHNpemVvZihzdHJ1Y3QgaXB2NmhkcikpKQorCQlyZXR1cm4gLUVJTlZBTDsKIAlza2Jf
cmVzZXRfdHJhbnNwb3J0X2hlYWRlcihza2IpOwogCW1lbWNweShza2JfcHVzaChza2IsIGhjX3B0
ciAtIGhlYWQpLCBoZWFkLCBoY19wdHIgLSBoZWFkKTsKIAlza2JfcmVzZXRfbmV0d29ya19oZWFk
ZXIoc2tiKTsK
--000000000000680912065b1692d1
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtutskgs1>
X-Attachment-Id: f_mtutskgs1

LyoKICogMjA3LWtlcm5lbC1idWctaW4tbG93cGFuLWhlYWRlci1jb21wcmVzcwogKi8KCiNkZWZp
bmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5j
bHVkZSA8bGludXgvaWZfZXRoZXIuaD4KI2luY2x1ZGUgPGxpbnV4L2lmX3BhY2tldC5oPgojaW5j
bHVkZSA8bmV0L2lmLmg+CiNpbmNsdWRlIDxuZXRpbmV0L2luLmg+CiNpbmNsdWRlIDxwdGhyZWFk
Lmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRl
IDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+CiNpbmNsdWRlIDxzeXMvdWlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCnR5cGVkZWYgdWlu
dDhfdCB1ODsKdHlwZWRlZiB1aW50MTZfdCB1MTY7CgojZGVmaW5lIEJUUFJPVE9fSENJIDEKCiNk
ZWZpbmUgSENJX0NPTU1BTkRfUEtUIDB4MDEKI2RlZmluZSBIQ0lfQUNMREFUQV9QS1QgMHgwMgoj
ZGVmaW5lIEhDSV9FVkVOVF9QS1QgMHgwNAojZGVmaW5lIEhDSV9WRU5ET1JfUEtUIDB4ZmYKCiNk
ZWZpbmUgSENJX0VWX0NNRF9DT01QTEVURSAweDBlCiNkZWZpbmUgSENJX0VWX0xFX01FVEEgMHgz
ZQojZGVmaW5lIEhDSV9FVl9MRV9DT05OX0NPTVBMRVRFIDB4MDEKCiNkZWZpbmUgSENJX09QX1JF
U0VUIDB4MGMwMwojZGVmaW5lIEhDSV9PUF9SRUFEX0JVRkZFUl9TSVpFIDB4MTAwNQojZGVmaW5l
IEhDSV9PUF9SRUFEX0JEX0FERFIgMHgxMDA5CiNkZWZpbmUgSENJREVWVVAgX0lPVygnSCcsIDIw
MSwgaW50KQoKLyogQ29ubmVjdGlvbiBoYW5kbGUgdGhlIGZha2VkIExFIGxpbmsgaXMgZ2l2ZW47
IHJldXNlZCBhcyB0aGUgQUNMIFRYIGhhbmRsZS4gKi8KI2RlZmluZSBGQUtFX0xFX0NPTk5fSEFO
RExFIDIwMQoKdHlwZWRlZiBzdHJ1Y3QgeyB1OCBiWzZdOyB9IF9fYXR0cmlidXRlX18oKHBhY2tl
ZCkpIGJkYWRkcl90OwoKc3RydWN0IGhjaV9jb21tYW5kX2hkciB7IHUxNiBvcGNvZGU7IHU4IHBs
ZW47IH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CnN0cnVjdCBoY2lfZXZlbnRfaGRyIHsgdTgg
ZXZ0OyB1OCBwbGVuOyB9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwpzdHJ1Y3QgaGNpX2V2X2Nt
ZF9jb21wbGV0ZSB7IHU4IG5jbWQ7IHUxNiBvcGNvZGU7IH0gX19hdHRyaWJ1dGVfXygocGFja2Vk
KSk7CgpzdHJ1Y3QgaGNpX2V2X2xlX2Nvbm5fY29tcGxldGUgewoJdTggc3RhdHVzOyB1MTYgaGFu
ZGxlOyB1OCByb2xlOyB1OCBiZGFkZHJfdHlwZTsgYmRhZGRyX3QgYmRhZGRyOwoJdTE2IGludGVy
dmFsOyB1MTYgbGF0ZW5jeTsgdTE2IHN1cGVydmlzaW9uX3RpbWVvdXQ7IHU4IGNsa19hY2N1cmFu
Y3k7Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CgpzdHJ1Y3QgaGNpX3JwX3JlYWRfYnVmZmVy
X3NpemUgewoJdTggc3RhdHVzOyB1MTYgYWNsX210dTsgdTggc2NvX210dTsgdTE2IGFjbF9tYXhf
cGt0OyB1MTYgc2NvX21heF9wa3Q7Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CnN0cnVjdCBo
Y2lfcnBfcmVhZF9iZF9hZGRyIHsgdTggc3RhdHVzOyBiZGFkZHJfdCBiZGFkZHI7IH0gX19hdHRy
aWJ1dGVfXygocGFja2VkKSk7CgpzdHJ1Y3QgdmhjaV92ZW5kb3JfcGt0X3JlcXVlc3QgeyB1OCB0
eXBlOyB1OCBvcGNvZGU7IH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CnN0cnVjdCB2aGNpX3Br
dCB7Cgl1OCB0eXBlOwoJdW5pb24gewoJCXN0cnVjdCB7IHU4IG9wY29kZTsgdTE2IGlkOyB9IF9f
YXR0cmlidXRlX18oKHBhY2tlZCkpIHZlbmRvcl9wa3Q7CgkJc3RydWN0IGhjaV9jb21tYW5kX2hk
ciBjb21tYW5kX2hkcjsKCX07Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CgpzdGF0aWMgaW50
IHZoY2lfZmQgPSAtMTsKCnN0YXRpYyB2b2lkIGRpZShjb25zdCBjaGFyICp3aGF0KQp7CglmcHJp
bnRmKHN0ZGVyciwgIkZBSUw6ICVzICglcylcbiIsIHdoYXQsIHN0cmVycm9yKGVycm5vKSk7Cgll
eGl0KDEpOwp9CgpzdGF0aWMgdm9pZCBoY2lfc2VuZF9ldmVudF9wYWNrZXQodTggZXZlbnRfY29k
ZSwgdm9pZCAqcGF5bG9hZCwgc2l6ZV90IHBheWxvYWRfbGVuKQp7CglzdHJ1Y3QgaGNpX2V2ZW50
X2hkciBoZHIgPSB7IC5ldnQgPSBldmVudF9jb2RlLCAucGxlbiA9ICh1OClwYXlsb2FkX2xlbiB9
OwoJdTggcGFja2V0X3R5cGUgPSBIQ0lfRVZFTlRfUEtUOwoJc3RydWN0IGlvdmVjIGlvdlszXSA9
IHsKCQl7ICZwYWNrZXRfdHlwZSwgMSB9LAoJCXsgJmhkciwgc2l6ZW9mKGhkcikgfSwKCQl7IHBh
eWxvYWQsIHBheWxvYWRfbGVuIH0sCgl9OwoJaWYgKHdyaXRldih2aGNpX2ZkLCBpb3YsIDMpIDwg
MCkKCQlkaWUoIndyaXRldiBIQ0kgZXZlbnQiKTsKfQoKc3RhdGljIHZvaWQgaGNpX3NlbmRfY29t
bWFuZF9jb21wbGV0ZSh1MTYgb3Bjb2RlLCB2b2lkICpyZXR1cm5fcGFyYW1zLCBzaXplX3QgcmV0
dXJuX2xlbikKewoJc3RydWN0IGhjaV9ldmVudF9oZHIgaGRyID0gewoJCS5ldnQgPSBIQ0lfRVZf
Q01EX0NPTVBMRVRFLAoJCS5wbGVuID0gKHU4KShzaXplb2Yoc3RydWN0IGhjaV9ldl9jbWRfY29t
cGxldGUpICsgcmV0dXJuX2xlbiksCgl9OwoJc3RydWN0IGhjaV9ldl9jbWRfY29tcGxldGUgY29t
cGxldGUgPSB7IC5uY21kID0gMSwgLm9wY29kZSA9IG9wY29kZSB9OwoJdTggcGFja2V0X3R5cGUg
PSBIQ0lfRVZFTlRfUEtUOwoJc3RydWN0IGlvdmVjIGlvdls0XSA9IHsKCQl7ICZwYWNrZXRfdHlw
ZSwgMSB9LAoJCXsgJmhkciwgc2l6ZW9mKGhkcikgfSwKCQl7ICZjb21wbGV0ZSwgc2l6ZW9mKGNv
bXBsZXRlKSB9LAoJCXsgcmV0dXJuX3BhcmFtcywgcmV0dXJuX2xlbiB9LAoJfTsKCWlmICh3cml0
ZXYodmhjaV9mZCwgaW92LCA0KSA8IDApCgkJZGllKCJ3cml0ZXYgSENJIGNvbW1hbmQgY29tcGxl
dGUiKTsKfQoKLyoKICogQW5zd2VyIGV2ZXJ5IEhDSSBjb21tYW5kIHRoZSBrZXJuZWwncyBjb250
cm9sbGVyLWluaXQgc2VuZHMgd2l0aCBhIHN1Y2Nlc3MKICogQ29tbWFuZCBDb21wbGV0ZS4gIFR3
byBjb21tYW5kcyBuZWVkIHJlYWwgdmFsdWVzIG9yIEhDSURFVlVQIGZhaWxzIHdpdGgKICogRUlO
VkFMOiBhbiBhbGwtemVybyBCRF9BRERSIGlzIHJlamVjdGVkIGFzIGludmFsaWQsIGFuZCBhIHpl
cm8gQUNMIE1UVQogKiBsZWF2ZXMgdGhlIGNvbnRyb2xsZXIgd2l0aCBubyB1c2FibGUgVFggYnVm
ZmVyLiAgRXZlcnl0aGluZyBlbHNlIGdldHMgdGhlCiAqIGxhcmdlc3QgYWxsLXplcm8gcmV0dXJu
LXBhcmFtZXRlciBibG9jayBhbiBIQ0kgZXZlbnQgY2FuIGNhcnJ5ICgweGY5IGFmdGVyCiAqIHRo
ZSAzLWJ5dGUgQ29tbWFuZCBDb21wbGV0ZSBwcmVhbWJsZSksIHNvIG5vIHBhcnNlciBzZWVzIGEg
c2hvcnQgcmVwbHkuCiAqLwpzdGF0aWMgdm9pZCAqaGNpX2NvbW1hbmRfcmVzcG9uZGVyX3RocmVh
ZCh2b2lkICp1bnVzZWQpCnsKCWZvciAoOzspIHsKCQljaGFyIGJ1ZlsxMDI0XTsKCQlzc2l6ZV90
IG5ieXRlcyA9IHJlYWQodmhjaV9mZCwgYnVmLCBzaXplb2YoYnVmKSk7CgkJaWYgKG5ieXRlcyA8
PSAwKSB7CgkJCWlmIChlcnJubyA9PSBFSU5UUikKCQkJCWNvbnRpbnVlOwoJCQlyZXR1cm4gTlVM
TDsKCQl9CgkJaWYgKGJ1ZlswXSAhPSBIQ0lfQ09NTUFORF9QS1QgfHwKCQkgICAgbmJ5dGVzIDwg
MSArIChzc2l6ZV90KXNpemVvZihzdHJ1Y3QgaGNpX2NvbW1hbmRfaGRyKSkKCQkJY29udGludWU7
CgkJc3RydWN0IGhjaV9jb21tYW5kX2hkciAqY21kID0gKHN0cnVjdCBoY2lfY29tbWFuZF9oZHIg
KikoYnVmICsgMSk7CgkJaWYgKGNtZC0+b3Bjb2RlID09IEhDSV9PUF9SRUFEX0JEX0FERFIpIHsK
CQkJc3RydWN0IGhjaV9ycF9yZWFkX2JkX2FkZHIgYmRfYWRkciA9IHswfTsKCQkJbWVtc2V0KCZi
ZF9hZGRyLmJkYWRkciwgMHhhYSwgNik7CgkJCWhjaV9zZW5kX2NvbW1hbmRfY29tcGxldGUoY21k
LT5vcGNvZGUsICZiZF9hZGRyLCBzaXplb2YoYmRfYWRkcikpOwoJCX0gZWxzZSBpZiAoY21kLT5v
cGNvZGUgPT0gSENJX09QX1JFQURfQlVGRkVSX1NJWkUpIHsKCQkJc3RydWN0IGhjaV9ycF9yZWFk
X2J1ZmZlcl9zaXplIGJ1ZmZlcl9zaXplID0gezB9OwoJCQlidWZmZXJfc2l6ZS5hY2xfbXR1ID0g
MTAyMTsKCQkJYnVmZmVyX3NpemUuc2NvX210dSA9IDk2OwoJCQlidWZmZXJfc2l6ZS5hY2xfbWF4
X3BrdCA9IDQ7CgkJCWJ1ZmZlcl9zaXplLnNjb19tYXhfcGt0ID0gNjsKCQkJaGNpX3NlbmRfY29t
bWFuZF9jb21wbGV0ZShjbWQtPm9wY29kZSwgJmJ1ZmZlcl9zaXplLAoJCQkJCQkgIHNpemVvZihi
dWZmZXJfc2l6ZSkpOwoJCX0gZWxzZSB7CgkJCWNoYXIgemVyb19yZXR1cm5fcGFyYW1zWzB4Zjld
ID0gezB9OwoJCQloY2lfc2VuZF9jb21tYW5kX2NvbXBsZXRlKGNtZC0+b3Bjb2RlLCB6ZXJvX3Jl
dHVybl9wYXJhbXMsCgkJCQkJCSAgc2l6ZW9mKHplcm9fcmV0dXJuX3BhcmFtcykpOwoJCX0KCX0K
fQoKc3RhdGljIHZvaWQgY3JlYXRlX3ZoY2lfY29udHJvbGxlcl93aXRoX2Zha2VfbGVfY29ubmVj
dGlvbih2b2lkKQp7CglwdGhyZWFkX3QgaGNpX2NvbW1hbmRfcmVzcG9uZGVyOwoJaW50IGhjaV9z
b2NrID0gc29ja2V0KEFGX0JMVUVUT09USCwgU09DS19SQVcsIEJUUFJPVE9fSENJKTsKCWlmICho
Y2lfc29jayA8IDApCgkJZGllKCJzb2NrZXQoQUZfQkxVRVRPT1RILCBCVFBST1RPX0hDSSkiKTsK
Cgl2aGNpX2ZkID0gb3BlbigiL2Rldi92aGNpIiwgT19SRFdSKTsKCWlmICh2aGNpX2ZkIDwgMCkK
CQlkaWUoIm9wZW4gL2Rldi92aGNpIik7CgoJLyogVmVuZG9yIHBhY2tldCByZXF1ZXN0aW5nIEhD
SV9QUklNQVJZOyB0aGUgcmVwbHkgY2FycmllcyB0aGUgZGV2IGlkLiAqLwoJc3RydWN0IHZoY2lf
dmVuZG9yX3BrdF9yZXF1ZXN0IHJlcXVlc3QgPSB7IEhDSV9WRU5ET1JfUEtULCAwIH07CglpZiAo
d3JpdGUodmhjaV9mZCwgJnJlcXVlc3QsIHNpemVvZihyZXF1ZXN0KSkgIT0gc2l6ZW9mKHJlcXVl
c3QpKQoJCWRpZSgid3JpdGUgdmhjaSB2ZW5kb3IgcGFja2V0Iik7CgoJc3RydWN0IHZoY2lfcGt0
IHJlcGx5OwoJaWYgKHJlYWQodmhjaV9mZCwgJnJlcGx5LCBzaXplb2YocmVwbHkpKSAhPSBzaXpl
b2YocmVwbHkpKQoJCWRpZSgicmVhZCB2aGNpIHJlcGx5Iik7CgkvKiBTb21lIGtlcm5lbHMgZW1p
dCBIQ0lfT1BfUkVTRVQgYmVmb3JlIHRoZSB2ZW5kb3IgcmVwbHkuICovCglpZiAocmVwbHkudHlw
ZSA9PSBIQ0lfQ09NTUFORF9QS1QgJiYgcmVwbHkuY29tbWFuZF9oZHIub3Bjb2RlID09IEhDSV9P
UF9SRVNFVCkgewoJCWNoYXIgc3RhdHVzX29rID0gMDsKCQloY2lfc2VuZF9jb21tYW5kX2NvbXBs
ZXRlKEhDSV9PUF9SRVNFVCwgJnN0YXR1c19vaywgMSk7CgkJaWYgKHJlYWQodmhjaV9mZCwgJnJl
cGx5LCBzaXplb2YocmVwbHkpKSAhPSBzaXplb2YocmVwbHkpKQoJCQlkaWUoInJlYWQgdmhjaSBy
ZXBseSBhZnRlciByZXNldCIpOwoJfQoJaWYgKHJlcGx5LnR5cGUgIT0gSENJX1ZFTkRPUl9QS1Qp
CgkJZGllKCJ1bmV4cGVjdGVkIHZoY2kgcGFja2V0IHR5cGUiKTsKCWludCBoY2lfZGV2X2lkID0g
cmVwbHkudmVuZG9yX3BrdC5pZDsKCglpZiAocHRocmVhZF9jcmVhdGUoJmhjaV9jb21tYW5kX3Jl
c3BvbmRlciwgTlVMTCwKCQkJICAgaGNpX2NvbW1hbmRfcmVzcG9uZGVyX3RocmVhZCwgTlVMTCkp
CgkJZGllKCJwdGhyZWFkX2NyZWF0ZSIpOwoKCWlmIChpb2N0bChoY2lfc29jaywgSENJREVWVVAs
IGhjaV9kZXZfaWQpICYmIGVycm5vICE9IEVBTFJFQURZKQoJCWRpZSgiSENJREVWVVAiKTsKCWNs
b3NlKGhjaV9zb2NrKTsKCgkvKiBGYWtlIGFuIExFIENvbm5lY3Rpb24gQ29tcGxldGUgc28gYW4g
QUNMIGxpbmsgZXhpc3RzIHRvIHNwZWFrIEwyQ0FQIG9uLiAqLwoJc3RydWN0IHsKCQl1OCBzdWJl
dmVudDsKCQlzdHJ1Y3QgaGNpX2V2X2xlX2Nvbm5fY29tcGxldGUgY29ubjsKCX0gX19hdHRyaWJ1
dGVfXygocGFja2VkKSkgbGVfbWV0YTsKCW1lbXNldCgmbGVfbWV0YSwgMCwgc2l6ZW9mKGxlX21l
dGEpKTsKCWxlX21ldGEuc3ViZXZlbnQgPSBIQ0lfRVZfTEVfQ09OTl9DT01QTEVURTsKCWxlX21l
dGEuY29ubi5oYW5kbGUgPSBGQUtFX0xFX0NPTk5fSEFORExFOwoJbGVfbWV0YS5jb25uLnJvbGUg
PSAxOwoJbWVtc2V0KCZsZV9tZXRhLmNvbm4uYmRhZGRyLCAweGFhLCA2KTsKCWxlX21ldGEuY29u
bi5iZGFkZHIuYls1XSA9IDB4MTE7CgloY2lfc2VuZF9ldmVudF9wYWNrZXQoSENJX0VWX0xFX01F
VEEsICZsZV9tZXRhLCBzaXplb2YobGVfbWV0YSkpOwoKCXVzbGVlcCgyMDAwMDApOwp9CgovKgog
KiBJbmplY3QgYW4gTDJDQVAgTEUgY3JlZGl0LWJhc2VkIGNvbm5lY3Rpb24gcmVxdWVzdCBmb3Ig
UFNNIDB4MDAyMyAoSVBTUCkuCiAqIFRoZSA2bG93cGFuIGxpc3RlbmVyIGFjY2VwdHMgaXQsIGFu
ZCBjaGFuX3JlYWR5X2NiKCkgdGhlbiByZWdpc3RlcnMgYnQwCiAqIGFuZCBicmluZ3MgaXQgdXAs
IHNvIG5vIGV4cGxpY2l0IFNJT0NTSUZGTEFHUyBpcyBuZWVkZWQuCiAqLwpzdGF0aWMgdm9pZCBv
cGVuX2wyY2FwX2lwc3BfY2hhbm5lbCh2b2lkKQp7Cgl1OCBsMmNhcF9sZV9jb25uX3JlcVsxNF07
Cgl1OCBhY2xfcGFja2V0WzY0XTsKCWludCBvZmZzZXQgPSAwOwoKCWwyY2FwX2xlX2Nvbm5fcmVx
WzBdID0gMHgxNDsJCQkvKiBMMkNBUF9MRV9DT05OX1JFUSAqLwoJbDJjYXBfbGVfY29ubl9yZXFb
MV0gPSAweDAxOwkJCS8qIGlkZW50aWZpZXIgKi8KCSoodTE2ICopJmwyY2FwX2xlX2Nvbm5fcmVx
WzJdID0gMTA7CQkvKiBjb21tYW5kIGxlbmd0aCAqLwoJKih1MTYgKikmbDJjYXBfbGVfY29ubl9y
ZXFbNF0gPSAweDAwMjM7CQkvKiBQU006IElQU1AgKi8KCSoodTE2ICopJmwyY2FwX2xlX2Nvbm5f
cmVxWzZdID0gMHgwMDQwOwkJLyogc291cmNlIENJRCAqLwoJKih1MTYgKikmbDJjYXBfbGVfY29u
bl9yZXFbOF0gPSAxMjgwOwkJLyogTVRVICovCgkqKHUxNiAqKSZsMmNhcF9sZV9jb25uX3JlcVsx
MF0gPSAxMjgwOwkJLyogTVBTICovCgkqKHUxNiAqKSZsMmNhcF9sZV9jb25uX3JlcVsxMl0gPSAx
MDsJCS8qIGluaXRpYWwgY3JlZGl0cyAqLwoKCWFjbF9wYWNrZXRbb2Zmc2V0KytdID0gSENJX0FD
TERBVEFfUEtUOwoJLyogUGFja2V0LWJvdW5kYXJ5IGZsYWcgMiA9IGZpcnN0IG5vbi1mbHVzaGFi
bGUsIHBvaW50LXRvLXBvaW50LiAqLwoJKih1MTYgKikmYWNsX3BhY2tldFtvZmZzZXRdID0gRkFL
RV9MRV9DT05OX0hBTkRMRSB8ICgyIDw8IDEyKTsKCW9mZnNldCArPSAyOwoJKih1MTYgKikmYWNs
X3BhY2tldFtvZmZzZXRdID0gNCArIHNpemVvZihsMmNhcF9sZV9jb25uX3JlcSk7CglvZmZzZXQg
Kz0gMjsJCQkJCS8qIEFDTCBkYXRhIGxlbmd0aCAqLwoJKih1MTYgKikmYWNsX3BhY2tldFtvZmZz
ZXRdID0gc2l6ZW9mKGwyY2FwX2xlX2Nvbm5fcmVxKTsKCW9mZnNldCArPSAyOwkJCQkJLyogTDJD
QVAgUERVIGxlbmd0aCAqLwoJKih1MTYgKikmYWNsX3BhY2tldFtvZmZzZXRdID0gMHgwMDA1OwoJ
b2Zmc2V0ICs9IDI7CQkJCQkvKiBMRSBzaWduYWxpbmcgQ0lEICovCgltZW1jcHkoJmFjbF9wYWNr
ZXRbb2Zmc2V0XSwgbDJjYXBfbGVfY29ubl9yZXEsIHNpemVvZihsMmNhcF9sZV9jb25uX3JlcSkp
OwoJb2Zmc2V0ICs9IHNpemVvZihsMmNhcF9sZV9jb25uX3JlcSk7CgoJaWYgKHdyaXRlKHZoY2lf
ZmQsIGFjbF9wYWNrZXQsIG9mZnNldCkgIT0gb2Zmc2V0KQoJCWRpZSgid3JpdGUgTDJDQVAgTEUg
Y29ubmVjdGlvbiByZXF1ZXN0Iik7Cgl1c2xlZXAoMzAwMDAwKTsKfQoKaW50IG1haW4odm9pZCkK
ewoJaW50IGxvd3Bhbl9lbmFibGVfZmQ7Cgl1bnNpZ25lZCBidDBfaWZpbmRleCA9IDA7CglpbnQg
YXR0ZW1wdDsKCglta2RpcigiL3N5cy9rZXJuZWwvZGVidWciLCAwNzU1KTsKCW1vdW50KCJkZWJ1
Z2ZzIiwgIi9zeXMva2VybmVsL2RlYnVnIiwgImRlYnVnZnMiLCAwLCBOVUxMKTsKCglsb3dwYW5f
ZW5hYmxlX2ZkID0gb3BlbigiL3N5cy9rZXJuZWwvZGVidWcvYmx1ZXRvb3RoLzZsb3dwYW5fZW5h
YmxlIiwgT19XUk9OTFkpOwoJaWYgKGxvd3Bhbl9lbmFibGVfZmQgPCAwKQoJCWRpZSgib3BlbiA2
bG93cGFuX2VuYWJsZSIpOwoJaWYgKHdyaXRlKGxvd3Bhbl9lbmFibGVfZmQsICIxXG4iLCAyKSA8
IDApCgkJZGllKCJ3cml0ZSA2bG93cGFuX2VuYWJsZSIpOwoJY2xvc2UobG93cGFuX2VuYWJsZV9m
ZCk7CgoJY3JlYXRlX3ZoY2lfY29udHJvbGxlcl93aXRoX2Zha2VfbGVfY29ubmVjdGlvbigpOwoJ
b3Blbl9sMmNhcF9pcHNwX2NoYW5uZWwoKTsKCglmb3IgKGF0dGVtcHQgPSAwOyBhdHRlbXB0IDwg
MTAwICYmICFidDBfaWZpbmRleDsgYXR0ZW1wdCsrKSB7CgkJYnQwX2lmaW5kZXggPSBpZl9uYW1l
dG9pbmRleCgiYnQwIik7CgkJaWYgKCFidDBfaWZpbmRleCkKCQkJdXNsZWVwKDEwMDAwMCk7Cgl9
CglpZiAoIWJ0MF9pZmluZGV4KQoJCWRpZSgiYnQwIG5ldmVyIGFwcGVhcmVkIik7CgoJaW50IHBh
Y2tldF9zb2NrZXQgPSBzb2NrZXQoQUZfUEFDS0VULCBTT0NLX1JBVywgaHRvbnMoRVRIX1BfSVBW
NikpOwoJaWYgKHBhY2tldF9zb2NrZXQgPCAwKQoJCWRpZSgic29ja2V0KEFGX1BBQ0tFVCkiKTsK
CglzdHJ1Y3Qgc29ja2FkZHJfbGwgYnQwX2xpbmtfYWRkcmVzczsKCW1lbXNldCgmYnQwX2xpbmtf
YWRkcmVzcywgMCwgc2l6ZW9mKGJ0MF9saW5rX2FkZHJlc3MpKTsKCWJ0MF9saW5rX2FkZHJlc3Mu
c2xsX2ZhbWlseSA9IEFGX1BBQ0tFVDsKCWJ0MF9saW5rX2FkZHJlc3Muc2xsX3Byb3RvY29sID0g
aHRvbnMoRVRIX1BfSVBWNik7CglidDBfbGlua19hZGRyZXNzLnNsbF9pZmluZGV4ID0gYnQwX2lm
aW5kZXg7CglidDBfbGlua19hZGRyZXNzLnNsbF9oYWxlbiA9IDA7CgoJLyoKCSAqIDM2IGJ5dGVz
OiBzaG9ydGVyIHRoYW4gc2l6ZW9mKHN0cnVjdCBpcHY2aGRyKSA9PSA0MC4gIG5ldC82bG93cGFu
L2lwaGMuYwoJICogZG9lcyBza2JfcHVsbChza2IsIHNpemVvZihzdHJ1Y3QgaXB2NmhkcikpIGJl
Zm9yZSB0aGUgY29tcHJlc3NlZCBoZWFkZXIKCSAqIGlzIHB1c2hlZCwgYW5kIHNrYl9wdWxsKCkg
aXMgYSBuby1vcCB3aGVuIGxlbiA+IHNrYi0+bGVuLCBzbyBza2ItPmRhdGEKCSAqIGlzIG5ldmVy
IGFkdmFuY2VkLiAgRXZlcnkgY29tcHJlc3NpYmxlIGZpZWxkIGJlbG93IGlzIGNob3NlbiB0byBi
ZQoJICogaW5jb21wcmVzc2libGUsIHNvIHRoZSBJUEhDIGhlYWRlciBpcyAyOCBieXRlcyAtLSBt
b3JlIHRoYW4gdGhlIDE2CgkgKiBieXRlcyBvZiBoZWFkcm9vbSBBRl9QQUNLRVQgcmVzZXJ2ZWQg
Zm9yIGJ0MCAoaGFyZF9oZWFkZXJfbGVuIDAsCgkgKiBuZWVkZWRfaGVhZHJvb20gMCkuICBUaGUg
c2tiX3B1c2goKSB0aGVyZWZvcmUgdW5kZXJmbG93cyB0aGUgYnVmZmVyLgoJICovCgl1OCB0cnVu
Y2F0ZWRfaXB2Nl9mcmFtZVszNl07CgltZW1zZXQodHJ1bmNhdGVkX2lwdjZfZnJhbWUsIDAsIHNp
emVvZih0cnVuY2F0ZWRfaXB2Nl9mcmFtZSkpOwoJdHJ1bmNhdGVkX2lwdjZfZnJhbWVbMF0gPSAw
eDYxOwkJLyogdmVyc2lvbiA2LCB0cmFmZmljIGNsYXNzICE9IDAgKi8KCXRydW5jYXRlZF9pcHY2
X2ZyYW1lWzFdID0gMHgxMjsJCS8qIHRyYWZmaWMgY2xhc3MgLyBmbG93IGxhYmVsICovCgl0cnVu
Y2F0ZWRfaXB2Nl9mcmFtZVsyXSA9IDB4MzQ7Cgl0cnVuY2F0ZWRfaXB2Nl9mcmFtZVszXSA9IDB4
NTY7CQkvKiBmbG93IGxhYmVsICE9IDAgLT4gVEY9MDAsIDQgYnl0ZXMgaW5saW5lICovCgl0cnVu
Y2F0ZWRfaXB2Nl9mcmFtZVs2XSA9IDB4MDY7CQkvKiBuZXh0IGhlYWRlciBUQ1A6IG5vIE5IQyAt
PiAxIGJ5dGUgaW5saW5lICovCgl0cnVuY2F0ZWRfaXB2Nl9mcmFtZVs3XSA9IDB4MDc7CQkvKiBo
b3AgbGltaXQgbm90IDEvNjQvMjU1IC0+IDEgYnl0ZSBpbmxpbmUgKi8KCS8qIHNvdXJjZSAyMDAx
OmRiODo6MSAtLSBnbG9iYWwgdW5pY2FzdCwgc28gYWxsIDE2IGJ5dGVzIGdvIGlubGluZSAqLwoJ
dHJ1bmNhdGVkX2lwdjZfZnJhbWVbOF0gPSAweDIwOwoJdHJ1bmNhdGVkX2lwdjZfZnJhbWVbOV0g
PSAweDAxOwoJdHJ1bmNhdGVkX2lwdjZfZnJhbWVbMTBdID0gMHgwZDsKCXRydW5jYXRlZF9pcHY2
X2ZyYW1lWzExXSA9IDB4Yjg7Cgl0cnVuY2F0ZWRfaXB2Nl9mcmFtZVsyM10gPSAweDAxOwoJLyog
ZGVzdGluYXRpb24gZmYwNTo6Li4uICwgdHJ1bmNhdGVkIGJ5IHRoZSAzNi1ieXRlIGZyYW1lIGxl
bmd0aCAqLwoJdHJ1bmNhdGVkX2lwdjZfZnJhbWVbMjRdID0gMHhmZjsKCXRydW5jYXRlZF9pcHY2
X2ZyYW1lWzI1XSA9IDB4MDU7CgoJc2VuZHRvKHBhY2tldF9zb2NrZXQsIHRydW5jYXRlZF9pcHY2
X2ZyYW1lLCBzaXplb2YodHJ1bmNhdGVkX2lwdjZfZnJhbWUpLCAwLAoJICAgICAgIChzdHJ1Y3Qg
c29ja2FkZHIgKikmYnQwX2xpbmtfYWRkcmVzcywgc2l6ZW9mKGJ0MF9saW5rX2FkZHJlc3MpKTsK
CXJldHVybiAwOwp9Cg==
--000000000000680912065b1692d1--
