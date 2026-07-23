Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB12D5C68
	for <linux-wpan@vger.kernel.org>; Thu, 23 Jul 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777970; cv=none; b=r88RJG1R5gxs0HDBBUsHpTmz66qb+iYmDJW9kYkUNHLMhCVdh8SnAa3OLeowi4DdkAyV0FvddetIRvfgCi4PaG8Gu0KpRyGKaC9PXGxoYwJ5BRG0iZBaudxSwtWHzphiLxlcxMshxYP/0waW32KyByNBu42iU5g+kKtuGHCOY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777970; c=relaxed/simple;
	bh=GcSQDAE1wRtLPtrlrb8ZIN/uvi9Y+ars5Q6AEC/DnE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjnCDGas+fncetzIKCGkn9NvqCtc2N9yLrL2+T6ak1eRfMr5XFBW14WPS2DupyVEaSXBEJs5IKRGSPMimQYueeDTyVveWCEL6RD098jLPyZR2nzqDnIMtz3MhH6rQG0ZMZorRZj3C3CgkoyUSzryGhXUUNNTFePV91mj6hOByoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q27keboN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q27keboN"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so2303946d6.1
        for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2026 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777967; x=1785382767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZjcmph09vEWik6hkHqT0aUjM+ij2e4ZNys+sdCisss=;
        b=Q27keboNDVCxwkr3Tk9NDPWK6k8/PvWBGURB4CxmpeJyJ6pj6x4/COsYp6SADnChkh
         gwBCTVVXgsn0iIEQ5sX5R5+pIQRE/KdPBYB9HcNBLhgqNgtibfWSIkA58T62UWuL9um+
         I9By+lT+iS75VxuxCic3xQnerfIuxi7zicvb9x42QCQ+z4baoJ9uq0pwmZVhviltRK2Z
         dF4y2nQ7lxAVUMHnra8DTbkAJdtnuJgDRD3Yw7DXX0ujfHHzSRs7xbwQZmqEXyH0YBMl
         rS+rGfI9gfYxAkd/iMq0tz9/qIN/Wph6DGJJr1gPcLUr3hT/QqoJk1MuD6BtOfXRtaWj
         tDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777967; x=1785382767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZjcmph09vEWik6hkHqT0aUjM+ij2e4ZNys+sdCisss=;
        b=Z8qWi9qcCZTgtY48WmbgVyHHDYKzrPHhw9mamFPbbIExQ+9Y9RUTWP4q1lIsxMVpiF
         vfpaUlau9ys15SnoYFWm9+6CQ4lD9cPvXhakvfBf6UiYhiRY9GjZos2D6cyD0aJ3e1wd
         VZlW7ZGB+vzSD6k2hotD0fJMokoe02RqnGpxKLu8KAxqc/8PR516kFmQkX6q2WI72GcZ
         1L8VH+CK/s2kr2QcRk2wBUHlgx5Z6TPbEnJ51gloDW26wPCuKbqSpj5GqQKR3dFqjnwc
         ATKdKRE7JFNOhZeyylAvz7QGFtm91ciSEtmWRANqfRG1PwXS2csifj8i1FnCWpNZIHkq
         b5Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa0KflNbAESx/A1TqSXmnDNKUr5J8IPmL9hhB0yIhI57iZ3bqHAeleAtkjBoiFgd7xVfwJ0Am+FA6w@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxmTfyH7qpk9shWI0d+0Vi0eaX1a4EOMaUuR+eIVm6boC2NIZ
	Sw4zF03UpM3YpU+0gx6uwru7dOJaIaJ1rkoXU1mlIJ9cXlo6IgFGByqn
