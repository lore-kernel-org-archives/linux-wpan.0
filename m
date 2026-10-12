Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15842F12C5
	for <linux-wpan@vger.kernel.org>; Mon, 12 Oct 2026 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768307; cv=none; b=gFzBJgJG7tlfhzHMwr69BNPpJNiE9nDhxkOjM7tf4OcLhWcJzqEB8x/3gxSAAzVyjRoUYPiHvwG5jDegRQI+PpnhnBLHP1d1PkAEzcgAsbMLl7mh74lUCIXlX4vpnng1ISh3zs4uEcNSI1Oc9Zs6NNl5GVgOEWM6n6p8H8E23hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768307; c=relaxed/simple;
	bh=yWi7Q1J2djTBuVueWn5sOUMdqjsqhx3pjQnh0zBQZBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SCLXsNLHuK6qDc6VTaDlZoJQ4SbwU21FWEe6R8ImoWgjEdbSWpNzZQAt240JT+5/vIs4qHnGGFtgigA5ukJn6GNsfMVGS4wqQvVzhQh3FTJVh2O8C+GXpz39XKzMmOav9gzZcWwTnm1rwR1KbbmO4spHDUkURnO27NatO0T5QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S49ZcmwL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S49ZcmwL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab62a8250aso736746a91.1
        for <linux-wpan@vger.kernel.org>; Sun, 11 Oct 2026 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768305; x=1792373105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGNfDe4PH3EHur5xwCh9qmvE7IvKd55G+GXc+WjRDUQ=;
        b=S49ZcmwLH2MZBnOGpyrojMIqR1WAg4CSID293pxDSQcar1+GUGz4ll05KLPOET1I9Y
         GSeiAcZUvL1Jv8tM4o0WQfVeYBs7lsjA2iQ89jDcBQTjj9jb0G3OhAoh7UvaVy5kYOl4
         kHhNaeZj7RTgwNGDE02YG4S+vUtFmzhWU0HL30hzxQyVQg/n8pRyS11PKg/6VYTOJ2E+
         w/pXAcyOMOtI6volip2dqdQtssPxs34O0DdazBaTQPoZ7uvsWQLztmrk/fCE7qBJxluQ
         qsG4rSZLKXyHulAEG36NbLkVLmGX+PgG0bQh2ojw2TQVHfA0xC3EM6RP9IOxMdw/1qI1
         RhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768305; x=1792373105;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGNfDe4PH3EHur5xwCh9qmvE7IvKd55G+GXc+WjRDUQ=;
        b=Ru0PNUlchY3Gphuq06MvQ2/2lLx6K/f+bkXtuyfTnGzLetmRz97jr2k8mvo6xOXWpy
         okSVCmZt24oDL+AUy7EbEgD2kTQiiwpDkqtVxsYm/PGbWEqj9hKykOBr7pS5RbM+EckC
         m5EMfIV/3bRHUv9D7T7ZdijMMHPD4HmiNatIHL0Pl27dyJqCog4dNFWhRSYjR0vTeRKu
         +pQbkEde6dMc4QZ/8U7oaZW9C3qDveCpNkhFBO3TZzYmP8kuTvyBzjnG3CMiIGwqsrj1
         WA0nPki1P9Mttb1XUooleG7y+Yu80x5+n4HneALq2DvGgfz2zO9RypCVfUTkV5zAqYuB
         KGnw==
X-Gm-Message-State: AFq9FYJzyHBNfP+NYJeMFGzKHHLgqrnGP5cEK7xqqN2z+GGSF5ZXTTkg
	czmZNt/p0FKOKpljrjNR273mdKoncZpoPKa2CG6BBX8xYTMf6wdc/PtQ
X-Gm-Gg: AYBFou3WcQnIuWm+d3LPzPFJ0/Y6v2DkmEHFt9aynGPavb7ZDGvJey4XlQcOqVEEVkM
	lrqZjpJVI5waJjpZ9wE4GoZd4veB3AjP5V+UA2cRWqi5nol3+U4px7RJ+VhPQOhORqqvxec1OV8
	exgOEaKubO+AggkWstOdWqeKjCHIOrEJoJeBh4y7+nUTBgUajg4Ii0pPCqld9JvltFw1u/8XOwq
	9r+ojE18ekvV68k0PO75Rj9pRyd1YRjEUuY7fDkgo+xNYFHBoAhypPKG5g61mXRWahfLAtnGz7N
	xmQePdmTfEhcwpgPnERR1DcgJHQPimsVvCvY78P+fMB+SgKT+bMfKgTZwgqD337HmQ80CNTiC4n
	OiA9yn/4UQpEOGQr0pVZlht9/ouaxYQ5v3kzLtzYiEnrkbzY9zIGS3BdjqHcOoy6yh422nQQ57J
	PSqrfRjzsjAFW/Vf/E6E7kgofHrH9V9MsrfU5snf8YBi9y4JQlbj8XCErgkejxozqACQ==
X-Received: by 2002:a17:90b:3c0d:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3abb39f450amr2604770a91.11.1791768304968;
        Sun, 11 Oct 2026 18:25:04 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm14104449a91.5.2026.10.11.18.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 18:25:04 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zhilinz@nebusec.ai,
	lucien.xin@gmail.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net] ieee802154: 6lowpan: Hold wpan reference until lowpan destruction
Date: Mon, 12 Oct 2026 09:24:57 +0800
Message-Id: <pm-ip-core-objects-candidate-0015-v5-006dffdec5c84633dfbe@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The underlying wpan device must remain alive while users of the lowpan
netdevice can invoke its neighbour discovery callbacks. lowpan_newlink()
retains wdev, but lowpan_dellink() drops that reference immediately
after unregistering ldev, before ldev's outstanding references have
drained.

With router reachability probing enabled, rt6_probe_deferred() holds
ldev while sending a neighbour solicitation. If the worker selects a
valid link-local source before physical wpan unregister, it can continue
into option sizing after address teardown. The following order is
possible:

1. The RT6 worker enters ndisc_send_ns() with its reference to ldev.
2. ipv6_get_lladdr() copies the source and releases its lock and RCU
   read section. The worker is preempted before ndisc_ns_create().
3. Physical wpan unregister calls lowpan_device_event(), which calls
   lowpan_dellink(). It unregisters ldev and drops the wdev reference.
4. netdev_run_todo() skips the still-referenced ldev and frees wdev.
5. The worker resumes into lowpan_ndisc_opt_addr_space(), dereferencing
   the freed wdev through ldev's stored pointer.

RTNL and synchronize_net() do not join this workqueue execution after
source selection. Out-of-order netdevice finalization therefore permits
a use-after-free read of wdev->ieee802154_ptr and its embedded wpan_dev.

Release the existing wdev reference from ldev's private destructor so it
covers the worker's entire use of ldev. Install the destructor only
after successful registration, preserving the existing reference release
on registration failure. Once ldev's users finish, its destructor drops
the wdev reference and physical device finalization can proceed.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in lowpan_ndisc_opt_addr_space+0x324/0x380
    Read of size 8 at addr ffff8881077d44c8 by task kworker/0:1/11

    CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: events rt6_probe_deferred
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? lowpan_ndisc_opt_addr_space+0x324/0x380
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? lowpan_ndisc_opt_addr_space+0x324/0x380
     kasan_report+0xe0/0x110
     ? lowpan_ndisc_opt_addr_space+0x324/0x380
     ? __pfx_lowpan_ndisc_opt_addr_space+0x10/0x10
     lowpan_ndisc_opt_addr_space+0x324/0x380
     ndisc_ns_create+0x5c9/0x760
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xee/0x1c0
     ? __pfx_ndisc_ns_create+0x10/0x10
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? ipv6_get_lladdr+0x287/0x470
     ndisc_send_ns+0xae/0x1a0
     ? __pfx_ndisc_send_ns+0x10/0x10
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? debug_object_deactivate+0x2f8/0x3c0
     rt6_probe_deferred+0xf4/0x290
     ? process_one_work+0x895/0x19c0
     ? __pfx_rt6_probe_deferred+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x175/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 1:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kvmalloc_node_noprof+0x358/0x900
     alloc_netdev_mqs+0xa0/0x1250
     ieee802154_if_add+0xdb/0x10e0
     ieee802154_register_hw+0x6ef/0xa10
     hwsim_add_one+0x699/0x12e0
     hwsim_probe+0x2c/0x130
     platform_probe+0xbe/0x1d0
     really_probe+0x21f/0xa90
     __driver_probe_device+0x1ec/0x490
     driver_probe_device+0x4f/0x130
     __driver_attach+0x248/0x580
     bus_for_each_dev+0x143/0x1d0
     bus_add_driver+0x2ea/0x660
     driver_register+0x155/0x490
     hwsim_init_module+0x11f/0x170
     do_one_initcall+0xf3/0x4e0
     kernel_init_freeable+0x59d/0xae0
     kernel_init+0x24/0x280
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 535:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x236/0x5a0
     device_release+0xd7/0x280
     kobject_put+0x1ad/0x610
     netdev_run_todo+0x931/0x1460
     ieee802154_unregister_hw+0x5f/0x100
     hwsim_del+0x304/0x580
     hwsim_del_radio_nl+0x158/0x1f0
     genl_family_rcv_msg_doit+0x1f6/0x2e0
     genl_rcv_msg+0x48b/0x700
     netlink_rcv_skb+0x133/0x390
     genl_rcv+0x2d/0x40
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff8881077d4000
     which belongs to the cache dyn-kmalloc-8k of size 8192
    The buggy address is located 1224 bytes inside of
     freed 8192-byte region [ffff8881077d4000, ffff8881077d6000)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1077d0
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000040 ffff888100048280 dead000000000122 0000000000000000
    raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
    head: 0200000000000040 ffff888100048280 dead000000000122 0000000000000000
    head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
    head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
    head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff8881077d4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff8881077d4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff8881077d4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
     ffff8881077d4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff8881077d4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: faab39f63c1f ("net: allow out-of-order netdev unregistration")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 6a8d6852cb93..42ae2df8b9a4 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -67,6 +67,11 @@ static int lowpan_dev_init(struct net_device *ldev)
 	return 0;
 }
 
+static void lowpan_dev_free(struct net_device *ldev)
+{
+	dev_put(lowpan_802154_dev(ldev)->wdev);
+}
+
 static int lowpan_open(struct net_device *dev)
 {
 	if (!open_count)
@@ -181,6 +186,7 @@ static int lowpan_newlink(struct net_device *ldev,
 		return ret;
 	}
 
+	ldev->priv_destructor = lowpan_dev_free;
 	wdev->ieee802154_ptr->lowpan_dev = ldev;
 	return 0;
 }
@@ -193,7 +199,6 @@ static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
 
 	wdev->ieee802154_ptr->lowpan_dev = NULL;
 	lowpan_unregister_netdevice(ldev);
-	dev_put(wdev);
 }
 
 static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