X-Gm-Gg: AR+sD10uu6eH8yZLXhz0QW4Mc8eGkY81BMQFhmVntelljb0C54YTcDbmKtM3QXGU9uY
	icvfc10aT+tpnisp7v9u7+CLPmgHnsdeDzBVtu3h75DZmPPXMLAw5ZQiaZwDIphT/6rXdcU3gv5
	WqtFgjtNjMS4WLWBxQWeQ3QP6BrHQMWQ7tOA3IfyYgjgHtBr66WHQqWG5w87dAVmaQ9Uedt0IqU
	309wsPqM1iz85Jb7GmoCVnA7ul7QQTat0ROGwsJ+tscGCKbVfP9anNAZTv+3cvPdce+BMxbJNjR
	M30LJ676tyOyd2OunKbYz0eYuTBwcyD85THPpHM5k0JAeKUTdjTTRvOCnaCPZ/4Bcvcw+ESOEZY
	7e7hVWym1QV5D8KIU5+aRj4ZCmciqhrNjLBOMgn5tP8HK4faWcqrFiUJq31iWkfJwTVPvNeq8oI
	LZo+O2k4/3JpkTpPBkGGjuhRb1AsBdLEo=
X-Received: by 2002:a05:6214:1d0d:b0:8fe:310f:7f4 with SMTP id 6a1803df08f44-907ca5572cdmr18684376d6.49.1784777967640;
        Wed, 22 Jul 2026 20:39:27 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8df5d0sm35952586d6.18.2026.07.22.20.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:39:27 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] mac802154: KASAN slab-use-after-free in mac802154_rx_mac_cmd_worker
Date: Wed, 22 Jul 2026 23:37:58 -0400
Message-ID: <20260723033829.764639-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker

on commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a (Jul 16 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/ea5e98e729d2ae8cb1e9481b5c315ab8

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  376.015401][   T12] BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker (net/mac802154/rx.c:110)
[  376.016760][   T12] Read of size 4 at addr ffff888115e78b58 by task kworker/u8:0/12
[  376.017796][   T12]
[  376.018231][   T12] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  376.018237][   T12] Workqueue: phy1-mac-cmds mac802154_rx_mac_cmd_worker
[  376.018270][   T12] Call Trace:
[  376.018292][   T12]  <TASK>
[  376.018302][   T12]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  376.018393][   T12]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  376.018529][   T12]  kasan_report (mm/kasan/report.c:595)
[  376.018543][   T12]  mac802154_rx_mac_cmd_worker (net/mac802154/rx.c:110)
[  376.018560][   T12]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[  376.018589][   T12]  worker_thread (kernel/workqueue.c:3486)
[  376.018599][   T12]  kthread (kernel/kthread.c:436)
[  376.018647][   T12]  ret_from_fork (archkernel/process.c:158)
[  376.018735][   T12]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  376.018754][   T12]  </TASK>
[  376.018758][   T12]
[  376.032833][   T12] Freed by task 8455 on cpu 0 at 375.611793s:
[  376.033290][   T12]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  376.033651][   T12]  kasan_save_free_info (mm/kasan/generic.c:584)
[  376.034018][   T12]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  376.034371][   T12]  kfree (./include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
[  376.034677][   T12]  device_release (drivers/gpu/drm/vkms/vkms_configfs.c:690)
[  376.035065][   T12]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
[  376.035413][   T12]  netdev_run_todo (net/core/dev.c:11749)
[  376.035808][   T12]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)
[  376.036235][   T12]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
[  376.036574][   T12]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[  376.036933][   T12]  genl_rcv (net/netlink/genetlink.c:1218)
[  376.037233][   T12]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[  376.037584][   T12]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[  376.037930][   T12]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  376.038335][   T12]  __sys_sendto (net/socket.c:2252)
[  376.038676][   T12]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[  376.039018][   T12]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  376.039455][   T12]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  376.039998][   T12]
[  376.040171][   T12] The buggy address belongs to the object at ffff888115e78000
[  376.040171][   T12]  which belongs to the cache kmalloc-cg-8k of size 8192
[  376.041250][   T12] The buggy address is located 2904 bytes inside of
[  376.041250][   T12]  freed 8192-byte region [ffff888115e78000, ffff888115e7a000)
[  376.042239][   T12]
[  376.042414][   T12] The buggy address belongs to the physical page:


Best,
Shuangpeng
